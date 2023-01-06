Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561C565FCD5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjAFIdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjAFId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:33:26 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509DD7A938
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 00:33:23 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083320euoutp0169a2a032ad89f712a9dbdd3af380f79d~3qy3qm8H12179921799euoutp01f
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:33:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230106083320euoutp0169a2a032ad89f712a9dbdd3af380f79d~3qy3qm8H12179921799euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672994000;
        bh=RdOD06wolOCIAicxPsN2ij6az3cOrx4wHkq03SQoR78=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CnbydIeAviAlGIk4cryN6Fw9u2a2gZ9Iw0a93SdRj7VF9YeCgT35PvF/tzreEOVES
         CQb6UDuLO5AS84fwM2MmltZ6MNGcmAx0iLJKscebUu0j6MQwWzPfoDxZUlIiIX+cR0
         XHp6zWo+sj9EcW4Q//b9bmK3Bf9pjdTnFNJUkQ8E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230106083319eucas1p2f07e06335cea133036a099678e5780c8~3qy2t7MAJ0992309923eucas1p26;
        Fri,  6 Jan 2023 08:33:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 96.14.61936.FCCD7B36; Fri,  6
        Jan 2023 08:33:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2~3qy2XZ6nJ1095210952eucas1p1E;
        Fri,  6 Jan 2023 08:33:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230106083318eusmtrp1a6df33b9d2377ba20b7a7b965d6a9e93~3qy2Wlb9c2166121661eusmtrp1f;
        Fri,  6 Jan 2023 08:33:18 +0000 (GMT)
X-AuditID: cbfec7f4-a2dff7000002f1f0-ce-63b7dccfbd0d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.C6.23420.ECCD7B36; Fri,  6
        Jan 2023 08:33:18 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230106083318eusmtip1a6555075bf69d5e8699929cba0a653cc~3qy2Gbyys0159601596eusmtip1O;
        Fri,  6 Jan 2023 08:33:18 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/7] block zoned cleanups
