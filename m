Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703876DAC35
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbjDGL0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbjDGL0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:26:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6953976F;
        Fri,  7 Apr 2023 04:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNxr9jGM+6ROitDKYY6Y1rPLtluaipPktfxXlOWMPcCt9NAvFzl7Bmlm5f1lxVnE+R9FkEPyoNkU+30x19p4nEbmzTg9ydjDqrbPI1BTtbkGwWVcJFtTu1QZW6dFTGGF7MU/GX6u68/P6z5I/v2TywGflJSWxUTnQu5ong1yLQLr10zoYkJTxU3+E1qIVNcIPXevzTJMlCzxx50/TfHzRRmt+xbebH8tY1utqn6xYn4wSGXSRnBmqI0vru8Yw2tiWK6tiZyT7TMs+a69URXOC4Z71s1AI/qNufwqTa6J4QvEpJS1Xl+9dBLv01FT4MrlugnCp6AT0d40iG71IuruXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZRDLU0UGuqwjxgjsOFw+rCf8kwPn4Z+7f7Ff2XUmfI=;
 b=M6wZcJXx1Wu3tQkiSdOB3qvBnK5WiiRKs00KRpq+K1QA7EHpv4zrkZzGzusZv0fxQvZoSGW5adfOlVszCHlwThEux9Dozm3S8Iu2jzO2n/wVjo4UHUewWwp9AKuenBMnpj4sviNFdd6JMuNeWa2QTbpXUNTHT/cUkoiZM0SQRFMJ1Rb5RfhCk1hBGlaqLQAUOu+UdVwssbF0/db/Tf70QdEvbfvhjHc+fN5MKBPe8bCU4UTNKtSv5i94QWTcQnyBGedlT1pls43A7vE/VHn5aVEHMEVp5qmdz3EsLqIuRCD6PUBc5wt3q5qrCUDHAgXyeuBvn/PLQiiYAvJmzLr+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZRDLU0UGuqwjxgjsOFw+rCf8kwPn4Z+7f7Ff2XUmfI=;
 b=fe/7RtSvR7XdoPAt9QNarGvvmSl8lBUHrQ/LX4XI2a7eTh+ix2XXHcd5Ve6uuEI1Hq+jri9aqykwPxUzDPdQl3ir32l60fqth0GPzDA7rvlZmGAwHw8DN7DpxCS7cjKVMrv1EHuMChyAoYdpusP1tkbPHjlfIQg7emrqlM/E/Pw=
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 11:26:14 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::73) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Fri, 7 Apr 2023 11:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.20 via Frontend Transport; Fri, 7 Apr 2023 11:26:14 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:26:07 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 8/9] perf mem: Increase HISTC_MEM_LVL column size to 39 chars
Date:   Fri, 7 Apr 2023 16:54:58 +0530
Message-ID: <20230407112459.548-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407112459.548-1-ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 31851183-4134-4089-3106-08db375ae5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cv10qBqh2HHmLGmHaXY0YgFKbXNcNwN28eFfDMpxHxco91ItdnNhvT6pl8LYTBFD+xKt3n/52hjrKFNwIO2upk040gMcD5zio5BgKGk8V50hK61b1c/Qt960nLH2P/ZZS++dSnIm2PDfdUhCUtsCuacN4Op8Pt1l+mNswwfSK/z76tEf9Mp05hylS6EAAvLYniNx6qj+B4Rj+oLXhgNH/yKqvxBPYjSEknI9v0hVl8aAOgXLdopigxwYTlykEZ6QL5Sg/YPWtbCfiLXe6VhfdEph0sO0LslFZPtL/0SBJk4vjo59Vk3fKZZJOo1gHyTe2nm3qVAJufyc4lIyFZ7Ofuj2HfBLZnErgLwEJvkRCaqkMsT+0Uic70/WJS9GaDBFnV8ov6F3ZjFtgUJapSp94zx+bnU+LD+izk4sMVV0AL9P+FKQC6/nmVRTgeqvhom1Top25zMSVtVTEv2O15f8Wr8Nvo0vfvs0Gc6avDsf2tojcrb5oGFY7T+83nJ8o4oeXt0imzRtpaiGUbCO0elDvAm40YRhhIXmDt1aflVZqGP/CmuQxUHlpl086pNbQGvIrlQ8joA7xxkak4wQftxTFFC3tDZvGLjn/ol6e1Uy6PQv0ApfG3YaNGxlko57PAVlmKD4rNBV1rcitLUjIK38b0jIYJl7zKWbJWqfrzNrmySHNfKz9VwA24upeBKnA1iSz5CJjcCzJeQ+/dZgbdwqYVIC+4Zaxi3ZEpcwACrHR3s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(82310400005)(86362001)(2906002)(8936002)(40480700001)(7696005)(2616005)(36860700001)(6666004)(4326008)(83380400001)(47076005)(426003)(186003)(336012)(16526019)(1076003)(26005)(82740400003)(70206006)(70586007)(8676002)(40460700003)(7416002)(81166007)(356005)(41300700001)(5660300002)(54906003)(478600001)(316002)(110136005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:26:14.2263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31851183-4134-4089-3106-08db375ae5ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

39 is taken from the length of longest printable new API string:
"Remote socket, same board Any cache hit". Although, using old API
can result into even longer strings, let's not overkill by making
it dynamic length.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b6e4b4edde43..46ce4527919a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -207,7 +207,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LOCKED, 6);
 	hists__new_col_len(hists, HISTC_MEM_TLB, 22);
 	hists__new_col_len(hists, HISTC_MEM_SNOOP, 12);
-	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
+	hists__new_col_len(hists, HISTC_MEM_LVL, 36 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
-- 
2.34.1

