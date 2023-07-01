Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B47445C1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGABFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGABFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:05:01 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434782D52
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dam9mLXEiFl8fNKALcBTmh781xGhj5tXdQD5PK+rw9GuVtB9Neldxp6BLROGPVQOCWU+XEKcv6+XCgm8P+w2F+C8BwdJvTnS2UDviVz79+oXcejd4EjMxUBsVmPsg9XQoGgilWsP+LUwilgi5lBBlbuiJdJ4jUjir0CO1OdOcoxiyXUNhKBDihTfR8v7D8hbbDKBzfOA+JHxQJbkVO+YegMLDG0YmsX+BB0nj22koNIAVnV0T3y/mVDqyQJv7Mx8YkkYHE1VSMahbDUquC/UEiKPViTPCdVZ7W8F3qJi5C7Sga2z8t4eXsgPuyiEJSkhUzftSd5Lvf/dkeglfC325w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbfo5kEsoA7YYwuAfhDv6dwtUZhjWTNomL86fymbh44=;
 b=VHDgLFD8MXwsapj6MeNWzgmlti+pNVWJdiRHP9SVhWoEH9hc+rJYWOlIJbkbX5nZcRJVj8nuGTWrRLWaL3YueoCxruepxFjc+f0UzurbLNU038h13BQhvKw3/jZEuEnAOnRVKYS5z6n0N/tODfRC81qcZSn9fLpFIoT1fz7ov2gfaXRIrZ+11OyFkwiI3+30HPNpNuAveHV979npqLEOcRIk/hbTBboOEYFe5nIRcDRuaB+euGsNrR0UhNEvZcDJpuq9hakUt/0zXJbwb9IzgwfDmV7OYyP5wpQG4xqetf3lnGre33y1HpD8BkbzK2eK0zWOZ58V+4M6U/7+tF3P2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbfo5kEsoA7YYwuAfhDv6dwtUZhjWTNomL86fymbh44=;
 b=tF3q6G6LfCSQJCgajrxP+ZOHS4ukjMcn6GfK7nuuig1hCjREByzhxfi+mVx/It6kjZ9Vu60vdACpUtTByPBSSiaAS97wKjXZrL2wkxHn5F9lubZPoRMRQIva8RZ2rBjRC70HqdoovaFMtcR/x8KUCaOIxrJZlHitqp/bTKI98+XFDkhvkuFfU4FrIaugevMkphIYHAN3vAdAr8hgtKdpnKoxaFlR1O/v8kByOvurw2+XNT465Y3M7rOCIEe76WH9o9Es3d2nruD+n0bmNxmqQyc991D7CTysMgU06mwiCKoNTdNy9VXH3GzCZInnzTrWJ4yTrNnO7uFLS7z/Lksu+A==
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Sat, 1 Jul
 2023 01:04:58 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::aa) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Sat, 1 Jul 2023 01:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.43 via Frontend Transport; Sat, 1 Jul 2023 01:04:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 30 Jun 2023
 18:04:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 30 Jun
 2023 18:04:45 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 30 Jun 2023 18:04:44 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
        Namhyung Kim <namhyung@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ryan Roberts <ryan.roberts@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2] mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte comparison
Date:   Fri, 30 Jun 2023 18:04:42 -0700
Message-ID: <20230701010442.2041858-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3ee5b4-5cab-4b89-0526-08db79cf301d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPpSLCg50N8njx/oz9U6FX9jTfp2nWhujwMKWZk7xyu73dvNlNayEDFLV4zGiVjtyDtHl1nuHp43ty0Clb1c9Y59JC788A+gD72oxH15ZAEGK6feU+EVA3Aa5tkGkOWjW0FTS954DdAhfRIxBeC+HIQsLJN9dTTotjAN766OqVtrM/MpeDmXxoQeaA96rN2gaYk5BfQcTjaKBkA2eN2OM0p6Jucq4iSAg6XoyYvKna0P4QXV0loHqAalavngQpDkEBXCYAeipSWBNkUj6JfmeTC6EgbdICMTFMzUDk4F+v6Z1n4DErsY13Uu9mGs+6w8EgHYrC/vPSLJDuRpQNP/ilMtDJImlaEG2hHT8EpExVc5lbEz/8Sg4xmeqNRRHDBQvGIQaNaVYqzCJi9BF1BWmaVsNA5Du30Rr0mKxI2OMvD1tqbBxkE/dYcQtdUBzw3Yi4OwBNCmkxWknqkowitXlWqQfbyG13qhhB/UMxE0a4MMpGvvvrWMNOcS4A3SNlZshpCUTDbHO2ujK1G4Afwmu6PycL/ZrFt3YqgcBShhBi+TlxbjcSU6HNdMTn1cfomRQ2xyXUwhCypUfm6nwzpP8MFe8GrfObegjT88M62ZAFNvGQOQVaM5+Y7FQh09e9R7GzyTUY6N5l4PKjbHQXLVaLqcwXVOJsoY+nXd80Np1z7RrxB+VMqxdyt/k8iB//OAbt3XEM2TPcOGsq6yGAjRZE66NFOTHEGhvJFsrhDXy6ZtKgpVAlUAs/2dYJjDFdlq
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(7696005)(54906003)(426003)(83380400001)(2616005)(336012)(36860700001)(86362001)(40460700003)(1076003)(82310400005)(40480700001)(47076005)(26005)(186003)(2906002)(82740400003)(36756003)(356005)(6916009)(316002)(70586007)(7636003)(7416002)(7406005)(70206006)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 01:04:57.3894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3ee5b4-5cab-4b89-0526-08db79cf301d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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
Acked-by: James Houghton <jthoughton@google.com>
Acked-by: Muchun Song <songmuchun@bytedance.com>
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

Changes since v1:

Added Acked-by's.

Fixed as per Ryan Roberts (thanks!): changed to ptep_get_lockless().


 mm/hugetlb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bce28cca73a1..64a3239b6407 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7246,7 +7246,12 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
 	}
-	BUG_ON(pte && pte_present(ptep_get(pte)) && !pte_huge(ptep_get(pte)));
+
+	if (pte) {
+		pte_t pteval = ptep_get_lockless(pte);
+
+		BUG_ON(pte_present(pteval) && !pte_huge(pteval));
+	}
 
 	return pte;
 }

base-commit: bf1fa6f15553df04f2bdd06190ccd5f388ab0777
-- 
2.41.0

