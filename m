Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB76336E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiKVIVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiKVIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:21:11 -0500
Received: from out29-121.mail.aliyun.com (out29-121.mail.aliyun.com [115.124.29.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD5C40443
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:21:08 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08002614|-1;BR=01201311R161S84rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00516761-0.000814287-0.994018;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.QE3zAv6_1669105264;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.QE3zAv6_1669105264)
          by smtp.aliyun-inc.com;
          Tue, 22 Nov 2022 16:21:05 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     perex@perex.cz, tiwai@suse.com, aichao@kylinos.cn,
        wanjiabing@vivo.com, ubizjak@gmail.com
Cc:     tiwai@suse.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix urb timeout with URB_ISO_ASAP flag
Date:   Tue, 22 Nov 2022 16:20:40 +0800
Message-Id: <20221122082040.48591-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the loglevel is greater than 4, with a long messages printed on the
console while playing or recording audios, the usb controller may become
abnormal.
`usb 1-2: timeout: still 1 active urbs on EP #1`

Fix it by configuring the transfer_flags URB_ISO_ASAP flag.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 sound/usb/endpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 310cd6fb0038..df9a91c2fc7d 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1245,7 +1245,7 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
 		if (!u->urb->transfer_buffer)
 			goto out_of_memory;
 		u->urb->pipe = ep->pipe;
-		u->urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
+		u->urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
 		u->urb->interval = 1 << ep->datainterval;
 		u->urb->context = u;
 		u->urb->complete = snd_complete_urb;
@@ -1288,7 +1288,7 @@ static int sync_ep_set_params(struct snd_usb_endpoint *ep)
 		u->urb->transfer_dma = ep->sync_dma + i * 4;
 		u->urb->transfer_buffer_length = 4;
 		u->urb->pipe = ep->pipe;
-		u->urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
+		u->urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
 		u->urb->number_of_packets = 1;
 		u->urb->interval = 1 << ep->syncinterval;
 		u->urb->context = u;
-- 
2.29.0

