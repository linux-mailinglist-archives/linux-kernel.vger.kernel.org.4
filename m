Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2D5BE191
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiITJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiITJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:37 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343AC5EDD5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:11:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091132euoutp01aebfe0207f6559656fe5bb9a29a80bb3~WhpY-ehnJ1166711667euoutp01r
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:11:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220920091132euoutp01aebfe0207f6559656fe5bb9a29a80bb3~WhpY-ehnJ1166711667euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663665092;
        bh=2fIGGCsma0+nVBZgfpMGxL+SDIiTbKkvsObjxRsUwIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzMqFP9ObO/Bj/vyo0PHjE1RQbFu+tqKA7ZIxhbtXFgJeiJcBSlxA5JOymoO88ywo
         V8MAW1GuMaq2eQYNIio41vvXgG8UbqvtbmaDPSWDT0hpz5gpysUhb9L6DmPZNTRO+f
         hbYdlMDSwMk2Wge6mKcYwx8DNnhDL7glVO7MX6Vs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220920091129eucas1p2c8c037d698574fc9f77d875389dd6ed5~WhpWnT_Mq1764517645eucas1p2B;
        Tue, 20 Sep 2022 09:11:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.98.19378.1C389236; Tue, 20
        Sep 2022 10:11:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220920091128eucas1p2d9c9dcebdce4039360f92b0f577ab649~WhpV7FHQL1155311553eucas1p2H;
        Tue, 20 Sep 2022 09:11:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220920091128eusmtrp14229902d0f5956c1a621460964c32551~WhpV6JdbH0212802128eusmtrp1l;
        Tue, 20 Sep 2022 09:11:28 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-c5-632983c11bbd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.53.10862.0C389236; Tue, 20
        Sep 2022 10:11:28 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220920091128eusmtip1ca4a4c4aeda06c94dd20fb7b9e2a2951~WhpVhcVOi1126811268eusmtip1z;
        Tue, 20 Sep 2022 09:11:28 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     gost.dev@samsung.com, jaegeuk@kernel.org,
        Johannes.Thumshirn@wdc.com, hare@suse.de, bvanassche@acm.org,
        dm-devel@redhat.com, matias.bjorling@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v14 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Tue, 20 Sep 2022 11:11:14 +0200
