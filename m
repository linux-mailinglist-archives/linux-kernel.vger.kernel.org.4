Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB745E80F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiIWRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiIWRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:37:18 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3548E153A57
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:36:39 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173637euoutp029696f93575484fb979c1184a74d2df33~XjePuHCcX2651126511euoutp02e
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:36:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220923173637euoutp029696f93575484fb979c1184a74d2df33~XjePuHCcX2651126511euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663954597;
        bh=ejhVj2g5QfJG/lRSOPvtvchuAqj5y4NFP968qKAMySY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGpeOo2hCjqZ9PcAYq1A57aM+3ND0txF+EfsW6smymjJgud4QssTnH1shqcMNW+Bt
         Yv/ZsaRYtDrYsKwgwHfDMWW6LECWgPLBMUv5YUIMGgUXOdDHKMHRlijB6UGdPctK8z
         jh43DS5LKa7PJ272FrltmZZA4ibobvPJpcKxUHmA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923173635eucas1p1012b2a34974b634fd508b49151c8f749~XjeN9sEbZ1392113921eucas1p1O;
        Fri, 23 Sep 2022 17:36:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7F.6E.29727.3AEED236; Fri, 23
        Sep 2022 18:36:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220923173634eucas1p18fccee11155c670354da389b4d2f4c60~XjeMrPz061389413894eucas1p1M;
        Fri, 23 Sep 2022 17:36:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220923173634eusmtrp2085269d5b93f72f25da920ed225641b9~XjeMqcR-y1023410234eusmtrp2A;
        Fri, 23 Sep 2022 17:36:34 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-3b-632deea3a07a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.5F.10862.1AEED236; Fri, 23
        Sep 2022 18:36:34 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220923173633eusmtip28b3fca191f74d1d4ca1c403f983a9307~XjeMSQMwF2194521945eusmtip2h;
        Fri, 23 Sep 2022 17:36:33 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com
Cc:     jaegeuk@kernel.org, gost.dev@samsung.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v15 13/13] dm: add power-of-2 target for zoned devices with
 non power-of-2 zone sizes
