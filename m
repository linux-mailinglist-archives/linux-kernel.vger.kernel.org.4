Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ECB746327
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGCTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGCTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:01:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0010EF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWHTfUER0G1yzIw6Jb03bhEMYf83btcHKVSAhM+m1dW++TNgALlmlFSQh3Z3/A0Nxk3KhvXRVpCD5Czzf739KyOC9rwN80+ClhWm0LzIZkpe47FbRGo3i6RQZ6reK5kFnK4oH7P2b0E7LD7i8nf8CKlm8aBqD0s6+/5qqsBwVJFepNgwFDcXqzGqtgCB2ZwlaOxJqJwIo11ey9ox967zVYZ1eH3xSp819mLlI2t5mLvVl3sm5L7A5vuyHnCCyQSpPELq5fIwD8dHzUD5tGq+h2QRd8Zg4qbxGgWR+Jbq08yHbIndNCeQbVtsn8OUCVsViIxhyRc2zni9zSuEr0z0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4hQEngljiBuMGKa7/H9dnFsqTDES+zur4iQU7FQ8DQ=;
 b=ZJo8jDgFfu0SyKE3qFMeywdlpaQSmgGeXtNgpVP62mjM4rXftmaFu+WQHuEkO2ZUztu6dcLbSkIVwPEhoyXp+gE7dsMACbyIbUk2v1Bb2SDqbAacd7C/v2iZLAmZR5o9JId/49gVUlWP0V7M4/F8i1TmekaJDJ6dmhzplAheLZan/c88V5yBIEAtw9Xfti+t3PnrlgtplCrtR8VEH5X1NMmrG1jK9mfrc4rbFsi+H1fLQoglqzECeLc3K+ITn2G/Ht/lf6MJhlHZ0q6dASM8NAyAvSaDJWVEJ2ZEM86+tKPy94hkGCHJlI1LllACg2HDtCv0GKOMxWF8xoLnxGODOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4hQEngljiBuMGKa7/H9dnFsqTDES+zur4iQU7FQ8DQ=;
 b=PiitQvUBS87MkQGzcVGcZ75MR0DFV5AVGzybDB2IF+gMqWElRfVwV2VLPROo5Q0yHEiBafeiwB0LiNHm/o+iIUPuE4RxSz92YBe9J0gROuDPu76HYEg1DgO5sYgC5vkCGrgPb+f9Q+SLymTKKU3V2cfuiaj/DnVTpSjdiqiX6NbX7CINTRwv0E7R22FTxjFw3RXyyr/EFkBCepbzn21WvpXc+KRt23Mbl+UhNoQOpUpwLR/gUa5KFzFjh1eQDeFzevLAdpTMlq/uiIVDlIpaterJb2GwT79fZwAPdpuIaFfbVMHIL1E/iFvs69s03OUtq/7RiHKZUxAik0MgAKKNeg==