Message-Id: <20220920091119.115879-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87oHmzWTDZ68VrVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlXGh
        dSZLwX7eivU3lzM1ME7l7mLk5JAQMJHYuvo7cxcjF4eQwApGifnzLjJBOF8YJW53LWODcD4z
        Srw/vYgdpuXl9IusEInljBIH131nhHBeMkocW9AIVMXBwSagJdHYCdYgIpAu8fXrBkYQm1mg
        n1li6RVzEFtYIETi14a5YOUsAqoS0zrFQMK8AlYS95vnMEHskpeYeek72BhOAWuJObtb2CBq
        BCVOznzCAjFSXqJ562ywFyQEdnNKzH9xCqrZRWLxk7vMELawxKvjW6AekJE4PbmHBcKulnh6
        4zdUcwujRP/O9WwgB0kAbes7kwNiMgtoSqzfpQ9R7igx+/lcqAo+iRtvBSFO4JOYtG06M0SY
        V6KjTQiiWkli588nUEslJC43zYFa6iFxZv5qxgmMirOQPDMLyTOzEPYuYGRexSieWlqcm55a
        bJyXWq5XnJhbXJqXrpecn7uJEZgOT/87/nUH44pXH/UOMTJxMB5ilOBgVhLhbfHXTBbiTUms
        rEotyo8vKs1JLT7EKM3BoiTOm5y5IVFIID2xJDU7NbUgtQgmy8TBKdXAtJz/wKuFLWEHJ/5K
        6WVck7f6xNYprJN/hn29LPJ83QaBv60rmDvS7KYuDV/bHbnU6/iO99ekTHMmK3uvNZSaOy9t
        ldcb8SnbbwT4McbPL/C5zHN8asL2uNeXj3X9cRNVmrhv16E/Jb7SD76UeWxKeaV9aHbv58aT
        VcyzPt2+28r8Nl5FSins3JevUvW1hwr2bAxvzmdmFzy/i+eyYdmd/UeOtG7IFbv0Z67jioBH
        2S9+m6r6ikzuuviBz6E//pfjmkrGRZafZTRlJtxb5XfX9ca6b7wnNx5nFWZb0aL/Zcuuf15J
        V3UdGMWPztnkPslp9V5FDb2TMx6V1q7ekuUZGa4YL5w6X3pR3dwEJYUpKw4qsRRnJBpqMRcV
        JwIAQF9rlfYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7oHmjWTDZZO1LdYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3GhdSZLwX7eivU3lzM1ME7l7mLk
        5JAQMJF4Of0iaxcjF4eQwFJGiWNP9zFDJCQkbi9sYoSwhSX+XOtigyh6zihx9Mk6li5GDg42
        AS2Jxk52kBoRgVyJw5snMIHUMAvMZ5bo+LMHbJCwQJBE5+xn7CD1LAKqEtM6xUDCvAJWEveb
        5zBBzJeXmHnpO9gcTgFriTm7W9hAbCGgmo5Zm9kg6gUlTs58wgJiMwPVN2+dzTyBUWAWktQs
        JKkFjEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmN327GfW3Ywrnz1Ue8QIxMH4yFGCQ5m
        JRHeFn/NZCHelMTKqtSi/Pii0pzU4kOMpkBnT2SWEk3OByaPvJJ4QzMDU0MTM0sDU0szYyVx
        Xs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJtNnr2SY+iQfGhrv17W46ad7aqtB+wKmd3qSku9Z
        dhzNlbxhsLyr30E43Fp01caSI9yNq3c5pC756av0pv6yaYtm7VLu9LOaWzZfmbZY+mzE8xZf
        fqu/TtJnvdsuBN4/WsJ4h7dG6nKFxPpFastOny5tD923RPV94ydusfn/84zXvd8mIjPHfEv/
        Vh/7V59cVz57d4lHfe75/LWGKRtvieit+nbzaeTW42X5HjWX9txJa1i60YPVzmipU3rmwYO9
        j27G7vx58c+BHwIrH5xbuzli3ap7r86+8hVY9+B+WdS2Kd8/+a16ep3rbqnjWsNnZyfdjA1o
        jCm/flFk/ftyq9AJ9WVFuzXk3VWPJXfUruRTYinOSDTUYi4qTgQAvqKJtGYDAAA=
X-CMS-MailID: 20220920091128eucas1p2d9c9dcebdce4039360f92b0f577ab649
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091128eucas1p2d9c9dcebdce4039360f92b0f577ab649
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091128eucas1p2d9c9dcebdce4039360f92b0f577ab649
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091128eucas1p2d9c9dcebdce4039360f92b0f577ab649@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

dm-zoned relies on the assumption that the zone size is a
power-of-2(po2) and the zone capacity is same as the zone size.

Ensure only po2 devices can be used as dm-zoned target until a native
support for zoned devices with non-po2 zone size is added.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zoned-target.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 95b132b52f33..9325bf5dee81 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 				return -EINVAL;
 			}
 			zone_nr_sectors = bdev_zone_sectors(bdev);
+			if (!is_power_of_2(zone_nr_sectors)) {
+				ti->error = "Zone size is not a power-of-2 number of sectors";
+				return -EINVAL;
+			}
 			zoned_dev->zone_nr_sectors = zone_nr_sectors;
 			zoned_dev->nr_zones = bdev_nr_zones(bdev);
 		}
@@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 			return -EINVAL;
 		}
 		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
+		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
+			ti->error = "Zone size is not a power-of-2 number of sectors";
+			return -EINVAL;
+		}
 		zoned_dev->nr_zones = bdev_nr_zones(bdev);
 	}
 
-- 
2.25.1

