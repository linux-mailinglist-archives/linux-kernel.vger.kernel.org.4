Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D46E5FFCA1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 01:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJOXeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 19:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 19:34:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC21DA62
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:34:16 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1326637be6eso9823135fac.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1m0RqvaU8CcvLjEgPz7d1jceF1TiMS+vA+25fd7T9/E=;
        b=muSxxihox91FUI6kHRr7yKu3S6AalcTSrfFTR3dM9yTcSzf+UVf7XV4Y3/C6HLcbzC
         zF56a9IHWYGmkkobPmNpdirA8S7oBMeRcxAx23Nyn78WIhk7S8Je6AV7qAyfb03nkTHE
         YGnu26myGPJXp8c8SyHgGcKnqYfOHQlVMZAydrZiIBaBahKlenipi+6lArTqftxVHg54
         zSTgIT+M2XXE+ifzByhe5LWADKXRhlorj55OEEjwNGcJALm8Du5jEclq1Uxyd69y2L0j
         ilNv1fYAQW8pMEJ4WFyzQ9/LPLFrnTViQ4yCYcOjvso+1RsNT+9epgaZK5GW+dlVMqVl
         SCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1m0RqvaU8CcvLjEgPz7d1jceF1TiMS+vA+25fd7T9/E=;
        b=aLamOOXbPMZ6RygeKWhwe8ZLiRAMksspNFhuNzwN0LV+mSkOzQ9bdQseUdv6A9+sQj
         4gI24mKhGEgQ2dA4aVtd7qqVVSsjzjf/4GorsuyJVKsPKcfMG/3yN7Wv2c+rRT0rr62D
         Qpj/s+qEVcePdb7lBK8I24BN5Euj4uvEfv5uZVtcyOsa+vRhA/SQQg2xCJjr6FWqe+oZ
         lqENnzDRu1bl6WNwU4behmvw7c16HcmEyiH0soR5lMbzoDy2II+nr+ZmE80DKhlJmaQN
         xFbEMrHNxQ1qUAwmNWi9eYHbbdwcQkxHf3sxiZvPsHjQHn9FFt3EiGaizZkXBp8sklw1
         1RCg==
X-Gm-Message-State: ACrzQf15fQirODQZDebZovc87eMfkE/HWjYP5m+bAfqrEBXacdaG1ZZf
        CXp4LgCHkNFs0mfELwDEM+U=
X-Google-Smtp-Source: AMsMyM6NpoEW7uV+vjQlw5+5bf1zbaYszcJOVcIsToHnDYk6J5ZzPaW3K2Vq+4FMMgDUoApvN7mphw==
X-Received: by 2002:a05:6871:28e:b0:136:4f44:78a7 with SMTP id i14-20020a056871028e00b001364f4478a7mr11526358oae.264.1665876856020;
        Sat, 15 Oct 2022 16:34:16 -0700 (PDT)
Received: from bebop.lan (2603-8080-2704-6601-b457-170a-9e05-cc6d.res6.spectrum.com. [2603:8080:2704:6601:b457:170a:9e05:cc6d])
        by smtp.gmail.com with ESMTPSA id w3-20020a4adec3000000b004808e0d8467sm2653858oou.2.2022.10.15.16.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 16:34:15 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 1/2] sound: dice: Fix "Firestudio" typo
Date:   Sat, 15 Oct 2022 18:33:29 -0500
Message-Id: <20221015233330.8679-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221015233330.8679-1-thirtythreeforty@gmail.com>
References: <20221015233330.8679-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functionality change, just a small cleanup before adding the
Firestudio Mobile.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 sound/firewire/dice/dice-presonus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice/dice-presonus.c b/sound/firewire/dice/dice-presonus.c
index 967cc3119a64..c85178e64667 100644
--- a/sound/firewire/dice/dice-presonus.c
+++ b/sound/firewire/dice/dice-presonus.c
@@ -11,7 +11,7 @@ struct dice_presonus_spec {
 	bool has_midi;
 };
 
-static const struct dice_presonus_spec dice_presonus_firesutio = {
+static const struct dice_presonus_spec dice_presonus_firestudio = {
 	.tx_pcm_chs = {{16, 16, 0}, {10, 2, 0} },
 	.rx_pcm_chs = {{16, 16, 0}, {10, 2, 0} },
 	.has_midi = true,
@@ -23,7 +23,7 @@ int snd_dice_detect_presonus_formats(struct snd_dice *dice)
 		u32 model_id;
 		const struct dice_presonus_spec *spec;
 	} *entry, entries[] = {
-		{0x000008, &dice_presonus_firesutio},
+		{0x000008, &dice_presonus_firestudio},
 	};
 	struct fw_csr_iterator it;
 	int key, val, model_id;
-- 
2.38.0