Date:   Fri, 23 Sep 2022 19:36:18 +0200
Message-Id: <20220923173618.6899-14-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923173618.6899-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djP87qL3+kmGzx8Jm2x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaL1vZvTBZ7381mtbh5YCeTxZ5Fk5gsVq4+ymTxZP0sZou/XfeAsre0LS7v
        msNmMX/ZU3aLCW1fmS0+L21ht1hz8ymLxYlb0g5CHpeveHvsnHWX3ePy2VKPTas62Tw2L6n3
        2H2zgc1jZ+t9Vo/3+66yefRtWcXosfl0tcfnTXIe7Qe6mQJ4orhsUlJzMstSi/TtErgy3t79
        wFKwv77iwK47rA2Mc1K7GDk5JARMJM6sOcjYxcjFISSwglFixYEjLBDOF0aJpiPrGUGqhAQ+
        M0rMfaXRxcgB1rF1TiVEzXJGiZ47P6AaXjJKvPvwnA2kiE1AS6Kxkx2kV0QgXeL41pvsIDXM
        AhOZJZ5uvg2WEAZKfH4/lQXEZhFQlViwbCrYMl4BS4k1m5ayQpwnLzHz0nd2kJmcQPH+xhqI
        EkGJkzOfgLUyA5U0b53NDDJfQmAzp8SFzbvZIA51kbj3iAtijLDEq+Nb2CFsGYn/O+czQdjV
        Ek9v/IbqbWGU6N+5HqrXWqLvTA6IySygKbF+lz5EuaNE36VVrBAVfBI33gpCXMAnMWnbdGaI
        MK9ER5sQRLWSxM6fT6CWSkhcbprDAmF7SNzY0cs8gVFxFpJfZiH5ZRbC3gWMzKsYxVNLi3PT
        U4sN81LL9YoTc4tL89L1kvNzNzECU+Hpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrwpF3WThXhT
        EiurUovy44tKc1KLDzFKc7AoifOyzdBKFhJITyxJzU5NLUgtgskycXBKNTCp57Jw7lFI/V4y
        e8fFlaxWfY3tEe6yUu+uyO6Q/d/NxrfukOsG36UhP7tybnpUb76wlXVfpW9O8Z9Ips2lx8Nj
        Vm/+V8Uzye6xv3j5xAidMj0Gte4zLwUUq/4LsLKePLJdq4d933HnvXUFC0p/8vWKvQqO0d2T
        Llx76XOd3F7hmRveHZniosOq+fLI3Vv1k7dkvbBWmiR96+GDzuMRC06k2/cVrD78N4PbOvun
        faXRL511338evWG05Ptq3fB/1kqSL26tspPeKhTSeETvgNZu60L2vT6tW0wZQzwnWbv2ZNXc
        3D9D+6fWMtnCPF+lizXihyw1e0y1FTWXpb/JftqbECYZme51rvXW0ZgoTiWW4oxEQy3mouJE
        AH3r+Rv0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7qL3ukmG7xoY7RYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWtw8sJPJYs+iSUwWK1cfZbJ4sn4Ws8XfrntA2VvaFpd3
        zWGzmL/sKbvFhLavzBafl7awW6y5+ZTF4sQtaQchj8tXvD12zrrL7nH5bKnHplWdbB6bl9R7
        7L7ZwOaxs/U+q8f7fVfZPPq2rGL02Hy62uPzJjmP9gPdTAE8UXo2RfmlJakKGfnFJbZK0YYW
        RnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZb+9+YCnYX19xYNcd1gbGOaldjBwc
        EgImElvnVHYxcnEICSxllFj7fC5jFyMnUFxC4vbCJihbWOLPtS42iKLnjBJr7i5jBGlmE9CS
        aOxkB6kREciVOLb2HitIDbPAQmaJt3/ugjULC6RKvJqwFcxmEVCVWLBsKpjNK2ApsWbTUlaI
        BfISMy99ZweZyQkU72+sAQkLCVhInF/8iB2iXFDi5MwnLCA2M1B589bZzBMYBWYhSc1CklrA
        yLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMHK3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuFN
        uaibLMSbklhZlVqUH19UmpNafIjRFOjsicxSosn5wNSRVxJvaGZgamhiZmlgamlmrCTO61nQ
        kSgkkJ5YkpqdmlqQWgTTx8TBKdXApHjR7FaCtHeY9NEJfNvkZhzIY7/7OP9x2O2ex/y3NGz/
        7Fp9rH5TVM3O9LLSV9cFajOZqrwW3GsP3CXXHNB7wvhzset8+8BfNxfYRZaFnn/+r55pUhyb
        Zf7m/SkyfbUJ6w5LVh2sbmk7eCbKl0EvtCrpUMFeN/8J32btjvP4Z8+1ZIbn6biN16T+/L/9
        tGBnbMY2S9mMKcesolMvhGa0zVl0zLR9stK+P2lFNSfu3U/b9vGBRrH7jPsfJFZfripf3d6R
        k/O0efqWDROuJX/f2/H1d4SjxtSJ3dMuB0mLil+eUVHN3XGiVFR+2gavlS/7dh49F+TAvVY9
        d7nZ728Xp7XubT/16Ow5161Zy9Ts4pRYijMSDbWYi4oTAQhmqjplAwAA
X-CMS-MailID: 20220923173634eucas1p18fccee11155c670354da389b4d2f4c60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173634eucas1p18fccee11155c670354da389b4d2f4c60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173634eucas1p18fccee11155c670354da389b4d2f4c60
References: <20220923173618.6899-1-p.raghav@samsung.com>
        <CGME20220923173634eucas1p18fccee11155c670354da389b4d2f4c60@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only zoned devices with power-of-2(po2) number of sectors per zone(zone
size) were supported in linux but now non power-of-2(npo2) zone sizes
support has been added to the block layer.

Filesystems such as F2FS and btrfs have support for zoned devices with
po2 zone size assumption. Before adding native support for npo2 zone
sizes, it was suggested to create a dm target for npo2 zone size device to
appear as a po2 zone size target so that file systems can initially
work without any explicit changes.

