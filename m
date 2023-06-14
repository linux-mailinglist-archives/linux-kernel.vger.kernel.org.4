Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9698E72F631
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbjFNHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243202AbjFNHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:24:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869A426A0;
        Wed, 14 Jun 2023 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oa4DOgSZwpr5FlHNC7X1lgn1eoGAQfcjs1SrNJbVpTg=; b=hHT9ZAx1PTiGPKAhnhqP1Wfk0i
        gl/+ELIbVzYi5aXI1kQPrGZT96YPRBF6A6Q7Js1mZev89Tt+WQpCZIcUJDbkCkNKYX/ty67ZCP5/P
        xoJqBWhbwkQav79q7n1SdUb6wTcMTdmC9e+2NSFUl99xYNPRAsRaQAGirQTj9uQY3mOibluV2sY1L
        AIlwwJo/zRDSagW0sI9yDcUMOwZBIJ5Y2aOBzK7ZTio+Klw1348reyBx3oaf2Bw1gr8gOVe9sTVbe
        byFTWDgVz7bOlLr3OX/XR+jBRRciFXAxJf2eEzKxWJCHrWF6gj4LWBgLTh4iMAQc416FZGai/enI5
        xyH6aaMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9Kpy-00AeEL-0l;
        Wed, 14 Jun 2023 07:22:38 +0000
Date:   Wed, 14 Jun 2023 00:22:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ayush Jain <ayush.jain3@amd.com>
Cc:     sfr@canb.auug.org.au,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wyes Karny <wyes.karny@amd.com>, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Kernel null pointer dereference on stopping raid device
Message-ID: <ZIlqvsZ6nMv2OT2u@infradead.org>
References: <e78344ad-8d57-91d8-0bfb-724c740c7c72@amd.com>
 <3c4911c4-d3d7-a93e-5f14-e97384ae4f21@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4911c4-d3d7-a93e-5f14-e97384ae4f21@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayush,

can you try this patch?

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ca0de7ddd9434d..828c4e6b9c5013 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2460,7 +2460,7 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	blkdev_put(rdev->bdev, mddev->major_version == -2 ? &claim_rdev : rdev);
+	blkdev_put(rdev->bdev, &claim_rdev);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3644,7 +3644,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 		goto out_clear_rdev;
 
 	rdev->bdev = blkdev_get_by_dev(newdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-			super_format == -2 ? &claim_rdev : rdev, NULL);
+			&claim_rdev, NULL);
 	if (IS_ERR(rdev->bdev)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
@@ -3681,7 +3681,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	blkdev_put(rdev->bdev, super_format == -2 ? &claim_rdev : rdev);
+	blkdev_put(rdev->bdev, &claim_rdev);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
