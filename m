Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00D062DAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbiKQMdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiKQMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:33:08 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4A876146;
        Thu, 17 Nov 2022 04:32:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k19so2529940lji.2;
        Thu, 17 Nov 2022 04:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25zzCeIdQLt2oZnq3HAIA1FC7vZFFoxeYg3WH60K9nE=;
        b=qPGMkYweiJF1ezIePnlKNNr50vIJs3qoth6up0ubbki0AWF6i0eXAYm4WpLeQrR6sV
         RI/LDYMNVXusVREwcxiVtzn7fXDWZxc6vm2I2uUgWz6FS1D8PTc3E+NjhbNGqrhdyxSB
         urKQy6MCHB6xfhCuQIWsIR8ezalcpIoP9jLu2A6Rj9pbZ2TWKWlUTT/CLpcd09/Lz8Bp
         FhpAutf3kXqJqaLqKNuFdzmKCmVhVEnQMDTjKQ9wK6taAILCYbuDCjFIIQ+3RIpbgPiX
         n8RaLcWHx9Q3Tgi88H2LjUyGC/dvCgrPi6EVONCZRFGX51Q06JkviHBloW+6gbQwcfMD
         L+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25zzCeIdQLt2oZnq3HAIA1FC7vZFFoxeYg3WH60K9nE=;
        b=O/fKsGU3j2DVZxeE6U1ReervR3VNCV0Dn8E/QLyR0PQrRSQUpYta7NjpcKpb2Tts5s
         3dqYIh4JgytuSFMPgwuFCIdUE0XtrUiAXvXkl9WKqF7LCAaXZoZ1fBR7YIiLDJvLCh9Q
         EaRR+BUpXqXJYJikyOYQ4K/ePaiX5PqJ6LPUlznmjLq26KpwEe5DdCy0ZogLGWbrYMPD
         W+VwV/yu9XgTbC4OrI/ucu8axa3f7QKiTLeFBVmNDi0eKL1LJl8NDLKXGEJZAGqpmFUR
         wXiH2iK3BF7h68rZuJBCcg/o8Xp3aX186tZkq4o9S3k1V5I1GHeTEH26GhgGz2hEa8Ay
         r32w==
X-Gm-Message-State: ANoB5pmdUNUEyTZR6tMNoQNsqyj0M1Usy80qF3yIdsrsohbiQn3d/JIB
        LFc8Tck5/rOv5gGeyVUQuwY=
X-Google-Smtp-Source: AA0mqf47EjZ7iHBlfAyyzeU7WAqvnuY3fphQib5vR6FIP9s2zwOuCRM7n70HaCpEFq6uQmqJt34J4Q==
X-Received: by 2002:a2e:88d3:0:b0:277:72a:41a5 with SMTP id a19-20020a2e88d3000000b00277072a41a5mr1020205ljk.352.1668688336925;
        Thu, 17 Nov 2022 04:32:16 -0800 (PST)
Received: from mkor.rasu.local ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id k20-20020ac24f14000000b0049ad315cfc3sm127362lfr.162.2022.11.17.04.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:32:16 -0800 (PST)
From:   Maxim Korotkov <korotkov.maxim.s@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Manjunathappa, Prakash" <prakash.pm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] pinctrl: single: Fix potential division by zero
Date:   Thu, 17 Nov 2022 15:30:34 +0300
Message-Id: <20221117123034.27383-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a possibility of dividing by zero due to the pcs->bits_per_pin
if pcs->fmask() also has a value of zero and called fls
from asm-generic/bitops/builtin-fls.h or arch/x86/include/asm/bitops.h.
The function pcs_probe() has the branch that assigned to fmask 0 before
pcs_allocate_pin_table() was called

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 67bec7ea0f8b..414ee6bb8ac9 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -727,7 +727,7 @@ static int pcs_allocate_pin_table(struct pcs_device *pcs)
 
 	mux_bytes = pcs->width / BITS_PER_BYTE;
 
-	if (pcs->bits_per_mux) {
+	if (pcs->bits_per_mux && pcs->fmask) {
 		pcs->bits_per_pin = fls(pcs->fmask);
 		nr_pins = (pcs->size * BITS_PER_BYTE) / pcs->bits_per_pin;
 	} else {
-- 
2.17.1

