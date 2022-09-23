Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE985E80D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIWRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiIWRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:36:28 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01914A7B3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:36:25 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220923173622euoutp01288215b17b049a8654bb1bac7f7495b9~XjeBr5JwC0680206802euoutp01i
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:36:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220923173622euoutp01288215b17b049a8654bb1bac7f7495b9~XjeBr5JwC0680206802euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663954582;
        bh=fdohm/2himTcOYcoyxrTHSzZfRbu/kuActVSfmc2bbg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=F6sDLF9QIY6PXCyJm6cnuEw7NWRj0zq9QpgtIPMvapZZb2CqFMgk2a39AQ+muzVQ0
         QFrh2Q4u8XMMmh7O1FNB8UC8ZQnMMiEE4AVeeghaxGuK9meKic5RpuhNf8jxCrGh4n
         KfV+IdfKsqQ7XpoZLW5IZ+DPUla9Xw6Knccrsrd8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923173621eucas1p1efd71c6b9be430ff1fc25874264177f0~XjeAbW_iG1387913879eucas1p1E;
        Fri, 23 Sep 2022 17:36:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A4.6E.29727.49EED236; Fri, 23
        Sep 2022 18:36:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65~Xjd-VO9jb1390013900eucas1p1H;
        Fri, 23 Sep 2022 17:36:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220923173619eusmtrp153694b731b806786b4e038580dbfd562~Xjd-UQcdb1032310323eusmtrp1W;
        Fri, 23 Sep 2022 17:36:19 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-1e-632dee943151
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A7.78.07473.39EED236; Fri, 23
        Sep 2022 18:36:19 +0100 (BST)
