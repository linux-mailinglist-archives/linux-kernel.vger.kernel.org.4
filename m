Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2C730501
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjFNQeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjFNQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:33:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 327EF1FDC;
        Wed, 14 Jun 2023 09:33:42 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id A63B320FEB2B;
        Wed, 14 Jun 2023 09:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A63B320FEB2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686760421;
        bh=L6ewCnTLmvd3IAdzmYn9pAB0e+CkfQZzUgJPoFiFoKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEasVLt6aR+pIq1LBr9t8DKN/CTK4zMPwQNz2URzNu/kzusgo0Or5zhpKXPVqFq0L
         xs0ONMe7OEuXUks1Oui2TH6zEhXq6GBUoAB7K+uEalcjPQ/HkWb8MH1WcRzTPN8opn
         1n5IU50pQ7Vrrry1XmfMjiaBtmVDT/OAowWn75hk=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v3 6/6] tracing/user_events: Document auto-cleanup and remove dyn_event refs
Date:   Wed, 14 Jun 2023 09:33:36 -0700
Message-Id: <20230614163336.5797-7-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614163336.5797-1-beaub@linux.microsoft.com>
References: <20230614163336.5797-1-beaub@linux.microsoft.com>
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

Now user_events auto-cleanup upon the last reference by default. This
makes it not possible to use the dynamics event file via tracefs.

Document that auto-cleanup is enabled by default and remove the refernce
to /sys/kernel/tracing/dynamic_events file to make this clear.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 Documentation/trace/user_events.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/user_events.rst b/Documentation/trace/user_events.rst
index f79987e16cf4..e7b07313550a 100644
--- a/Documentation/trace/user_events.rst
+++ b/Documentation/trace/user_events.rst
@@ -14,10 +14,6 @@ Programs can view status of the events via
 /sys/kernel/tracing/user_events_status and can both register and write
 data out via /sys/kernel/tracing/user_events_data.
 
-Programs can also use /sys/kernel/tracing/dynamic_events to register and
-delete user based events via the u: prefix. The format of the command to
-dynamic_events is the same as the ioctl with the u: prefix applied.
-
 Typically programs will register a set of events that they wish to expose to
 tools that can read trace_events (such as ftrace and perf). The registration
 process tells the kernel which address and bit to reflect if any tool has
@@ -144,6 +140,9 @@ its name. Delete will only succeed if there are no references left to the
 event (in both user and kernel space). User programs should use a separate file
 to request deletes than the one used for registration due to this.
 
+**NOTE:** By default events will auto-delete when there are no references left
+to the event. Flags in the future may change this logic.
+
 Unregistering
 -------------
 If after registering an event it is no longer wanted to be updated then it can
-- 
2.25.1

