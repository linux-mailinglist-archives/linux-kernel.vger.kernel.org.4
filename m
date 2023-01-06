Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13E65FCDC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjAFIe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjAFId2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:33:28 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB0B80ACD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 00:33:27 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083325euoutp0113ae92e574a6f226dc10d3be3abca767~3qy8kvvbc2179921799euoutp01q
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:33:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230106083325euoutp0113ae92e574a6f226dc10d3be3abca767~3qy8kvvbc2179921799euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672994005;
        bh=ki5YCi75NytYdqt7jBnGHXj1OOScNdOplcKKRH7vS3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtzsNb3p5ukwBbg3Z1DF6RY7c2g7hjRifZy337iRD0UoyWinTYTFvqz05If70KWdW
         J3a+eKZR3qk6/uvzGxmgvAbd1sgCi9h4q8U1q2BRVNeXc95m2XSKLjvre1KdTwkeYg
         yThgZYnKFjSmYkEqNBGOXv/UQeHt+mIs9k4NxI1c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230106083324eucas1p2a41a4dc8a4943a42cebd2faff7b4f11b~3qy7O-sUd0368903689eucas1p23;
        Fri,  6 Jan 2023 08:33:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5A.14.61936.3DCD7B36; Fri,  6
        Jan 2023 08:33:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e~3qy6rXvLi0142401424eucas1p2Q;
        Fri,  6 Jan 2023 08:33:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230106083323eusmtrp21b31fb042b763934d753f5d411f81c64~3qy6qwBSI1128211282eusmtrp2F;
        Fri,  6 Jan 2023 08:33:23 +0000 (GMT)
X-AuditID: cbfec7f4-a2dff7000002f1f0-de-63b7dcd3c38d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.AB.52424.3DCD7B36; Fri,  6
        Jan 2023 08:33:23 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230106083323eusmtip2fe614ae8c9a0dcec5c403fa52c600eb8~3qy6fASkM2941329413eusmtip2G;
        Fri,  6 Jan 2023 08:33:23 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 7/7] dm: call dm_zone_endio after the target endio callback
 for zoned devices