Received: from localhost (unknown [106.210.248.168]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220923173619eusmtip1613f6827d35757d800c666df5309f030~Xjd__cKuy0836708367eusmtip1P;
        Fri, 23 Sep 2022 17:36:19 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com
Cc:     jaegeuk@kernel.org, gost.dev@samsung.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Date:   Fri, 23 Sep 2022 19:36:05 +0200
Message-Id: <20220923173618.6899-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87pT3ukmGzS1mVmsP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFp+XtrBbrLn5lMXixC1pB0GPy1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA
        5rGz9T6rx/t9V9k8+rasYvTYfLra4/MmOY/2A91MATxRXDYpqTmZZalF+nYJXBlXLz9iKjgS
        XfHg3CPmBsYdbl2MnBwSAiYSE8/PZOxi5OIQEljBKLF2wWN2COcLo8SLydPZIJzPjBIt55ey
        w7Rc+bqcFcQWEljOKNH9Rg+i6CWjxOx7R4BmcXCwCWhJNHaC1YsIpEsc33oTbCqzwDYmibaZ
        O1lAEsIC4RIzpl4AK2IRUJW4+GcJWJxXwEJi657/bBDL5CVmXvrODhEXlDg58wlYDTNQvHnr
        bGaQoRICyzklXl2ZCHWdi8TsN4eZIWxhiVfHt0DFZSROT+5hgbCrJZ7e+A3V3MIo0b9zPRvI
        1RIC1hJ9Z3JATGYBTYn1u/Qhyh0lPh5+wg5RwSdx460gxAl8EpO2TWeGCPNKdLQJQVQrSez8
        +QRqqYTE5aY5UEs9JK5NPssMCbZYibVTjjNNYFSYheSxWUgem4VwwwJG5lWM4qmlxbnpqcWG
        eanlesWJucWleel6yfm5mxiBafD0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd6Ui7rJQrwpiZVV
        qUX58UWlOanFhxilOViUxHnZZmglCwmkJ5akZqemFqQWwWSZODilGpiqVadcy02JXPGn4UVh
        /Ot4002/qnyfRG7mefupKliMTczKbftJ0aaG5TYWLtYsWyIeFu15P6VPNtJt0xodjoz7pswb
        g0sn/z1n2vplvazxCsPVgv/mpR1Wi1++btFrqSn3Lv3qFzF8rVPrVh0dHtLnZ+wku//yzK4V
        N6autFm6QXRaT7eRw/SjdlkP75SIOmyx+P1hgxOf7hnnAs0UM9W4/zefTJjFIsF7WSRH+uNZ
        1UMeLKsemRyJm+8qJ6Mw9eik/v1Rf1ZsXK7p5v/8+kOVYy2yUZlOM04Kta47FV/c8Ctj+lfV
        P4/CO/LTEpnmG0vf8jyzO91379xCf0XRE0HP700pqDD3fDl7YcA/xkolluKMREMt5qLiRACr
        lNuG8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7qT3+kmG5xfrmux/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcvfyIqeBIdMWDc4+YGxh3uHUxcnJICJhI
        XPm6nLWLkYtDSGApo8S+EzPZIBISErcXNjFC2MISf651sUEUPWeUaDnWwtLFyMHBJqAl0djJ
        DlIjIpArcWztPbBBzAJHmCTadt8HSwgLhEocXjuJBcRmEVCVuPhnCZjNK2AhsXXPf6hl8hIz
        L31nB5nJLKApsX6XPkSJoMTJmU/AypmBSpq3zmaewMg/C6FqFpKqWUiqFjAyr2IUSS0tzk3P
        LTbUK07MLS7NS9dLzs/dxAiM123Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeFMu6iYL8aYkVlal
        FuXHF5XmpBYfYjQFunois5Rocj4wYeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqem
        FqQWwfQxcXBKNTCFZ/26Xrnh6OW5y5LOJj6d58EqrFl2qjp+3vs7H59FHJ75q6C/qojRqSTP
        Nrcr6fCBDfrBK5+kZZ9yfx7j7XpQ+K397t1qV15ferK6ujlqW0/J8hlfzlp7fP46sYCbVSDk
        4d34c3NffvXs39RncDPEJH7pw5RZnBErNmQ82OSyVlRjptvrBdps/Zu+3RHbqvQ0ctW+R9Zy
        us5uj7bNVxSfZKE0scnYteK2+YYn9RNiTolODMtk+HFzuuykOWtfV93XNzs+vyLgksW9iSsq
        2JqcDnmtkVBfxD1N3rCBYbfAao/ukvDil9y7HyakRB/6XjF5x1zL77u5J12Ialp6b+PTAK7l
        Ov5985Rdu9Ov+jFaKrEUZyQaajEXFScCAGYERZ1gAwAA
X-CMS-MailID: 20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
  Please consider this patch series for the 6.1 release.

- Background and Motivation:

The zone storage implementation in Linux, introduced since v4.10, first
targetted SMR drives which have a power of 2 (po2) zone size alignment
requirement. The po2 zone size was further imposed implicitly by the
block layer's blk_queue_chunk_sectors(), used to prevent IO merging
across chunks beyond the specified size, since v3.16 through commit
762380ad9322 ("block: add notion of a chunk size for request merging").
But this same general block layer po2 requirement for blk_queue_chunk_sectors()
was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
to be non-power-of-2").

NAND, which is the media used in newer zoned storage devices, does not
naturally align to po2. In these devices, zone capacity(cap) is not the
same as the po2 zone size. When the zone cap != zone size, then unmapped
LBAs are introduced to cover the space between the zone cap and zone size.
po2 requirement does not make sense for these type of zone storage devices.
This patch series aims to remove these unmapped LBAs for zoned devices when
zone cap is npo2. This is done by relaxing the po2 zone size constraint
in the kernel and allowing zoned device with npo2 zone sizes if zone cap
== zone size.

Removing the po2 requirement from zone storage should be possible
now provided that no userspace regression and no performance regressions are
introduced. Stop-gap patches have been already merged into f2fs-tools to
proactively not allow npo2 zone sizes until proper support is added [1].

There were two efforts previously to add support to npo2 devices: 1) via
device level emulation [2] but that was rejected with a final conclusion
to add support for non po2 zoned device in the complete stack[3] 2)
adding support to the complete stack by removing the constraint in the
block layer and NVMe layer with support to btrfs, zonefs, etc which was
rejected with a conclusion to add a dm target for FS support [0]
to reduce the regression impact.

