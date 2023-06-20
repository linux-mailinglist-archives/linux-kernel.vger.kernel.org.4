Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4DA736108
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFTBRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFTBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CE0FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqKI6eH+vOfdUvamaTfcyyTTEEAmqGF7yDA6GJfRbYVAa/Dc6RHxHJ98GLxcPi8MTlv0MP9PK2h46oP/CGE+VcSoWPCP0sOunVRI6hYucN5ZAAVYBCPRCID8Zy+5HNmcq1HTrZNgJXRYKYOAU4KDCIW5WwCpWcH2qsrWVuryv00Z8jLPJoH82k9sbeJyeBLHLZxE4Qp1tQHAV/6INVk9ygW7D54t/q+he92xUhcU5F+PQHu1fbHR22Ibjz+Sfe4pFBRRbb1pYaBcZhKQ1R2LjomREuLX3/Axx8QD1Ucouwmbra/aiU0UzBJQJ1qk++kKHZlojh8NIRSg7N716r0YHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU6vV/sOpPEMMFpfhHsw3NPBeeRzKVMoxxxvmeZx6Tw=;
 b=Em0WVj0yYvr8aaM8UZKs5wRMNScxIrQF2oW26byDuEm6hT/jde4YvqumZU1BcrEA7kCHchVCuuqTTP1uEWQ44GoFSgt1nZz62sC82QUKw5rlsilCieZ02auojDJDGGw7mUa8qVeuDIWJRQVHrbii83kioBvwIZnskcA/THcMXiSgvhve4XcN5fu0kPb37IO54J1ke8yUfL0Zx+vMjWkpM5mSuqrtYe4d2MaeSiL0AbrkxqwQtYXaehOy/zidxZiMYxle7XEhogiBPBKMdBXgwjQchVG6yQq50PirvQ2fyRRO7Vdn6P5LVITy1sJKTdrjEobANhh8U2veEBKTKfGe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU6vV/sOpPEMMFpfhHsw3NPBeeRzKVMoxxxvmeZx6Tw=;
 b=ZYjoKETK3MVERrm8jOxzdLRFhxlHv1VuGDkQgiWuMFcObcwiVQ7C4yzbuR01OOiKUI+Vm+u2b5g5Jx5P7nfAAXUfkftRcpU3QCohyGEVCZPR60kcK2mgR30eu+HM1AYKpXtQ+pzhNn13vfmJaESLR4qFjYXQvOcsP/5fRggCcq9eAJx84bCDr+oyjIIcUPJBxCQ+ivxuzAuj3kMiibRyyrl6RXybU4WNWwuvTS8Cy05zLZNmJGo5e4BUZVmpoAMBpkAt6FIu0q6dheZoV741SnBlmadB4BI0rPJumDvYddWfVdHoTXAFv3R3mZxyr5/hqv5hI/XXIfrE0LAAdJh8MQ==
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 01:17:28 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::18) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 01:17:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:20 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:20 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 00/11] A minor flurry of selftest/mm fixes
Date:   Mon, 19 Jun 2023 18:17:08 -0700
Message-ID: <20230620011719.155379-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620011719.155379-1-jhubbard@nvidia.com>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|DM4PR12MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d0819d-e819-431f-45ad-08db712c1d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hj1yoBb8KYwZjK6BdvY/nrOwxLTBqO4JcJIjcBHKzfzRtPNhEE5LfRvZBhyVkUxpbgUSkAZeHBls+KnlK03OaQBqq2ayUihvvraRxgMANfY1UnDwiNH/MSVKu+huPJOAKQpkljUiaEB8znxRyRpvs9/k1IN7GuQACVEcaGfmF8JeJw/O5j0vXfTPH8WVmrnJWqKM4/psmejJzfUQewmBevc6wVIknu4QbTwLee+YcxCkNImlYyZirUWfQTVhI29cTVGVBCPoqUAzDOvb1PuduVNfLs/Cpqf6MC/cW6uM3PbxRDj0Tma9J8AzNf4ArJaJYRUXqpKmeSOuE2tG1HrY6uRAo7G1Q70tcTX69vHGfjUAkHrZ9a8a+0suoyZ/sWnXgXVRCxWFM8FH9Vuapy19uSsd7tMRlRcEBolZwqqvO6cmAFj28uiIrzR5mzKM2iuqnDN39/Cbut34zYTpM5dCIHJ094xG6fL4/Smlq/tJ9wYNnL0Hi03QPfuPE7IvGCX5gg3MUQ9SQzvPt6LcjZra3sa5ajvpu1Y/pGopyakUbqPbpkqLM2ajOKPU0L68/0aIJfDHrjIEjZy/db/L+GhDBUDYkQu1AqxHOkGDzb5hoIHzYeZ8trvbGTzf3Gc8C9pSmfjNFrx5R3aE9EPjYMmbiaz6gWt9jA9FFvEX1vR2lYqWqTV5Hy4pPq+3ig65VWZXpBoWONKEWoWZLC7bSzu8AKvHDtL82D6ZEI0RDNjUExneGAkNRZ9TeuDxsqyWgRRXwQXpsHL5l1m/uhWkSgAn8LKAfirXGl1OAv1ZuDA9Xjg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(356005)(107886003)(26005)(1076003)(186003)(7636003)(5660300002)(8676002)(8936002)(82740400003)(316002)(110136005)(478600001)(54906003)(41300700001)(36756003)(70206006)(4326008)(70586007)(2906002)(86362001)(40480700001)(47076005)(2616005)(36860700001)(966005)(6666004)(7696005)(40460700003)(83380400001)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:28.7957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d0819d-e819-431f-45ad-08db712c1d71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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

