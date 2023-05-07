Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8436F957B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjEGAeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjEGAdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552252269D;
        Sat,  6 May 2023 17:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4B1614A8;
        Sun,  7 May 2023 00:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A135FC433D2;
        Sun,  7 May 2023 00:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419560;
        bh=Gi/XeeeFJGaxdykTW9TYbF0cQECHu1dUcrdCmjj4qbA=;
        h=From:To:Cc:Subject:Date:From;
        b=pY4Yg0oHCEOUNVTi0xbZ1JzNtW2iqFNfF9vF2GoUyAKZPo6+XBrEuFuyHReasmP+h
         M4SHU2jBHyClCc3fdcpRhD1LBWPFO+x0rmFH5nCJ15fi6eWc6Qn+5YOLaxETdzNtWL
         2YHi2Lks807evJvqidPD4wJP2kRCpJc0UagXHUuTgArGvznGZs+HbtaKBjnTeDmrJt
         3qneC2JTM26gAWHP+ovuZc8ZlsVMUfPQHrRoTP6qdSwUp1wNnzuXb5g+/Oy0nu5HsN
         JTGyQ285xQbpgidPa9LQikcyJ/BUgCUhUzwvgp3kzTjWBFdY+lButGpXivmIFCIhZT
         GMNbj7MXZgeWg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.2 01/20] ASoC: jack: allow multiple interrupt per gpio
Date:   Sat,  6 May 2023 20:32:16 -0400
Message-Id: <20230507003237.4074305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svyatoslav Ryhel <clamor95@gmail.com>

[ Upstream commit a2d4051b0bd6dffcd736888ae89a550d6f60b060 ]

This feature is required for coupled hp-mic quirk used
by some Nvidia Tegra 3 based devices work properly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Link: https://lore.kernel.org/r/20230221183211.21964-3-clamor95@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fcece5ca38c69..f951acb2ce362 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -367,6 +367,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 
 		ret = request_any_context_irq(gpiod_to_irq(gpios[i].desc),
 					      gpio_handler,
+					      IRQF_SHARED |
 					      IRQF_TRIGGER_RISING |
 					      IRQF_TRIGGER_FALLING,
 					      gpios[i].name,
-- 
2.39.2