This series adds support to npo2 zoned devices in the block and nvme
layer and a new **dm target** is added: dm-po2zoned-target. This new
target will be initially used for filesystems such as btrfs and
f2fs until native npo2 zone support is added.

- Patchset description:
Patches 1-3 deals with removing the po2 constraint from the
block layer.

Patches 4-5 deals with removing the constraint from nvme zns.

Patch 5 removes the po2 contraint in null blk

Patch 6 adds npo2 support to zonefs

Patches 7-13 adds support for npo2 zoned devices in the DM layer and
adds a new target dm-po2zoned-target which converts a zoned device with
npo2 zone size into a zoned target with po2 zone size.

The patch series is based on linux-next tag: next-20220921

Testing:
The new target was tested with blktest and zonefs test suite in qemu and
on a real ZNS device with npo2 zone size.

Performance Measurement on a null blk:
Device:
zone size = 128M, blocksize=4k

FIO cmd:
fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
--io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k
--loops=4

The following results are an average of 4 runs on AMD Ryzen 5 5600X with
32GB of RAM:

Sequential Write:
x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  578     |  2257    |   12.80   |  576     |  2248    |   25.78   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  581     |  2268    |   12.74   |  576     |  2248    |   25.85   |
x-----------------x---------------------------------x---------------------------------x

Sequential read:
x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  667     |  2605    |   11.79   |  675     |  2637    |   23.49   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  667     |  2605    |   11.79   |  675     |  2638    |   23.48   |
x-----------------x---------------------------------x---------------------------------x

Random read:
x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  522     |  2038    |   15.05   |  514     |  2006    |   30.87   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  522     |  2039    |   15.04   |  523     |  2042    |   30.33   |
x-----------------x---------------------------------x---------------------------------x

Minor variations are noticed in Sequential write with io depth 8 and
in random read with io depth 16. But overall no noticeable differences
were noticed

[0] https://lore.kernel.org/lkml/PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=6afcf6493578e77528abe65ab8b12f3e1c16749f
[2] https://lore.kernel.org/all/20220310094725.GA28499@lst.de/T/
[3] https://lore.kernel.org/all/20220315135245.eqf4tqngxxb7ymqa@unifi/

Changes since v1:
- Put the function declaration and its usage in the same commit (Bart)
- Remove bdev_zone_aligned function (Bart)
- Change the name from blk_queue_zone_aligned to blk_queue_is_zone_start
  (Damien)
- q is never null in from bdev_get_queue (Damien)
- Add condition during bringup and check for zsze == zcap for npo2
  drives (Damien)
- Rounddown operation should be made generic to work in 32 bits arch
  (bart)
- Add comments where generic calculation is directly used instead having
  special handling for po2 zone sizes (Hannes)
- Make the minimum zone size alignment requirement for btrfs to be 1M
  instead of BTRFS_STRIPE_LEN(David)

Changes since v2:
- Minor formatting changes

Changes since v3:
- Make superblock mirror align with the existing superblock log offsets
  (David)
- DM change return value and remove extra newline
- Optimize null blk zone index lookup with shift for po2 zone size

Changes since v4:
- Remove direct filesystems support for npo2 devices (Johannes, Hannes,
  Damien)

Changes since v5:
- Use DIV_ROUND_UP* helper instead of round_up as it breaks 32bit arch
  build in null blk(kernel-test-robot, Nathan)
- Use DIV_ROUND_UP_SECTOR_T also in blkdev_nr_zones function instead of
  open coding it with div64_u64
- Added extra condition in dm-zoned and in dm to reject non power of 2
  zone sizes.

