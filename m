Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F13618DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKDBdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDBc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:32:57 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443501CB0F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:32:54 -0700 (PDT)
X-UUID: a83640dbf08d42068760d5fb3362947b-20221104
X-CPASD-INFO: c880302e3dc24631910fba284e6cba80@rIhyUGBiYJVfhKV-g3l-a1liYJaSjVK
        Hdp9Wk5CRZFCVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3snpyUGNeYg==
X-CLOUD-ID: c880302e3dc24631910fba284e6cba80
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:172.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:148.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:0,DUF:7445,ACD:130,DCD:130,SL:0,EISP:0,AG:0,CFC:0.221,CFSR:0.16,UAT:0,R
        AF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,
        EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: a83640dbf08d42068760d5fb3362947b-20221104
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: a83640dbf08d42068760d5fb3362947b-20221104
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 781106644; Fri, 04 Nov 2022 09:32:50 +0800
From:   aichao <aichao@kylinos.cn>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, aichao <aichao@kylinos.cn>
Subject: [PATCH] ALSA: usb-audio: fix usb camero disconnect issue
Date:   Fri,  4 Nov 2022 09:32:36 +0800
Message-Id: <20221104013236.3480427-1-aichao@kylinos.cn>
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

When current rate is different from the runtime rate,
snd_usb_endpoint stop and close endpoint to resetting rate.
if snd_usb_endpoint close the endpoint, sometimes usb will
 disconnect the device.

Signed-off-by: aichao <aichao@kylinos.cn>
---
 sound/usb/pcm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 5dc9266180e3..2ae4a55cbaa8 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -517,7 +517,6 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		if (snd_usb_endpoint_compatible(chip, subs->data_endpoint,
 						fmt, hw_params))
 			goto unlock;
-		close_endpoints(chip, subs);
 	}
 
 	subs->data_endpoint = snd_usb_endpoint_open(chip, fmt, hw_params, false);
@@ -546,9 +545,6 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	ret = configure_endpoints(chip, subs);
 
  unlock:
-	if (ret < 0)
-		close_endpoints(chip, subs);
-
 	snd_usb_unlock_shutdown(chip);
  stop_pipeline:
 	if (ret < 0)
@@ -574,7 +570,6 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	if (!snd_usb_lock_shutdown(chip)) {
 		if (stop_endpoints(subs))
 			sync_pending_stops(subs);
-		close_endpoints(chip, subs);
 		snd_usb_unlock_shutdown(chip);
 	}
 
-- 
2.25.1

