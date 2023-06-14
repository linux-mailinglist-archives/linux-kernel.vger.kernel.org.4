Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5091772F86B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbjFNIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243822AbjFNIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:52:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E792943;
        Wed, 14 Jun 2023 01:52:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qgzh05j2yz4f3w0d;
        Wed, 14 Jun 2023 16:52:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbG7f4lks7u0Lg--.65484S7;
        Wed, 14 Jun 2023 16:52:17 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 3/3] md/raid10: improve raid10_end_write_request()
Date:   Wed, 14 Jun 2023 16:47:40 +0800
Message-Id: <20230614084740.1493969-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614084740.1493969-1-linan666@huaweicloud.com>
References: <20230614084740.1493969-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbG7f4lks7u0Lg--.65484S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4xtr45Gr18WrykWryrCrg_yoW5ZFykpa
        9xKan0y39rGwnrArsxtFWUXaySv395KrZ3Cr43Ww18Ja4Yyr45G3WUG3y5XrWUXrZ5ur1Y
        qF15Wr4DCFsrXFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1BOJ7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

Improving the code to prevent excessive nesting by repeated checks of
'repl'. And putting bio after it has been set to IO_MADE_GOOD is more
reasonable.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 74 ++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 56206cbd169d..b9f2c841dd9f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -467,48 +467,51 @@ static void raid10_end_write_request(struct bio *bio)
 
 	dev = find_bio_disk(conf, r10_bio, bio, &slot, &repl);
 
-	if (repl)
+	if (repl) {
 		rdev = r10_bio->devs[slot].replacement;
-	else
+		/* replacement may have replaced rdev */
+		if (rdev == conf->mirrors[dev].replacement) {
+			if (bio->bi_status && !discard_error) {
+				/*
+				 * Never record new bad blocks to replacement,
+				 * just fail it.
+				 */
+				md_error(rdev->mddev, rdev);
+				goto out;
+			}
+		}
+	} else {
 		rdev = r10_bio->devs[slot].rdev;
+	}
 	/*
 	 * this branch is our 'one mirror IO has finished' event handler:
 	 */
 	if (bio->bi_status && !discard_error) {
-		/* replacement may have replaced rdev */
-		if (repl && rdev == conf->mirrors[dev].replacement)
-			/* Never record new bad blocks to replacement,
-			 * just fail it.
-			 */
-			md_error(rdev->mddev, rdev);
-		else {
-			set_bit(WriteErrorSeen,	&rdev->flags);
-			if (!test_and_set_bit(WantReplacement, &rdev->flags))
-				set_bit(MD_RECOVERY_NEEDED,
-					&rdev->mddev->recovery);
+		set_bit(WriteErrorSeen,	&rdev->flags);
+		if (!test_and_set_bit(WantReplacement, &rdev->flags))
+			set_bit(MD_RECOVERY_NEEDED,
+				&rdev->mddev->recovery);
 
-			dec_rdev = 0;
-			if (test_bit(FailFast, &rdev->flags) &&
-			    (bio->bi_opf & MD_FAILFAST)) {
-				md_error(rdev->mddev, rdev);
-			}
+		dec_rdev = 0;
+		if (test_bit(FailFast, &rdev->flags) &&
+		    (bio->bi_opf & MD_FAILFAST))
+			md_error(rdev->mddev, rdev);
 
-			/*
-			 * When the device is faulty, it is not necessary to
-			 * handle write error.
-			 */
-			if (!test_bit(Faulty, &rdev->flags))
-				set_bit(R10BIO_WriteError, &r10_bio->state);
-			else {
-				/* Fail the request */
-				set_bit(R10BIO_Degraded, &r10_bio->state);
-				if (repl)
-					r10_bio->devs[slot].repl_bio = NULL;
-				else
-					r10_bio->devs[slot].bio = NULL;
-				to_put = bio;
-				dec_rdev = 1;
-			}
+		/*
+		 * When the device is faulty, it is not necessary to
+		 * handle write error.
+		 */
+		if (!test_bit(Faulty, &rdev->flags)) {
+			set_bit(R10BIO_WriteError, &r10_bio->state);
+		} else {
+			/* Fail the request */
+			set_bit(R10BIO_Degraded, &r10_bio->state);
+			if (repl)
+				r10_bio->devs[slot].repl_bio = NULL;
+			else
+				r10_bio->devs[slot].bio = NULL;
+			to_put = bio;
+			dec_rdev = 1;
 		}
 	} else {
 		/*
@@ -540,16 +543,17 @@ static void raid10_end_write_request(struct bio *bio)
 				r10_bio->devs[slot].addr,
 				r10_bio->sectors,
 				&first_bad, &bad_sectors) && !discard_error) {
-			bio_put(bio);
 			if (repl)
 				r10_bio->devs[slot].repl_bio = IO_MADE_GOOD;
 			else
 				r10_bio->devs[slot].bio = IO_MADE_GOOD;
+			bio_put(bio);
 			dec_rdev = 0;
 			set_bit(R10BIO_MadeGood, &r10_bio->state);
 		}
 	}
 
+out:
 	/*
 	 *
 	 * Let's see if all mirrored write operations have finished
-- 
2.39.2

