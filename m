Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1C5BE19F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiITJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiITJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:39 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07725C340
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:35 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091133euoutp027be9a53b343131a222ec64d7e19f44b1~WhpabUFod2701927019euoutp02S
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220920091133euoutp027be9a53b343131a222ec64d7e19f44b1~WhpabUFod2701927019euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665093;
        bh=mYF3BflLJSX6KlMqYwCikWQ6QWnNIFxRzvAPPTHfZ4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je4/BQVd3TgVsJuG1fP4Q3guasOaYPxVmKs0AzGfydkykq3awu2PRq9gsQwNAbd4I
         DYfzCuy95WmmSyGqBqvsDL10FAH4Q+YxFP2OsfBxiA+CSCMLz+h5mvrwIyQzCbN1iC
         We89esevomHQ/agR90VIwByec+c9WCzfiewwTBKw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220920091131eucas1p247204f6a63f7aefc2c1301f141ebda8f~WhpYddF052051120511eucas1p2E;
        Tue, 20 Sep 2022 09:11:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 20.3E.29727.3C389236; Tue, 20
        Sep 2022 10:11:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220920091131eucas1p1ab4ef3ac98b2fd27c546a44b583a1745~WhpX4jabH2927429274eucas1p1e;
        Tue, 20 Sep 2022 09:11:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920091131eusmtrp1377130c21e3f808f237dad059e13bbd8~WhpX3npdA0212802128eusmtrp1y;
        Tue, 20 Sep 2022 09:11:31 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-4f-632983c3706c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.53.10862.2C389236; Tue, 20
        Sep 2022 10:11:30 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091130eusmtip28e17e5680947414d0bbdb37cc38fc1db~WhpXgqteE2421324213eusmtip2H;
        Tue, 20 Sep 2022 09:11:30 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     gost.dev@samsung.com, jaegeuk@kernel.org,
        Johannes.Thumshirn@wdc.com, hare@suse.de, bvanassche@acm.org,
        dm-devel@redhat.com, matias.bjorling@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v14 10/13] dm-table: allow zoned devices with non power-of-2
 zone sizes
Date:   Tue, 20 Sep 2022 11:11:16 +0200
Message-Id: <20220920091119.115879-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7qHmzWTDW5eUbFYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDI+LP/LVrCG
        r2L+hwuMDYyXuLsYOTkkBEwkNp6ZxtTFyMUhJLCCUeL69m8sEM4XRonulg+sEM5nRok/2zYy
        djFygLWs+CQKEV/OKHHo7ReoopeMEnePrWcDKWIT0JJo7GQHWSEikC7x9esGRpAaZoGXTBLN
        51cygySEBSIlJr27zQRiswioSmx40QTWwCtgLXG+tYMF4j55iZmXvoPFOYHic3a3sEHUCEqc
        nPkErIYZqKZ562xmkAUSAus5Ja6sXMkGcamLxKHNUHOEJV4d38IOYctInJ7cAxWvlnh64zdU
        bwujRP/O9VC91hJ9Z3JATGYBTYn1u/Qhyh0lXi9fzAJRwSdx460gxAV8EpO2TWeGCPNKdLQJ
        QVQrSez8+QRqqYTE5aY5UEs9JBqv3WaZwKg4C8kvs5D8Mgth7wJG5lWM4qmlxbnpqcWGeanl
        esWJucWleel6yfm5mxiBSfD0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd4Wf81kId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUzmgV5zrGfnFhXP1pmnp5XO
        1zDr+ddyhsh9BoGtbnxhwsyhhY9vfFZ7prCHI2bi2j+/Is6cEOfbJCLnJNzQGWm58qnbZdHD
        IdzlPzm46z1NmBOsb6fPe3dHqkPpf8X2Z/Gv3tsEfxVufRnMvrtvlvz/Ow5nH+T8nfL+R6nC
        ihNHrAON10cwnfZ5bTP7TCvT0liG1dar96htnXZNwrFu7/0+FaaS2mc3qk4z+LQyr/e9KnTX
        9fFk9XtG2/4X/ZFiTzu9Z/opO51tB+dlyIgE1YgoO88O2dq0yiyeo+2W667dpj6HXU3ebF49
        VXbXZPnlDRKsc/Yeu3dKJKQibXe3mOp35gmizKZxAf4R1mefrFJiKc5INNRiLipOBADIjk7K
        8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7qHmjWTDaauNrdYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DI+LP/LVrCGr2L+hwuMDYyXuLsYOTgkBEwk
        VnwS7WLk4hASWMoocffUa8YuRk6guITE7YVNULawxJ9rXWwQRc8ZJZqevWMGaWYT0JJo7GQH
        qRERyJU4vHkCE0gNs8B3JomGnwdYQWqEBcIltpzSB6lhEVCV2PCiCayeV8Ba4nxrBwvEfHmJ
        mZe+g8U5geJzdrewgdhCAlYSHbM2s0HUC0qcnPkErJ4ZqL5562zmCYwCs5CkZiFJLWBkWsUo
        klpanJueW2ykV5yYW1yal66XnJ+7iREYr9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8Lb4ayYL
        8aYkVlalFuXHF5XmpBYfYjQFunsis5Rocj4wYeSVxBuaGZgamphZGphamhkrifN6FnQkCgmk
        J5akZqemFqQWwfQxcXBKNTDJ/g1nP878ymvO5Haz3ZYq2y8/n23870yKZq1mTnrFrZBr9Yvf
        SXf8uRW3WIsxfeaLzFWPSkQKNSvn23+8tSj5OfcTpTtbNjUuW/Gj7FfEowczYic2dczm2f7y
        0+VbFWlJx9bZvU7YdWaKxPvQ7Ktf99ovK4r9OfXlpkNb72VKTdLaIN243Hza/O0dVzQTp0Xe
        qP3IU5vV9mznGfYM9n4Ws+8f9uu/3d6c3iDg9kiwIatua3D6Xfv+s+29Qe0nmqTadvT4LRaZ
        yfnm9/MFC7x17PJNrF09fj77Y6NZbT5x7dnmCbqvCzap7NApqnuteVRj55t1rUF3dynVzCrs
        u70mXdFBy3j9hwgeid2eB7KVlFiKMxINtZiLihMBzBSj1WADAAA=
X-CMS-MailID: 20220920091131eucas1p1ab4ef3ac98b2fd27c546a44b583a1745
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091131eucas1p1ab4ef3ac98b2fd27c546a44b583a1745
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091131eucas1p1ab4ef3ac98b2fd27c546a44b583a1745
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091131eucas1p1ab4ef3ac98b2fd27c546a44b583a1745@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
the block layer now supports it.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-table.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e42016359a77..38b83c383e8f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (start & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, start)) {
 			DMERR("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			      dm_device_name(ti->table->md),
 			      (unsigned long long)start,
@@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (len & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, len)) {
 			DMERR("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			      dm_device_name(ti->table->md),
 			      (unsigned long long)len,
@@ -1647,8 +1647,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 		return -EINVAL;
 	}
 
-	/* Check zone size validity and compatibility */
-	if (!zone_sectors || !is_power_of_2(zone_sectors))
+	if (!zone_sectors)
 		return -EINVAL;
 
 	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
-- 
2.25.1

