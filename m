Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F745B5612
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiILIYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiILIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:22:45 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D92EF22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:22:42 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220912082229euoutp02f4ee85a292b11502e503a92aa4bb8e8a~UD0R7fHMQ2459324593euoutp02G
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:22:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220912082229euoutp02f4ee85a292b11502e503a92aa4bb8e8a~UD0R7fHMQ2459324593euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662970949;
        bh=VLoCFLXBp82iOTzKgyetXtUrw6dZfbKcf6Fwvb6vl3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtBoq1dFD9tkwkS5uOBCHvsnFB/AWGgatj+1zkCf+AlMW1jDPO9sPPelSv/UQRUsM
         7JO924ESD0rtq3rsMpoLldSOjeGpfbiZwULPMEHJGF/GZNljKMa+wEET2UcR4DkW4L
         usQCeJRV9cQZv2pyWRETQUSLdzxjB0oQ1MPlTNVQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220912082218eucas1p25aec09241db9eba6d129d00870d39881~UD0IVRA_d2083820838eucas1p2b;
        Mon, 12 Sep 2022 08:22:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 31.A8.29727.A3CEE136; Mon, 12
        Sep 2022 09:22:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220912082218eucas1p23b4bcf6d76947724b9a7468a4b82a7f6~UD0H3RlcH2085220852eucas1p2X;
        Mon, 12 Sep 2022 08:22:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220912082218eusmtrp1990f88d4f6be66802adc81c7f14a6e5a~UD0H2XOxU1362613626eusmtrp1J;
        Mon, 12 Sep 2022 08:22:18 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-1b-631eec3a28a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 16.3F.07473.A3CEE136; Mon, 12
        Sep 2022 09:22:18 +0100 (BST)
Received: from localhost (unknown [106.210.248.191]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220912082218eusmtip2ca44631e327ca0164a0583a8af1664a1~UD0HkB02t2962029620eusmtip2r;
        Mon, 12 Sep 2022 08:22:18 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        linux-nvme@lists.infradead.org, pankydev8@gmail.com,
        matias.bjorling@wdc.com, linux-block@vger.kernel.org,
        bvanassche@acm.org, gost.dev@samsung.com, dm-devel@redhat.com,
        hare@suse.de, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v13 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date:   Mon, 12 Sep 2022 10:22:02 +0200
Message-Id: <20220912082204.51189-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912082204.51189-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7pWb+SSDWacNbZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDLW79nAVDCP
        r2LKou1sDYwXubsYOTkkBEwkPvd8ZOpi5OIQEljBKLH/zDVGCOcLo8TUTy3sEM5nRomrZ36z
        w7S82rWbDSKxnFFiwf2tLBDOS0aJr5cWMncxcnCwCWhJNHaCNYgIpEt8n/4ObAezwDYmifsP
        XzCDJIQFUiU2HT3HCGKzCKhKnHz7kRGkl1fASuLAb0GIZfISMy99B5vDCRR+vaoVrJxXQFDi
        5MwnLCA2M1BN89bZzCDzJQRWc0rsvd/ACNHsIvH5SC/U1cISr45vgbJlJE5P7mGBsKslnt74
        DdXcwijRv3M9G8gREgLWEn1nckBMZgFNifW79CHKHSUmrb7ADFHBJ3HjrSDECXwSk7ZNhwrz
        SnS0CUFUK0ns/PkEaqmExOWmOVBLPSSmt25nncCoOAvJM7OQPDMLYe8CRuZVjOKppcW56anF
        hnmp5XrFibnFpXnpesn5uZsYgWnw9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRFeFkPpZCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1MDDteKC2vCmb3/66V
        uar8juO1vyGc5xjPTpEzVb6y0ye+pfDWpjOV/19f1Sqe+TZk/ht9t4vJd87wLn4pULl4/psk
        y9618ZFd06Tfzvjnq8P+wrzYRoCXbYdcdpn8KUO5WbNtbgf8tJ3606PPk/v8trvGZ7s1WMSf
        X52z3H3r+5Kld86y/z45+dnPPwv+P1fbP33t16edelWrsr4cZAiu5Zc7dbU+5IPcqvgz/8wl
        di2fZP/1+R2eP6anJrUlRxa0LG70+bmuedJhBU/RpZXNVSbBzd1m92bal1Y3yLcJ6XrkV7gd
        VVzSb3nhfd+sbRlTjXMUf16q1inaUrXK83+zIceRuWe35HgEcN4zW3OuR4mlOCPRUIu5qDgR
        AN8VzOPyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7pWb+SSDQ52ClusP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFp+XtrBbrLn5lMXixC1pB0GPy1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA
        5rGz9T6rx/t9V9k8+rasYvTYfLra4/MmOY/2A91MATxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnr92xgKpjHVzFl0Xa2BsaL3F2MnBwSAiYS
        r3btZuti5OIQEljKKHHh22pmiISExO2FTYwQtrDEn2tdUEXPGSWmPLjM1MXIwcEmoCXR2MkO
        UiMikCvxeeUPsBpmgSNMEn9frQAbJCyQLPGt6wUTiM0ioCpx8u1HRpBeXgEriQO/BSHmy0vM
        vPQdbA4nUPj1qlawvUIClhJnv90Ai/MKCEqcnPmEBcRmBqpv3jqbeQKjwCwkqVlIUgsYmVYx
        iqSWFuem5xYb6hUn5haX5qXrJefnbmIERuy2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrwshtLJ
        QrwpiZVVqUX58UWlOanFhxhNgc6eyCwlmpwPTBl5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC
        6YklqdmpqQWpRTB9TBycUg1M83O4GKysTaWNJiuoSk5K+5R7UcOoTvDvOQeJ5IRb0azr8ioe
        xJy9Uz/n77dVHB2hMYnplkcO1SitWr7gpvTXOa91zgnf4N8txdBw3ud+Sv60baL83S/C3Exn
        v1oZPSlgiyiLuK5AflpZ2LMcbQbHMzmiSgE9nJ9cJT02BkSw6MqvlQ6/myiy7rPC7oxJjGxp
        /VsUtt7ZbZdRopRR+HHV8yvOK6ddvrj1cXDzKbWL65abpJnL2S98wOtpclTfgqFjr99y0Tvu
        XVJtfNzuU19mMXh0t/rYPODfVWKZp7e+b9mceXPZPp+Y9sq6nEf9012WFx51OQ323Nbdlx0i
        /CM4tn4SfWhQ6M395OQONiWW4oxEQy3mouJEAJx94GNhAwAA
X-CMS-MailID: 20220912082218eucas1p23b4bcf6d76947724b9a7468a4b82a7f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220912082218eucas1p23b4bcf6d76947724b9a7468a4b82a7f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082218eucas1p23b4bcf6d76947724b9a7468a4b82a7f6
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082218eucas1p23b4bcf6d76947724b9a7468a4b82a7f6@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

This is a prep patch for the new dm-po2zoned target as it modifies
bi_sector in the endio callback.

Call dm_zone_endio for zoned devices after calling the target's endio
function.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7c35dea88ed1..874e1dc9fc26 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1122,10 +1122,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(bdev_is_zoned(bio->bi_bdev)))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1154,6 +1150,10 @@ static void clone_endio(struct bio *bio)
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

