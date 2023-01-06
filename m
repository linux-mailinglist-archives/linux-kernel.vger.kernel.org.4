Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0265FCD2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjAFIdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjAFId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:33:26 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A117A93A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 00:33:23 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083321euoutp013da2bde89e10e9fc4527f70e88156150~3qy4eLefG1654616546euoutp01k
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:33:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230106083321euoutp013da2bde89e10e9fc4527f70e88156150~3qy4eLefG1654616546euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672994001;
        bh=xL98W+EK2xf54BjrEuaYdsMq2UetfroxJnaNHM1J0YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5Kt3ipmIqt9FPhQy71S0Xvmh86cC9Carqc/YhAA+WhVkmforjvQnKtdEXIrbVMrK
         IVlmC25Mcvdf09/FaahR5ulL8H1NPew4qWLZuMpX4lLZtV5EEQ33tYcKBtyVvGqlqc
         yu4TOC4G0GPHK3+4YgqYFlOl3vzR01T6/jKsVUsk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230106083319eucas1p2e3212c7c60824af430d2b887b4feb81a~3qy3WM79E3119231192eucas1p2D;
        Fri,  6 Jan 2023 08:33:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A7.14.61936.FCCD7B36; Fri,  6
        Jan 2023 08:33:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038~3qy28xCRM1636916369eucas1p1N;
        Fri,  6 Jan 2023 08:33:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230106083319eusmtrp2f28926097487b7893e7b9aeafb0edc06~3qy28ACgL0987109871eusmtrp2j;
        Fri,  6 Jan 2023 08:33:19 +0000 (GMT)
X-AuditID: cbfec7f4-a2dff7000002f1f0-d2-63b7dccfd9b7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.AB.52424.FCCD7B36; Fri,  6
        Jan 2023 08:33:19 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230106083319eusmtip121f48b06b25f955e94de4a91b3bdc881~3qy2vWoUw0382103821eusmtip1Z;
        Fri,  6 Jan 2023 08:33:19 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Date:   Fri,  6 Jan 2023 09:33:11 +0100
Message-Id: <20230106083317.93938-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106083317.93938-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7rn72xPNljxy9Bi9d1+NotpH34y
        W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
        iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
        8ya5AO4oLpuU1JzMstQifbsErow1PWdYC66zVfzsucXawHiJtYuRk0NCwESi+ewili5GLg4h
        gRWMEosWTGUDSQgJfGGUWHnUDCLxmVGi78E+FpiO98svMkIkljNKnGpcyQLR8YJR4kV7ahcj
        BwebgJZEYyc7SFhEQFhif0cr2AZmgc1MErd/r2UESQgLRErc/7UEbBuLgKrEt7UXwOK8ApYS
        cxa2M0Esk5eYeek72CBOASuJ59PXMEHUCEqcnPkEbC8zUE3z1tnMIAskBLo5JRafWgz1m4vE
        /kPLmSFsYYlXx7ewQ9gyEv93zodaUC3x9MZvqOYWRon+nevZQD6QELCW6DuTA2IyC2hKrN+l
        DxF1lLjd7Qph8knceCsIcQGfxKRt05khwrwSHW1CELOVJHb+fAK1U0LictMcaAh6SBzc94x9
        AqPiLCS/zELyyyyEtQsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEprPT/45/2cG4
        /NVHvUOMTByMhxglOJiVRHjL+rclC/GmJFZWpRblxxeV5qQWH2KU5mBREuedsXV+spBAemJJ
        anZqakFqEUyWiYNTqoFJd50j46ZtXbYbdGs0Nthc/Cn8+VGw3AaLjQenZHy90+B7qL16gXS0
        qmLw33epulonpn/8/z36jJFJa8ZXsRN8pxlcbms/8Vkwu6Tnb8v706v8lh5xPRpzzEjzyMoW
        Q/dDC/xCJs99tf/5nmfpl2P6Ozdndfqs+BWi8zxp+5HwnIRPj36KJO9Ik9uy5LK+VTT7p/a3
        0xZ8d/ZqmPf9+66KS/YFSxsE/tldrP8h9SZoP+citY3TDLYzhVxPupJgqq5jOmvT/FlXD+25
        cJdR91hI7JrnbEe/BHHOSGRtPPZr6YoSTddLseatWvLbxD8YZf1anhfQ+TPp9gTt+tinD4IP
        fZm7//uZxonB6lNNVVrOeiixFGckGmoxFxUnAgCPh/C21gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7rn72xPNrjzV9Ji9d1+NotpH34y
        W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
        iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
        8ya5AO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
        vYw1PWdYC66zVfzsucXawHiJtYuRk0NCwETi/fKLjF2MXBxCAksZJba0NbJAJCQkbi9sYoSw
        hSX+XOtiA7GFBJ4xSnQeiOpi5OBgE9CSaOxkBwmLAJXs72hlAZnDLHCQSeLZlO/MIAlhgXCJ
        hVd3gNksAqoS39ZeAJvJK2ApMWdhOxPEfHmJmZe+gw3iFLCSeD59DRPELkuJjo+9bBD1ghIn
        Zz4Bu40ZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYfduO
        /dyyg3Hlq496hxiZOBgPMUpwMCuJ8Jb1b0sW4k1JrKxKLcqPLyrNSS0+xGgKdPdEZinR5Hxg
        /OeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTCVLtpSuLt2qeJv
        1n99F8tFAiel2m576bV1UceCicoXVrC4h7g8XZQZtX/hpz0Ld3yQ43TaoPRpwsr3b1NPrxL1
        0GgRvyPccchFTC7nvP/eT5fcy5vupicYT05dtflryHl/dYnvdQtUXhW0zy69aLHubM8H71r3
        eNF/rlLONxuSM53F+ZY/iBGeduiF4SS729acSdKGVW7XGAOv3fn1J/LoF1WnZ9mn5J+3XGKp
        6J2yYuNCrzdnzv77bbnig3F0KLtG05z9JaZHtLr7ytfd/fKmVfbnr+i3T7K1fj2sqnLyadUs
        Wp70KP3//S1fQlrP7zhw++dmg7MeqUc2PT4g/mlPV+D2QutZR1/HTFTP4Dz/XomlOCPRUIu5
        qDgRANWNwXtHAwAA
X-CMS-MailID: 20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038
References: <20230106083317.93938-1-p.raghav@samsung.com>
        <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the superfluous request queue check in bdev_is_zoned() as the
bdev_get_queue can never return NULL.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 43d4e073b111..0e40b014c40b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1283,12 +1283,7 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 
 static inline bool bdev_is_zoned(struct block_device *bdev)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return blk_queue_is_zoned(q);
-
-	return false;
+	return blk_queue_is_zoned(bdev_get_queue(bdev));
 }
 
 static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
-- 
2.25.1

