Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF9600E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJQMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJQMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:01:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859ED2E9CB;
        Mon, 17 Oct 2022 05:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKntQqdvAe8BTp62EXLmeyojwYXe8VuDir4WeSZ3jOiOEDd2OtIXXdYqx3zNHsUnW7gfYALlw56B5Qiv4268pEYshoQ1wXOjYHirRJGhJyeW6AHDN3Uzjed1dNxYiI3nHEk8T7weF9d0gfUU1lufWta8C/B1FPXuMrsaktVDLzlwRwXzLViLekFVlRPcl0Nb5sfy1FchOCrJ8Tz37+bfLH9yI7PmbKVHxhtHi2bdy8cs9uBgDFpZ6fk8Pm7tRSnTJZmlkmPN8lpbL7zzbzXxqTubH+8ePVIC3M81x0Xx7Mfmel9kdyOVSs2rXIlPdlzLvPf4jIozqDLxi9Tiwv/Y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STz//h8icKXeTM5/Ar1KcmkXKVEvp2U/tmJ/N5BxPsU=;
 b=RdR/b7rPcuL9782SCUVGKwqLhGsVOWSkhMJ9gB/NWQynvwUNWa5inZEaAuoc1y96QFeUDkJailL+3C0BGzxEzzhARqYS/7ORZD+KkptE+npy6bBGzU81/EI/Ad1RqDQLmEKASvBH03qdtIqPY88ra7jRXpMJ8EmylhyK3lgNJrp8Tu0ZFTbW9zTvS57aGgt1ASQ9wHYU012/KM0MEDSvWguWiNT9tyAAoSSIb1jWq5V+WCUAsLxbirnyWtpygiKT9AZqRQIab+jzOw1GdoaYH/eFecUOrkATZS1Zzc2qEe3tmpkvBv1ZL3ajhooiwu/2M5BSa1YbCU48IMWSk7Z4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STz//h8icKXeTM5/Ar1KcmkXKVEvp2U/tmJ/N5BxPsU=;
 b=Z6mzDHCZWPra4e16BiYQPXu60zdqD6XecDeIPBeOBIP2rs+uX1JuWWrtF0jA51zkQ/7nP4sYrHpGjPjFvcEUgH0QZ6tj03mdA4G6dOZIAEhxVKweeJW4XcnqFWQkK6ieygB4Oc8g1hoUNfTvjPrnCt7sKMFsguveUJKN2Rswk4c=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 12:01:28 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::ff) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11 via Frontend
 Transport; Mon, 17 Oct 2022 12:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 12:01:28 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 07:01:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 05:01:27 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 17 Oct 2022 07:01:24 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 1/2] Revert "pinctrl: pinctrl-zynqmp: Add support for output-enable and bias-high-impedance"
Date:   Mon, 17 Oct 2022 17:30:59 +0530
Message-ID: <20221017120100.21549-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221017120100.21549-1-sai.krishna.potthuri@amd.com>
References: <20221017120100.21549-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|CH0PR12MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a88660-83ba-46f9-e23d-08dab03752e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRZP9pPANr8cW4sOUO8GahzOl8H4xygNmxwD0KVTwy9wtT2EIOQz1uX8eCRNmFh/2OnPt/4Slmi9VF6zExnwHWXc3Ss00QoqMIQUgwlyA3oPv1hqQGlNNNduv0bIdf0T5gj3QI1oIJqFy1xilLXVed2eRgEnxJammEgJkt9Y5B7HEZKlrUN//a9CeUCqvMDYdbpalbs8jzPpTi3TQfXSM2W2N6a9eeJepdOIxDY4u4TUgZT7wr0DwjA4tD+FQ+AWGttNrRhbPKpesGa3ZIbtX2QrswxNgURUDSAG7UQuP4zY0fFxv+OLvurcFK/HtJPQ8dHa9/mBDhoYfO3W1ar2xwbZSzo81xXHst6iqm7f0b3t0zxzGaeHk5Dyfl8gP9iiY3WQsKqJzxg7hM+21E1/vjhRFVHC8MrPwNyIHysknLUr05u2+32f1xpWE9QI38xpQXLYCNXBGCY86gtVRIndhPeDRZWbPeqO+oOouJzWXyN3wT9NjkP6vphmyKRdZS2lOqtL1tU2Nm+6aH7cmH9luG0beXWxo+M3NACBS+pPCMvZJEWhLQ+iTuu4IVCfdoJ1x9YmXnqB8jCjS3gyxojKJ4lBcru/7JEsxpIDlBAxDFuUCr+m6Xs+BjCethZnlk1VyKA1eahjVC+4RY5RAq7YOMnJF7ftZ8ba9XwaTJo3VNXq2jnbdP2gzXSpbMQkmOjmgrhE0E2+Xx47UoW3V4AqG6FwdWQbnR60ANY/kHuBZyMPAYky41JJ1ZJqRkcY7L8JQ6QXRkwbqLBLVeMXdlAhHivOrQn2lRCVeMQgVpLdVCc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(110136005)(4326008)(70206006)(70586007)(6666004)(8676002)(316002)(2616005)(1076003)(186003)(103116003)(40480700001)(86362001)(47076005)(426003)(336012)(83380400001)(2906002)(40460700003)(26005)(41300700001)(36860700001)(36756003)(5660300002)(8936002)(356005)(81166007)(478600001)(82740400003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 12:01:28.6118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a88660-83ba-46f9-e23d-08dab03752e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ad2bea79ef0144043721d4893eef719c907e2e63.

On systems with older PMUFW (Xilinx ZynqMP Platform Management Firmware)
using these pinctrl properties can cause system hang because there is
missing feature autodetection.
When this feature is implemented in the PMUFW, support for these two
properties should bring back.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 7d2fbf8a02cd..c98f35ad8921 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -412,10 +412,6 @@ static int zynqmp_pinconf_cfg_set(struct pinctrl_dev *pctldev,
 
 			break;
 		case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-			param = PM_PINCTRL_CONFIG_TRI_STATE;
-			arg = PM_PINCTRL_TRI_STATE_ENABLE;
-			ret = zynqmp_pm_pinctrl_set_config(pin, param, arg);
-			break;
 		case PIN_CONFIG_MODE_LOW_POWER:
 			/*
 			 * These cases are mentioned in dts but configurable
@@ -424,11 +420,6 @@ static int zynqmp_pinconf_cfg_set(struct pinctrl_dev *pctldev,
 			 */
 			ret = 0;
 			break;
-		case PIN_CONFIG_OUTPUT_ENABLE:
-			param = PM_PINCTRL_CONFIG_TRI_STATE;
-			arg = PM_PINCTRL_TRI_STATE_DISABLE;
-			ret = zynqmp_pm_pinctrl_set_config(pin, param, arg);
-			break;
 		default:
 			dev_warn(pctldev->dev,
 				 "unsupported configuration parameter '%u'\n",
-- 
2.17.1

