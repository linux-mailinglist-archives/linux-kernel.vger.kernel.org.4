Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA55ED9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiI1KAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiI1KAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:00:18 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D7855BC;
        Wed, 28 Sep 2022 03:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYvtOb0AS0osOMqw/md4PJ27WOJzSnhabYyeeuw9DK3VFC2ejnwyMWdbm1S/EFt08GTom2hVZUtN9mrBICwzbNBZoji7NjRqKPXS4XVQCva6nIYX7Mel2eQF1d5IcSFWPqtAvQGk7m4QWo7B+v5OB7TnLOqdYIGW1Qrw0XTnpLc3T4tnjTxVPiZE0xUvNif5rV4rtWBSHp0rRxU+toNNcQpSc+eJyUcskcr+r+rCVK3iB98mOvSAmJHnbUE9fC3oPkkajebsVQA/7kIGoRx4+ytfBLx7prcizVi+WZSq1W5Xm8D6Dt6TnoXx5LUHieMdhxy210455PjtETYchkpumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mA3orzX0dJKd2jRvVaqf/p4GdBJttR/PnQwbywR8x8=;
 b=UkmeVm+fwraJ23T55aJMrYjTLrKJSUmg5AIyR9txf5yjJJoMzsleDbBurLtApZ4DxZ1Wpw7cZJZoQBwzGefsz9+PM3YITdKu9WZP2Sq03LMr9XSSOhljrFyBGIFFtiq7G2XW1xj7+ODyNP6kr3SiLmb1zJZxTz7P94Q0pQeYxRqymMr1oWU0EoVaSgsMe+7nPP1uy7aDF2yu0VLbz2VZRZvS0mQUgk2fmx8iHPBaDTVBmXVImCM3iobTuTnT+jFvZ+QIs6a66ZDvVqyGLLa/Ekp/VGyXJXir7JMiXFw48BzeXtNBbzspse1meOH4vsiExM4m8pP6NYNU/rMiToE0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mA3orzX0dJKd2jRvVaqf/p4GdBJttR/PnQwbywR8x8=;
 b=iMKL49xz/AD8531YuDThBHlKRscRFX0N/Ived04179NhLDV8KBp1JumppaN4z389IRrciBaWF4iUscYD/Gaoj6uK5TM0Iy+BE2NmakCazrWbg9S9FdKG8Imvw6bEnQ+ehwhvC0zcvNTgUjBjL3UL2Kd7uO+CUXUtG0mfZlJtTYA=
Received: from DM6PR12CA0018.namprd12.prod.outlook.com (2603:10b6:5:1c0::31)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 10:00:12 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::e7) by DM6PR12CA0018.outlook.office365.com
 (2603:10b6:5:1c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 10:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:00:12 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:00:02 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 07/15] perf/uapi: Define PERF_MEM_SNOOPX_PEER in kernel header file
Date:   Wed, 28 Sep 2022 15:27:57 +0530
Message-ID: <20220928095805.596-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928095805.596-1-ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b7939d-ae11-4822-3888-08daa1383c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otcoY4vOt3EQrbR1MA+dunDZ2caXYDfVIcCV9JrwRVd2HaMmKJ70h/hS1etgcptaBB4Y0W5gaHH7e0IVLKA3kY7czEp6Bn1+DF08vEe9tmyH72Cyug5eO4+11PWD7dwPsMj62JjNimnBDVGJsERrY471j8Zu6y51OX7B4jeauegMuogy/JVfaYgaBSljjIgjqy7d5+dMwQTRJWSkBx69uOWjQJquEqoa7kxjuv6EWJUkyn6daOsQE+hvJ07M8FDxrK9k/gdKIroTUiR+SiL50g+WtWUhBKFrJITCuynOPMN9lNnpbOeMnutTCNnbakBB96R06/IOffQsNgUCuOKnN+zDMSHpMgWsZ+Zt5AXcyW55qcxsD2X/pfbee6ArogDpgyvqdIuAPFuVq2mZJdnOGJkUj/vveGE+27Gmk/pDs3qC7rDh/D5620kJhuSvtUDzzPSPIcJbAA2z/ddH0COlP7Buco2PJ+5+LJ9DlrFutye9N4eYrE4uWdYzeXxa17SUZhO/eBxlCD+mPQRzYtQHpKZrr8NVS6ZkGIR8wk3DS/+d3N4riTKZxF9DPpc/1CZgTDmETUJbQvm/RJouJjMGJYudS+DSH2WZ3/2rbDObjixXyg39KLSHsoLQZfI2GIpJKs9kYXX7qEDParqNGAnTVVH0vTLvJfHbt8iBqqG6IEQkv0zmtGZIiEKft6/PdGVhROzyVahdI5De92XtTqDaENs5J8CsmKOXVYGh0IO50oqnnjzV2vFLbFcyon31D3MUE9GKxR/Cvak+9lEHhiFZjNexAMtgITAjERiBqLZ0Pvm7ZpTFw5BhowmlpLdhhCa3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(316002)(110136005)(8676002)(54906003)(478600001)(4326008)(70586007)(70206006)(40480700001)(16526019)(7416002)(6666004)(44832011)(40460700003)(356005)(4744005)(1076003)(36756003)(2906002)(426003)(26005)(41300700001)(2616005)(8936002)(336012)(7696005)(36860700001)(186003)(47076005)(5660300002)(83380400001)(82740400003)(81166007)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:00:12.3254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b7939d-ae11-4822-3888-08daa1383c11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PERF_MEM_SNOOPX_PEER is defined only in tools uapi header. Although
it's used only by perf tool, not defining it in kernel header can
create problems in future.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4ae3c249f675..85be78e0e7f6 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1356,7 +1356,7 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_SHIFT	19
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-/* 1 free */
+#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
 #define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
-- 
2.31.1

