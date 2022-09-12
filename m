Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777095B5605
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiILIXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiILIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:44 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8082F010
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:40 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082221euoutp0125c8ebd32ca6ebd370f8d77624b2d2da~UD0KZuKYg1523515235euoutp01_
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220912082221euoutp0125c8ebd32ca6ebd370f8d77624b2d2da~UD0KZuKYg1523515235euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970941;
        bh=tGdXrZOo82rW1rnRJeQcvmwRabixUhHDV5CM9X+9nHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yx6qvHNIXdR1X377oa1ahBEMKO+nitw1GbVaZcwzfNA23DZeC/koX/3s00hunzGf8
         Miq2fc98DBdtblc/1788pWk8FPQwmkdNCmJqf5HoNUv2ntQdH1Nf4BENzVB7NklDHO
         5HYf13qVilMSqozQclEyUdbGB4xVmI7PFbInWOTA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220912082211eucas1p2f4e53c71b5ea9a1f0214abe7042837cf~UD0A-672_2521325213eucas1p2K;
        Mon, 12 Sep 2022 08:22:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FD.93.19378.23CEE136; Mon, 12
        Sep 2022 09:22:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220912082210eucas1p2a27e358b12b0e4b06a7e00938251c90c~UD0ATwGB62085220852eucas1p28;
        Mon, 12 Sep 2022 08:22:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220912082210eusmtrp1f5c6636a975c4ba6a58f300fa8852a07~UD0ASz6Sq1301813018eusmtrp1a;
        Mon, 12 Sep 2022 08:22:10 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-4c-631eec32418d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 38.2F.07473.23CEE136; Mon, 12
        Sep 2022 09:22:10 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082209eusmtip191ef30b7acb64dd77f15d10c24dee9b1~UD0AAjOPs0956209562eusmtip1a;
        Mon, 12 Sep 2022 08:22:09 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        linux-nvme@lists.infradead.org, pankydev8@gmail.com,
        matias.bjorling@wdc.com, linux-block@vger.kernel.org,
        bvanassche@acm.org, gost.dev@samsung.com, dm-devel@redhat.com,
        hare@suse.de, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v13 04/13] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Mon, 12 Sep 2022 10:21:55 +0200
Message-Id: <20220912082204.51189-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7pGb+SSDRoarS3WnzrGbLH6bj+b
        xbQPP5ktfp89z2yx991sVoubB3YyWexZNInJYuXqo0wWT9bPYrb423WPyWLvLW2Ly7vmsFnM
        X/aU3WJC21dmixsTnjJafF7awm6x5uZTFosTt6QdhDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S
        77H7ZgObx87W+6we7/ddZfPo27KK0WPz6WqPz5vkPNoPdDMF8ERx2aSk5mSWpRbp2yVwZcze
        dIul4BR/xbOWbawNjEt4uxg5OSQETCROT5nD0sXIxSEksIJR4seGw4wQzhdGif4DW5kgnM+M
        Es9O/GKHaZl68yRUy3JGiSnz54MlhAReMkpsWp/VxcjBwSagJdHYCRYWEUiX+D79HdggZoF+
        Zonbv3ezg9QIC0RKLL7kDFLDIqAqMeHLFEYQm1fAUuLYneOsELvkJWZe+g42h1PASuL1qlao
        GkGJkzOfsIDYzEA1zVtnM0PUb+eU+LO5BMJ2kZjZ9pUJwhaWeHV8C9T9MhKnJ/ewQNjVEk9v
        /GYGuU1CoAXo453r2UBukxCwlug7kwNiMgtoSqzfpQ9R7iix6sMhRogKPokbbwUhLuCTmLRt
        OjNEmFeio00IolpJYufPJ1BLJSQuN82BWuoh0fCxn2UCo+IsJL/MQvLLLIS9CxiZVzGKp5YW
        56anFhvnpZbrFSfmFpfmpesl5+duYgQmw9P/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeFkMpZOF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MMm6feGteydi
        rPlxyyc9sa2bVz2dprlW7H3MzaPcetrubSvXZBdzdP55eIwhtfW1mvLaqP83l7wq/6nZf2rG
        O331zi7TphBrZfXl1Tbrlwp179C2SDUNfq6y8Mx/3ndft+txZ2p8unooICXt8xcTaUZdxYmH
        nJbezlgyIc9x1X+nS6mxfAxqzi8vq029M0tu+UqtG11NR7fcWZg0w2zRXqdvkUIqmv4Lqq/l
        Kam6T3v2VWJa0XL/Jh7znasdte4kHVxSYWvzcumqFH+rkJ5NM7cn299cd0j1alsv4y+l2Zqp
        M8Ocn3jITm1i3bDe02hH9I9pzPd2VehY5c7XVD/cOP/qt0d76tZHJ/NcsGUVsVBiKc5INNRi
        LipOBACDoUju9QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7pGb+SSDbbd57FYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzF70y2WglP8Fc9atrE2MC7h7WLk
        5JAQMJGYevMkSxcjF4eQwFJGiXn/r7NDJCQkbi9sYoSwhSX+XOtigyh6zijx+dIPoA4ODjYB
        LYnGTrB6EYFcic8rf4DVMAvMZ5aY8+4yWLOwQLjE6gu72UBsFgFViQlfpoDFeQUsJY7dOc4K
        sUBeYual72CDOAWsJF6vagWrEQKqOfvtBjtEvaDEyZlPWEBsZqD65q2zmScwCsxCkpqFJLWA
        kWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYPRuO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMLL
        YiidLMSbklhZlVqUH19UmpNafIjRFOjuicxSosn5wPSRVxJvaGZgamhiZmlgamlmrCTO61nQ
        kSgkkJ5YkpqdmlqQWgTTx8TBKdXAtFNN5eY5kYcyDn6Cn5/u+NyWMoNVlmuf0MIr83Yrq5Tz
        Ll2UHxbNo/pj7cT3+fZJxZpzd++NY5j3pGruiTeTslZb39Sc8Pz/ucRlO7cniOjmPku7G/r/
        Ua3rJPdNrSoTbe4IZnxaKayQ9jch5egWvi7Jm5VvpniHS6+96ar92V2wPzmtco75eR3vORUV
        c/fqTeuIc/6vceVKuxbP8snXe6Z29nouffrezjPPW/aG35PPHNW5Jte37Kp699Vx9v+Ncgen
        Tzn+6H7sVrdn4QmsWzwkbl7uelL/8ec2JcW3msuvPFG/wZX2Sev8qf+SW5STV+05avF6N8ei
        ThmRN7pC65/yWv0Ufvph6+0/f3pyhXcpsRRnJBpqMRcVJwIAwJIQXGcDAAA=
X-CMS-MailID: 20220912082210eucas1p2a27e358b12b0e4b06a7e00938251c90c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082210eucas1p2a27e358b12b0e4b06a7e00938251c90c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082210eucas1p2a27e358b12b0e4b06a7e00938251c90c
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082210eucas1p2a27e358b12b0e4b06a7e00938251c90c@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 3 +--
 include/linux/blkdev.h    | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4..662f1a92f39b 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -241,8 +241,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 {
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
-	return bdev_nr_zones(req->ns->bdev) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d0d66a0db224..b2636dcca105 100644
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

