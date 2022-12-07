Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99411645372
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLGFbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLGFbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:31:06 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2455CA6;
        Tue,  6 Dec 2022 21:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqs8fmIrJmejsfGRi9BJKj0nOsWFK3kuz75UfdFwT6xTSUSYyVwQWN5/O/cL9vnmseRQwyg59IiNNcFi3E02E5KTlPqw+h2yD/2BKOjq+yxZrJIFG+74nWvHs5S/cQp/fsr8IkIlpisyaAkWzyxOz4B2QpCU1PFl5vuAUtKQ5Ft+ntQQR7kpvKDWb++nvINe2ir5WKb6FCDAjMZkagGr3tflv0mA4EJjiUk5alyjwZ6pQ4sHnvboBtqADToiuJcfd+rsCZUktXN5IZrBdmwprDTTOln1Tai7LgcI0LJnQjKMpOjhqY9ovO2R9jha4YgQF122nCAWboEPCXG+SuLmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GplPQuZrw5dQeqIVKcx2vvdzNpLPImS7CPM1DzQsw2Y=;
 b=KporV3Vw0aCRnXGyCUMe+lLy74Wxnx0whSTr/fSSGYJU1LEOWbeQ2ukAs34r/QPWOIT78oOThhuADGRiWyJz/SRo/yIEdmRqVKvo1qE0obp5+kuVDdDvNKka02zbST5zM57gAFDvqMrqKNY3pZjAIB9WAxFIUkBFSmMixZ1OW6dKF0KIcQCjxXCIkIjaAZUakBgr7DjWlwCDqTb3ofY7U+NeTbXSVPk38TYEQFhtgfdgu+1m7noZW9ArDWyTJ4PM7pc2YUDdNuD+szVhPfojIP6RLwOs5PpGA5cjD9FbYkQoSW8SIMRlaGfgHM6tly09SjXGh408rQktOxhT8c5k0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GplPQuZrw5dQeqIVKcx2vvdzNpLPImS7CPM1DzQsw2Y=;
 b=gwM0YOThSW78M7R+C+lGDSm0KgKDkMBRJJ8DrnVNDHqwdB485bTnMJFMV8nks7D0ipk7meOIyQueCcZaLU/fDKeaMj3XVFHol98dGXwid8XdmNgOMQMBTdP7G1aP4m4QwwPL09Mv9PoQMrFGKG+6PP39+cOq/4NYt31dV5Jiarg=
Received: from MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 05:31:00 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::6c) by MW3PR05CA0011.outlook.office365.com
 (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.8 via Frontend
 Transport; Wed, 7 Dec 2022 05:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Wed, 7 Dec 2022 05:31:00 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 23:30:54 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 1/4] perf vendor events amd: Add Zen 4 mapping
Date:   Wed, 7 Dec 2022 11:00:04 +0530
Message-ID: <20221207053007.336806-2-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207053007.336806-1-sandipan.das@amd.com>
References: <20221207053007.336806-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: a03edad2-cca9-4cff-71bb-08dad814399f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpUNEfwEZNKiZHmkYoKPd1Ps0QZugnKfL4Eo+hU5J84g4ix63RAUtEgbQuVRSFYyYhu9uoNm5Fp4q3uuS4naamXpPcyWFYdi7joTi6jNesN2PCDv33143Mv8rY3Y6iuiYYdMhCKP0NhrOfLCczamAZWUFfOUvp7BtnU1zAKGZ+/aVN2fznwr8bGF2X1kIO6bnMLRMtqPNWHJsmxvHKWoO94qyzXA25uOCFXoHFDS24XstQf6dnk5w4fI/Wj6qrkrppZU6WLd+P9+IIm73sbnKITHUwI2m34ICqrFbrwIZ2/NzGpeksBqFWejNwG1fv6qkj5+lM1BwCaRLfH2l4RSfLjxKuKFLH1W2q5PmuBJ6tOR5hDXHaDVchdESikmOUXVFeWCHr2JOqKjct6ugROs+R189HYvefLbxUlnmqr/yAiORrcrzVgY4csR4TA/GjFvrWalxsqDNxFdi1xWxfFhiY0vnlFiChBDuupuU7VFL87NyYpKi7hRhRpoKhEFNPkDxRn+yoeH/MA2ZwIwq9iYfbH1zvq7XTpcusWzt01HuqnXbeUSruNKF7tj2PPtNkTpz2o1wCEsqIRlskOqPkA2UUB2TBN42NkeK6RFk9ZBS+9dh1ioQeiVB/2wzki3sox7h5u7Aa3TTKomNK65OEcc4RlZHI1elO4UWAAd/IDW3kPty19trKi1xyD8Jj27j5VBe8HILUcEzrIg5ZmQIBYl5qjPGF+M4KtaN6iASMkde00=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(478600001)(8936002)(41300700001)(81166007)(86362001)(54906003)(356005)(2906002)(7416002)(40460700003)(44832011)(4744005)(4326008)(5660300002)(82310400005)(40480700001)(8676002)(1076003)(47076005)(186003)(26005)(6666004)(16526019)(336012)(426003)(2616005)(110136005)(316002)(70206006)(82740400003)(70586007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 05:31:00.2324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03edad2-cca9-4cff-71bb-08dad814399f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a regular expression in the map file so that appropriate JSON event
files are used for AMD Zen 4 processors. Restrict the regular expression
for AMD Zen 3 processors to known model ranges since they also belong to
Family 19h.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index df47462a125f..f6a149a9cebb 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -32,4 +32,5 @@ GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
+AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
+AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
-- 
2.34.1