Date:   Fri,  6 Jan 2023 09:33:10 +0100
Message-Id: <20230106083317.93938-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87rn72xPNth1gcdi9d1+NotpH34y
        W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
        iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
        8ya5AO4oLpuU1JzMstQifbsEroy1x8+zF3TwVNzZ0M7UwDiHs4uRk0NCwESi/30LWxcjF4eQ
        wApGiYerW1lAEkICXxgl1s+CSnxmlDh/7gwbTMeZYxPZIRLLgRIrPrJCOC8YJV59nsnUxcjB
        wSagJdHYyQ7SICIgLLG/A2QqFwezwGYmidu/1zKC1AgLaEr8fx4OYrIIqEo87LABKecVsJT4
        2LeYBWKXvMTMS9/ZIeKCEidnPgGLMwPFm7fOZgYZKSHwg0Ni45d1UA0uEjsPXIKyhSVeHd/C
        DmHLSJye3AMVr5Z4euM3VHMLo0T/zvVsIEdICFhL9J3JATGZgU5bv0sfotxRoufiUWaICj6J
        G28FIU7gk5i0bTpUmFeio00IolpJYufPJ1BLJSQuN82BWuoh8WVFDxskaGMlWhb2Mk5gVJiF
        5LFZSB6bhXDDAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHp7PS/4192MC5/9VHv
        ECMTB+MhRgkOZiUR3rL+bclCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeWdsnZ8sJJCeWJKanZpa
        kFoEk2Xi4JRqYFpTVC2lGbfpo8OmiQsl2ubMCU72/JxgV9j3Stv0zWmezTYffmpadSht6by9
        2z+reed560nbK/5yC3UIM7Jp3Mjc4j6vhPfZst+qOasFE5P9pE0nOSYy3fmWdMZIles78575
        OsFfzmdu21MV/dVEkdlC4vHUnax53wWd5hxIqFqTecS317Lxs6xBjk6l+oH1C/ze+/XbC5ga
        BWdeuXRUqWZL4877Myv7NrKaP1cuXng6afrtP0yJQvveRtXMmxIQ6qGR3SNuvtuzetm6m9f+
        5lg/vnPlqNmNVTu2Fi7g5r86La6eY7ZrWr8151Lr/uT1k0t/n5mc815smzWny7w8De9b/tHh
        Ev0PTQ8aLTllrsRSnJFoqMVcVJwIAEX1jw/WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7rn7mxPNmieo2ex+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLmwd2MlnsWTSJyWLl6qNMFmdefmax2HtL2+LyrjlsFvOXPWW3+Ly0hd3i
        xC1pB16Py1e8PS6fLfXYtKqTzWPzknqP3Tcb2Dx2tt5n9Ti70tHj/b6rbB59W1Yxemw+Xe3x
        eZNcAHeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        Xsba4+fZCzp4Ku5saGdqYJzD2cXIySEhYCJx5thEdhBbSGApo8SfMzoQcQmJ2wubGCFsYYk/
        17rYuhi5gGqeMUqcOTUHqIGDg01AS6KxE6xXBKhmf0crC0gNs8BBJolnU74zg9QIC2hK/H8e
        DmKyCKhKPOywASnnFbCU+Ni3mAVivLzEzEvfwSYyA1Wv36UPUSIocXLmE7ASZqCS5q2zmScw
        8s9CqJqFpGoWkqoFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNu27Gfm3cwznv1Ue8Q
        IxMH4yFGCQ5mJRHesv5tyUK8KYmVValF+fFFpTmpxYcYTYGOnsgsJZqcD4z7vJJ4QzMDU0MT
        M0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGplp7ptQXvK+UEyoSXVeY7BYU3nWe
        KVXhSLfAvcNbKpsvHO7JO8B0YxJny4VFOWtevw1r7kn7UvzZ0/hWA0fuuunh76LmFj84qrXJ
        a6dCYdDT71IbZ3StqeAXybj26q9xSEjLmqL/f2vMPrLv5WRXqotwjknYIuacW1bel55VZ2FU
        b3T82jz21TfTf+d0CqwzeHbj8u7Pa1b931YvuODjl2Wvtd7OMb75Z/bDsAJxZs4/rulfO9MW
        fAq+pjK55WxD5YVGg9/7+o3ZXt8omBUUzBHTOG335Vaz89Nv3zrTGibBY/JzDd//Rr7v+Rya
        L3VEetNushrKTbrNvvPE6nvOvo4x+0P0FuudPxBw0DFURImlOCPRUIu5qDgRAD3Q8I9DAwAA
X-CMS-MailID: 20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2
References: <CGME20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2@eucas1p1.samsung.com>
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
  It is still unclear whether the support for non-po2 zone size devices
  will be added anytime soon [1]. I have extracted out the cleanup
  patches that doesn't do any functional change but improves the
  readability by adding helpers. This also helps a bit to
  maintain off-tree support as there is an interest to have this feature
  in some companies.

I have retained the reviewed by tags for the commits that did not change
from the main patches I sent before[1].

[1] https://lore.kernel.org/lkml/20220923173618.6899-1-p.raghav@samsung.com/

Luis Chamberlain (1):
  dm-zoned: ensure only power of 2 zone sizes are allowed

Pankaj Raghav (6):
  block: remove superfluous check for request queue in bdev_is_zoned
  block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
  nvmet: introduce bdev_zone_no helper
  zonefs: use bdev_zone_no helper to calculate the zone index
  dm-zone: use generic helpers to calculate offset from zone start
  dm: call dm_zone_endio after the target endio callback for zoned
    devices

 block/blk-core.c             |  2 +-
 block/blk-zoned.c            |  4 ++--
 drivers/md/dm-zone.c         |  8 +++-----
 drivers/md/dm-zoned-target.c |  8 ++++++++
 drivers/md/dm.c              |  8 ++++----
 drivers/nvme/target/zns.c    |  3 +--
 fs/zonefs/super.c            |  8 +++-----
 fs/zonefs/zonefs.h           |  1 -
 include/linux/blkdev.h       | 28 +++++++++++++++++++++++-----
 9 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.25.1

