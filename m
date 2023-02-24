Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5346A1D36
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBXOHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:07:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB269ADA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7ED5CE238A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A58EC433EF;
        Fri, 24 Feb 2023 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677247654;
        bh=6WgQseSSE1/0RjYTZmTF8phVwKCFajro+gk7cetd7fg=;
        h=From:Subject:Date:To:Cc:From;
        b=e3icBfRRHSaWBxoU7LXlhkkJ0dYzqRGcFoeLU+fspHDzlaA9zBC8GeNEr0XoWqRYb
         XrWCoGjjVBIjqcs7d4Fn0XnOqYQPZ66sLSLH85VvoqWnwlZbCSUYTqBzMqkbk9Gol+
         qJyNPR1dH8GkTHU/eTurusY2fu4NeKRdFDjG5Ci98wc7ru8+xQso8CEw4jFzJd9hlb
         aZABOvgqo7J2hWYjnyLse4bS0PkJM5HA1SkEOKbThYc9T6S5x7xLhJ60RS0EJu/apn
         lhCFM1kQJZGHnb3Qjo7eTeasTkDA7K/1drnv3JHFpNrmyqdmpU7BU6FNYQU88xQxys
         CN+qvpn2mCfkw==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] ASoC: mt8192: Fixes from initial glance at kselftest
 run
Date:   Fri, 24 Feb 2023 14:03:54 +0000
Message-Id: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrD+GMC/x2L0QrCMAwAf2Xk2UCbwqz+iviQdZkLsm42U4Sxf
 7fz8Y67DUyKisG12aDIR03nXMGfGkgj54eg9pWBHAVHFJBtTjit0V8IX29NTxz0K4ZxCOLYxzN
 RC/Xu2AS7wjmNx79Oy2GXIv+8qtt9338NhGfcfwAAAA==
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6WgQseSSE1/0RjYTZmTF8phVwKCFajro+gk7cetd7fg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj+MSgptemsOYFwoH0fc5cIPy9dkZo6raLVN9t/bwB
 +1VF2laJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/jEoAAKCRAk1otyXVSH0F4CB/
 wO8wM26BECdCimtw2TUtGGjddmXPhsckwQto7lBLJnqtFnOxrYE4eHSGXjRkRyvFN1BjKnEObQY6Cb
 ZrzIw5s7kYMxAd0ik6y/+TOM5X+a2h7PJvwkfFlQEnTNUXz06e+Wr7+2th0RPw28ovpvrv9suUyjMf
 PrlaTSKbcvL/ThYL94y2bKP8bqL9segFhHf8NwSpneSBlVAsg3lHNb2tUKoVxZP4OeTMNSgMTlyYxd
 GfYjWV1qZgwIKdzteb1WDVZQn20VkgeGqSy4G+XqdAsor1IPfo26xdcE0snqTs7tID86Yvi9yBN9ss
 MfryzIZcD7L/hWfFve8dZ9/dvrj84m
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of fixes I came up after glancing through an
initial test run with the Spherion Chromebook on KernelCI.  There are
more issues flagged, this is just what I fixed thus far - the volume
controls on the MT6359 have issues for example, and a lot of controls
aren't marked as Switches like they should be.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (4):
      ASoC: mt8192: Remove spammy log messages
      ASoC: mt8192: Fix event generation for controls
      ASoC: mt8192: Report an error if when an invalid sidetone gain is written
      ASoC: mt8192: Fix range for sidetone positive gain

 sound/soc/mediatek/mt8192/mt8192-dai-adda.c | 58 ++++++++++-------------------
 1 file changed, 19 insertions(+), 39 deletions(-)
---
base-commit: b361d5d2464a88184f6e17a6462719ba79180b1a
change-id: 20230223-asoc-mt8192-quick-fixes-8f3e0a187226

Best regards,
-- 
Mark Brown <broonie@kernel.org>

