Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143C4676698
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 14:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjAUNsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 08:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAUNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:48:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82BB441;
        Sat, 21 Jan 2023 05:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fg1m+P2RVZhQAj4RGMSgpWT+uZPlHkXH3pRaeXMhsUz9KAnazZdzDxPdO0AVTjc/K8rsXIeTWPIfTqz+blOial/qAG7nskFMQfnxEGrDvkurRKzoUFj8jwKWmC2xqPpm14gakMDQ896UGZas487gHzGtu+ArcqBT9fPYwn/JwOiFm+LmT6JWG2eC15idCGpxG3LBXEON/3iriMID1pCLhuzwf5VejLIDbDUOc4GWRu1VpuuB3LP/3GoTWBPmu1Gg71Wg2hqgeWh7oijHrCcjXpTCoemhVCOuKixY9BFRqZJ5yKda1Bn4iQCDuTMRjcYtDPfT6BNI8p4/8CnwSgBGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9lFgys8sEcMQWQ5jKThr/7wan3B2UAz2sRM5/eCby8=;
 b=Nh4WVWgUiQk7dCxLdF6UKUmh4kyeqj2zitqzi/21bmtqt2wgYcj5gXTLnKV9MPtPsHz7tpVeNMC93Vr7H/mxS1btTuO+GIMTDwmdGO491pVZk8tpTx51XyVYouU2xvGqVWHjwd+C2kRcy5GTgsVsMLpNKg4CPG9eo2CjStSXrjrPfAdvUSr9C5IcFSlay0Opwpv/PzDpv6uuVdfmnuDYqALSjNBLm4hIByI7SbNiyL6l32mJHEi2q5Yjoy+lkoYm479jdam1zl63AwEb7M/S511zQUucjmMI8M92Yu6zOjQ8LCqb0cPzczx9z8AsqmTQK13rGomRB96yC9XhnIuhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9lFgys8sEcMQWQ5jKThr/7wan3B2UAz2sRM5/eCby8=;
 b=kEyYpYXLk7dS7Z9il9eDzfrwZGGXoX+WCRTFcpTBJW06dr7+iZ1Fm7Xhk4TyPWEsyDV1H3qJPVYiiZzPHHGO7iMnRDnbf0dGg5iw6zfKtP83dUev8ZN3eOSXYhpSpxFF1v/Bc60Qyl2xhhF5KSgbQAT7jYaI10CpGtgrWI1gtx4=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 13:48:00 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::34) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28 via Frontend
 Transport; Sat, 21 Jan 2023 13:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Sat, 21 Jan 2023 13:48:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 21 Jan
 2023 07:47:59 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] pinctrl: amd: Fix debug output for debounce time
Date:   Sat, 21 Jan 2023 07:48:10 -0600
Message-ID: <20230121134812.16637-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230121134812.16637-1-mario.limonciello@amd.com>
References: <20230121134812.16637-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: efa1ef5a-0a6b-4f02-8aac-08dafbb61c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oPfASB3SZNKqvDtkSWRzy7HnFEiTlgin7te7fG9ZMjpCWB3u9e+C9x5ifIRjQQXTYiK8wB3M+YCqc2v3M9f/lTEkOBm2Hzycm7eBIZyfAx2QUe3LTT8Fsw/Um3zlCFUVJBKfI6liDJk1p+ZNk+NnEJVA76ifATNg8R4cvAf0+pka2pMW11URSg+1ZcSU90mvTKMeWY9Ir4HGFfIf+pYBxp4C+EYd8+Z7OC0ea//ZcMiL5BkihlU4wUqFWhVqoxpLKPRNpKzB3JjJ6dJZY90QP6Ub7UHfpC3CJx2IdD9CFbjAmwPmS/LqqirWMT9F9EV8Bf/sX08vscVzm302DbKJi8YcYtJEnTFpuCECksTisNQc9GVjggoeFDCI5ENP6ckyQZAXCLW2EELV2UCB6kpk1SnAE3h+Fp1xZoe+GEuodG379/cuAvNFLWuVMYztOg4PguaqCuJlzI6aBOrTkaTw6alh99A2yieUVX5jvIz6CzUE5V39BmXgr0SEsJWhmCwY8eO+JoOKM3DPvkDVS4rIZ182Pk7fTRNG/c0ak8JVukYIVGXfMB3Rrv/6SyASTQD/S6a6nHjI7NHVZ5bRcLw9G+BqucdwvYQpfJd6VFfzSw6xvSoOh9anWrBzoPZxIDHSRitp9EqLVdOqUb+bZhwRw/hw6kWV/iqKayJO1VAf12Wvjc8HBkzYX1slcciX/KaZNcOi28/DUcDDSPKL8MZ1WV9FZXZhMjFajd2wFoh/RI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(44832011)(86362001)(2906002)(40480700001)(4744005)(70586007)(70206006)(336012)(16526019)(186003)(26005)(41300700001)(4326008)(8676002)(1076003)(2616005)(47076005)(426003)(478600001)(7696005)(40460700003)(316002)(110136005)(54906003)(6666004)(82740400003)(81166007)(5660300002)(356005)(8936002)(36860700001)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 13:48:00.3008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa1ef5a-0a6b-4f02-8aac-08dafbb61c5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one GPIO has debounce enabled but future GPIOs in the list don't
have debounce the time never gets reset and shows wrong value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9bc6e3922e78e..32c3edaf90385 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -365,6 +365,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 
 			} else {
 				debounce_enable = "  ∅";
+				time = 0;
 			}
 			snprintf(debounce_value, sizeof(debounce_value), "%u", time * unit);
 			seq_printf(s, "debounce %s (🕑 %sus)| ", debounce_enable, debounce_value);
-- 
2.34.1

