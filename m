Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFB86AE700
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCGQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCGQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:43:52 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E62E0D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:41:08 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 1F2BC24027A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:40:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1678207229; bh=NuO8UAZcKVDSwoFoeZu9FBy6Ay4iiw09tdqRjBF8Ies=;
        h=From:To:Cc:Subject:Date:From;
        b=D26WLG0/L6TQuTI+MRYCsOI6ePQjCzQ3YOKIaJKeNyT1+ls/gowd/1N2v8uu1W0Ch
         wW9JSzkZ9lDYn37n3ecJIa9UpjuD8cTmV5QNRl6ksWCji0Ggd8sXu+0Z98FjpfEnO/
         KL3PTnT2/INqeEwHmbyC2oTOxUAWkB3VsVUCqZYfOFUPEFTkdMz6FHpwsaocOOHN0W
         K+FDCNih5W+1TKVygc0Jv9FoCu5TzeadVJhu+QTDSV3GSq2TImf9escB8WEPMqWoRL
         ozMtjvHUao+0WC0KIM9+AsGFjPV91BoeLDrG2W+QD8SVgQlzsUWfVB3UWJWvuLl/W7
         HhwuOLLnOng7Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PWLlv686Dz9rxD;
        Tue,  7 Mar 2023 17:40:27 +0100 (CET)
From:   "Hamidreza H. Fard" <nitocris@posteo.net>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Hamidreza H. Fard" <nitocris@posteo.net>
Subject: [PATCH] ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book2 Pro
Date:   Tue,  7 Mar 2023 16:37:41 +0000
Message-Id: <20230307163741.3878-1-nitocris@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Galaxy Book2 Pro (13" 2022 NP930XED-KA1DE) with codec SSID
144d:c868 requires the same workaround for enabling the speaker amp
like other Samsung models with ALC298 code.

Signed-off-by: Hamidreza H. Fard <nitocris@posteo.net>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3c629f4ae080..ef78553fe6f0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9539,6 +9539,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc830, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc832, "Samsung Galaxy Book Flex Alpha (NP730QCJ)", ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xca03, "Samsung Galaxy Book2 Pro 360 (NP930QED)", ALC298_FIXUP_SAMSUNG_AMP),
+	SND_PCI_QUIRK(0x144d, 0xc868, "Samsung Galaxy Book2 Pro (NP930XED)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),

base-commit: a1eeed68b1f1d23ed05f66f43058988ba734ba8f
-- 
2.39.2

