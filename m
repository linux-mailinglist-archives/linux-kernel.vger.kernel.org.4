Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0698743158
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF2XvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjF2Xu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:50:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 973D430F1;
        Thu, 29 Jun 2023 16:50:55 -0700 (PDT)
Received: from CPC-beaub-VBQ1L.localdomain (unknown [4.155.48.123])
        by linux.microsoft.com (Postfix) with ESMTPSA id AA4AD208396B;
        Thu, 29 Jun 2023 16:50:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA4AD208396B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688082654;
        bh=gCxckCcdhkcYSNpOGc+UHMmZw5sSgaEy+c0gjwxBW/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZlKCwXeupqEmLSMFQsH4rfdDLmvfpxma01KBAaL01XCt0ehHvzVGlrOcbTYEuk9H
         LIPTkaXf0toboei85ZVGoBtPtrwvrozJKh2jpCgntl0E+uNdwwS3M65B3Fg31U5eg5
         B8zZddU70CKUl6TYMkQM3i1mqVL+h4vEGKqM0XqQ=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing/user_events: Fix struct arg size match check
Date:   Thu, 29 Jun 2023 23:50:48 +0000
Message-Id: <20230629235049.581-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629235049.581-1-beaub@linux.microsoft.com>
References: <20230629235049.581-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When users register an event the name of the event and it's argument are
checked to ensure they match if the event already exists. Normally all
arguments are in the form of "type name", except for when the type
starts with "struct ". In those cases, the size of the struct is passed
in addition to the name, IE: "struct my_struct a 20" for an argument
that is of type "struct my_struct" with a field name of "a" and has the
size of 20 bytes.

The current code does not honor the above case properly when comparing
a match. This causes the event register to fail even when the same
string was used for events that contain a struct argument within them.
The example above "struct my_struct a 20" generates a match string of
"struct my_struct a" omitting the size field.

Add the struct size of the existing field when generating a comparison
string for a struct field to ensure proper match checking.

Fixes: e6f89a149872 ("tracing/user_events: Ensure user provided strings are safely formatted")

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8df0550415e7..5c787fe48d53 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1317,6 +1317,9 @@ static int user_field_set_string(struct ftrace_event_field *field,
 	pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->name);
 
+	if (str_has_prefix(field->type, "struct "))
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " %d", field->size);
+
 	if (colon)
 		pos += snprintf(buf + pos, LEN_OR_ZERO, ";");
 
-- 
2.34.1

