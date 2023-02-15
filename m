Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93269790B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjBOJck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjBOJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:32:38 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2731CAEA;
        Wed, 15 Feb 2023 01:32:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNirhMe6C0x8kSsKY+U/jwoudEl5jtnKQ/wKdanq4V9jFTJ1ez3PwHUtpagj1q2OCecmOY+fQ/v5mVXcvLn2hkR0krNGHyzdQM6oMeLFqqq78yCWvJlSy1kQjXWKERCKRyHa+9MreKHlRU9HnIt4YgbUap5U0jJ/B015Ylsx1exb9ew7nNsdo0d71MPHsgQy0WYjEIH09X+jjyDuenC/SMQ1wmtpMd5yPHjhTFgbmZXnt9DxCMK1F2G8XxBDrks+jWb1U6JawNIRmwT2wzItHp31Wwhf6As9ZZXKGg+misbytNQITxuRji3/4GAuveVuDDCSgXowc2vh1YIMnIlRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81vGKPrQKEH6d3DYw1rWcIYP7MvUYASHHVO9VKDUUps=;
 b=LZptMGTYPlK52dkCMKvXTjDd7p+pKLNQSTuQ3R/1Gwk8zhMAyMAYD9a8QhjbFtU2LV7+W10ipVWJeKHCDbve5OjsIdZzBfnIOcmLdS2WBrLB1roVLuuHAiknqxgmgUQ/BsAGeMtGOOHerF8MmyxWOyZAePXtbHnIcVrGkeo6xcOrhHw96r6jXQqWYtA9TWY/kngIqYugvhwm0E/uEiF4dMenHqw//uT0NdHpteif2WC3YNBu8M2L5S8ga1bWeEt2j4iGS9l+uIiJL+9l/Z2/FeyDPVeytanYjEvVwYAdTPkbXOf3uiSLAQDD1+wJ4CA/JMFemrQjHQtl8jhsmWGZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81vGKPrQKEH6d3DYw1rWcIYP7MvUYASHHVO9VKDUUps=;
 b=VeNm/KprXCBQC5BEIoFSWUt5NNq96NUBMoSNl3ibO8lerHBBMdxcz5tty1IgYYZG5CIlR8i765ZAGJR08/vBzdp2K5ie5gWuEPfyvhwXRBtI4wipk9Zdu4uof00iwLBdWvSdXNS2g0PzKDZ6RsssTbs8ErXG82amXu7VlVQtqFg=
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 09:32:32 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::2b) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 09:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Wed, 15 Feb 2023 09:32:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 03:32:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 01:32:08 -0800
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 15 Feb 2023 03:32:05 -0600
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 0/2] usb: dwc3: core: add external vBus supply support for ulpi phy
Date:   Wed, 15 Feb 2023 15:01:44 +0530
Message-ID: <20230215093146.5812-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bc72cf-698e-4e1f-6ce6-08db0f379024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV082ciV41M9padzMMSET2t7fBJKQWmpq5aahSVzs0PiUKsRPqYiFXXYRIIKjokUQvWELgE0WM98CxUXKgECbDzSYenf4LvDHvL/PUIE11Hk2GqEQNxrFnOXEXrObQ+gCKmaUpoI5CtJ4AhqX6h0paxy1//DLc6Xvc41TO1YpjsV6k6WsdBdl0Rtd7Vt5u1arq4XHKf7JT/CGsARk6rkMDrSeQDYxMUvpRl4eir0E3LGfLMVTmSblQY3Sl0Y/loqilEcmONE6gb9QoK2VJrrVnTFep1ZygcEIeNnWvjh2d9f2lMiD4V3YQob0Q9c/xgDEymd9NtzzLxP4L5FD0A5mEDb8iEkewnumlMn1/vzhxXnlKF0o3VJHDaHqai03muBCpIrXUC49cAE29cwp0AmoR2ANMSmC1idJO6H+YoimWLDIfmPEZGnEklvE02sBHb1Ef9mM25ZDnlFHRvdrIJFz0h+S9nAqGb7SEBKiWXZJdlgV/Rut5nvXz4We+7ns7yus9cOgWW88Zqelgf+4mVr1rc4nV9sXO03WBJQdIKSA3/+YRv8goCczu604yoEdcXJCf4uqciJYVTLqDXoClamoU5GNgvgvv/zBDJqxgoOhFi73TCLhakXnyxvoL4eiqOvB/Gxx9qaCZ2EuJWTHT+IF8GKKZpOa9CjqWflBoB9yG+bEn1M5J+H2PW4gMmC3Dgz2eBCKcCm/eR3GuOol36zwEVO04PeTAgUFgXTKHPbk+o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(44832011)(36860700001)(4744005)(82310400005)(81166007)(82740400003)(40480700001)(186003)(336012)(86362001)(40460700003)(966005)(36756003)(26005)(47076005)(426003)(356005)(70206006)(54906003)(110136005)(316002)(6666004)(41300700001)(8676002)(4326008)(1076003)(478600001)(70586007)(2616005)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 09:32:31.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bc72cf-698e-4e1f-6ce6-08db0f379024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ULPI USB PHY does not support internal VBUS supply, they worked on
with an external supply. To support the external vBus supply for ULPI PHY,
added 'snps,ulpi-ext-vbus-drv' quirk and based on quirk configure the ULPI
PHY in the phy configuration setup.
---
Reference for dwc3 register data-base Link: GUSB2PHYCFG (USB3_XHCI) Register [:ULPIEXTVBUSDRV]
https://www.xilinx.com/htmldocs/registers/ug1087/ug1087-zynq-ultrascale-registers.html
---
Piyush Mehta (2):
  dt-bindings: usb: dwc3: Add snps,ulpi-ext-vbus-drv quirk
  usb: dwc3: core: add external vBus supply support for ulpi phy

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml |  8 ++++++++
 drivers/usb/dwc3/core.c                              | 12 ++++++++++++
 drivers/usb/dwc3/core.h                              |  4 ++++
 3 files changed, 24 insertions(+)

-- 
2.17.1

