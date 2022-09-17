Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC0C5BB829
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIQMYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 08:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIQMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 08:24:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9815A06
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 05:24:49 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MV95P692QzmV5w;
        Sat, 17 Sep 2022 20:20:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 20:24:47 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 17 Sep
 2022 20:24:47 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH -next 1/2] ALSA: mts64: Switch to use list_for_each_entry() helper
Date:   Sat, 17 Sep 2022 20:31:54 +0800
Message-ID: <20220917123155.1899689-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use list_for_each_entry() helper instead of list_for_each() and
list_entry() to simplify code a bit. No functional change.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/drivers/mts64.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index d3bc9e8c407d..746ac25a319e 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -752,7 +752,6 @@ static int snd_mts64_rawmidi_create(struct snd_card *card)
 	struct mts64 *mts = card->private_data;
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_substream *substream;
-	struct list_head *list;
 	int err;
 	
 	err = snd_rawmidi_new(card, CARD_NAME, 0, 
@@ -778,16 +777,16 @@ static int snd_mts64_rawmidi_create(struct snd_card *card)
 
 	/* name substreams */
 	/* output */
-	list_for_each(list, 
-		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substreams) {
-		substream = list_entry(list, struct snd_rawmidi_substream, list);
+	list_for_each_entry(substream,
+			    &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substreams,
+			    list) {
 		sprintf(substream->name,
 			"Miditerminal %d", substream->number+1);
 	}
 	/* input */
-	list_for_each(list, 
-		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams) {
-		substream = list_entry(list, struct snd_rawmidi_substream, list);
+	list_for_each_entry(substream,
+			    &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams,
+			    list) {
 		mts->midi_input_substream[substream->number] = substream;
 		switch(substream->number) {
 		case MTS64_SMPTE_SUBSTREAM:
-- 
2.25.1

