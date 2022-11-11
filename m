Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF98625819
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKKKVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiKKKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:21:32 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321DD13E3D;
        Fri, 11 Nov 2022 02:20:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eud8nPScSclxDOJcZS8tI6mH7XJQZFmaKlC5FP9TRu/XedHRefgcwiBF1XKicZEXse6A/OmHiMOmjTuG8i0GUXxwG4Isitrt0KlH9FfcEH2twcDjFO6Z4oOo1iLaOBeuMWWHV4d3cv0AhZfrKnjFnAblGxyzY02b9K60Fx6awK7L26AUlgx68rkpwXL0TIxhUlBl/obGYkgOTuGBo/SPm1efcZ+Em0eJ4mmm3mKMHvzx5EriLaVmSEGNoMXCJElK/e4JEI4XysHL1k8/RndPCFD1tZjdETn2PRJhjG8AkFBpgO5N7NEcpQpkkwSaohfyCHrf03adqb+MuAlKTVItNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e16U+KjxKRs0sqGQHj2L0rsHXv4IZExtK3Ryb24EgeY=;
 b=NkST4LGaeP9pf5ctYMeVhqgyXe9SWrUf4Q8Ufcy5HbckcPHB3SjPVQLPcPFenuAXEEwQNPSiqHnGakYTyHUlBTDeFpxTScLYItKWAxAzjamVHcPsvvnPRumBuzHk1ZHsLS1cw1N1X9yolOkcM2rn6sqvOikuKWSE0Jrew4e27a4KNr9W0/XRmc1P/QziVMKE6bDjQFNGi2j+CMn7hs221CBHyw3SI1zwxWpEQ5s6gGgIdfpjkD9XockyIYXBJObaHGLzIUOHwdnmxDktOM289QR8MBhEwaAgTt8x626wVxVq3YV7IPLLmUnvgeJhRVTNCk6c20Cq6vJv7lJMgErecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e16U+KjxKRs0sqGQHj2L0rsHXv4IZExtK3Ryb24EgeY=;
 b=hc3YuF31C9bTpQ6kuvKLYrtvseOROZ12qTNMxAiiUOne13mnOSAZtIrXbhDYipOOjccQFLSFO63tmLT7FYu3vd5IOJtA0EkYgM8vL11wmQ9DbrQmnYzyyAkY8hRVr2JShyy0Mhhx89ilkHFqR86sWBtevYAfLWF8Y8/d1MJP+LYK/hgJmbTq+GczFokao+JsYdewy4sf2L8a1Rc+J1ebcpQRSiNskXpVciwB+6lKpuyDcyo97X8jLmQHSD0rOuL2uUmnsJzpCXxWWOnQAdh9IyzqtOzRg56rYYY8pp2fPa2lS3c/m9RobBB0bNPjZjTyWij09omcBjD45BQWQN2fgQ==
Received: from MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 10:20:36 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::3d) by MW3PR05CA0028.outlook.office365.com
 (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.9 via Frontend
 Transport; Fri, 11 Nov 2022 10:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 10:20:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 11 Nov
 2022 02:20:24 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 11 Nov
 2022 02:20:24 -0800
Received: from jilin-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 11 Nov 2022 02:20:22 -0800
From:   Jim Lin <jilin@nvidia.com>
To:     <thierry.reding@gmail.com>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v7 1/3] xhci: Add hub_control to xhci_driver_overrides
Date:   Fri, 11 Nov 2022 18:18:11 +0800
Message-ID: <20221111101813.32482-2-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111101813.32482-1-jilin@nvidia.com>
References: <20221111101813.32482-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: a8db617d-4ee3-4129-b0bf-08dac3ce5fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijwyOiIerL7vx6CH5wxN309C1m4EGkZ4+NQqCb9P70PPIpIdtCD+V1uyTGsivpvnVdIlsVvHyxPVBF66keUsM7QZG9ind5evldPv8pEckymDAa3cfzuJIzEkjvw9/ECxtdPH/Z0ZIa7GLSTw7FvDMe8hLAlduTTyq3sWIno1nCG85Gc+cARl8JEiWHK6u8oK+3DUKPzySujg0RbBDco2tm/RdzTCIXpO8X6dMTHfzpDFFuWmEqptmDKbii2ibaUPpI/f4PGiSyk3txIakV1vR72b6EnGgBE0cU+RpdobN66FYQv3wDxv5SkfwfkBRVESy/3bOEmiVq5CNg8yurXfYw7O5g4Ra/af2xBiQn2UA6U6nx/rNuc2TeF8c1EA2UNTPrxXERE9gvEb4hOUHGbB7uTr8aI9YAzz2D0zFoTf/idfoDs6z8Zkso6cHPY4xPtmxNnOuUyc+gSn994DGFErsU5raCiZjMKDT9HOpTolM2aBE/CiN7hDwMd4a9cdsmFXhmFI64Sx4D4cml+66yf9uIyT7hGJnVVP+oM2SzDtO6FIRfguwF5AY9Tmy3Hh/+dSIy0u6EcPTFK2NVx9H8j6MDKNOCtdDpOmvxblJoxr0k87Wlbst0RSKu9dh+VR2hwZKGMzrX6yx8nd+tmibA+1JnrlnPQ1JojZc172ckjJywCSWRV2K/OFkqHjOaxxzW1ft0TnAo3VNnufk5+RofYecE8fQts/XZhbAW2h8Q0tVqzh72hJuVWViU1THl12BVu2wGlo6SyKouS4aMbXfiIRBw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(426003)(2906002)(47076005)(40460700003)(8676002)(70586007)(70206006)(4326008)(41300700001)(26005)(36756003)(86362001)(82310400005)(40480700001)(82740400003)(6636002)(316002)(54906003)(7636003)(356005)(110136005)(186003)(2616005)(336012)(6666004)(5660300002)(1076003)(8936002)(107886003)(7696005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 10:20:36.4124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8db617d-4ee3-4129-b0bf-08dac3ce5fd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hub_control() callback to the xhci_driver_overrides structure to
allow host drivers to override the default hub_control function. This
is required for Tegra which requires device specific actions for power
management to be executed during USB state transitions.

Signed-off-by: Jim Lin <jilin@nvidia.com>

---
v5: new change
v6: adjust parameter alignment (xhci.h hub_control)
v7: change commit message

 drivers/usb/host/xhci.c | 2 ++
 drivers/usb/host/xhci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 902f410874e8..3c7bf0a0e0b4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5461,6 +5461,8 @@ void xhci_init_driver(struct hc_driver *drv,
 			drv->check_bandwidth = over->check_bandwidth;
 		if (over->reset_bandwidth)
 			drv->reset_bandwidth = over->reset_bandwidth;
+		if (over->hub_control)
+			drv->hub_control = over->hub_control;
 	}
 }
 EXPORT_SYMBOL_GPL(xhci_init_driver);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 5a75fe563123..f51b674fc10c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1943,6 +1943,8 @@ struct xhci_driver_overrides {
 			     struct usb_host_endpoint *ep);
 	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
+	int (*hub_control)(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
+			   u16 wIndex, char *buf, u16 wLength);
 };
 
 #define	XHCI_CFC_DELAY		10
-- 
2.17.1

