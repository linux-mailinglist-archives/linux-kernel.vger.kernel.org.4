Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DD600E78
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJQMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJQMBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:01:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B38402C0;
        Mon, 17 Oct 2022 05:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrblE1KA36o3k22Tk/7VTrg3h3nkw1R7zFFfKq72frACo6zouqlRZ8Em8sJYDWCuuWA7i2SqFOAieMZM9eVdiIleuWibhvYKqfUQ4Bi+qvFDkEvFjFpdIu4oAkyfpvV86nwJ89zXAUzHZX11PxMmT7H/LZRj7k1Ka94AKWfbdMn5TGkQMpvStyq2wrNaR0sc4lFn8UrpYwjwPo2opHHzKWx+EF/vsVWQTElS7B1m2zsZypaN9/6j6DVS010q5dw9cjky0vV0Pr5DkfA6sFp8v/eRyhEydxIBqV1sCwcprQsDdCk2bAiG/MIyFE8eOt6pDsiac+KBSCkCzTqTWcu3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW6MGak5wVW/gsGOjv+UoYaSYBjqCnOBg3DukYJGVrE=;
 b=ifAMjPYPzuzOAxZPIidvvtUrqxx8BCmvrRIqkrXEjdTq3sisthiV6pXjyTZGS+QTJ65vpnEA9tIF9Zj9dnH09UiZOs4lZiH4/ghA5aS7hdWf97FURZ96XLmuV1jbate+oCrRBhS4ofCWM+Q10SlxKe4JoBa1L/6+ryKNH44ZO/rSlIlaTO+ugpEMh+OhaT4Hxudyx1i5dWZbQbbTb/CDs6VSh6RPkdQunxINGKtj4jc4aAXJa1Vi4vHK7flBWGfuSVYx8TkTcU0QhUKmrm6fJ093MS0RDya/XQZ0uW2bKVq/9v8BWnGKeK2uIhGQWOnx4EcINnEclx8tDX+ruMy8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW6MGak5wVW/gsGOjv+UoYaSYBjqCnOBg3DukYJGVrE=;
 b=eXAYuna50WeZ3gleBKnNxl4iBgzDO/298ub5+A0j+7wlZ2EzpV1abU/glCWwUZscnAhM8S5Ku4CPZTcy5fmxXDKBJQno8Vzx8mPskey4s6gU2Hhbzo8wGZnUpb6fnoAjKrNwMcmADTyl7iPUW3hPhDi8ylzd7TAPX6Z06/MPgmA=
Received: from DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29) by
 PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Mon, 17 Oct 2022 12:01:25 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::1f) by DM6PR01CA0024.outlook.office365.com
 (2603:10b6:5:296::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20 via Frontend
 Transport; Mon, 17 Oct 2022 12:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 12:01:25 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 07:01:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 05:01:24 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 17 Oct 2022 07:01:21 -0500
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
Subject: [PATCH 0/2] pinctrl: pinctrl-zynqmp: Revert output-enable and bias-high-impedance support
Date:   Mon, 17 Oct 2022 17:30:58 +0530
Message-ID: <20221017120100.21549-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fc7ba6-da55-45f0-452c-08dab03750ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XH5W+J8UJZJqMFxKlKQ8jY+gpwDR8lsoLf25Pjefbp2Ou9e2IhdWWNNGqOySWP9ZE/Tnhymxx5UnNzZWgi6mo8bdwW5MgyxntQ453z5JyERBbPWdBmzKEe+jobfITnITB/MLiXhscdtGj608jjVyBkwOkmQAW8fibPlLyGop+Q52LWzFnxPXmMDXASmJWj4R6D32lDMA8ylfW5FBpiqNGVXdJ8SRuB/erNCO2nok+yVcDtpxg+dzgGy6kD1Na9M94GcJVOjOVzSSt6GI0ZZgN1vEKUWrV40MUZaRY6Y8pBSOdnB8k0H0C/mx6ugpcCOYpv2xcrDN6AfjdAMBAT5F49XDbixUdQaSXetZJodOPhujqlP2VxXfrw/o33wdxTNCWc9v6/qaBJMTtrFVxz1clDwEg8fxp4defMHHSnsdhVx76ARX+LzTYQIix4P0F4dVDIK1agRcHw/6IgxJNBMvhR1uCWVhwdfwQ+55MJz0sBV7MGNTvCOSElvhuQwphrOxU9ZKnk/Nrp9pHpIPxzGXPYPAZ2Qd7uBJThzulUF7gEnD6nvEGtNSGwd0HdGWDZ0nkyCJFun0G76BUyU+qcBSmtxzw/HE3ExHhpI17ttu9kQWjPkVK0NOPLOzM6+z3AQ6GKB8+mgvgVKJ5U3P5TI3H0zNqScDarRg+u3rLS6Gp7ZRPeG00ntnxyMAogH+WWvGD4lP33U+UwDYdT8ZkrT5bm40hymVJw1nCVty9lnc5Bv0+LlILk5nMLbt/LcBnIHluGJgu2tqCEM1H3LgtB7ZekXwVolg+Crd325LUMl2dxezhHBupTi3Z/3h+gzouwHt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(86362001)(2616005)(110136005)(478600001)(4744005)(40480700001)(316002)(54906003)(8936002)(36860700001)(81166007)(70206006)(70586007)(8676002)(4326008)(82310400005)(5660300002)(41300700001)(356005)(26005)(83380400001)(103116003)(47076005)(40460700003)(426003)(82740400003)(36756003)(6666004)(2906002)(186003)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 12:01:25.3047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fc7ba6-da55-45f0-452c-08dab03750ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
X-Spam-Status: No, score=0.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having support for output-enable and bias-high-impedance properties
causing system hang with older Xilinx ZynqMP Platform Management Firmware
because there is missing autodetection feature.
When this feature is implemented, support for these two properties should
bring back.

Sai Krishna Potthuri (2):
  Revert "pinctrl: pinctrl-zynqmp: Add support for output-enable and
    bias-high-impedance"
  Revert "dt-bindings: pinctrl-zynqmp: Add output-enable configuration"

 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml | 4 ----
 drivers/pinctrl/pinctrl-zynqmp.c                         | 9 ---------
 2 files changed, 13 deletions(-)

-- 
2.17.1

