Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0E73F480
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjF0G0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjF0G0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:26:19 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DAD882117
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:26:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 93E676027C75A;
        Tue, 27 Jun 2023 14:26:02 +0800 (CST)
X-MD-Sfrom: dengxiang@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   dengxiang <dengxiang@nfschina.com>
To:     tiwai@suse.com, yangyingliang@huawei.com
Cc:     linux-kernel@vger.kernel.org, dengxiang@nfschina.com
Subject: [PATCH] Asoc: alc897: EAPD pin47 cannot work.
Date:   Tue, 27 Jun 2023 14:25:51 +0800
Message-Id: <20230627062551.25775-1-dengxiang@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to unknown reason that snd_hda_intel would disable codec
wakeup twice during snd_hda_intel initialization, Internal SPK is forbidden
to put sound outside with snd_hda_intel driver on Unis B760 sku machine.
PIN47 EAPD status need be pulled down to work normally.

Signed-off-by: dengxiang <dengxiang@nfschina.com>
---
 sound/pci/hda/patch_realtek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a7e4765eff80..89a5d067b36d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -534,6 +534,16 @@ static void set_eapd(struct hda_codec *codec, hda_nid_t nid, int on)
 {
 	if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
 		return;
+
+	switch (codec->core.vendor_id) {
+	case 0x10ec0897:
+	case 0x80867a50:
+		on = 0;
+		break;
+	default:
+		break;
+	}
+
 	if (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD)
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_EAPD_BTLENABLE,
 				    on ? 2 : 0);
-- 
2.30.2

