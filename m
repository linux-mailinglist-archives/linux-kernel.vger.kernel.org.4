Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116560ADD6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiJXOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbiJXOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:36:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DFA43AD3;
        Mon, 24 Oct 2022 06:10:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so6578837wmq.4;
        Mon, 24 Oct 2022 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ckwP6SZrttFwr6q/sGcNYSFGy/msNDVyZpAOWEeZ8w=;
        b=inKQ1QRQBd2kH0yamrljN5I7Tavh58rIwYt8BjFrJvvpqQnI87e5BM8m11dqOvATDX
         O0dN7xO2ogwyzHdwfIIF/9S+5JTqPihCSDcaLTTRNaMh+rsvRYK3pxMESywxnoDdd9O3
         Gbgvat5iOIZihcIdE5K7hGTgd9XXTmmb1P4Gq4FpQoG4Hdkx7MPWgBX+7/hacySY/7rk
         DGJwIKStLujvhDDabIJd/RC3d6DwMrDVuu0ne2UI49WcRHy8ghSWPydJedtmkpc6ToCe
         dujR1Bz3i65aZPdHRL27ttEwdIey8yWxuVKvKlbLE0kA8frWmyqkURU9Wzm8atEMgB6P
         rSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ckwP6SZrttFwr6q/sGcNYSFGy/msNDVyZpAOWEeZ8w=;
        b=d6ZiKU8Bhr1x9bSRkxtDJShxVUt+XjlS1u4ih/J0Myir7nldHAoK6hWLPe7ki0Z55U
         MNs8WX1q4zCgmfF/URsn9LaBlECBEE4gjpGm/dNAXCcToszRW9VXROXoJbrToYyy6Le4
         jOSvBjhE7/9M6oqsLtL2DTFW/Gy+EtHG3V1do1eBJ+4q4X77lNSsSfuN8GYZcbrQg5hx
         M2sATsKMDt9SqctndSx8UesnFFtVsPkyG54Qcd8C6leBdWktgG+2ClU4PAwQpUb0TSdL
         /KGSSr/x/XAkUCStJuhiOmxYd3jS+xAcs3wkM8ECvjh9wSiPrdWu86LcOdzIkkv47qa3
         HIPg==
X-Gm-Message-State: ACrzQf1LwI/qxPvu9fWlBWwVyH2sMY+YsGYW3osjS0OKskUaJtRBonJG
        oGuiXgZpSvM742yHECsbcfQ=
X-Google-Smtp-Source: AMsMyM4Eux5p6QGnnjdVJQNbuM9tL3KSnsNRcKXNy+skLIDyzqy4y86gJPUNpqIBsvvckFcimdUQGg==
X-Received: by 2002:a05:600c:4618:b0:3c6:bf28:ae64 with SMTP id m24-20020a05600c461800b003c6bf28ae64mr44399479wmo.51.1666616884152;
        Mon, 24 Oct 2022 06:08:04 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d1-20020adff2c1000000b0022ac1be009esm27228344wrp.16.2022.10.24.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:08:03 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: asihpi: remove variable loops
Date:   Mon, 24 Oct 2022 14:08:03 +0100
Message-Id: <20221024130803.2156295-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable loops is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/asihpi/asihpi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 8de43aaa10aa..001786e2aba1 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -725,7 +725,6 @@ static void snd_card_asihpi_timer_function(struct timer_list *t)
 	unsigned int pcm_buf_dma_ofs, min_buf_pos = 0;
 	unsigned int remdata, xfercount, next_jiffies;
 	int first = 1;
-	int loops = 0;
 	u16 state;
 	u32 buffer_size, bytes_avail, samples_played, on_card_bytes;
 	char name[16];
@@ -806,7 +805,6 @@ static void snd_card_asihpi_timer_function(struct timer_list *t)
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->control->appl_ptr)
 		);
-		loops++;
 	}
 	pcm_buf_dma_ofs = min_buf_pos;
 
-- 
2.37.3

