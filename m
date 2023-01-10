Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186ED664D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjAJUIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjAJUIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:08:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56D365EB;
        Tue, 10 Jan 2023 12:08:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8235E618F8;
        Tue, 10 Jan 2023 20:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ECAC433EF;
        Tue, 10 Jan 2023 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673381308;
        bh=Rp+czZg6segzTvjYV1RqZZWVIT4bMNdzIqwCOmZs3jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+QtQ41B1Ze0PnE5XECAWtttC0RUHrpS/1C9gX0ONy6cU4ecKHtSCgkk6K/VLMy0G
         oQBt1AtdpBwyZf6kDc5VDMMTdQQ5LPyZshct6Sne1ltP8jzfm4wMJTYTYTH9IGRO88
         TJRdLDycn6cmHIscIHrmFMSVOpp4tMl+AjgX3tvfaNHyUxKXyMd2QIwcD4gb404oIv
         8jXIBs2mRkpMx0egDnTkTgqAbrVL0ta+TaS4J5RoKyGBMuo7zczVPgPCUaTIEoFNbh
         U78yJaIDhF//jyym7ls4mS0wkjFnO1hne1HDemGWLvQON1uZTCF/zgpSYetSyuoff/
         fKCCCSxzxI3lg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] rtla/osnoise: Add the mode abstraction
Date:   Tue, 10 Jan 2023 21:08:04 +0100
Message-Id: <1b7fb58b676509a35104832027fcd1052149a059.1673380089.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673380089.git.bristot@kernel.org>
References: <cover.1673380089.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to the hwnoise tool, add the mode abstraction
to the osnoise tool, so it can have multiple operation modes.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 tools/tracing/rtla/src/osnoise_top.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 76479bfb2922..d7bbd73e1a78 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -14,6 +14,10 @@
 #include "osnoise.h"
 #include "utils.h"
 
+enum osnoise_mode {
+	MODE_OSNOISE = 0,
+};
+
 /*
  * osnoise top parameters
  */
@@ -32,6 +36,7 @@ struct osnoise_top_params {
 	int			set_sched;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
+	enum osnoise_mode	mode;
 };
 
 struct osnoise_top_cpu {
-- 
2.38.1

