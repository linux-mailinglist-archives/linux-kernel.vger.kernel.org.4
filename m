Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0AB742CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjF2TDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjF2TBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FDA3A9B;
        Thu, 29 Jun 2023 12:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2AFC615FD;
        Thu, 29 Jun 2023 19:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45644C433C9;
        Thu, 29 Jun 2023 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065299;
        bh=bqydMEeG0Xm6PkNRJNTSzNvr4tSuM+az5ZB4GfP+xew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAZFANMfFZRZrz2/lGJepPjVIFxPqfXd9waW6VWRui8P3jq1AraS8ImxI59vXRJnG
         bFP15cyAQEqB24JZOnnIA3ZEcaLHPeH5YlSJMQb/KWu+SnFTwmydRnsCBsXRv9X7lp
         QMm7L9gK9xJfDOpz8Bf23QAOV8bsWR+gg7yczDmCyCrhiX1p9mZj4SDZEa3xZJ928r
         /hnP/ktG8zmWnB7ozpYoCkHeVQp+Hv2qf3JCYWpniXKYF17MdL14wimdlz6iphS6o9
         gl7h9ggr1YEvre8M1PQ77F9w7kOPMjXgVxKLsaArt/YhIWbRIb7AfNhUwJ+83TVGq6
         R3+qhieEwWjPQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     sunliming <sunliming@kylinos.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/12] tracing/user_events: Handle matching arguments that is null from dyn_events
Date:   Thu, 29 Jun 2023 15:01:23 -0400
Message-Id: <20230629190134.907949-3-sashal@kernel.org>
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

[ Upstream commit cfac4ed7279d056df6167bd665e460787dc9e0c4 ]

When A registering user event from dyn_events has no argments, it will pass the
matching check, regardless of whether there is a user event with the same name
and arguments. Add the matching check when the arguments of registering user
event is null.

Link: https://lore.kernel.org/linux-trace-kernel/20230529065110.303440-1-sunliming@kylinos.cn

Signed-off-by: sunliming <sunliming@kylinos.cn>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 774d146c2c2ca..ad64da21c34aa 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1232,6 +1232,8 @@ static bool user_event_match(const char *system, const char *event,
 
 	if (match && argc > 0)
 		match = user_fields_match(user, argc, argv);
+	else if (match && argc == 0)
+		match = list_empty(&user->fields);
 
 	return match;
 }
-- 
2.39.2