Received: from MW2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:907::19) by
 CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 3 Jul 2023 19:00:57 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::a5) by MW2PR16CA0006.outlook.office365.com
 (2603:10b6:907::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Mon, 3 Jul 2023 19:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.43 via Frontend Transport; Mon, 3 Jul 2023 19:00:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Jul 2023
 12:00:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 3 Jul 2023 12:00:46 -0700
Received: from sandstorm.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 3 Jul 2023 12:00:46 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Hugh Dickins" <hughd@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        <linux-riscv@lists.infradead.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        James Houghton <jthoughton@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH] mm: riscv: fix an unsafe pte read in huge_pte_alloc()
Date:   Mon, 3 Jul 2023 12:00:44 -0700
Message-ID: <20230703190044.311730-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4e77db-9892-4e80-754c-08db7bf7d583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZ/X1yu/X+S35lK9SWQbBh7EdONin+46gQ2X3K0kv3oyW8HBMG2cR1PT/qf5Gqpb+bTJ+Ti7y5QMYZHT5ew07m9XvGQ0w6KoJlqRz/9/lR2hN84u1fFeGMjfVtAUn82k3/k+T5dewCyEWbqEXMMKipESNqOhLahPIHbu7MoYIrRni8LJuMWup58MQQlVLeGL9fOWRFm6LsSuYH8VERoDLDi3lsWRgR8mxy6gGUrwKnQCItlsjPu+WX+gnY3t5VOa44q06Aw6Npsf0ihoRpN0XvK5wJm93/KqptgGRthRBIIDjqxk2hwacrj04yio3FZ9atiw9SftgQBLeyDtxYlTk/AE3LfDNwUvKbjx0Ns/CM1r9npngen7fqZdHmft82JjnK0PBNJzYbXZ6cbDCcIKUVFZUWw2sLgwWJXcVi+R/jIRlbBtXfUZOL/2agZxWK7CwdcHbrFjtkaXSh1VzKHFNRqC3VKt8hRf2DSZzlKsVcrCmAAfPKaFVtgl3TePEe4Yh9i39WogSOrRvmiffk0Q9cujFiy2CIRshci81htOlv7F/RHYNtTa8QmgamepUg1mVql+JLK4eBQuDW8D+Y37T9RT8qqepyOo+8hS5/eeJYGy1B4PTgZQLjFtDLuFWFXM/mz5BXg+Bmm7JGe20NXNJbyArpnS2ZsHYyB5lWQULII6Byahzu7I+jBLWym57IiHSDn6rL39uB72Lc3frBNft+aqc/ZiddYM261XpbSBXGbOGGRPuNG1vk3p+O3/V33hU/0sCmOYT692ASVi5PrQcPNK6ARyiNWuq8sXnnWHrJw=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(336012)(54906003)(316002)(8936002)(47076005)(41300700001)(426003)(82310400005)(8676002)(40460700003)(40480700001)(36860700001)(356005)(83380400001)(82740400003)(70586007)(6916009)(70206006)(7636003)(4326008)(36756003)(26005)(966005)(186003)(86362001)(478600001)(5660300002)(7416002)(1076003)(2906002)(7696005)(2616005)(14583001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 19:00:57.1420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4e77db-9892-4e80-754c-08db7bf7d583
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WARN_ON_ONCE() statement in riscv's huge_pte_alloc() is susceptible
to false positives, because the pte is read twice at the C language
level, locklessly, within the same conditional statement. Depending on
compiler behavior, this can lead to generated machine code that actually
reads the pte just once, or twice. Reading twice will expose the code to
changing pte values and cause incorrect behavior.

In [1], similar code actually caused a kernel crash on 64-bit x86, when
using clang to build the kernel, but only after the conversion from *pte
reads, to ptep_get(pte). The latter uses READ_ONCE(), which forced a
double read of *pte.

Rather than waiting for the upcoming ptep_get() conversion, just convert
this part of the code now, but in a way that avoids the above problem:
take a single snapshot of the pte before using it in the WARN
conditional.

As expected, this preparatory step does not actually change the
generated code ("make mm/hugetlbpage.s"), on riscv64, when using a gcc
12.2 cross compiler.

[1] https://lore.kernel.org/20230630013203.1955064-1-jhubbard@nvidia.com

Suggested-by: James Houghton <jthoughton@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/riscv/mm/hugetlbpage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 542883b3b49b..96225a8533ad 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -73,7 +73,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 	}
 
 out:
-	WARN_ON_ONCE(pte && pte_present(*pte) && !pte_huge(*pte));
+	if (pte) {
+		pte_t pteval = ptep_get_lockless(pte);
+
+		WARN_ON_ONCE(pte_present(pteval) && !pte_huge(pteval));
+	}
 	return pte;
 }
 

base-commit: 0a8d6c9c7128a93689fba384cdd7f72b0ce19abd
-- 
2.41.0

