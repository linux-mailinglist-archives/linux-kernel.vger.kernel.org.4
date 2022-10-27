Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E405160F912
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiJ0Nbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbiJ0Nbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:31:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78119172522;
        Thu, 27 Oct 2022 06:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4Fi3bLRTqCgEkxjJ4CyOJglMO2ZUjZWBU2pWgSHMiLsobseMbdlIQVE4Hs8WBhBrO6h5mnjxg4pMdX3P3zMly5X9x8o5YtK/xc79YF8ONIy/DPcxfioayRH7sto3wiVBM6IrCugWjhHmQ9sOSl27yNpBul6rLBTaEwKTapK263KPqre7S93Ctwmmwukwx8Ys3/SVnxnnS74Rb2BcJ/ge6u+4yIZ7g4bc6SIHjeeoTk7uwd6QHV4tksBxp5Rwa2tUfAjwkvdkU1k1QvG4dIlQFR49IDiPULh0kiWG0Yf2r5eS82rwB/w4fX0D0a5H+OakDuMMKWQ9a3paqvenQPGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM/A0WIH/GzkFxF/q6myWG5gXkuSF77TryLzR39KYc8=;
 b=Pgjodz3W0ZxeSEO3B2dohD563u7LLxpg7/WfbjopN1fsCQj3MYHcZnd/YSa/od6H8SsEtJq7XtqpWiUXMZvk+Nbncn3NCieaKqPWZEvArDk9hs4MrktiIzDM7bJgjTtbHa3RRI5RRPdg9oedx/dUjtALSgHYfm8pGmsZoiOUXWTb7R25O0LnMO2J/4C33ZMD7J3qHdKbUx5wc3meHg0x2mxD4oJyj6GiRdHbgdI6hUuTOlQjehMN/YuDaNg52NTNiXn5yYTkh2tXeSnl9ZRDLTjPaUcYiLEgzf0IcHHiOQEI3WAFRt0hX94ZfLdumuQ7UToAzJOjAJHD9lcvfQhUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM/A0WIH/GzkFxF/q6myWG5gXkuSF77TryLzR39KYc8=;
 b=tWn7D4nD1+1XxHiOrfcC1qw1flHiZPgJMhIYypyjZwYpeJVg0eJG/aXjW1w9/nhR4s7j5ceaLreS7bkzp5wit6x0EqbgQOpcu5oW22NmSMJBT9i3+V//Dt9TB7rAP3rgEB1Gq7SRN1dzRO4lba732ZO5O7/Rt7UYlBuhC3QaXY1pj/LlH4+u2wGyesa3LFtICgBOGJbm4WpeBnBdcs47L6+Qrf3JVUBcH7PbiFZFMLSVJhyHvil9weIhQx20zb8LUq3UrIXBSsNd75/Yp+LMP6uXiv6kczQH6V7BVXgbR0EN4j5v7H5kS0kt5w8C97YFdYmp2WhbNmtI1cQgcXZRBQ==
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.26; Thu, 27 Oct 2022 13:31:47 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::6a) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Thu, 27 Oct 2022 13:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 13:31:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 27 Oct
 2022 06:31:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 06:31:41 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 27 Oct 2022 06:31:40 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <jilin@nvidia.com>
Subject: [PATCH v5 1/3] xhci: hub: export symbol on xhci_hub_control
Date:   Thu, 27 Oct 2022 21:31:25 +0800
Message-ID: <20221027133127.27592-2-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221027133127.27592-1-jilin@nvidia.com>
References: <20221027133127.27592-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 765c94f2-3284-4193-5d26-08dab81f98e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpbKV3721apDffIUrdhit8sUJImkzLIGteBIeHlilFSULjllklTpSQyaEwSGPPLrhxtxEWLYZ8rhTS23ozOW7piD4iufIjvl8/LMfhygCJGLytW6NQUVY7RX9EJYO5eEgZOAriwGR5/LB2pmp7fO0Pv4o99vR1JXfilA8JlGSbBYxqqPhMG2w+1dzrQcVZrG3dYIC1AudquI+14DkIQpgX11QHeSiWCHH4JgNOQfiI4mhnzBO7W6LayaxwoU+JhwaKt92fYKKoDthTh6OXz05ODDPhlOVe6BbwyCMdfUSl82p9szUGQrEXwvJEWI9mGM7UoDf28rnnZ//QvALx47Hi01rPiEjo4+NE9gmU8LObf8gIox0IoFutnlrqPH1MERRj1MUvbPpknv9022SPUDDW31J0dFhVV5weIscAH4qYIpszOS8/c6l2+LiuwmpkOL7tTItf9YaUh8Xf8LbTr+FB+LgoPVXsyH/yCIkW9F7iBdDLcWPZsHB1KC1nU+iPc3WAD4SC0fSVmy1TsoCXRr/PnyRLuR4kTbRtjNqObPCDWqLEECUwxM7VkMtKXbPvUkjZC6WFXaIdNsoo2gTzbMVVqj6GfmZleXONTRSSDIJ4vH4CIInr7sCpkvmAMHmRcHraDKvhAH69O+uJsO0P1aAH0omBxdNeDhc6jrLqBx9YnlpkBOPHfrhmzQbL2q4ChG7mQRwWcdOnIagToMsOtN1/BRRa1RWmlowcLhp5bPp8hmYQWOuWOwuSPbSJX4E0nwoiHQNv2Oox2n2nPY64Fajw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(86362001)(186003)(8676002)(83380400001)(26005)(47076005)(336012)(36860700001)(7636003)(426003)(2906002)(356005)(82740400003)(5660300002)(8936002)(1076003)(4744005)(107886003)(7696005)(70586007)(4326008)(82310400005)(41300700001)(2616005)(478600001)(40460700003)(40480700001)(70206006)(6636002)(316002)(110136005)(6666004)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:31:47.3943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 765c94f2-3284-4193-5d26-08dab81f98e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EXPORT_SYMBOL_GPL on xhci_hub_control() for other driver module
to invoke and avoid linking error.

Signed-off-by: Jim Lin <jilin@nvidia.com>

---
v5: new change

 drivers/usb/host/xhci-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index af946c42b6f0..4f20cdae2a89 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1604,6 +1604,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	spin_unlock_irqrestore(&xhci->lock, flags);
 	return retval;
 }
+EXPORT_SYMBOL_GPL(xhci_hub_control);
 
 /*
  * Returns 0 if the status hasn't changed, or the number of bytes in buf.
-- 
2.17.1