Hi,

This is v2 of a series that fixes up build errors and warnings for at
least the 64-bit builds on x86 with clang.

There are lots of changes since v1 [1], thanks to reviews from Peter Xu, David
Hildenbrand, and Muhammad Usama Anjum. These include:

* Using "make headers", and documenting that prerequisite as well.
* Better ways to avoid clang's Wformat-security warnings
* Added Cc's, ack-by's, reviewed-by's.
* Updated commit log messages.

The series also includes an optional "improvement" of moving some uffd
code into uffd-common.[ch], which is proving to be somewhat
controversial, and so if that doesn't get resolved, then patches 9 and
10 may just get dropped. They are not required in order to get a clean
build, now that "make headers" is happening.

[1]: https://lore.kernel.org/all/20230602013358.900637-1-jhubbard@nvidia.com/

thanks,

John Hubbard
NVIDIA

John Hubbard (11):
  selftests/mm: fix uffd-stress unused function warning
  selftests/mm: fix unused variable warnings in hugetlb-madvise.c,
    migration.c
  selftests/mm: fix "warning: expression which evaluates to zero..." in
    mlock2-tests.c
  selftests/mm: fix invocation of tests that are run via shell scripts
  selftests/mm: .gitignore: add mkdirty, va_high_addr_switch
  selftests/mm: fix two -Wformat-security warnings in uffd builds
  selftests/mm: fix a "possibly uninitialized" warning in pkey-x86.h
  selftests/mm: fix uffd-unit-tests.c build failure due to missing
    MADV_COLLAPSE
  selftests/mm: move psize(), pshift() into vm_utils.c
  selftests/mm: move uffd* routines from vm_util.c to uffd-common.c
  Documentation: kselftest: "make headers" is a prerequisite

 Documentation/dev-tools/kselftest.rst         |   1 +
 tools/testing/selftests/mm/.gitignore         |   2 +
 tools/testing/selftests/mm/Makefile           |   7 +-
 tools/testing/selftests/mm/cow.c              |   7 --
 tools/testing/selftests/mm/hugepage-mremap.c  |   2 +-
 tools/testing/selftests/mm/hugetlb-madvise.c  |   8 +-
 tools/testing/selftests/mm/khugepaged.c       |  10 --
 .../selftests/mm/ksm_functional_tests.c       |   2 +-
 tools/testing/selftests/mm/migration.c        |   5 +-
 tools/testing/selftests/mm/mlock2-tests.c     |   1 -
 tools/testing/selftests/mm/pkey-x86.h         |   2 +-
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +-
 tools/testing/selftests/mm/uffd-common.c      | 105 +++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h      |  12 +-
 tools/testing/selftests/mm/uffd-stress.c      |  10 --
 tools/testing/selftests/mm/uffd-unit-tests.c  |  16 +--
 tools/testing/selftests/mm/vm_util.c          | 106 ++----------------
 tools/testing/selftests/mm/vm_util.h          |  36 ++----
 18 files changed, 165 insertions(+), 173 deletions(-)


base-commit: 929ed21dfdb6ee94391db51c9eedb63314ef6847
-- 
2.40.1

