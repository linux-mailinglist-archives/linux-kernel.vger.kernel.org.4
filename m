Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EEB65FCDB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjAFIeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjAFId2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:33:28 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45E67BDB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 00:33:27 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083324euoutp02141e1482c206bc40f54e48d0e7b54851~3qy7JNW4D2168121681euoutp02s
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:33:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230106083324euoutp02141e1482c206bc40f54e48d0e7b54851~3qy7JNW4D2168121681euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672994004;
        bh=2fIGGCsma0+nVBZgfpMGxL+SDIiTbKkvsObjxRsUwIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbiSJYvdvkNeL4z4kNKj9/QEI3bp7dNQ1PF9b3K7CyfS0JqDl7mSIdb6N/Sww2iXZ
         DEY7DMyMNWIuq9gWCNveg6wGbmAsIe0Uru26MamRaP2H4PR1bSY/6Ec8HZM50Ev/vC
         te0iWVFcPVJQAXl8InqQDOHQc1u4CDnwEF+KHTfY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230106083322eucas1p2971716b1ceb1cf2f5b90a0b696f8ac40~3qy51-6_o2329223292eucas1p2b;
        Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E7.43.43884.2DCD7B36; Fri,  6
        Jan 2023 08:33:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0~3qy5cK3zL2329223292eucas1p2a;
        Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230106083322eusmtrp14b2b106c1afd8945ed5347acbbf4cd5e~3qy5bgmoU2166121661eusmtrp1k;
        Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
X-AuditID: cbfec7f5-25bff7000000ab6c-49-63b7dcd2ee91
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.C6.23420.2DCD7B36; Fri,  6
        Jan 2023 08:33:22 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230106083321eusmtip292f5234c8251a10cc76fbb993a2024c1~3qy5MIvO82941329413eusmtip2E;
        Fri,  6 Jan 2023 08:33:21 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 5/7] dm-zoned: ensure only power of 2 zone sizes are allowed
Date:   Fri,  6 Jan 2023 09:33:15 +0100
Message-Id: <20230106083317.93938-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106083317.93938-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djP87qX7mxPNjj1U9Zi9d1+NotpH34y
        W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLP523WOyOPPyM4vF3lvaFpd3zWGzmL/sKbvF
        jQlPGS0+L21htzhxS9qB3+PyFW+Py2dLPTat6mTz2Lyk3mP3zQY2j52t91k9zq509Hi/7yqb
        R9+WVYwem09Xe3zeJOfRfqCbKYAnissmJTUnsyy1SN8ugSvjQutMloL9vBXrby5namCcyt3F
        yMkhIWAicWzBSZYuRi4OIYEVjBKLTq5lgnC+MEqsP3oWKvOZUeLA1O3MMC0diw5AJZYzShw7
        28kM4bxglDj5/T5jFyMHB5uAlkRjJztIg4iAsMT+jlawBmaBHmaJ3Xc+M4EkhAV8JLp/bWQE
        sVkEVCXm3LzPAmLzClhK3L2+BmqbvMTMS9/BBnEKWEk8n76GCaJGUOLkzCdg9cxANc1bZ4Md
        ISEwm1PiwJrT7BDNLhJtU9sZIWxhiVfHt0DFZSROT+5hgbCrJZ7e+A3V3MIo0b9zPRvIBxIC
        1hJ9Z3JATGYBTYn1u/Qhyh0l1ixexQJRwSdx460gxAl8EpO2TWeGCPNKdLQJQVQrSez8+QRq
        qYTE5aY5UEs9JP53LWGawKg4C8kzs5A8Mwth7wJG5lWM4qmlxbnpqcXGeanlesWJucWleel6
        yfm5mxiBKe/0v+NfdzCuePVR7xAjEwfjIUYJDmYlEd6y/m3JQrwpiZVVqUX58UWlOanFhxil
        OViUxHlnbJ2fLCSQnliSmp2aWpBaBJNl4uCUamDS6Smd2XLy7OXvL+bWmtp7z1Pc0L4pauuH
        P1cnRE5vPH9qQvCDQ7FXMwy0dk+e9sfsCpvp0vpNe9rqlA9GC7D7tVuV7fTbefCRTvyLtwxL
        p9j9NinRWxX0OOZOn8+a6KB+DeZfRw+tX3CyXf/Rsj2fJz/dOiMk7Ef9VON7z0I3cK790fU9
        nDWVs8khzVbr5dXlrj+marLcnH9vD699j4pbS1lU952is2d97DbXzLQvPFTnOddZ6WPBUdtX
        9Q+3x6r8U9oRF8xSl3ZP2kXr6GHTlOaKCfXJT8JYTGT80ny/5W9Z+PiAUPELrozPxyvySi/3
        NCxyvHX1Sc3d1/UzZbZcfrzy5bPzDGvyfmX+2MTyW4mlOCPRUIu5qDgRAG4MpdjoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7qX7mxPNmg9xmKx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLmwd2MlnsWTSJyWLl6qNMFn+77jFZnHn5mcVi7y1ti8u75rBZzF/2lN3i
        xoSnjBafl7awW5y4Je3A73H5irfH5bOlHptWdbJ5bF5S77H7ZgObx87W+6weZ1c6erzfd5XN
        o2/LKkaPzaerPT5vkvNoP9DNFMATpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
        ZKqkb2eTkpqTWZZapG+XoJdxoXUmS8F+3or1N5czNTBO5e5i5OSQEDCR6Fh0gKWLkYtDSGAp
        o0T3rzvMEAkJidsLmxghbGGJP9e62CCKnjFKvN79GyjBwcEmoCXR2MkOUiMCVLO/oxVsELPA
        HGaJk5tngg0SFvABGroRbBCLgKrEnJv3WUBsXgFLibvX10Atk5eYeek72CBOASuJ59PXMIHY
        QkA1HR972SDqBSVOznwC1ssMVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbUK07MLS7N
        S9dLzs/dxAiMzm3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeMv6tyUL8aYkVlalFuXHF5XmpBYf
        YjQFunsis5Rocj4wPeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBK
        NTB1mdzP3lr/US1n1otJEhdWGUZsWTqFyz/m0BmZjxMenuqex//nC1tAN1PP9Xr2dVWXbz7S
        VZzopTgtz/1qxfTl6dOeadce77H4JDY78roph1LTG4GMGVb3jJTeMwmGrH99t/70/MUW95xs
        0i6aMqrE8245FJiT0rPER3dn7T/33UteHbp24FeGQMj/V59UwljNEjZ0quzPuDy3+or6jkf7
        fBfHunfdNN9SceIP76Nd9788i81Xq1hs4G4437Rix/rHVypKmRkSLrJc90qPv7ja69XLrDxx
        yUlX7tu2G0Vb3TOpj+qpmrUjXDYmRerm+ozQs7dPfeVeWKuYOev3Nq/paV6PO/7UN5aUuB49
        Ny9DiaU4I9FQi7moOBEAFX/yu1cDAAA=
X-CMS-MailID: 20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0
References: <20230106083317.93938-1-p.raghav@samsung.com>
        <CGME20230106083322eucas1p2414f1f7f121fbbd7a0e5e1b1b622f5c0@eucas1p2.samsung.com>
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

