Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E602A742CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjF2TD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbjF2TBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DABA3594;
        Thu, 29 Jun 2023 12:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C730B615D8;
        Thu, 29 Jun 2023 19:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E2C433CA;
        Thu, 29 Jun 2023 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065300;
        bh=4yKJJVHut3d9Sly9KPcxcIqJNazp/tDpdtVbUNvd0Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gV+R6YO3IPe05kcRMQsrKYnOl7+7u2SOGEECyCmDdWjO6XC5hdQo+dH1X9XQ0qk3O
         7aA+M1khkm6rsGZQhiN1xp2+0UkQ99hzcrbIiZEQkVuBL29PznCEd/aQ7jVKlb3m+8
         mQ0DXokCSAl9tVgiwGRnOi6B/W1j/XyF6EMUE81kIDACL31Xlpg31YnEPVoczqnEcq
         4zGMRXhqqajmdfX+xx9ZvtUmm99kHh+PJM7LIZpXwYDUNrosdSz1LQy8mlhct2TCDN
         cuL3bbbY6coW5aUEVs804f9asG0zYML65AWEu/rFMyIBmY+WqMI8vy0REQP4aEhOUH
         KTBnNzhngzpJA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     sunliming <sunliming@kylinos.cn>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/12] tracing/user_events: Fix the incorrect trace record for empty arguments events
Date:   Thu, 29 Jun 2023 15:01:24 -0400
Message-Id: <20230629190134.907949-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190134.907949-1-sashal@kernel.org>
References: <20230629190134.907949-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

[ Upstream commit 6f05dcabe5c241d066ec472cf38ac8b84f8c9c6f ]

The user_events support events that has empty arguments. But the trace event
is discarded and not really committed when the arguments is empty. Fix this
by not attempting to copy in zero-length data.

Link: https://lkml.kernel.org/r/20230606062027.1008398-2-sunliming@kylinos.cn

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ad64da21c34aa..49e114d250136 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -916,7 +916,7 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 	if (unlikely(!entry))
 		return;
 
-	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
+	if (unlikely(i->count != 0 && !copy_nofault(entry + 1, i->count, i)))
 		goto discard;
 
 	if (!list_empty(&user->validators) &&
@@ -957,7 +957,7 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
 
 		perf_fetch_caller_regs(regs);
 
-		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i)))
+		if (unlikely(i->count != 0 && !copy_nofault(perf_entry + 1, i->count, i)))
 			goto discard;
 
 		if (!list_empty(&user->validators) &&
-- 
2.39.2

