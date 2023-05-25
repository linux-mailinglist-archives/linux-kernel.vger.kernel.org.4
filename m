Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17E1711661
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbjEYS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243367AbjEYSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F4C1BD9;
        Thu, 25 May 2023 11:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2287961B13;
        Thu, 25 May 2023 18:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6155C433EF;
        Thu, 25 May 2023 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040267;
        bh=gtVAtcsloKGLxWTwu09fR9w1OdO8Jv8IF8FgZQaUUf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+wHVPRLzGbV7y2XVVyk1B/MyeKsLHoJX1lqXi4BSCcwGHx+nHD6MVezfHjS8bjqu
         2CAt1znv/PYGYHZPtbyl3E31l9AucRflKwjUtMePZKc+BQaHeHPSWIykuBVQUg0JdW
         XSHu3uOp1JQmRiza2Vg8ENH1XY4b+vW7MUOuUuPGAMbVPHJP/7sv98tOcBQU+bfyOY
         og9KWaSBbwemXyIVBnYWI6g3EZ/2SLitZsog8gU8S49Dkzyyg4FGj/O1XL79kjbOAC
         WuIki1Csiouz/eWGmHdlL1vM5+OJOtnls8bYd2YXxQKT/3+v0wtrdGIeltOrT0cKQG
         6+dW6k1qrtwLg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YongSu Yoo <yongsuyoo0215@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, v4bel@theori.io,
        linma@zju.edu.cn, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/27] media: dvb_ca_en50221: fix a size write bug
Date:   Thu, 25 May 2023 14:43:38 -0400
Message-Id: <20230525184356.1974216-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184356.1974216-1-sashal@kernel.org>
References: <20230525184356.1974216-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YongSu Yoo <yongsuyoo0215@gmail.com>

[ Upstream commit a4315e5be7020aac9b24a8151caf4bb85224cd0e ]

The function of "dvb_ca_en50221_write_data" at source/drivers/media
/dvb-core/dvb_ca_en50221.c is used for two cases.
The first case is for writing APDU data in the function of
"dvb_ca_en50221_io_write" at source/drivers/media/dvb-core/
dvb_ca_en50221.c.
The second case is for writing the host link buf size on the
Command Register in the function of "dvb_ca_en50221_link_init"
at source/drivers/media/dvb-core/dvb_ca_en50221.c.
In the second case, there exists a bug like following.
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index 36afcea709a75..1e08466ba0c6c 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -198,7 +198,7 @@ static void dvb_ca_en50221_thread_wakeup(struct dvb_ca_private *ca);
 static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
 				    u8 *ebuf, int ecount);
 static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
-				     u8 *ebuf, int ecount);
+				     u8 *ebuf, int ecount, int size_write_flag);
 
 /**
  * Safely find needle in haystack.
@@ -381,7 +381,7 @@ static int dvb_ca_en50221_link_init(struct dvb_ca_private *ca, int slot)
 	ret = dvb_ca_en50221_wait_if_status(ca, slot, STATUSREG_FR, HZ / 10);
 	if (ret)
 		return ret;
-	ret = dvb_ca_en50221_write_data(ca, slot, buf, 2);
+	ret = dvb_ca_en50221_write_data(ca, slot, buf, 2, CMDREG_SW);
 	if (ret != 2)
 		return -EIO;
 	ret = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, IRQEN);
@@ -789,11 +789,13 @@ static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
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
@@ -828,7 +830,7 @@ static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
 
 	/* OK, set HC bit */
 	status = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND,
-					    IRQEN | CMDREG_HC);
+					    IRQEN | CMDREG_HC | size_write_flag);
 	if (status)
 		goto exit;
 
@@ -1516,7 +1518,7 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 
 			mutex_lock(&sl->slot_lock);
 			status = dvb_ca_en50221_write_data(ca, slot, fragbuf,
-							   fraglen + 2);
+							   fraglen + 2, 0);
 			mutex_unlock(&sl->slot_lock);
 			if (status == (fraglen + 2)) {
 				written = 1;
-- 
2.39.2