The design of this target is very simple: remap the device zone size to
the zone capacity and change the zone size to be the nearest power of 2
value.

For e.g., a device with a zone size/capacity of 3M will have an equivalent
target layout as follows:

Device layout :-
zone capacity = 3M
zone size = 3M

|--------------|-------------|
0             3M            6M

Target layout :-
zone capacity=3M
zone size = 4M

|--------------|---|--------------|---|
0             3M  4M             7M  8M

The area between target's zone capacity and zone size will be emulated
in the target.
The read IOs that fall in the emulated gap area will return 0 filled
bio and all the other IOs in that area will result in an error.
If a read IO span across the emulated area boundary, then the IOs are
split across them. All other IO operations that span across the emulated
area boundary will result in an error.

The target can be easily created as follows:
dmsetup create <label> --table '0 <size_sects> po2zoned /dev/nvme<id>'

The target does not support partial mapping of the underlying
device as there is no use-case for it.

Note:
This target is not related to dm-zoned target, which exposes a zoned block
device as a regular block device without any write constraint.

This target only exposes a different zone size than the underlying device.
The underlying device's other constraints will be directly exposed to the
target.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
Suggested-by: Hannes Reinecke <hare@suse.de>
---
 .../admin-guide/device-mapper/dm-po2zoned.rst |  79 +++++
 .../admin-guide/device-mapper/index.rst       |   1 +
 drivers/md/Kconfig                            |  10 +
 drivers/md/Makefile                           |   2 +
 drivers/md/dm-po2zoned-target.c               | 293 ++++++++++++++++++
 5 files changed, 385 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zoned.rst
 create mode 100644 drivers/md/dm-po2zoned-target.c

diff --git a/Documentation/admin-guide/device-mapper/dm-po2zoned.rst b/Documentation/admin-guide/device-mapper/dm-po2zoned.rst
new file mode 100644
index 000000000000..8a35eab0b714
--- /dev/null
+++ b/Documentation/admin-guide/device-mapper/dm-po2zoned.rst
@@ -0,0 +1,79 @@
+===========
+dm-po2zoned
+===========
+The dm-po2zoned device mapper target exposes a zoned block device with a
+non-power-of-2(npo2) number of sectors per zone as a power-of-2(po2)
+number of sectors per zone(zone size).
+The filesystems that support zoned block devices such as F2FS and BTRFS
+assume po2 zone size as the kernel has traditionally only supported
+those devices. However, as the kernel now supports zoned block devices with
+npo2 zone sizes, the filesystems can run on top of the dm-po2zoned target before
+adding native support.
+
+Partial mapping of the underlying device is not supported by this target as
+there is no use-case for it.
+
+.. note::
+   This target is **not related** to **dm-zoned target**, which exposes a
+   zoned block device as a regular block device without any write constraint.
+
+   This target only exposes a different **zone size** than the underlying device.
+   The underlying device's other **constraints** will be exposed to the target.
+
+Algorithm
+=========
+The device mapper target maps the underlying device's zone size to the
+zone capacity and changes the zone size to the nearest po2 zone size.
+The gap between the zone capacity and the zone size is emulated in the target.
+E.g., a zoned block device with a zone size (and capacity) of 3M will have an
+equivalent target layout with mapping as follows:
+
+::
+
+  0M           3M  4M        6M 8M
+  |             |  |          |  |
+  +x------------+--+x---------+--+x-------  Target
+  |x            |  |x         |  |x
+   x               x             x
+   x               x             x
+   x              x             x
+   x             x             x
+  |x            |x            |x
+  +x------------+x------------+x----------  Device
+  |             |             |
+  0M           3M            6M
+
+A simple remap is performed for all the BIOs that do not cross the
+emulation gap area, i.e., the area between the zone capacity and size.
+
+If a BIO lies in the emulation gap area, the following operations are performed:
+
+	Read:
+		- If the BIO lies entirely in the emulation gap area, then zero out the BIO and complete it.
+		- If the BIO spans the emulation gap area, split the BIO across the zone capacity boundary
+                  and remap only the BIO within the zone capacity boundary. The other part of the split BIO
+                  will be zeroed out.
+
+	Other operations:
+                - Return an error
+
+Table parameters
+================
+
+::
+
+  <dev path>
+
+Mandatory parameters:
+
+    <dev path>:
+        Full pathname to the underlying block-device, or a
+        "major:minor" device-number.
+
+Examples
+========
+
+::
+
+  #!/bin/sh
+  echo "0 `blockdev --getsz $1` po2zoned $1" | dmsetup create po2z
diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
index cde52cc09645..5df93711cef5 100644
--- a/Documentation/admin-guide/device-mapper/index.rst
+++ b/Documentation/admin-guide/device-mapper/index.rst
@@ -23,6 +23,7 @@ Device Mapper
     dm-service-time
     dm-uevent
     dm-zoned