Date:   Fri,  6 Jan 2023 09:33:17 +0100
Message-Id: <20230106083317.93938-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106083317.93938-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djPc7qX72xPNvi01dpi9d1+NotpH34y
        W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
        iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
        8ya5AO4oLpuU1JzMstQifbsErozTq7IKXvJW9E1rZWtgXMPdxcjJISFgIjGnr4cdxBYSWMEo
        0XE8BcL+wigx/4Z2FyMXkP2ZUWL/2alsMA2dP36wQiSWM0rsfnqABcJ5wSjxbcYDxi5GDg42
        AS2Jxk6wqSICwhL7O1rBapgFNjNJ3P69lhEkISwQL3FhXQfYVBYBVYmP/ffYQHp5BSwlPpzN
        hVgmLzHz0newOZwCVhLPp69hArF5BQQlTs58wgJiMwPVNG+dzQwyX0KgnVPiz9XTLBDNLhLz
        LnxjhrCFJV4d38IOYctI/N85nwnCrpZ4euM3VHMLo0T/zvVgR0gIWEv0nckBMZkFNCXW79KH
        KHeU2H/+BiNEBZ/EjbeCECfwSUzaNp0ZIswr0dEmBFGtJLHz5xOopRISl5vmQB3mIbGs8Q/r
        BEbFWUiemYXkmVkIexcwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITGan/x3/soNx
        +auPeocYmTgYDzFKcDArifCW9W9LFuJNSaysSi3Kjy8qzUktPsQozcGiJM47Y+v8ZCGB9MSS
        1OzU1ILUIpgsEwenVANTadtTYcPT903PZf6LiTt++ZyYFk/qhOh3/5MVbz25vK4rcOMElTDP
        9TEBfw4Z8VT/vFK7ZdK6K8zLBMWVTcRZ2/N4drdZPkhn7VA6p7lJvX0Vp/+BuQXOJ6trQs/m
        yeR8n6DR0Lho71HO1e6TqpWL+Het2h6w1ITnR+wklQ+JXwxuaWlG7l4x48h5w0mac08m9K9/
        G5lZGPlQ90fB83vKHB+E5v7Un6DE9rt5A/fe/dwGj0rOb9127q+XXdO5pJ2srU8+XAld5MZ9
        zr+5WG2Hxeqn7UoHpI7z9/tndB/bd6aGgffM5vzuq4Y2X04od4t0y5+fIez98GH2HouK3SL+
        Cgu3bpRXsN40PybyKNtXJZbijERDLeai4kQAPHRhhtUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7qX72xPNni9R9pi9d1+NotpH34y
        W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
        iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
        8ya5AO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
        vYzTq7IKXvJW9E1rZWtgXMPdxcjJISFgItH54wdrFyMXh5DAUkaJz99uMUMkJCRuL2xihLCF
        Jf5c62KDKHoGVDR5FlCCg4NNQEuisZMdpEYEqGZ/RysLSA2zwEEmiWdTvoMNEhaIlXh4djtY
        EYuAqsTH/ntsIL28ApYSH87mQsyXl5h56TtYCaeAlcTz6WuYQGwhoJKOj71sIDavgKDEyZlP
        WEBsZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYOxtO/Zz
        yw7Gla8+6h1iZOJgPMQowcGsJMJb1r8tWYg3JbGyKrUoP76oNCe1+BCjKdDZE5mlRJPzgdGf
        VxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAxGHALnq8uOu5I6vY
        iwOrt6eJ3LbvVd1r4uVvJDFBK83eKabvpn3mrAzzO3dOuZxT+XtivsWGK8y2KjHVorNqyp2P
        1UuwBJ3+E9l4oeCCb0KMQ/2W2zeLHrsGq/zqW7R9yQE/b6OOmFW55styWvY4LP78+b24kW5p
        s4NH159l1oIacYtbPa5Z2XFNuKemGNs57T2bi4KKo0Nmr5LPqcK/lm5lWrMvF3st5Z0vLHD1
        RO6bk1yy10rqlyaEb0v+uuYzw9c8t6lB008qGuRus/VcOeniyoZFsqb3sq0VQz6Xd4vdvvMj
        2n/blJh4443s7Mz5mlqR0/fMUBDnrwg+ERR5+fO5nUKTGT58vn7gFZ8SS3FGoqEWc1FxIgDt
        M+6dRgMAAA==
X-CMS-MailID: 20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e
References: <20230106083317.93938-1-p.raghav@samsung.com>
        <CGME20230106083323eucas1p2f0f6d5d5c1c3713be35b841157ae463e@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
uses either native append or append emulation, and it is called before the
endio of the target. But target endio can still update the clone bio
after dm_zone_endio is called, thereby, the orig bio does not contain
the updated information anymore.

Currently, this is not a problem as the targets that support zoned devices
such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
and even if they do (such as dm-flakey), they don't modify the
bio->bi_iter.bi_sector of the cloned bio that is used to update the
orig_bio's bi_sector in dm_zone_endio function.

Call dm_zone_endio for zoned devices after calling the target's endio
function.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b424a6ee27ba..fdef74fe8bd1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1109,10 +1109,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(bdev_is_zoned(bio->bi_bdev)))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1141,6 +1137,10 @@ static void clone_endio(struct bio *bio)
 		}
 	}
 
+	if (static_branch_unlikely(&zoned_enabled) &&
+	    unlikely(bdev_is_zoned(bio->bi_bdev)))
+		dm_zone_endio(io, bio);
+
 	if (static_branch_unlikely(&swap_bios_enabled) &&
 	    unlikely(swap_bios_limit(ti, bio)))
 		up(&md->swap_bios_semaphore);
-- 
2.25.1

