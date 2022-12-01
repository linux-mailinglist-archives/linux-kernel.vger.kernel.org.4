Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44F63E989
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLAF5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLAF5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:57:51 -0500
X-Greylist: delayed 1813 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 21:57:46 PST
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B38FADED3;
        Wed, 30 Nov 2022 21:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2sfL8
        8ljNExUazjMx4B4afbjkoUHlImO6mzjH+QoguQ=; b=jK0KPFGiUI13oPcvmG2ZU
        Hlj/tc9TZ89hHgS/1pOTcIKkq45XUyvIU98H22l70SC4ir+je5h/EDQgbpcVYyGk
        USi+aH8y0HPZqEj14Vz/OI1Kfh/8uxzdYn2lVBjbJ45yGUjCnyg9IXnU7Isk3ner
        9I+B77RBV3gDqBsyRst7Do=
Received: from localhost.localdomain (unknown [222.93.197.62])
        by smtp3 (Coremail) with SMTP id DcmowADHzrIwO4hjQA7aEg--.9053S2;
        Thu, 01 Dec 2022 13:27:13 +0800 (CST)
From:   "jieqing.wang" <standback@126.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        jason_wang@realsil.com.cn, "jieqing.wang" <standback@126.com>
Subject: [PATCH] media: fix secfeed undefined when filter alloc fail
Date:   Thu,  1 Dec 2022 13:27:05 +0800
Message-Id: <20221201052705.2313911-1-standback@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADHzrIwO4hjQA7aEg--.9053S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1DWrWrJrWkAw17WF45Jrb_yoWfZrc_Wr
        y0vr9rur1YvF17Xw1rZw1rZ34jvryUZrn3JF4qqa43Jw1UuF1xKa4DWF98KF1xXa1jvas5
        tas09F45K3sIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj6wZ3UUUUU==
X-Originating-IP: [222.93.197.62]
X-CM-SenderInfo: hvwd0vpedfyqqrswhudrp/1tbiqBHKoFpD-G-x3wAAs3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  In dvb_dmxdev_filter_start, when secfeed allocate secfilter fail.
  the secfeed of current dmxfilter, need set to NULL;
  Instead of call start_filtering, which already handled in
  dvb_dmxdev_feed_restart

Signed-off-by: jieqing.wang <standback@126.com>
---
 drivers/media/dvb-core/dmxdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index f6ee678107d3..f7928cb16266 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -731,7 +731,7 @@ static int dvb_dmxdev_filter_start(struct dmxdev_filter *filter)
 		ret = (*secfeed)->allocate_filter(*secfeed, secfilter);
 		if (ret < 0) {
 			dvb_dmxdev_feed_restart(filter);
-			filter->feed.sec->start_filtering(*secfeed);
+			*secfeed = NULL;
 			dprintk("could not get filter\n");
 			return ret;
 		}
-- 
2.25.1

