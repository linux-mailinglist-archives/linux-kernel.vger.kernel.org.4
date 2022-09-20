Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476EF5BE1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiITJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiITJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:34 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0604B0FB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091127euoutp02b9efeaf57ef4f21b2c3e28283db629c4~WhpUsGUfu2779827798euoutp02x
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220920091127euoutp02b9efeaf57ef4f21b2c3e28283db629c4~WhpUsGUfu2779827798euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665087;
        bh=MPxvSzLcYgkHFJ9lgd3adGCBkNSqCsfg2K+B6j8dKmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXqAC2rUhXuy4MHzmJ18XBnGqenjj+LEPaZUk0/y2vuqWtb1ySj/A0fnz69UJovTd
         BeZm9M1pgsI/Qh7w0niHkLm0iY6f8IeOX462pPTpe5zIJKBmBRe7npOm2lxmvJdUSy
         MvDxa0A/SbCXXrIMFN7UMTuzrYb6STJQ6cZHEr90=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220920091125eucas1p23e67d481146efde016dad5c786011d8e~WhpSXEcYr0517105171eucas1p2f;
        Tue, 20 Sep 2022 09:11:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F2.98.19378.CB389236; Tue, 20
        Sep 2022 10:11:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220920091124eucas1p1dc8fd9969ebd1839fca5a3c627a29b75~WhpR0Hf1U2023920239eucas1p1G;
        Tue, 20 Sep 2022 09:11:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920091124eusmtrp1e9f6cdb960d22f7b616235b3ca762032~WhpRzOjYj0212802128eusmtrp1P;
        Tue, 20 Sep 2022 09:11:24 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-b0-632983bc4414
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 81.53.10862.CB389236; Tue, 20
        Sep 2022 10:11:24 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091124eusmtip2f3668095586367022451a638029d7e40~WhpRc8yvv2352523525eusmtip2A;
        Tue, 20 Sep 2022 09:11:24 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     gost.dev@samsung.com, jaegeuk@kernel.org,
        Johannes.Thumshirn@wdc.com, hare@suse.de, bvanassche@acm.org,
        dm-devel@redhat.com, matias.bjorling@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v14 04/13] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Tue, 20 Sep 2022 11:11:10 +0200
