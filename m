Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A004C743242
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjF3BcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF3BcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:32:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD32974
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn5nAxcUNnld5oDMF/qxe6603EHAgNfnjxPGWX2r88y5YXnQ4J6Sy+7k5FImfiVYtJCI306nOdWnoLExlKNZZKD25R6DoLqHYH+o07JS7kKD1/YYLCRuClSMxxQsf93J4MkMPMQO+/SoKQf1m2ViG4DxQJAHQB/0kXVeGXf7hr0tQPhsNZZVqVUtkjVRu/r4UkvXoXBTZLnr023tJ8m84t1ZAzsNxVfIC0IJtdiDVgGXI7oIhySMK07dZwMW+zaVtnSbW+kb9iyret6KPJuNY/pTTZMsifYzSo69uZiucQ3FUS0r6wi1AoTkJ+nBB+vMcacqJ2jGLfhVyYax+AATOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2czduMdPMPW74eoadqc75//pR696cUAJih3JlUHpmU=;
 b=DZNRIBb+q3mNSZPz/mGqVAGU7OTCXbKeE59t0Sbl7ll8LN1lShf1Kogp8ttzAElX7mG4FcHiGto8heIEQ1mk63hm6wtdUTa3XEN9ZwzAdbjrHCHATanRgtmIix4JpfNtMFb36rT3bCdmB4VR3aO0XE3qogprxR0Fs7OHWdOyahi5uDeeMMD8WySbk7YrrIQTcDoULFZbn7INgWc6pgduzLo+VEWDDch7iNswfgcEVDfggVof1sKx1nr+vTp0eBPMyxa1+8+P7bry7Wu/LQu/YmRgBlpOLiPLXqf9Di9cEuXPUPA4gMVTAWvQUUY10JM4MTBJKHA8hK4tYJknXowIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2czduMdPMPW74eoadqc75//pR696cUAJih3JlUHpmU=;
 b=BZ9V+3qH+jEXb9/7j/CHIx3dz+lNIB4mW729pc+HJ8XwQyBpS5Uxo/5K4Uv3xMTY7umKV4MKeS40EJS5BiU9ovfskZhrlN/fG6e4vPoROOkwjTjhjX0riQ/+kKaoRZ2UOYI/a54r1wpA/bHar2Y2Kj0qeifpvWX2KsvkEsFrAb5y5+KYAut6d7ISlpYaTBcTfuVrV9Vjn47gutuYPmgbWQ6lx3vgjN2yB9ju/35qq8Fsys01vkZqUsjDemLnXtZfJXfyLlVC70GaMZh3aTg+03c1PsTM5K0w57B9Gh5xpZQBBT1we6ZK6MRgQXqnC+zqGvoFUgLHqNTnBNsJLMu4+g==
