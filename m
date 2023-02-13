Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC16694E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBMRlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjBMRlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:41:18 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7263B769
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676310049; bh=gIV/oJRw26WlvPqibHioU11aUhIPun7fMfARunHmZBQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=fGoIHUGorho3vV4FPnzXe5AxlralGTCDzDUI5xIZ4lR8uTvrTxKPPCw/O4IvSFa3/
         ld+jfYUyb8Hvb7YP/7BGGH6p2xMSP7MMVaOWEltVYzmVyRMFdfnw7kmLolGY1MtL0K
         ZhzMEu5q1RSK6BIzxM6+GG0LZYWHzcnIw8lthEZ8=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 13 Feb 2023 18:40:49 +0100 (CET)
X-EA-Auth: aED07gXN0glhKVo5pX08bsrz9596Z3CtvxLY3EviswtJbMPx2KMKyKYpVSExM4qOSx/YOIsZOPfNOTX8GPDySJhsn78U3eDA
Date:   Mon, 13 Feb 2023 23:10:46 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] ASoC: codecs: wcd934x: Use min macro for comparison and
 assignment
Message-ID: <Y+p2Hn0nrtHiKwPR@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by using min helper macro for logical evaluation and value
assignment. The change also facilitates code realignment for improved
readability.
Proposed change is identified using minmax.cocci Coccinelle script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 sound/soc/codecs/wcd934x.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 28175c746b9a..783479a4d535 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -4737,13 +4737,9 @@ static u32 wcd934x_get_dmic_sample_rate(struct snd_soc_component *comp,
 	if (dec_found && adc_mux_index <= 8) {
 		tx_fs_reg = WCD934X_CDC_TX0_TX_PATH_CTL + (16 * adc_mux_index);
 		tx_stream_fs = snd_soc_component_read(comp, tx_fs_reg) & 0x0F;
-		if (tx_stream_fs <= 4)  {
-			if (wcd->dmic_sample_rate <=
-					WCD9XXX_DMIC_SAMPLE_RATE_2P4MHZ)
-				dmic_fs = wcd->dmic_sample_rate;
-			else
-				dmic_fs = WCD9XXX_DMIC_SAMPLE_RATE_2P4MHZ;
-		} else
+		if (tx_stream_fs <= 4)
+			dmic_fs = min(wcd->dmic_sample_rate, WCD9XXX_DMIC_SAMPLE_RATE_2P4MHZ);
+		else
 			dmic_fs = WCD9XXX_DMIC_SAMPLE_RATE_4P8MHZ;
 	} else {
 		dmic_fs = wcd->dmic_sample_rate;
-- 
2.34.1



