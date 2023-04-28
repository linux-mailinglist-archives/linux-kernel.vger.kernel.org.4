Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206026F1E54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346554AbjD1S4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbjD1S4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:08 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B05249;
        Fri, 28 Apr 2023 11:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZhZtYtTWOSusHKVG1KjPStAx6qW21RBgUThmUtmAXl9HlHodFsZ6xGCPvC0fx1Mk4H0mfapCy3ArBOpHHFpwKNcSVQd05sljiYNdmpCKZrDhcBkNdlDpRRYrUmzzMVfc6+A9JJL/fLxFlLMVjafPqinB5HuJjPl/wTigcIPA7bO+vt86q58j6X30NxAhYbWj4p4alhJZRaGaGQCrWRiBzdcyeeSFgXTrF+8cl3JoutOihoHGCNHq0mrAKW9LjhrkFZ7G3NEWxpIK+Pq/Q1Y5HmS79+X8bgs+njnzsxPq9DSw5YZeS8IV2AkC/WIG+YFJEoKR/128t8cDNqedkJ9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCK3UFN7kfeIWQFj87Ev9Xsr6tgtpWCv/5cTFSUBohk=;
 b=nemAPUSg94rtzUqrsKTS2667fC+c78ARA+dMUVLrSHzoI2F8zSDgx9XI5N/TJZ9JK1ChbWOtBXqWl7C/Ut9VcxwJgnsJ/d3Qol8QQ921q3yyzxyGnFljI5yPy1qaEe3rtnttziqWZc9QTKVy0XSUvZoUnVTDgKuUk6fQxMx2oUebD1zL91riNmaalZ6kd/0/iZjXYAr+rUed2kbGtvFUnhjyEK061SIwnb0srA35Yk4MKC2ctlwnGgFWilugZNyZSsUOTLI/R+QQRYUJNmsL3rJJc8CzwiqqBGzR3T5E1M2Hyy04cg5x1Z90EeQQHr2flBv1QUhB2dGlRyfff/urKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCK3UFN7kfeIWQFj87Ev9Xsr6tgtpWCv/5cTFSUBohk=;
 b=YA5R3dQHArK/3S12ygQgPI0YoUrjR1ua4ilgqmF/aazWXU6fjBZKWX/tMpM505GXWURx3U2PYUDZ3jZ4QslXHwDwqRxfpVgQ9+33cpXAjfp+sri6TJhACh8bHLHj4AAGXO3QhXm8W6/lEkc5/BRqcEKPa2col5cuiQ/tTz500mQ=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 18:56:04 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::93) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 18:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.25 via Frontend Transport; Fri, 28 Apr 2023 18:56:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:56:02 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     David S Miller <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/10] crypto: ccp: move setting PSP master to earlier in the init
Date:   Fri, 28 Apr 2023 13:55:34 -0500
Message-ID: <20230428185543.8381-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428185543.8381-1-mario.limonciello@amd.com>
References: <20230428185543.8381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|CH2PR12MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b9aea5-083c-4bb2-78d1-08db481a379f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NKDy9yUb3K9t/WX6FE/BvU+sPuUAmlW7jEHlKAdiZJuwZMkbG+eCb9m2GT87OGXBbl/BG1IWLcrp+JLmUHdDl0a3wbeTp4DTRz0KNKBbkWE+Ai7lMaIMwcwxn/I5G6Ha+Q3cyXXUAnpgZ4We4IlJNwQRFhq09lfvuxGQpfYWDB0ZfCjMDRWF4q7ci4tquMAZgzaJSyndh+jezvRYrKfWK+Q9WCZS+ceCzzcjQ3PIWu+SST/H/nXl5Y9cHzUTnAnWLw6KK7PTpCXcJ8DxO1l5eiOP8EQl87pC8edtSQ5FJsNojvrXnAxr/X9wpcpslhOTP4add/Jze7dySIXO84szS4ySao8y1/rEfHWyTYnEG1d4r++vBli88i9cYRV1E3JovF2iNMfEmZA9bfU/czhpcWgtjOwENMaBM28YYi+NOmXJxRJc5Qv4Zyi8s6sNqvdObKx2Rn8nAmRPs8y2dzT1dOl7RYf35iNjAxFYXM0EmAWdguV9a/QLRy+fL2Wd4f4TGq58xuGmrXweZWJY/qDtlpgaIhcIQJjGSfVtIaEhhHtBYFX1lPCjFVDV64Mx0Yi6xwtE4YxrF9PWP10kIwJgamvvKMLxBOeLeGV7s6I6MpX62hJ3tT7SAr7TQY+OxYYpE9WD6AVR7kigOhPPQkxJ7ewN4ScH4evdMJlY+jFZ27RrvACAnpL5M/1SqnVcxgBAl5llYQFIFp0KosVHriiiowJsOqykT2rLUF1xSKtPgA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(2906002)(82310400005)(36756003)(4744005)(40460700003)(40480700001)(6666004)(7696005)(4326008)(83380400001)(2616005)(47076005)(186003)(36860700001)(16526019)(426003)(336012)(1076003)(26005)(44832011)(6636002)(70206006)(70586007)(478600001)(110136005)(82740400003)(356005)(316002)(5660300002)(41300700001)(81166007)(8676002)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:56:04.1667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b9aea5-083c-4bb2-78d1-08db481a379f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic boost control needs to use platform access symbols
that look for the PSP master as part of initialization.

So move the PSP master before psp_init() so that dynamic boost
control can be initialized properly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index e3d6955d3265..e9136e398174 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -173,13 +173,14 @@ int psp_dev_init(struct sp_device *sp)
 		goto e_err;
 	}
 
+	/* master device must be set for platform access */
+	if (psp->sp->set_psp_master_device)
+		psp->sp->set_psp_master_device(psp->sp);
+
 	ret = psp_init(psp);
 	if (ret)
 		goto e_irq;
 
-	if (sp->set_psp_master_device)
-		sp->set_psp_master_device(sp);
-
 	/* Enable interrupt */
 	iowrite32(-1, psp->io_regs + psp->vdata->inten_reg);
 
-- 
2.34.1