Changes since v6:
- Added a new dm target for non power of 2 devices
- Added support for non power of 2 devices in the DM layer.

Changes since v7:
- Improved dm target for non power of 2 zoned devices with some bug
  fixes and rearrangement
- Removed some unnecessary comments.

Changes since v8:
- Rename dm-po2z to dm-po2zone
- set max_io_len for the target to po2 zone size sector
- Simplify dm-po2zone target by removing some superfluous conditions
- Added documentation for the new dm-po2zone target
- Change pr_warn to pr_err for critical errors
- Split patch 2 and 11 with their corresponding prep patches
- Minor spelling and grammatical improvements

Changes since v9:
- Add a check for a zoned device in dm-po2zone ctr.
- Rephrased some commit messages and documentation for clarity

Changes since v10:
- Simplified dm_poz_map function (Damien)

Changes since v11:
- Rename bio_in_emulated_zone_area and some formatting adjustments
  (Damien)

Changes since v12:
- Changed the name from dm-po2zone to dm-po2zoned to have a common
  naming convention for zoned devices(Mike)
- Return directly from the dm_po2z_map function instead of having
  returns from different functions (Mike)
- Change target type to target feature flag in commit header (Mike)
- Added dm_po2z_status function and NOWAIT flag to the target
- Added some extra information to the target's documentation.

Changes since v13:
- Use goto for cleanup in dm-po2zoned target (Mike)
- Added dtr to dm-po2zoned target
- Expose zone capacity instead of po2 zone size for
  DMSTATUS_TYPE_INFO(Mike)

Changes since v14:
- Make sure to put device if ctr fails after dm_get_device(Mike)

Luis Chamberlain (1):
  dm-zoned: ensure only power of 2 zone sizes are allowed

Pankaj Raghav (12):
  block: make bdev_nr_zones and disk_zone_no generic for npo2 zone size
  block: rearrange bdev_{is_zoned,zone_sectors,get_queue} helper in
    blkdev.h
  block: allow blk-zoned devices to have non-power-of-2 zone size
  nvmet: Allow ZNS target to support non-power_of_2 zone sizes
  nvme: zns: Allow ZNS drives that have non-power_of_2 zone size
  null_blk: allow zoned devices with non power-of-2 zone sizes
  zonefs: allow non power of 2 zoned devices
  dm-zone: use generic helpers to calculate offset from zone start
  dm-table: allow zoned devices with non power-of-2 zone sizes
  dm: call dm_zone_endio after the target endio callback for zoned
    devices
  dm: introduce DM_EMULATED_ZONES target feature flag
  dm: add power-of-2 target for zoned devices with non power-of-2 zone
    sizes

 .../admin-guide/device-mapper/dm-po2zoned.rst |  79 +++++
 .../admin-guide/device-mapper/index.rst       |   1 +
 block/blk-core.c                              |   2 +-
 block/blk-zoned.c                             |  37 ++-
 drivers/block/null_blk/main.c                 |   5 +-
 drivers/block/null_blk/null_blk.h             |   1 +
 drivers/block/null_blk/zoned.c                |  18 +-
 drivers/md/Kconfig                            |  10 +
 drivers/md/Makefile                           |   2 +
 drivers/md/dm-po2zoned-target.c               | 293 ++++++++++++++++++
 drivers/md/dm-table.c                         |  20 +-
 drivers/md/dm-zone.c                          |   8 +-
 drivers/md/dm-zoned-target.c                  |   8 +
 drivers/md/dm.c                               |   8 +-
 drivers/nvme/host/zns.c                       |  14 +-
 drivers/nvme/target/zns.c                     |   3 +-
 fs/zonefs/super.c                             |   6 +-
 fs/zonefs/zonefs.h                            |   1 -
 include/linux/blkdev.h                        |  80 +++--
 include/linux/device-mapper.h                 |   9 +
 20 files changed, 530 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zoned.rst
 create mode 100644 drivers/md/dm-po2zoned-target.c

-- 
2.25.1

