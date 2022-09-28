Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741FE5ED99D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiI1J7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiI1J7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:59:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D400139;
        Wed, 28 Sep 2022 02:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B62A/1UNmtf+ZbiiuryC1F+H/jHhs/mXM6R24vuEzEtc3AtKHcJX9tky7GWhhWi5HtacxY7+LmERxnyEU9SpiEHA10yQHh7LVlmTf9Ct6aJB/WNVNeDSmmRCZf3ONv1gMW2lvlB2gxEP/0swq9k2Ts7Ksqnw68AYIenke+aLQlGwWCaSvGK317XrvbHLA8u4pdXlAbSbLmHbC0R05rHgJklVPrX+Hjf2hBxMHGUf6BlcLpI+GkgRbOe+I7lqU65GO6EQtWTU67ktUQNjYwciS/Lnwl1LpGYHFDkYiWSvSXLXGKm5yda/vPE6TQ3+oGsF2ZgvU/ZxwnmqLFgThihWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrXjr4/8S0OArGRq5H341LrvqZuCcfb6T1aIQumKfoM=;
 b=FovEqY4nnqOuiLSOxZB37s7Vye/1eX0kSbtex4l08UbFdZy2qxCN88+OoRXxLcKJfz5qRhFp13RZndhBUJMTp0x8sBWI8F4z1dZCz3Qwf+1xFLZXgkFrXyYKa08nX5fY8b4JNDvXjkF16/geygZWchsx3aquRGc4FvtQihy0LB6389zn7EMd1gyqPsbIl5dqNrml+IyoMNk7BleqtzpWXNMCz5FI+sTKM89ubD8CPKckJVPYUZ3t0W8iDuIAcdZNG2esvFvreR78+DUPKUw2yYKlqe78ynmmD1f4uv2AbQeCT4EOwtchSRB7BJ55BKIyua8sPKU/qk97qeLzns+kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrXjr4/8S0OArGRq5H341LrvqZuCcfb6T1aIQumKfoM=;
 b=4jg2Xuy/eQ2AI864OW4xNnu7pTVYvUv04uQngoZIsI7jQdPvV//ZIsCHYTppXUvcL1xrlQhzmNqdYrlmUJv4ypaXY7+OIrDjostLC7jelwjzENK3ZhOYcvvnjzkKpKvGX+DIvBTeEhKOTHEnOTYaxCyocmp2YBVlI1cbR8CTw50=
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 09:59:11 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::e2) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 09:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 09:59:10 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 04:58:29 -0500
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
Subject: [PATCH v3 01/15] perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Date:   Wed, 28 Sep 2022 15:27:51 +0530
Message-ID: <20220928095805.596-2-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 415ed7cb-1fd1-4673-341e-08daa1381724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvZx1g/MTCVpsuBCh3apR7SBGhQby0JJxAMNuDr9tD+Kzx5sddXyw6DP9RB8k9Ci6RnQQpyu40GYDBmyju2dLFQ5AgA1KWzw4kYNPpUbfXB7hzEswUDfe+XbFw0JFu2a4VSrHcqivDwJgzbHFC3vXyX1LexZvd8GiVEO7g18nqnuLiwVYEtUUGE+OtnqUmoZTg7A34HF3ZOwLIgD10KUIZm2WI8kMQgIlk0XShgjFfJdRHNGrPWTxWgNIPsdM+TPSj8ygJ8D0MD3e3I53v2GBBSdPR1ybMhAU7TwPNQ3/QD8e5xT8kqbXFj1pxaCXgYg4Tqca6iReYNaXaRT1tz/Z4Zv+AOSNUMLHEBg7+CidPb1Z436MlrYgGlLCYSFrNZizLROPkes1L7Xj6KGAJKQvl1pu2HLA3glaTPvpKM6Z3ox2RYZUgprEGbXvj9Z0HgO5pwK/eISqvBRpg4wFffbNp6Hca1IWM8N0wZXn6bjCQsi/kdeOT6wITQeBRes/N6w1nN7Oy/6bRo7z5VLFFUrobqEhtycEetL0ShrTodqK+TZ1X4jj8B25Xvv9PBKabuW/Vk29Vc9AB0Gp+vnmOPt51C0NjkZClza2B935Jk4xxDcyVsEAqw3j+3wId4cv1+eaYvEgEFhiVnZscU4kKyNAwqLMUy8pC7g7RksjMwDddzHQ7I50AdsoFYZG2OHEO0sIOSmJyXWv8ekTBTZY39FuSArigJXNsuCye0dTd9vYgpo3gKkpU7DrZXQyX1gTF+BV40iXYjuv/a11aPjPms6K/DPR7EPGv13+Nu4qxCqzlCGR4IIcapY7st5tDYTsNh7/PykGiivKoJyBAa2pP27gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(478600001)(83380400001)(81166007)(82740400003)(5660300002)(356005)(16526019)(86362001)(1076003)(316002)(40480700001)(336012)(2616005)(186003)(36860700001)(47076005)(7696005)(2906002)(6666004)(54906003)(40460700003)(110136005)(41300700001)(426003)(26005)(70586007)(70206006)(4326008)(8936002)(44832011)(8676002)(7416002)(82310400005)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:59:10.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415ed7cb-1fd1-4673-341e-08daa1381724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
accesses but it can not distinguish between local and remote IO.
Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/uapi/linux/perf_event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index e639c74cf5fb..4ae3c249f675 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1336,7 +1336,9 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0xa available */
+/* 5-0x8 available */
+#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
+#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
-- 
2.31.1