+    dm-po2zoned
     era
     kcopyd
     linear
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 998a5cfdbc4e..74fdfd02ab5f 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -518,6 +518,16 @@ config DM_FLAKEY
 	help
 	 A target that intermittently fails I/O for debugging purposes.
 
+config DM_PO2ZONED
+	tristate "Zoned block devices target emulating a power-of-2 number of sectors per zone"
+	depends on BLK_DEV_DM
+	depends on BLK_DEV_ZONED
+	help
+	  A target that converts a zoned block device with non-power-of-2(npo2)
+	  number of sectors per zone to be power-of-2(po2). Use this target for
+	  zoned block devices with npo2 number of sectors per zone until native
+	  support is added to the filesystems and applications.
+
 config DM_VERITY
 	tristate "Verity target support"
 	depends on BLK_DEV_DM
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 84291e38dca8..ee05722bc637 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -26,6 +26,7 @@ dm-era-y	+= dm-era-target.o
 dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
 dm-verity-y	+= dm-verity-target.o
 dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
+dm-po2zoned-y	+= dm-po2zoned-target.o
 
 md-mod-y	+= md.o md-bitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
@@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
 obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
 obj-$(CONFIG_DM_DUST)		+= dm-dust.o
 obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
+obj-$(CONFIG_DM_PO2ZONED)	+= dm-po2zoned.o
 obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
 obj-$(CONFIG_DM_MULTIPATH_QL)	+= dm-queue-length.o
 obj-$(CONFIG_DM_MULTIPATH_ST)	+= dm-service-time.o
