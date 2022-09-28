Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE75ED4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiI1GZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiI1GZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:25:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F1129689
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:19 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S4sfTI009544
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=jpmExJOMfUyiPBPrMzdNoEt1u3hhVBVx1hncwAZBOZs=;
 b=Dl/de+x2j/YZig54/H91vY+92dE5YKanxI4j/V4h6g2NCuC1EzcA+LJz7DeT02Ce1ZVG
 HVVF72BRCv6Tnd94jk4jCPDgs3g46DEyHvQW8sqBvvJ5QkJJmkSS7gegpR3JfbIwz6kQ
 omJCLFc0RCPOVGSYoalbBvCfYLvwH1R25xI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jvfn68bdv-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:18 -0700
Received: from twshared12430.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 23:25:15 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id 6B8B0443E381; Tue, 27 Sep 2022 23:25:09 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <linux-mm@kvack.org>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <riel@surriel.com>, <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Alexander Zhu <alexlzhu@fb.com>
Subject: [PATCH 0/3] THP Shrinker
Date:   Tue, 27 Sep 2022 23:25:03 -0700
Message-ID: <cover.1664323311.git.alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Y4jdKVLRgC-_ekBZZZa6iMh51MLL6zqh
X-Proofpoint-ORIG-GUID: Y4jdKVLRgC-_ekBZZZa6iMh51MLL6zqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Zhu <alexlzhu@fb.com>

Transparent Hugepages use a larger page size of 2MB in comparison to
normal sized pages that are 4kb. A larger page size allows for fewer TLB
cache misses and thus more efficient use of the CPU. Using a larger page
size also results in more memory waste, which can hurt performance in som=
e
use cases. THPs are currently enabled in the Linux Kernel by applications
in limited virtual address ranges via the madvise system call.  The THP
shrinker tries to find a balance between increased use of THPs, and
increased use of memory. It shrinks the size of memory by removing the
underutilized THPs that are identified by the thp_utilization scanner.=20

In our experiments we have noticed that the least utilized THPs are almos=
t
entirely unutilized.

Sample Output:=20

Utilized[0-50]: 1331 680884
Utilized[51-101]: 9 3983
Utilized[102-152]: 3 1187
Utilized[153-203]: 0 0
Utilized[204-255]: 2 539
Utilized[256-306]: 5 1135
Utilized[307-357]: 1 192
Utilized[358-408]: 0 0
Utilized[409-459]: 1 57
Utilized[460-512]: 400 13
Last Scan Time: 223.98s
Last Scan Duration: 70.65s

Above is a sample obtained from one of our test machines when THP is alwa=
ys
enabled. Of the 1331 THPs in this thp_utilization sample that have from
0-50 utilized subpages, we see that there are 680884 free pages. This
comes out to 680884 / (512 * 1331) =3D 99.91% zero pages in the least
utilized bucket. This represents 680884 * 4KB =3D 2.7GB memory waste.

Also note that the vast majority of pages are either in the least utilize=
d
[0-50] or most utilized [460-512] buckets. The least utilized THPs are=20
responsible for almost all of the memory waste when THP is always=20
enabled. Thus by clearing out THPs in the lowest utilization bucket
we extract most of the improvement in CPU efficiency. We have seen=20
similar results on our production hosts.

This patchset introduces the THP shrinker we have developed to identify
and split the least utilized THPs. It includes the thp_utilization=20
changes that groups anonymous THPs into buckets, the split_huge_page()
changes that identify and zap zero 4KB pages within THPs and the shrinker
changes. It should be noted that the split_huge_page() changes are based
off previous work done by Yu Zhao.=20

In the future, we intend to allow additional tuning to the shrinker
based on workload depending on CPU/IO/Memory pressure and the=20
amount of anonymous memory. The long term goal is to eventually always=20
enable THP for all applications and deprecate madvise entirely.

In production we thus far have observed 2-3% reduction in overall cpu
usage on stateless web servers when THP is always enabled.

Alexander Zhu (3):
  mm: add thp_utilization metrics to debugfs
  mm: changes to split_huge_page() to free zero filled tail pages
  mm: THP low utilization shrinker

 Documentation/admin-guide/mm/transhuge.rst    |   9 +
 include/linux/huge_mm.h                       |  10 +
 include/linux/list_lru.h                      |  24 ++
 include/linux/mm_types.h                      |   5 +
 include/linux/rmap.h                          |   2 +-
 include/linux/vm_event_item.h                 |   3 +
 mm/huge_memory.c                              | 306 +++++++++++++++++-
 mm/list_lru.c                                 |  49 +++
 mm/migrate.c                                  |  72 ++++-
 mm/migrate_device.c                           |   4 +-
 mm/page_alloc.c                               |   6 +
 mm/vmstat.c                                   |   3 +
 .../selftests/vm/split_huge_page_test.c       | 114 ++++++-
 tools/testing/selftests/vm/vm_util.c          |  23 ++
 tools/testing/selftests/vm/vm_util.h          |   1 +
 15 files changed, 613 insertions(+), 18 deletions(-)

--=20
2.30.2

