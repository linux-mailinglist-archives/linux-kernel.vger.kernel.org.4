Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D4729605
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbjFIJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbjFIJzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:55:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5392F5FD0;
        Fri,  9 Jun 2023 02:46:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so5591488a12.1;
        Fri, 09 Jun 2023 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686304007; x=1688896007;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18c79hnDSol/lBi2kkuQKTV8w701gqJ/4FZD+vDn/9w=;
        b=I9/U+zVxfjzKwTE+vEEcFRITFriLK3T5XcoQyJqieapFjlNorTQlD1koiOAIF6Xt+n
         AMCi3dyNl8BeqLFktQzj4s9/lxpsIYgAJFi+J5C2wsbqlsSI3exRfNgbTVQU99/J4h5q
         9KWR04TSSwa0a//Ltx6yLGXYgH3j063VnROZrjbWuOG0B/izMtNICgakgeaihjVqf1N4
         iyFqLH4+QOD8jaAyIKrd1378hggNd1+MiL/7Uwa8QvzA8AyInmweJaZLPZshoepBpCkK
         DnDFpkjbYjrIsaLhkOgXObIP71k85pqfwQ03jwC679vXozeXePfx4VLeqhfPjAEBYh2m
         E1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304007; x=1688896007;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18c79hnDSol/lBi2kkuQKTV8w701gqJ/4FZD+vDn/9w=;
        b=QnUMB06Qg0EZ2Ki5eYc0/aXMckYFg3qF1bw4sOh4ykfffyQR3NWOZpTti7x6dHIkew
         9jaush+W8jXW49GqaG1qjNVdHuFyoji1hu9c2tLwgetQcF8C2bJMdKTEzyysHAeBRUMH
         AQ6M5dV+/ms/1Uj7rCxdeoQSqDZbpRuRIyaVB2SxYJitxUXi5NuXMwdd/4q0wAU/j/vp
         yJDv9g6XGH/gRWvSbbpK+HQFRvEUPASzu2CujHhLGF/+0XxfE6kO9fB18zxlCQLUBbh9
         GmEyL4aD/Nt0w2MGoCzqAedjDKmh/qkPm8RrJw6uJGSJA/F9IGZVdILIRZ858IZpSOih
         kAbw==
X-Gm-Message-State: AC+VfDwWlHVPtLf89igxoZakIOOG+sKauV+icbJqPTz4NV2DicO1DJkE
        BstHLObsRg/5YR7Tsh1wVWg=
X-Google-Smtp-Source: ACHHUZ6mP5Egj/gfBwjg3Z6eWXv7Ale5idZVR9M8IesXcSJpTUp0x1P2IWj5tcwY5FfxP3RBJKGtrg==
X-Received: by 2002:a17:907:2d93:b0:96f:add6:c1ed with SMTP id gt19-20020a1709072d9300b0096fadd6c1edmr1390429ejc.38.1686304007232;
        Fri, 09 Jun 2023 02:46:47 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:f180:ae6e:6e9a:f400])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906085700b00978874d1083sm1052591ejd.135.2023.06.09.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:46:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] posix-timers: refer properly to CONFIG_HIGH_RES_TIMERS
Date:   Fri,  9 Jun 2023 11:46:43 +0200
Message-Id: <20230609094643.26253-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c78f261e5dcb ("posix-timers: Clarify posix_timer_fn() comments")
turns an ifdef CONFIG_HIGH_RES_TIMERS into an conditional on
"IS_ENABLED(CONFIG_HIGHRES_TIMERS)"; note that the new conditional refers
to "HIGHRES_TIMERS" not "HIGH_RES_TIMERS" as before.

Fix this typo introduced in that refactoring.

Fixes: c78f261e5dcb ("posix-timers: Clarify posix_timer_fn() comments")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/time/posix-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8bb0dcf2e3d9..17fff6826a15 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -356,7 +356,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 			 * enabled as the periodic tick based timers are
 			 * automatically aligned to the next tick.
 			 */
-			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
+			if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS)) {
 				ktime_t kj = TICK_NSEC;
 
 				if (timr->it_interval < kj)
-- 
2.17.1

