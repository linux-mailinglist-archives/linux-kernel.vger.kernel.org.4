Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930287018BD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjEMR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjEMR5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4827C2125;
        Sat, 13 May 2023 10:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFEFA61B86;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BE8C433EF;
        Sat, 13 May 2023 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=c6woXOkPTNb3xhZya6YGx5eYYf5xdfTlpr93ZKM/zE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkovVvpv5xz93urGKjjc7mHNxj5nsU+noiJ+1XHWxWFRsXK5iNKckcvyfauH3MVai
         r3ZCGvOB4ua1ez7gV9SALLHWRE7TtAAZ0sqGur5V7ycK7kpMiBF5RexAXv1UmopzS+
         GPGGSGR9aERYaEvX4PCt2bcSLFAkNmfE9qr5Mbtu5AlVRmkiwSUSS80/dp9gAsusxx
         PX+igp7eoPcEiE2J6cZnHPYlLCCz0bWffNFRpCbbH7mOqjjFFHm/HVNTT0W94IjUaP
         8TitpBS8eCd9OHi1JIQNJpe1PM/6YrTQOwJs7pJqzbIf1ycayoaQY8lN4/4at/DiYT
         V9M1KphuqHp4w==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001txw-1Q;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     YongSu Yoo <yongsuyoo0215@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 11/24] media: dvb_ca_en50221: fix a size write bug
Date:   Sat, 13 May 2023 18:57:28 +0100
Message-Id: <9548a43e8934564309ae22d35c501073358776b4.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YongSu Yoo <yongsuyoo0215@gmail.com>

The function of "dvb_ca_en50221_write_data" at source/drivers/media
/dvb-core/dvb_ca_en50221.c is used for two cases.
The first case is for writing APDU data in the function of
"dvb_ca_en50221_io_write" at source/drivers/media/dvb-core/
dvb_ca_en50221.c.
The second case is for writing the host link buf size on the
Command Register in the function of "dvb_ca_en50221_link_init"
at source/drivers/media/dvb-core/dvb_ca_en50221.c.
In the second case, there exists a bug like followings.
In the function of the "dvb_ca_en50221_link_init",
after a TV host calculates the host link buf_size,
the TV host writes the calculated host link buf_size on the
Size Register.
Accroding to the en50221 Spec (the page 60 of
https://dvb.org/wp-content/uploads/2020/02/En50221.V1.pdf),
before this writing operation, the "SW(CMDREG_SW)" flag in the
Command Register should be set. We can see this setting operation
in the function of the "dvb_ca_en50221_link_init" like below.
...
	if ((ret = ca->pub->write_cam_control(ca->pub, slot,
CTRLIF_COMMAND, IRQEN | CMDREG_SW)) != 0)
		return ret;
...
But, after that, the real writing operation is implemented using
the function of the "dvb_ca_en50221_write_data" in the function of
"dvb_ca_en50221_link_init", and the "dvb_ca_en50221_write_data"
includes the function of "ca->pub->write_cam_control",
and the function of the "ca->pub->write_cam_control" in the
function of the "dvb_ca_en50221_wrte_data" does not include
"CMDREG_SW" flag like below.
...
	if ((status = ca->pub->write_cam_control(ca->pub, slot,
CTRLIF_COMMAND, IRQEN | CMDREG_HC)) != 0)
...
In the above source code, we can see only the "IRQEN | CMDREG_HC",
but we cannot see the "CMDREG_SW".
The "CMDREG_SW" flag which was set in the function of the
"dvb_ca_en50221_link_init" was rollbacked by the follwoing function
of the "dvb_ca_en50221_write_data".
This is a bug. and this bug causes that the calculated host link buf_size
is not properly written in the CI module.
Through this patch, we fix this bug.

Link: https://lore.kernel.org/linux-media/20220818125027.1131-1-yongsuyoo0215@gmail.com
Signed-off-by: YongSu Yoo <yongsuyoo0215@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index c2d2792227f8..b6ca29dfb184 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -187,7 +187,7 @@ static void dvb_ca_en50221_thread_wakeup(struct dvb_ca_private *ca);
 static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
 				    u8 *ebuf, int ecount);
 static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
-				     u8 *ebuf, int ecount);
+				     u8 *ebuf, int ecount, int size_write_flag);
 
 /**
  * findstr - Safely find needle in haystack.
@@ -370,7 +370,7 @@ static int dvb_ca_en50221_link_init(struct dvb_ca_private *ca, int slot)
 	ret = dvb_ca_en50221_wait_if_status(ca, slot, STATUSREG_FR, HZ / 10);
 	if (ret)
 		return ret;
-	ret = dvb_ca_en50221_write_data(ca, slot, buf, 2);
+	ret = dvb_ca_en50221_write_data(ca, slot, buf, 2, CMDREG_SW);
 	if (ret != 2)
 		return -EIO;
 	ret = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, IRQEN);
@@ -778,11 +778,13 @@ static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
  * @buf: The data in this buffer is treated as a complete link-level packet to
  *	 be written.
  * @bytes_write: Size of ebuf.
+ * @size_write_flag: A flag on Command Register which says whether the link size
+ * information will be writen or not.
  *
  * return: Number of bytes written, or < 0 on error.
  */
 static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
-				     u8 *buf, int bytes_write)
+				     u8 *buf, int bytes_write, int size_write_flag)
 {
 	struct dvb_ca_slot *sl = &ca->slot_info[slot];
 	int status;
@@ -817,7 +819,7 @@ static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
 
 	/* OK, set HC bit */
 	status = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND,
-					    IRQEN | CMDREG_HC);
+					    IRQEN | CMDREG_HC | size_write_flag);
 	if (status)
 		goto exit;
 
@@ -1508,7 +1510,7 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 
 			mutex_lock(&sl->slot_lock);
 			status = dvb_ca_en50221_write_data(ca, slot, fragbuf,
-							   fraglen + 2);
+							   fraglen + 2, 0);
 			mutex_unlock(&sl->slot_lock);
 			if (status == (fraglen + 2)) {
 				written = 1;
-- 
2.40.1

