Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81064C8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiLNMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiLNML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:11:29 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC726449
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:08:53 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id t191so3033722vkb.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf+Vr0pRRm+g6xOX7ieFyP1z/I6/3Npa8I3VTgkFW+o=;
        b=i1c6ejlIYQnnur8KETCLFxe1wg5i+fbDy2x5JdK7u8C+e568BRU7RyJ5QlqaRZekzA
         IwqSUuVPCvNRHGfk1QF+1Szw+JAIPJC0pPjDlANLUtM4+hwPqCC8e5hZoE2LjGpkhs/F
         LPb6vLeRLuMhVBvDiUymbuwXodVmPQ6HJL1H3G8aNzwdI0yml0ys0jqa5FmlPQagg93j
         irjaHkhcr54RUMoFqoRJ+ahGob2VyyaaKfq5gctM68jmdwvKBGgsyEMncvu97YZFxMPd
         NYOHDqRnJ87pW1ZJqh1uYqKQo3iI1z5f0rp4Nb3hdXpl4Kav/RLXoTgOQ1h8/heBxDMU
         f++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rf+Vr0pRRm+g6xOX7ieFyP1z/I6/3Npa8I3VTgkFW+o=;
        b=yM8lqQ99U2fCcyaBy6b4WbZoGVSll2UxrsiZ7srsV+J6coNwffkgS7RLfdg8cHNsOm
         d9b2aLCThNfDX0VMEsDnHhQv4S8gxEU7C9n96mHK+jbmK6Dks8cODjz+SKh+jJs3l80w
         4lalFvi5qRgMlUcQsVE6IrjjGlLlbbeAxLGSSZGit4PZjltx372Uv+GrvBIm9/a7+qkQ
         vc6pEtT2s/3qwG7b76vnHt2m/3/FPL30EhUFB0NqGn4fsLYZ4MOCsCIyKFjTkaQo2Mv9
         Ieu8Y37cN/wscWF159yfMQkzio66ywdPTzvx2sMH/QxGTEbPa0Bd2uZHEqgfdA5r318o
         Ycpw==
X-Gm-Message-State: ANoB5pnRpP63MNtUcT4J7+qzl1MlJteN7qZs6Qym7dk2tLJBbsKrpW2p
        JZJKLb0o3jyYE5Ok+qM1RYo=
X-Google-Smtp-Source: AA0mqf7vm0xnBYatIlyrA1OJT7EpcP5aZDNqdOpg8SnqqbTLBUCwMT/3KuHrxhSN3qQJcOPIAs7n4A==
X-Received: by 2002:a1f:2b86:0:b0:3b6:c28e:1b14 with SMTP id r128-20020a1f2b86000000b003b6c28e1b14mr2041720vkr.1.1671019732178;
        Wed, 14 Dec 2022 04:08:52 -0800 (PST)
Received: from lenovo-y720.. (097-101-018-014.res.spectrum.com. [97.101.18.14])
        by smtp.gmail.com with ESMTPSA id o17-20020a1f4111000000b003b89f00e276sm390421vka.40.2022.12.14.04.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 04:08:51 -0800 (PST)
From:   Moises Cardona <moisesmcardona@gmail.com>
To:     cezary.rojewski@intel.com
Cc:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, hdegoede@redhat.com, oder_chiou@realtek.com,
        akihiko.odaki@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Moises Cardona <moisesmcardona@gmail.com>
Subject: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Date:   Wed, 14 Dec 2022 07:08:30 -0500
Message-Id: <20221214120830.1572474-1-moisesmcardona@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The bytcr_rt5640.c file already supports the HP Stream 7.

The HP Stream 8 is almost identical in terms of the hardware
with the exception of it having stereo speakers, a SIM
card slot and the obvious size difference.


Signed-off-by Moises Cardona <moisesmcardona@gmail.com>

---
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index fb9d9e271845..569d039d680b 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -796,6 +796,16 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* HP Stream 8 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Stream 8 Tablet"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* I.T.Works TW891 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.37.2

