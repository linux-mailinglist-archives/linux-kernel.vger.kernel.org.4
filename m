Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CAC5B5615
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiILIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiILIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:50 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC82ED56
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082217euoutp025e8c60c7290b2891d5c17a1d98916ed6~UD0HPHW8_2332523325euoutp02R
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220912082217euoutp025e8c60c7290b2891d5c17a1d98916ed6~UD0HPHW8_2332523325euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970937;
        bh=iRbpzjINH/0PPLjaid0CzUjvnsaLFxGjPtxuxfcTQWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxBbwE4II+AFvZV/uzDF6jzuNsqqIS4H0nwOU3BQnEoNeV9/A/ykh1hNxqYKhOZp+
         ZBKxzSTTWygxa+Nlts+GcMaZvw6/SF5V1jLiRrfrHN6Dza9ndDbrUHac9pWkr312dA
         nwyOnXkhe3oZD/XSzJqq3zJ5CFZAYbFkBvtMrOac=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220912082215eucas1p20d6aa1ec8ff1a6e145de06afcb2fd104~UD0FXe4LO0125901259eucas1p2K;
        Mon, 12 Sep 2022 08:22:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 05.A3.19378.73CEE136; Mon, 12
        Sep 2022 09:22:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220912082214eucas1p1a5796db60e6972eace43c3ab6976248c~UD0EsLnG_0912009120eucas1p1x;
        Mon, 12 Sep 2022 08:22:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220912082214eusmtrp1977e05345de0d80a215460772cec7d12~UD0ErJayw1362513625eusmtrp1I;
        Mon, 12 Sep 2022 08:22:14 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-60-631eec372945
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F1.3F.07473.63CEE136; Mon, 12
        Sep 2022 09:22:14 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082214eusmtip21c2b4c578bcbcb433092971e84d434eb~UD0ESMPO52680426804eusmtip2P;
        Mon, 12 Sep 2022 08:22:14 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        linux-nvme@lists.infradead.org, pankydev8@gmail.com,
        matias.bjorling@wdc.com, linux-block@vger.kernel.org,
        bvanassche@acm.org, gost.dev@samsung.com, dm-devel@redhat.com,
        hare@suse.de, jaegeuk@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v13 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Mon, 12 Sep 2022 10:21:59 +0200
Message-Id: <20220912082204.51189-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djP87rmb+SSDd4sVbdYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlXFj
        0VqWgkbeildTlrM0MN7h6mLk4JAQMJH41BPdxcjJISSwglFiTad3FyMXkP2FUeJ/w2ZGCOcz
        o8SspotMIFUgDY//d7BBJJYzSvQ/WAlV9ZJR4sCkFywgY9kEtCQaO9lBGkQE0iW+T3/HBFLD
        LHCHSWL7xfdgk4QFQiQuLpnCCGKzCKhK3Hp3HSzOK2Ap0bq8E2qbvMTMS9/BBnEKWEm8XtXK
        CFEjKHFy5hMWEJsZqKZ562xmkAUSAps5JbpetjJDNLtIvPgxix3CFpZ4dXwLlC0jcXpyDwuE
        XS3x9MZvqOYWoHd2rmeDBIy1RN+ZHBCTWUBTYv0ufYhyR4mNC1ZDVfBJ3HgrCHECn8SkbdOZ
        IcK8Eh1tQhDVShI7fz6BWiohcblpDgtEiYfEtBO2ExgVZyH5ZRaSX2YhrF3AyLyKUTy1tDg3
        PbXYOC+1XK84Mbe4NC9dLzk/dxMjMBme/nf86w7GFa8+6h1iZOJgPMQowcGsJMLLYiidLMSb
        klhZlVqUH19UmpNafIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoHJYIWPvcye3yXW
        LAvFjs/YKWrNLlRdEVeQ9OW25pbvFlF1nlsaJtRHfvKNYk89vvN3ehL7lJcx9gFqU34uf7DI
        79C3TOfPNxTDFspwvTXKlJaXVDBf7rCWeeWW7Rov++K9XZuuZMotagkR1Mz0blujmqXnvP1n
        sEvCbKVy1UzmkM6NWb9+cp888eZSyP3o18ufcp6zOTarpe99ecSL1oPpfGHbbJT/bzo7MVvV
        edXLn9Pi//8pOsJo0l320Hbq/YBF82cvu3fz3xNx1apj4o1f2h/b+d1J69M9or4m5s/17O2v
        vMSPtZx+F/PriLvvvfCSmPAluYf8lb5Ut0Xle2rzh/5iO8HI6qAUdf6ORIwSS3FGoqEWc1Fx
        IgB38w+l9QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pmb+SSDfpfGlmsP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFjcmPGW0+Ly0hd1izc2nLBYnbkk7CHlcvuLtsXPWXXaPy2dLPTat6mTz2Lyk
        3mP3zQY2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4InSsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7ixaC1LQSNvxaspy1kaGO9wdTFy
        ckgImEg8/t/B1sXIxSEksJRR4svT7cwQCQmJ2wubGCFsYYk/17qgip4zSvT17AQq4uBgE9CS
        aOxkB6kREciV+LzyB1gNs8AbJokNd9YzgSSEBYIknm1cDDaURUBV4ta762BxXgFLidblnUwQ
        C+QlZl76DjaIU8BK4vWqVrDFQkA1Z7/dYIeoF5Q4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYw
        Mq1iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjN5tx35u3sE479VHvUOMTByMhxglOJiVRHhZ
        DKWThXhTEiurUovy44tKc1KLDzGaAt09kVlKNDkfmD7ySuINzQxMDU3MLA1MLc2MlcR5PQs6
        EoUE0hNLUrNTUwtSi2D6mDg4pRqYJs8wmWZTeigx2T3f1URF+4rwl3kpM/i5JZe0T14j5PVc
        mLsufnpzR/HrRO6r7Qu/KB0/x35xw4V9HzdLn7pfXTcj8+8x9efeb9cFMrZ9TUziY/brdIya
        8qDXdHpY8oEZKov73Gb/evz6D9/6DxNjM9XPNM07MvtIceyNXc/z+loWl5fzfu++feLZgoid
        Cm+ZrEUNa/ieRhlsjn35NPRxzLfb0yMsJe6lxiYsrlUudHOVn3PdpVTcIdRHyL1Dz+fPS+Xk
        /OW/Z1yarH9Y9NEdacO/WROiLda2L+7k5mgILJje0CI4QX12xpwe88PWwQlPrBla2P+lZ37R
        e/137fvgfpXadTs/+e7TfSK65c4hJZbijERDLeai4kQAGQ1PmGcDAAA=
X-CMS-MailID: 20220912082214eucas1p1a5796db60e6972eace43c3ab6976248c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082214eucas1p1a5796db60e6972eace43c3ab6976248c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082214eucas1p1a5796db60e6972eace43c3ab6976248c
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082214eucas1p1a5796db60e6972eace43c3ab6976248c@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

