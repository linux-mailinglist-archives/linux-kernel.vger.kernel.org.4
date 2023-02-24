Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB476A1D38
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBXOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBXOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:07:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0069ADB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:07:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF98061843
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4736AC433D2;
        Fri, 24 Feb 2023 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677247662;
        bh=Oq2cgGTNFolGMp2hlVeWgvvLAmgRBdfsEVQSk6MsZsY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uKKPbBrVYPXVtVtVuluQ0hZNDzeo41eFFiaJBZlmJc0FJjaH5Mrk83kF1sYILsIbw
         1n03r2XCb1ES0nFnDrMH7Lv0rlDun+8sy9T3o+oJnFzJXNl36xzzZwjp1NWWV42+Gn
         TTxeMwvLe23VtiqM2ydtEazfr3UbzOB4qYLxYUxo5S9nDBEUHtEiY259LNGL4Pixnf
         BRJ9aUj4dKoGSGZzt5s1qHoavhf15xRRGNKbH1Np+Jo45pMHXFNsEqiSUQs/HQ9GZG
         bwyCevc5py6Ezl7afx4i97+D6NZ4nZAkouQM5rvGSFNFQv9lcoFw5rTfnr7WWJIb8J
         AoEF5mr50w6hA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 24 Feb 2023 14:03:57 +0000
Subject: [PATCH 3/4] ASoC: mt8192: Report an error if when an invalid
 sidetone gain is written
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-asoc-mt8192-quick-fixes-v1-3-9a85f90368e1@kernel.org>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Oq2cgGTNFolGMp2hlVeWgvvLAmgRBdfsEVQSk6MsZsY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj+MSiKI/9K+DYjuaCW6GBP9SMdFxb8sNVK2hWQSGR
 k0Ewe1eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY/jEogAKCRAk1otyXVSH0KVdB/
 sHYybcK4VnCEic3yC/2mq3YLv2JzZZtTdDOrDDzw1GALc/ous7F1BMbn4ZjyfaFgQrkmagi+4gmNmA
 burLXblBiKahWsvJsLmUjtZx7SMrkZgvon5LWoX7U4aFw6NewfZdKnyaGE8dn/0yO5wmoV16UmlI7Y
 jWlfvomJnD5oombhkBTGCqZmH3Gbgf2ILKZ918qUxPlzYnj/EWMaoqoEryj4usxbo7nHRxacdcjpDh
 3fWFVmC7mUQ/RI4hVKSRaYmIaA1Gyah+ink0ob8Yosc4fIKT9YV6WJxGghrYft6TeGK55u/1PKvbYa
 SgOkeN91Mr5CQ1HwDbxsR3G32zJLGq
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

Reporting an error on invalid values is optional but helpful to userspace
so do so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
index a33d1ce33349..a02a297c0450 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-adda.c
@@ -601,6 +601,8 @@ static int stf_positive_gain_set(struct snd_kcontrol *kcontrol,
 					 POSITIVE_GAIN_MASK_SFT,
 					 (gain_db / 6) << POSITIVE_GAIN_SFT,
 					 &change);
+	} else {
+		return -EINVAL;
 	}
 
 	return change;

-- 
2.30.2

