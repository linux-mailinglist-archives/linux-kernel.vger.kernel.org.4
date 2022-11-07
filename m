Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD661E9F9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKGD7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKGD7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:59:20 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5AF10066
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 19:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667793550; bh=PWveDsnayKgrwHoxVXJd7rB504HWxfroON00hivoOew=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=YdXnXEFbW9DR84+iQYgGw8mU2/2+6Bb8Wwll1qOCq4uZ4C18UFwzkjyzz8M9CGjKY
         4G85+g/j+Pw/ehmO6twUGpIWGUtMEH2ymEhY8JaYmb8LRXmq+tRppsXo2A7Pzh5KdO
         vVYc3UXABM2TfdPXmo+/u4T/KqvpMkk6mhx9SXSQ=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  7 Nov 2022 04:59:10 +0100 (CET)
X-EA-Auth: kW7V4VN242VMCTbuSQIdbYqXwNnnKreCRhtWZoxe9kVNSMa8hCD5XlxbnutT/5ApyQQFpSH0lrGK4birqbcL2Px+W7eI+2Au
Date:   Mon, 7 Nov 2022 09:29:04 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: video: use min_t() for comparison and
 assignment
Message-ID: <Y2iCiOf9ctg4jdV0@qemulion>
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

Simplify code by using min_t helper macros in place of lengthy if/else
block oriented logical evaluation and value assignment. Use the _t
variant of min macro since the variable types are not same.
This issue is identified by coccicheck using the minmax.cocci file.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/most/video/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index ffa97ef21ea5..d5cc7eea3b52 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -173,7 +173,7 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
 	while (count > 0 && data_ready(mdev)) {
 		struct mbo *const mbo = get_top_mbo(mdev);
 		int const rem = mbo->processed_length - fh->offs;
-		int const cnt = rem < count ? rem : count;
+		int const cnt = min_t(int, rem, count);

 		if (copy_to_user(buf, mbo->virt_address + fh->offs, cnt)) {
 			v4l2_err(&mdev->v4l2_dev, "read: copy_to_user failed\n");
--
2.34.1



