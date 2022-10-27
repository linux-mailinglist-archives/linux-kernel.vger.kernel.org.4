Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361E460F920
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiJ0NdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiJ0NdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:33:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69171805B3;
        Thu, 27 Oct 2022 06:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzRN8Nawmwcnb/yNM40BcvDTE5wnFyPYPI2NjI4NacL0Y2a0tS58zf4HEEBQ5DpLv3rOOx5FQ4abQa71rmLVFfyWSG86/19sWVTDc8rwWohV7WQxnxZYrOdMaIXuKDmASi4sKLXPxocE7yPVu/l46Vgb0Vo0KvCbI+ssvYdvQQDBrgEjrZJuM2goFHxK98SwgXLHIy9y7xVLn+Qzo78s1lII4sWxGO2V+0a74NwjXwPw2nolBShnLO+yfYtyeQtutAmwE15d/GFerHclpiJF7n2/t2BiFLaED+ErJcm9CP+ms2/TZG8zPwlEFFSCwPrPD4HRLqh1ommNbSbgwUquAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0mLcsnN9bOL2ZI5/K14w7oV2ubzH+mMbLDegToQKXw=;
 b=ElgLXPYgxEQLwnxBu1OvAmVnu8yU1aRG42en2V8l0sQkpsrXu6yj89Ag1TcgxJWymd0ndwbRuHpnZpoMswYslGos+l0vYuYtexj5Pg8NFYe8dd8Jz+RhB8Mc7J2GNoTi9rV0Vmr8DdIpskEcndvkFHiXhtqOB8M41O9KvTrvnXX3WF80s/sS/B9kYee2ChgkPzmmXPsVaQw8Y1zeygSfZhorlddbvNj3pVHlrxtkOEAWUjV952zf+hS0gbKQH0gNukxJ3yIYIfYwcBECHYnpIvFEPH6ZskTDToj8eHJ2kYA3VZzeAwxH+fUlAVialKfw/V61mmYaa2zaWrzhkFJPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0mLcsnN9bOL2ZI5/K14w7oV2ubzH+mMbLDegToQKXw=;
 b=jZzPZ7KWkF6jxeNPqHR6G+rQjrDhLP7rX6iTZLhs+1HKF3rnxvByjeIV5MBi54oRu9mt0j4LEeHldhDf24exLORmP2849U/7mWt3WjwFv5xim3unNXFq5VXMXsxvPE2lqnY6UoMFAyyb/WmjYXvni676D9nV7TFz8CoIuXWcqgrnSF96XpLE2z2Mu6QosNuZCKfpMvOxydSUJ18UcO/x1QUeevAbnZuAcx9JbfU/hdT+3hjHjZzBLlgGZHuzG/JYMjircEV1bGx47IR4oVbf09aGGMYR050sLD53bVRD+nN6WEWlgnrKSPBUxTg/uil8UpWzMMRo4qHD6NeSmTlmjA==
Received: from MW4PR04CA0390.namprd04.prod.outlook.com (2603:10b6:303:81::35)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 13:31:51 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::c0) by MW4PR04CA0390.outlook.office365.com
 (2603:10b6:303:81::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 13:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 13:31:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 27 Oct
 2022 06:31:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 06:31:43 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 27 Oct 2022 06:31:42 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <jilin@nvidia.com>
Subject: [PATCH v5 2/3] xhci: Add hub_control to xhci_driver_overrides
Date:   Thu, 27 Oct 2022 21:31:26 +0800
Message-ID: <20221027133127.27592-3-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221027133127.27592-1-jilin@nvidia.com>
References: <20221027133127.27592-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6122a134-2d3f-4159-5561-08dab81f9b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzdc/l6nMFZvuM9SArIRbbvf/3TXR9deq7x5E1zeEUGK1Ta5fWyex8RUIJ/1c5d5FyAVGPPfVEIvQkxJU6PrKW2bUXPW80Q/0xeJ0/Ksrh3oypXhsQeBUYcd0P4hvzvffDXqZKWoHp47ZaYDmcIo0/Uzgo2z92gIRX3gQNno5vEaJnBBw4wlq6wpCLpFYoVegnIJA1/WM/EcFYovr1puZ0T7zNfOflYWeApIuHfQr9ECWDy+QDKluMQ87Isb3X4WUWy8IKanuwS7q6aAymqVECfWEfcjbEquKvGIDwiaPysSKj5F038MlaZF7VkL2e0HLSzuEmDK9D4tmRbb1swWRZvP5/0+mcFb0UVsiP+cZCPvtxUe/XLX7ACHlYpz6uy2OgWtPZiuJDU6FM+edeHuzl3fbPQliCt7poSVr1mF4yDyqwvlaXYOfFD/Q5OyMgOAcE2JGC8Wx0sX6vuo6e6lKbEPdnaBd+Iu3tF9ohMIENfeAlxvbP9xeZHnr/9+9jmxk+564fFWUEdFOYhW2/YkyzKfVg3KkRmghzvC3HUHtUnPjKBWRjWMNr8OCamE3B0po9FgeAOuGSdM3k+QD+eJilcUPkPI918hkFp53+VFpH2uJ1GqyqVRROsLgU6I0AlwlyY5KfY7nOtpcoLWOtaCi1+MISMUzl3GrLdrOAOp6FY871eJykNUzfTKT5dDqEEe5kTg/7jpN3o2F7T1T8OkWoO5AoL8TcDb6FOKbu7GyS6TkZfPBOFRh5i/jqCeiQDbgvMc5pnx7t+83rivRyJIvg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(5660300002)(336012)(186003)(1076003)(2906002)(316002)(110136005)(70206006)(54906003)(26005)(40460700003)(41300700001)(8936002)(6636002)(7696005)(70586007)(4326008)(6666004)(107886003)(36756003)(8676002)(82740400003)(356005)(7636003)(36860700001)(426003)(40480700001)(47076005)(86362001)(82310400005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:31:51.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6122a134-2d3f-4159-5561-08dab81f9b73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hub_control to "struct xhci_driver_overrides".
Add hub_control to xhci_init_driver() for platform xhci driver to
override it for local feature.

Signed-off-by: Jim Lin <jilin@nvidia.com>

---
v5: new change

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
index 5a75fe563123..f5a17c75c144 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1943,6 +1943,8 @@ struct xhci_driver_overrides {
 			     struct usb_host_endpoint *ep);
 	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
+	int (*hub_control)(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
+		u16 wIndex, char *buf, u16 wLength);
 };
 
 #define	XHCI_CFC_DELAY		10
-- 
2.17.1