Message-Id: <20220920091119.115879-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7djPc7p7mzWTDd6eZbJYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9JounV2cxWey9pW1x
        edccNov5y56yW0xo+8pscWPCU0aLz0tb2C3W3HzKYnHilrSDsMflK94eO2fdZfe4fLbUY9Oq
        TjaPzUvqPXbfbGDz6G1+x+axs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAG8UVw2Kak5
        mWWpRfp2CVwZK7bfYC74w1/x830HSwPjRd4uRk4OCQETieevPzN3MXJxCAmsYJR4sPcHI4Tz
        hVFiwvseNpAqIYHPjBJLpqnCdNy4+o8Fomg5o8T6/qdQHS8ZJQ6ceMfaxcjBwSagJdHYyQ7S
        ICKQLvH16wawGmaBbcwS9yZvZgJJCAtESnSenQS2gUVAVWLfsvWMIDavgJXEh3lPmSC2yUvM
        vPQdbBCngLXEnN0tbBA1ghInZz5hAbGZgWqat84G+0FC4DCnRP/s5WwQzS4SHx6uY4SwhSVe
        Hd/CDmHLSJye3MMCYVdLPL3xG6q5hVGif+d6NpAPJIC29Z3JATGZBTQl1u/Shyh3lGhuX8cE
        UcEnceOtIMQJfBKTtk1nhgjzSnS0CUFUK0ns/PkEaqmExOWmOVBLPSS6G+4wT2BUnIXkmVlI
        npmFsHcBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwCR5+t/xrzsYV7z6qHeIkYmD
        8RCjBAezkghvi79mshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZ
        Jg5OqQYmzQTz4CszalZ9FTNbf3Jymq73rWc1SpGyn+Ysyzzrx72NS3jezCupC4IDC7nWF//P
        faz8d5vg1PrquRktew9wFupENio1XdVQl5+ml3nvy/QPL2IuhXEHsf59pj7ZjvvyFL77F8Nb
        eiv/CjpPKr47Z0dCvCxDweX6iLwjE/JYugIYnb9tEPc8pMV8smXS7tnmW1+eDFz3X/JO6XXL
        fTyuc8NW+DxgiJA/wns6L6Ff4Sv3y462J7/kKvUFDY2XLj5ydt2W/Ok/Yz8e8Ctzd/irrnAp
        Ovlw5QWOa9rLAniLfO9WX7SuuWHEf2RekPP2ubtcuhc/Tbp4N3nJauGvCfPvrI4MrS+7vMHs
        qxDbBJEqJZbijERDLeai4kQAjOBXygEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xe7p7mjWTDe7ek7BYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9JounV2cxWey9pW1x
        edccNov5y56yW0xo+8pscWPCU0aLz0tb2C3W3HzKYnHilrSDsMflK94eO2fdZfe4fLbUY9Oq
        TjaPzUvqPXbfbGDz6G1+x+axs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAG8UXo2Rfml
        JakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZK7bfYC74w1/x
        830HSwPjRd4uRk4OCQETiRtX/7GA2EICSxklPu+Kh4hLSNxe2MQIYQtL/LnWxdbFyAVU85xR
        omnOeaAEBwebgJZEYyc7SI2IQK7E4c0TmEBqmAWOMUv0Tb0ONlRYIFyiY9UesEEsAqoS+5at
        B7N5BawkPsx7ygSxQF5i5qXvYIM4Bawl5uxuYYM4yEqiY9ZmNoh6QYmTM5+AzWQGqm/eOpt5
        AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG87ZjP7fsYFz56qPeIUYm
        DsZDjBIczEoivC3+mslCvCmJlVWpRfnxRaU5qcWHGE2B7p7ILCWanA9MKHkl8YZmBqaGJmaW
        BqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUzcb3c1n3hQuyj2z6f1Rd+3XGZh8zik
        ysOrbOLptShN8qJr8R71GZGrG/aVpIp+uGzyd/u7pmLTx3fupBVGM9jHHS/6fGTWFOHUeWvm
        35l1tO9nawaX7eR33p9V10tv5TKor8ioYrurp/+sT22FcWX4sTmPiqVajU4+zpLbKTh/6fy2
        2+m7Vu464tPaEPVf75furBmKfopLP0/0NzK8uV61aDlvafCdvaa+1Yd5+P1uKmlbn8rcL9/U
        OMlV12SObPjR53MnT57Uf+uc7Nl7M9b9bV2sYfPz94rER2viIhaIher+mX6Vs/33K/um9SEL
        z3xpXtj2NTTrRn7j97eHLn2wOPS1QP26wHqbn//EROz9lViKMxINtZiLihMBog/5mXADAAA=
X-CMS-MailID: 20220920091124eucas1p1dc8fd9969ebd1839fca5a3c627a29b75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091124eucas1p1dc8fd9969ebd1839fca5a3c627a29b75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091124eucas1p1dc8fd9969ebd1839fca5a3c627a29b75
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091124eucas1p1dc8fd9969ebd1839fca5a3c627a29b75@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A generic bdev_zone_no() helper is added to calculate zone number for a
given sector in a block device. This helper internally uses disk_zone_no()
to find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for zoned devices with non po2 zone size.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 3 +--
 include/linux/blkdev.h    | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 835bfda86fcf..1c5352295db1 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -254,8 +254,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 {
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
-	return bdev_nr_zones(req->ns->bdev) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e29799076298..5cf34ccd3e12 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1340,6 +1340,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 	return BLK_ZONED_NONE;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	return disk_zone_no(bdev->bd_disk, sec);
+}
+
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.25.1

