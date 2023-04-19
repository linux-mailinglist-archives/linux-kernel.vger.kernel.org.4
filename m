Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462CE6E83E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjDSVly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjDSVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:41:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 160861BEB;
        Wed, 19 Apr 2023 14:41:49 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7842121C2057;
        Wed, 19 Apr 2023 14:41:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7842121C2057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681940508;
        bh=At02062WqVBPFH5DXB8GaOuC2yKzAnMYYo2tjBSjyqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWAjdMn1ofGLAeYetRgxVoZ9998/Ls/oJmCP29Izqe6vHpioyRdlXvqs4gZ4/bXMW
         fTP5Dh3jnlPMuu3iu+JNFBq5m0InOehhnZGlLFIzT6vYh/VIJJWpJwZ8HzbtGLQ493
         OwH3+hiXH3R78qCIKElgMDPVzotF6mc8riib9w0A=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing/user_events: Set event filter_type from type
Date:   Wed, 19 Apr 2023 14:41:39 -0700
Message-Id: <20230419214140.4158-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419214140.4158-1-beaub@linux.microsoft.com>
References: <20230419214140.4158-1-beaub@linux.microsoft.com>
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

Users expect that events can be filtered by the kernel. User events
currently sets all event fields as FILTER_OTHER which limits to binary
filters only. When strings are being used, functionality is reduced.

Use filter_assign_type() to find the most appropriate filter
type for each field in user events to ensure full kernel capabilities.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index cc8c6d8b69b5..eadb58a3efba 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -918,6 +918,9 @@ static int user_event_add_field(struct user_event *user, const char *type,
 	field->is_signed = is_signed;
 	field->filter_type = filter_type;
 
+	if (filter_type == FILTER_OTHER)
+		field->filter_type = filter_assign_type(type);
+
 	list_add(&field->link, &user->fields);
 
 	/*
-- 
2.25.1

