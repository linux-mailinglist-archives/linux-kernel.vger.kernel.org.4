Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A65619214
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKDHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDHf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:35:28 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4165D2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:35:25 -0700 (PDT)
X-UUID: 1f4c790098d84c258246e053a3af6d50-20221104
X-CPASD-INFO: ae1fd406ff49445a8bea0bddb1cba13d@qrVrhpFmXmaShnaFg3eAm1iTlZFgjoS
        zpGuDko9hX4SVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3sKdrhpRiYA==
X-CLOUD-ID: ae1fd406ff49445a8bea0bddb1cba13d
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:161.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:99.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:1,DUF:7502,ACD:131,DCD:131,SL:0,EISP:0,AG:0,CFC:0.278,CFSR:0.087,UAT:0,R
        AF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,
        EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 1f4c790098d84c258246e053a3af6d50-20221104
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 1f4c790098d84c258246e053a3af6d50-20221104
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1062749013; Fri, 04 Nov 2022 15:35:29 +0800
From:   aichao <aichao@kylinos.cn>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, aichao <aichao@kylinos.cn>
Subject: [PATCH] ALSA: usb-audio: fix Hamedal C20 usb camero disconnect issue
Date:   Fri,  4 Nov 2022 15:35:18 +0800
Message-Id: <20221104073518.120807-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Hamedal C20, the current rate is different from the runtime rate,
snd_usb_endpoint stop and close endpoint to resetting rate.
if snd_usb_endpoint close the endpoint, sometimes usb will
 disconnect the device.

Signed-off-by: aichao <aichao@kylinos.cn>
---
 sound/usb/endpoint.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 533919a28856..c19e420b1780 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -825,7 +825,9 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 	usb_audio_dbg(chip, "Closing EP 0x%x (count %d)\n",
 		      ep->ep_num, ep->opened);
 
-	if (!--ep->iface_ref->opened)
+	if (!--ep->iface_ref->opened
+		&& (le16_to_cpu(chip->dev->descriptor.idVendor) != 0x0525)
+		&& (le16_to_cpu(chip->dev->descriptor.idProduct) != 0xa4ad))
 		endpoint_set_interface(chip, ep, false);
 
 	if (!--ep->opened) {
-- 
2.25.1

