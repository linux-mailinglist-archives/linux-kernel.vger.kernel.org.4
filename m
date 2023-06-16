Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C17732E52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbjFPKbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344767AbjFPK3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:29:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A73ABE;
        Fri, 16 Jun 2023 03:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4FD6361A;
        Fri, 16 Jun 2023 10:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C14C433C0;
        Fri, 16 Jun 2023 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911196;
        bh=9/v84xVX9Fh50n5P16H8hP2KaHmXMwGYY7S3patTJbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVJRXV5UWWZb4WPpDOiCJzBUPwb2TnUZlaVGm8gzx9pyGvIrSeSfBgGaDoFkosiMC
         kaqW2PUDTvIQwA+mFqXI2rwFfTwddCOs/h80CaiNcNG4DdU7KbY5X4/2Ln4bs6oCor
         6yw9do/PVzQmJe97Qj2jR9LFc9vDDwV5xQR7XM8Q/N3IBh9lorq1N2ojByWSmautQn
         Gg5tJodDEivcARM2+/7L1+uj1S2naFJN44TWjLfz/i+QOsdA2lvQiY7ybBru0lgDyF
         icgELBrHTGyD/pn+GaEvGQEOxPZumiJFnlmvjsNxXqkqLILiqmuNnalXF7aHyD8Pxg
         iSArXdzfyPwUQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, krzysztof.kozlowski@linaro.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 06/26] ASoC: codecs: wcd938x-sdw: do not set can_multi_write flag
Date:   Fri, 16 Jun 2023 06:26:03 -0400
Message-Id: <20230616102625.673454-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 2d7c2f9272de6347a9cec0fc07708913692c0ae3 ]

regmap-sdw does not support multi register writes, so there is
no point in setting this flag. This also leads to incorrect
programming of WSA codecs with regmap_multi_reg_write() call.

This invalid configuration should have been rejected by regmap-sdw.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230523165414.14560-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 402286dfaea44..9c10200ff34b2 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1190,7 +1190,6 @@ static const struct regmap_config wcd938x_regmap_config = {
 	.readable_reg = wcd938x_readable_register,
 	.writeable_reg = wcd938x_writeable_register,
 	.volatile_reg = wcd938x_volatile_register,
-	.can_multi_write = true,
 };
 
 static const struct sdw_slave_ops wcd9380_slave_ops = {
-- 
2.39.2