diff --git a/drivers/md/dm-po2zoned-target.c b/drivers/md/dm-po2zoned-target.c
new file mode 100644
index 000000000000..0f8f768a94cf
--- /dev/null
+++ b/drivers/md/dm-po2zoned-target.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/device-mapper.h>
+
+#define DM_MSG_PREFIX "po2zoned"
+
+struct dm_po2z_target {
+	struct dm_dev *dev;
+	sector_t zone_size; /* Actual zone size of the underlying dev*/
+	sector_t zone_size_po2; /* zone_size rounded to the nearest po2 value */
+	unsigned int zone_size_po2_shift;
+	sector_t zone_size_diff; /* diff between zone_size_po2 and zone_size */
+	unsigned int nr_zones;
+};
+
+static inline unsigned int npo2_zone_no(struct dm_po2z_target *dmh,
+					sector_t sect)
+{
+	return div64_u64(sect, dmh->zone_size);
+}
+
+static inline unsigned int po2_zone_no(struct dm_po2z_target *dmh,
+				       sector_t sect)
+{
+	return sect >> dmh->zone_size_po2_shift;
+}
+
+static inline sector_t device_to_target_sect(struct dm_target *ti,
+					     sector_t sect)
+{
+	struct dm_po2z_target *dmh = ti->private;
+
+	return sect + (npo2_zone_no(dmh, sect) * dmh->zone_size_diff) +
+	       ti->begin;
+}
+
+/*
+ * This target works on the complete zoned device. Partial mapping is not
+ * supported.
+ * Construct a zoned po2 logical device: <dev-path>
+ */
+static int dm_po2z_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct dm_po2z_target *dmh = NULL;
+	int ret;
+	sector_t zone_size;
+	sector_t dev_capacity;
+
+	if (argc != 1)
+		return -EINVAL;
+
+	dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
+	if (!dmh)
+		return -ENOMEM;
+
+	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
+			    &dmh->dev);
+	if (ret) {
+		ti->error = "Device lookup failed";
+		goto free;
+	}
+
+	if (!bdev_is_zoned(dmh->dev->bdev)) {
+		DMERR("%pg is not a zoned device", dmh->dev->bdev);
+		ret = -EINVAL;
+		goto bad;
+	}
+
+	zone_size = bdev_zone_sectors(dmh->dev->bdev);
+	dev_capacity = get_capacity(dmh->dev->bdev->bd_disk);
+	if (ti->len != dev_capacity) {
+		DMERR("%pg Partial mapping of the target is not supported",
+		      dmh->dev->bdev);
+		ret = -EINVAL;
+		goto bad;
+	}
+
+	if (is_power_of_2(zone_size))
+		DMWARN("%pg: underlying device has a power-of-2 number of sectors per zone",
+		       dmh->dev->bdev);
+
+	dmh->zone_size = zone_size;
+	dmh->zone_size_po2 = 1 << get_count_order_long(zone_size);
+	dmh->zone_size_po2_shift = ilog2(dmh->zone_size_po2);
+	dmh->zone_size_diff = dmh->zone_size_po2 - dmh->zone_size;
+	ti->private = dmh;
+	ti->max_io_len = dmh->zone_size_po2;
+	dmh->nr_zones = npo2_zone_no(dmh, ti->len);
+	ti->len = dmh->zone_size_po2 * dmh->nr_zones;
+	return 0;
+
+bad:
+	dm_put_device(ti, dmh->dev);
+free:
+	kfree(dmh);
+	return ret;
+}
+
+static void dm_po2z_dtr(struct dm_target *ti)
+{
+	struct dm_po2z_target *dmh = ti->private;
+
+	dm_put_device(ti, dmh->dev);
+	kfree(dmh);
+}
+
+static int dm_po2z_report_zones_cb(struct blk_zone *zone, unsigned int idx,
+				   void *data)
+{
+	struct dm_report_zones_args *args = data;
+	struct dm_target *ti = args->tgt;
+	struct dm_po2z_target *dmh = ti->private;
+
+	zone->start = device_to_target_sect(ti, zone->start);
+	zone->wp = device_to_target_sect(ti, zone->wp);
+	zone->len = dmh->zone_size_po2;
+	args->next_sector = zone->start + zone->len;
+
+	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
+}
+
+static int dm_po2z_report_zones(struct dm_target *ti,
+				struct dm_report_zones_args *args,
+				unsigned int nr_zones)
+{
+	struct dm_po2z_target *dmh = ti->private;
+	sector_t sect =
+		po2_zone_no(dmh, dm_target_offset(ti, args->next_sector)) *
+		dmh->zone_size;
+
+	return blkdev_report_zones(dmh->dev->bdev, sect, nr_zones,
+				   dm_po2z_report_zones_cb, args);
+}
+
+static int dm_po2z_end_io(struct dm_target *ti, struct bio *bio,
+			  blk_status_t *error)
+{
+	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
+		bio->bi_iter.bi_sector =
+			device_to_target_sect(ti, bio->bi_iter.bi_sector);
+
+	return DM_ENDIO_DONE;
+}
+
+static void dm_po2z_io_hints(struct dm_target *ti, struct queue_limits *limits)
+{
+	struct dm_po2z_target *dmh = ti->private;
+
+	limits->chunk_sectors = dmh->zone_size_po2;
+}
+
+static void dm_po2z_status(struct dm_target *ti, status_type_t type,
+			   unsigned int status_flags, char *result,
+			   unsigned int maxlen)
+{
+	struct dm_po2z_target *dmh = ti->private;
+	size_t sz = 0;
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		DMEMIT("%s %lld", dmh->dev->name,
+		       (unsigned long long)dmh->zone_size);
+		break;
+
+	case STATUSTYPE_TABLE:
+		DMEMIT("%s", dmh->dev->name);
+		break;
+
+	case STATUSTYPE_IMA:
+		result[0] = '\0';
+		break;
+	}
+}
+
+/**
+ * dm_po2z_bio_in_emulated_zone_area - check if bio is in the emulated zone area
+ * @dmh:	target data
+ * @bio:	bio
+ * @offset:	bio offset to emulated zone boundary
+ *
+ * Check if a @bio is partly or completely in the emulated zone area. If the
+ * @bio is partly in the emulated zone area, @offset can be used to split
+ * the @bio across the emulated zone boundary. @offset
+ * will be negative if the @bio completely lies in the emulated area.
+ *
+ */
+static bool dm_po2z_bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
+					      struct bio *bio, int *offset)
+{
+	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
+	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+	sector_t sector_offset =
+		bio->bi_iter.bi_sector - (zone_idx << dmh->zone_size_po2_shift);
+
+	*offset = dmh->zone_size - sector_offset;
+
+	return sector_offset + nr_sectors > dmh->zone_size;
+}
+
+static inline void dm_po2z_read_zeroes(struct bio *bio)
+{
+	zero_fill_bio(bio);
+	bio_endio(bio);
+}
+
+static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
+{
+	struct dm_po2z_target *dmh = ti->private;
+	int split_io_pos;
+
+	bio_set_dev(bio, dmh->dev->bdev);
+	bio->bi_iter.bi_sector = dm_target_offset(ti, bio->bi_iter.bi_sector);
+
+	if (op_is_zone_mgmt(bio_op(bio)) || !bio_sectors(bio))
+		goto remap_sector;
+
+	if (!dm_po2z_bio_in_emulated_zone_area(dmh, bio, &split_io_pos))
+		goto remap_sector;
+
+	/*
+	 * Read operation on the emulated zone area (between zone capacity
+	 * and zone size) will fill the bio with zeroes. Any other operation
+	 * in the emulated area should return an error.
+	 */
+	if (bio_op(bio) == REQ_OP_READ) {
+		/*
+		 * If the bio is across emulated zone boundary, split the bio at
+		 * the boundary.
+		 */
+		if (split_io_pos > 0) {
+			dm_accept_partial_bio(bio, split_io_pos);
+			goto remap_sector;
+		}
+
+		dm_po2z_read_zeroes(bio);
+		return DM_MAPIO_SUBMITTED;
+	}
+	/* Other IOs in emulated zone area should result in an error */
+	return DM_MAPIO_KILL;
+
+remap_sector:
+	/* convert from target sector to device sector */
+	bio->bi_iter.bi_sector -= (po2_zone_no(dmh, bio->bi_iter.bi_sector) *
+				   dmh->zone_size_diff);
+	return DM_MAPIO_REMAPPED;
+}
+
+static int dm_po2z_iterate_devices(struct dm_target *ti,
+				   iterate_devices_callout_fn fn, void *data)
+{
+	struct dm_po2z_target *dmh = ti->private;
+	sector_t len = dmh->nr_zones * dmh->zone_size;
+
+	return fn(ti, dmh->dev, 0, len, data);
+}
+
+static struct target_type dm_po2z_target = {
+	.name = "po2zoned",
+	.version = { 1, 0, 0 },
+	.features = DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONES |
+		    DM_TARGET_NOWAIT,
+	.map = dm_po2z_map,
+	.end_io = dm_po2z_end_io,
+	.report_zones = dm_po2z_report_zones,
+	.iterate_devices = dm_po2z_iterate_devices,
+	.module = THIS_MODULE,
+	.io_hints = dm_po2z_io_hints,
+	.status = dm_po2z_status,
+	.ctr = dm_po2z_ctr,
+	.dtr = dm_po2z_dtr,
+};
+
+static int __init dm_po2z_init(void)
+{
+	return dm_register_target(&dm_po2z_target);
+}
+
+static void __exit dm_po2z_exit(void)
+{
+	dm_unregister_target(&dm_po2z_target);
+}
+
+/* Module hooks */
+module_init(dm_po2z_init);
+module_exit(dm_po2z_exit);
+
+MODULE_DESCRIPTION(DM_NAME "power-of-2 zoned target");
+MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
+MODULE_LICENSE("GPL");
+
-- 
2.25.1

