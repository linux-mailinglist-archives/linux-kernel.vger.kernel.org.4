Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A7643C49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiLFEd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLFEdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:33:21 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCDADEC4;
        Mon,  5 Dec 2022 20:33:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu7KKRbmdfKYmpyUM0DTfpQT8cXTHzl+X2Bu5jmVSecm4oIBThLhxG2OQjJBEphwmVsC+KxjXZmFgaxfm/w9vSMLoOGE7p1eZVihHAeIqcsw/QXflG6vnL0Rsw81ZEEIctuhlYiSXEwOxN/7dRiSAabstFODiCL0n+D+peQLkip5Wk47sNJIU+7vKP6C/h8rjSEzHkuVxoB2M2nzXkkfA9x7W0jrqHT2VpQpzR9F38XiwuIvgcIlUKRZNS9obKf56FqEIhOVOenImL6XvVYnQ2w4jCvza2AZKwyREF0hyz5Tjxs5Hm0SHr4RXUVMPdVbh20gwnXByuurCNEqJm4fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1SPW7myZw5C0zA/jG4JiJ2UZgw2FLqfmbLtbrytOyE=;
 b=IXchvoMN8WFB+GmDPLzfRhQEU7aQqU91cybvYBBoHkqOa9PQGmRIAvwIDhajVhTFe/721Z5ypA6kDFNvFMFeZ2juMp8g0kgtQHTPU4ppknQ9mLRHGeXm8BaYSmuLLG0uaE1lDFAlpHYMafSIwb2LIUvAzl0V0ZUGGA2DUrk+4lZlDrVHYwUS5icl7or+pxCI+PXMTT06Dy17X7FM2/bjvYLs3avOxT6gRxf9uGMcyyFtlF9SrQkvKbwiZowlmr/OzX99I4UOj5a/NAH1fmF6reVniNIHeya2vLxRgnTgGEvfbBnvuhvq05vLXndrSBusC2H9BSCcNn0jdcMl+IhFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1SPW7myZw5C0zA/jG4JiJ2UZgw2FLqfmbLtbrytOyE=;
 b=nysRh+IXXsLM/kYgDuykaRIWeOPCX+xAkqaTVWGd9cT4RObGZbbTmR8bRGu7maSIjLoW+iY0o4ulP4dkMHBRIUFfcRhZ1SNxxFamh4XYP6C6QGadJdvdiLYcimJB5pECXtCLoRyrbkLop7Ui67LZ4NAPpccJTN08iGb+g2ugk5g=
Received: from DM5PR07CA0097.namprd07.prod.outlook.com (2603:10b6:4:ae::26) by
 CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 04:33:18 +0000
Received: from DS1PEPF0000E659.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::9f) by DM5PR07CA0097.outlook.office365.com
 (2603:10b6:4:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 04:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E659.mail.protection.outlook.com (10.167.18.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Tue, 6 Dec 2022 04:33:18 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 22:33:12 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <maddy@linux.ibm.com>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <tmricht@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 0/2] perf test: Add event group test
Date:   Tue, 6 Dec 2022 10:02:35 +0530
Message-ID: <20221206043237.12159-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E659:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 74db905c-1c53-402b-20a3-08dad742ffa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AtZ7ww9Z/IT8EF36TWH8DX2RZjZ4FjrBsBQvM2FkfNdJN83jn7/HIy9W/HSdiMmFdHgfpnUIvcOZUlNJra5Ehj3OEG2t90UUbFgZ/qLxSsd0tZWUVTiDobVrqFY3jI7im33hbw1Dr+9A/Xsi6tG/SbBS6VQwbT/ik/NG4cR5/cv59UCNXcA1TN41uxT12herQHxHIDqLJt3g4tGItpZMAbIgwWyNuuV4M73LhyFivBClyfL7c5/KLsiuwWdfYlbzxFc7ET+KEycHiP15XsV9QCVvt90+MKBv5AQ3IsqDK/99NkCC7SboMUqu2vS3Nud0JmDhqPv7xefppmiJ3GzKcuEJWA/eFH3C7ceRAj8iZRTORoPoQs2rsNQcE1RTETqVHdgiXLSvlNdmRsqWIHaz7QPOMzBExs25aq82xdFv6uHrOl92fGTQmWI1QIRNt8XJg+rmunvkHDvtCT0PGGo7gSEVoNg5lxUOo2vi9eJW/Yn7wZMt6mA8qFCiYZsJw1pccjWzwOeg3B40LbVHbCcGekCR3/1N4lmDDofPunZTslduHpUcgEouV6AQJoem6TOobD2luzDiYTeIF9hWVrUj8XOoLfMX7Cx8JVXoaMK8kkrL5AGYsKdODRX6/NIuzSZTZic3yzzIhd7OFSxcPCg9MirO0D3IkHDdRW7F7Ks2tufOPsLq9z99V7ub52/jyerKTBXrsIyGDYOnNMa/T9MD04fcWTl3IhUl1Bi12LC2D9teTSji96sKkSD41gMG8bLDDHHOJOCBnxe6+RpdmKmEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(86362001)(356005)(81166007)(2906002)(4326008)(41300700001)(8936002)(8676002)(70586007)(70206006)(44832011)(7416002)(83380400001)(36860700001)(966005)(478600001)(40460700003)(6916009)(54906003)(2616005)(316002)(1076003)(82740400003)(40480700001)(5660300002)(82310400005)(186003)(6666004)(47076005)(426003)(16526019)(336012)(7696005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 04:33:18.2193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74db905c-1c53-402b-20a3-08dad742ffa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E659.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple events in a group can belong to one or more pmus, however
there are some limitations to it. One of the limitation is, perf
doesn't allow creating a group of events from different hw pmus.
Write a simple test to create various combinations of hw, sw and
uncore pmu events and verify group creation succeeds or fails as
expected.

v2: https://lore.kernel.org/r/20221129111946.409-1-ravi.bangoria@amd.com
v2->v3:
 - Define a set of uncore pmus that supports more than 3 events. This
   will prevent false negative results by not picking random uncore
   pmu. Test will be skipped if no uncore pmu found.

Ravi Bangoria (2):
  perf tool: Move pmus list variable to new a file
  perf test: Add event group test

 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/event_groups.c | 127 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/Build           |   1 +
 tools/perf/util/pmu.c           |   2 +-
 tools/perf/util/pmus.c          |   5 ++
 tools/perf/util/pmus.h          |   9 +++
 8 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/event_groups.c
 create mode 100644 tools/perf/util/pmus.c
 create mode 100644 tools/perf/util/pmus.h

-- 
2.38.1

