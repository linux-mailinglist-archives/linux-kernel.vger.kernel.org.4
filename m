Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603C05F7FB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJGVRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJGVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:17:33 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AA036DFE;
        Fri,  7 Oct 2022 14:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOLRtoUnP6gV23ALq/0YOqiIOOIXTMLt9dFOljj29OdV+UBOlCsJ/2F3NNNoSclrsrB804Gkajc9ahHyj/1Ox1Jdprr1cdOGuyrnCQvfAx9QvLoFGi4mq8qd0bcpbbV/UUYXGDYRq5hEoO+gqx4G4BlCqryPgFv1+HzqfCT+cdQg87qL7HjsxRUmNkxTncG6WR9gVAKqH2fugwQQsTa0DsBwjC5Z9txb4ywQF7kw0QkdiAFljFEYVH13NI07/kZSZTNZzRP/iQn/G/7+l4ZafFoWztTUe/SotYa0WsF4gKZoSVUmdMGazCbMW1mrdv9unlpNRAydJ0DewZTbGBz0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUMywgD7R8nWKV6CdQK3nnSicEj8f1sFf4xdaLA0gDI=;
 b=jXKoUAGuOsepGcHwt/N45gxG1viTTpsUZNE5sUE4xlIVTJIthTfIeF04MFPOpqIDgqRMIZGDJEnEpbktG4mobs76G4BDS92VKztJMdb/kf1UsIBtMBt2n7lzZa6NvzrRXIdtsCRgWjJTOxKmwUagL1qkQrc6eV1wCl+3059S/+xniqZcuxdWlQKXhiATM3LfZjKToAQWZx1I/WXyHCBhza9ZmEBOVclNtpptLdZ+IlpfRbvrIgBo2l0VEE7phUtyjLx8x0k4qRaHkHzSxBU+hvUc9BxJaRVRgebJoZa4YZXOIVlajlfHeKjwrF4QjlCx5E7sRYdaAZYb4m5GKRltRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUMywgD7R8nWKV6CdQK3nnSicEj8f1sFf4xdaLA0gDI=;
 b=r0i+CGKeOQ4DRyaC5IL7PxjdDCuTBaGEldK5njs8EHSqs4+0g3iB0MB/wtqviJV5hN+IHwpJC/lzlmMBGdKnqN01wUeF2Lb9a8SmNv//itZr7KdpYx9eY0XLJ2fot8a3y8Vq3816rof2lZyDD7HVoqqD/AuzcTFgrS4lMNt9ptc=
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 21:17:27 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::83) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Fri, 7 Oct 2022 21:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 21:17:27 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 7 Oct
 2022 16:17:26 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Date:   Fri, 7 Oct 2022 21:17:12 +0000
Message-ID: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|BN9PR12MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: 1322ef87-b6f2-48de-f163-08daa8a9562d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHAWmAZal8ug+w8FFpWek/zM6Sg9FQoOToFNH0tf+NmjAYSF34s2MqvTT5Q6vev4jD9SB9QMMCDRHdwBIzg3CZwZAiJ1dGL3CEMbS/HCm1dEPb+noGLvdCD8XnxRi1nsgQpkiwica94vn7ZGc3OCR3WfEcYVa0npTRJvSloGRvg9nLtdgdFrqdJrHp6fq5nV4FodB931ie/sdkKuNw7ZgUr+CqK4OczRTZi9WBnVuThLKFfSnjJghUqQql+UuOfWn1eRfNxZVhenDkSXGTSEsPFsvF7FqHgGaJ635dI7RFIaHje4DQXAI3dQJ9AEQlua2GeF+uYC6VraN0f/CuB6rAUnjXfKLIXptAcJ04zL/lqmDMEMt9sAY8MNN4yGjqMeUDXynQdRzRx3iocbw8PSZyLjPTDTGr4/vi0MIHYean2GRjsWyDFnYro4pCTQIsspJGj5h4ZuzTvuxmvv7sfAl7t+rogFYyetrMugRxWGrtkmKvxLDXL8R5jj4RuA4t3EMkABSFsUvkIflSUSJpszfR/sKVGorahLky5BgHtot+rGbZ7NRmJ026gwJPtFv1RNomuinXC96auH+sVf14zzuJ+mwjo2DVjOa5BAeWUeYx5UOfotBz1APv/KG/lu/h/wrTebbY/8WDVlTlQnhwhuOcm+Ku2X3jLEnGsMSarHC6vjBQxCbOk+DTSJlbAp/mSiQzrxL0+2KVGq664WGojHlfUve2Mbj1BNYl4x8mw3FStYTbJ3NgAgYszT2P08dLYGMl02DIYfxjbVrsc8+JWs11uYsu+LZIJTyQ7jdUpAU2e+tZh51GEDTD18to0B4Ut1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(4744005)(5660300002)(8936002)(2906002)(41300700001)(40480700001)(4326008)(70206006)(356005)(478600001)(36756003)(70586007)(7696005)(81166007)(40460700003)(26005)(6666004)(82740400003)(8676002)(186003)(336012)(426003)(16526019)(47076005)(83380400001)(316002)(1076003)(2616005)(36860700001)(86362001)(110136005)(54906003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 21:17:27.4668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1322ef87-b6f2-48de-f163-08daa8a9562d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds decoding for the CXL Protocol Errors Common Platform
Error Record.

Smita Koralahalli (2):
  efi/cper, cxl: Decode CXL Protocol Error Section
  efi/cper, cxl: Decode CXL Error Log

 drivers/firmware/efi/Makefile   |   2 +-
 drivers/firmware/efi/cper.c     |   9 +++
 drivers/firmware/efi/cper_cxl.c | 108 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h |  58 +++++++++++++++++
 include/linux/cxl_err.h         |  21 +++++++
 5 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/cper_cxl.c
 create mode 100644 drivers/firmware/efi/cper_cxl.h
 create mode 100644 include/linux/cxl_err.h

-- 
2.17.1