Received: from BN9PR03CA0756.namprd03.prod.outlook.com (2603:10b6:408:13a::11)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 01:32:16 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::eb) by BN9PR03CA0756.outlook.office365.com
 (2603:10b6:408:13a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 01:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 01:32:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 29 Jun 2023
 18:32:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 29 Jun 2023 18:32:07 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 29 Jun 2023 18:32:07 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Christian Brauner" <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Daniel Vetter" <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ian Rogers <irogers@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jiri Olsa <jolsa@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Namhyung Kim <namhyung@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Ryan Roberts" <ryan.roberts@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte comparison
Date:   Thu, 29 Jun 2023 18:32:03 -0700
Message-ID: <20230630013203.1955064-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb23fa6-fdd0-4073-718a-08db7909d6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3D5x6w8n1ppm+s3zpLP/9s2GLV6tfFG0Syur83pdkQdQIuSj2sR8DxP3hDRPM3QwFCQxKGC+1X/sktWmAyRbzelOGYEaFC+BpEvTJptsgWJsBuSb3cHcOw0e/dghtZ9YJOQPdDC0Rup7/qX0gz3Kke9rqwzojXCIShk9SIqVEC2WLnWZqC5a85GLtXAAWfWhgDbnA94Nr64HszmR5N9IGpcEGR+4OgjolhEBYR9oAXOaTKTuyj3bD3zlLDCrPH8wNMxsID3GHSK1ThXqq/S0MUsoD6y/zs9tYurqOD2XUN6kUE/rh8eBEYf+IvV6YXHYs/6F7d/eTaBLzIt8DelF5nkVkBCG52N6+FD5HozpBgWDGA+IerCc6KQyCp3h73DngVl6/iHXPAgN/JDFEnVOpvthJvsIoVler8i7xhH7eL0MPnO0fbiEmWMsHTluxZdAW7luDDeyNjGnFnjiipuQmMIFU140GajR4OyOuhMFkR5NGt5xP7Th58fTKqYC7mbiXRpcqD2z3ltkwVXFug+p0dEp1cWGk7NXFhW4DtxP6kCcvxv/8J9+3nFiefnLx61VNYd40EzjYN186mcq0bUkj6PFXxvkiXllsMbQBIrnVOD92Lv7KNj43w8Gb1OIXz6aO6Gs0HTmJgQTG/oGs/2twGJaXbH0lw0u5hZ9jdBQn6YHd2WBy3Tgs6Ovhi5EA8iZjuaXkdAtahnJ9ILZksJjVTPo+5FGSBvE57xh27tgwPnIO2Ye7nWmMkP5yS7LYYzU
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(336012)(426003)(47076005)(40460700003)(83380400001)(2616005)(2906002)(7636003)(356005)(82740400003)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(5660300002)(86362001)(54906003)(41300700001)(70586007)(6916009)(4326008)(70206006)(6666004)(316002)(7696005)(478600001)(186003)(1076003)(7406005)(7416002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 01:32:16.4963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb23fa6-fdd0-4073-718a-08db7909d6bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following crash happens for me when running the -mm selftests
(below). Specifically, it happens while running the uffd-stress
subtests:

kernel BUG at mm/hugetlb.c:7249!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 3238 Comm: uffd-stress Not tainted 6.4.0-hubbard-github+ #109
Hardware name: ASUS X299-A/PRIME X299-A, BIOS 1503 08/03/2018
RIP: 0010:huge_pte_alloc+0x12c/0x1a0
...
Call Trace:
 <TASK>
 ? __die_body+0x63/0xb0
 ? die+0x9f/0xc0
 ? do_trap+0xab/0x180
 ? huge_pte_alloc+0x12c/0x1a0
 ? do_error_trap+0xc6/0x110
 ? huge_pte_alloc+0x12c/0x1a0
 ? handle_invalid_op+0x2c/0x40
 ? huge_pte_alloc+0x12c/0x1a0
 ? exc_invalid_op+0x33/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? __pfx_put_prev_task_idle+0x10/0x10
 ? huge_pte_alloc+0x12c/0x1a0
 hugetlb_fault+0x1a3/0x1120
 ? finish_task_switch+0xb3/0x2a0
 ? lock_is_held_type+0xdb/0x150
 handle_mm_fault+0xb8a/0xd40
 ? find_vma+0x5d/0xa0
 do_user_addr_fault+0x257/0x5d0
 exc_page_fault+0x7b/0x1f0
 asm_exc_page_fault+0x22/0x30

That happens because a BUG() statement in huge_pte_alloc() attempts to
check that a pte, if present, is a hugetlb pte, but it does so in a
non-lockless-safe manner that leads to a false BUG() report.

We got here due to a couple of bugs, each of which by itself was not
quite enough to cause a problem:

First of all, before commit c33c794828f2("mm: ptep_get() conversion"),
the BUG() statement in huge_pte_alloc() was itself fragile: it relied
upon compiler behavior to only read the pte once, despite using it twice
in the same conditional.

Next, commit c33c794828f2 ("mm: ptep_get() conversion") broke that
delicate situation, by causing all direct pte reads to be done via
READ_ONCE(). And so READ_ONCE() got called twice within the same BUG()
conditional, leading to comparing (potentially, occasionally) different
versions of the pte, and thus to false BUG() reports.

Fix this by taking a single snapshot of the pte before using it in the
BUG conditional.

Now, that commit is only partially to blame here but, people doing
bisections will invariably land there, so this will help them find a fix
for a real crash. And also, the previous behavior was unlikely to ever
expose this bug--it was fragile, yet not actually broken.

So that's why I chose this commit for the Fixes tag, rather than the
commit that created the original BUG() statement.

Fixes: c33c794828f2 ("mm: ptep_get() conversion")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/hugetlb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bce28cca73a1..73fbeb8f979f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7246,7 +7246,12 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
 	}
-	BUG_ON(pte && pte_present(ptep_get(pte)) && !pte_huge(ptep_get(pte)));
+
+	if (pte) {
+		pte_t pteval = ptep_get(pte);
+
+		BUG_ON(pte_present(pteval) && !pte_huge(pteval));
+	}
 
 	return pte;
 }

base-commit: bf1fa6f15553df04f2bdd06190ccd5f388ab0777
-- 
2.41.0

