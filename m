Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6B625821
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiKKKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiKKKVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:21:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9859E13F8F;
        Fri, 11 Nov 2022 02:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpMjcnylY1RME1I7aaL35g2/WEnxBrvq3Ru+LiPZKckyvPfyBZEnThsXk0xB522UTTEtoeMVhVFDt2kwyUxyr+gErI27o3aIah+W/pleSIaoyUD6y4mNVHtwwRquPldXOPI6jiOPT/f8RO4wOaJBZ82hTr0f34LGOFJPQUvvzAmOFmlzVvlsxZW19TiTpLFXZ0EI9N/2DDYEXwGCo25lYhTXt4rjYaPfLpivC5EBN3HUQ3o6dSZyayaySvHR30JRB2gPVO5vmTZFYJ+huCkkTTRa0EzMsOGa8FEvKHdtGva304YcmyQusOWcXMcG8782A3omZL6ZSAIIn6lDjOQ91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pAtFPgvHnO2SjScGb+WcStiNW+rvjoDKiE7Cz2zFPs=;
 b=ZFmDYcwFaiiD/HUUwJ4ZHsp6minugVZnaLL+/q1vbXIiSZ+dHcVwtk/8EhmEMX7lovj8rPtvo5YoVtDJ+y5rpXmTHpFpv8WOF0w5tF29v9M8rfRvgaHDkvT9cIpwtz5CE8E4XgWAZIb5+290UMlJ9TAaSx9L1c5gqABAEHfYK7o4lgd8sOo8gNnemxZfEMC74VjKb4mUG1Rv2dvhbs0Vyi+JvlRDIlIRErP6Gsl/XgccAkkKsDeeCo/mX2C8JRIVdixJZlsDPdPv5JUvZ8r2e847avJPVWM06RRaq3PvIS1ERuLOxjBM1Wk8DjeTpjtix4XSMnp1SuXM8+H2d0U0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pAtFPgvHnO2SjScGb+WcStiNW+rvjoDKiE7Cz2zFPs=;
 b=Mk7Z37IlvZzPS60nXJnaCVLMhnnS3H/jb/uB87YYkqwwWZeHyGm2V7mJt+WbDpFcLZVvMKXzF7n3PuXeyUkHbz6pYBTxReBbNaToqKJ/ZJBa8add2sJoP7WIFqXLOnU9CSoz8C1F7s7FAkxuM4c64T9JUkFSrm5F/83MF8RzW5V2gm++hySZUmcz8In4gVDnGll8Nxkr1Zm8mOR50pWF2cOQ+1JbC9vfaWR97wLMq9jLmnv9pwXaRl2o39e8qyUvoLjwaUhOAouiudhc8hLbM9STkSOJrBy0U6CwTfUayCyP8nLoeCU5py+4+/w0dMqjYEeErD1MwgqIiCj6M1gi4A==
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 10:20:41 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::2d) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Fri, 11 Nov 2022 10:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 10:20:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 11 Nov
 2022 02:20:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 11 Nov
 2022 02:20:26 -0800
Received: from jilin-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 11 Nov 2022 02:20:24 -0800
From:   Jim Lin <jilin@nvidia.com>
To:     <thierry.reding@gmail.com>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v7 2/3] xhci: hub: export symbol on xhci_hub_control
Date:   Fri, 11 Nov 2022 18:18:12 +0800
Message-ID: <20221111101813.32482-3-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111101813.32482-1-jilin@nvidia.com>
References: <20221111101813.32482-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|DM8PR12MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2f8fe4-bb29-4969-4ccc-08dac3ce62e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCwrU3hckzTwNeZGx9wGcuuTYE1FdEzF9cNQFXAzZUlZVhteNw+8l4MgQkp102uS4q4tfVXB/LLTL3v/Z59f7dJsAxRVsbh/V8gzAxwe7eUE/BjWcwjJ0cRXr9r0PRpuAg5TW7TzNB57CvvSmQ8v5GUBtJz8wRuSYF/AHkd558IMyI/NBD8vlAbn/MVpS3e8Tt9YFjT21tFhtdlazcjVuln8ZetF27Pz7vGhbSCKrYVKFw6yiw04HgiTfJE8euCNQT7fGfPJyI6s7g4rff88QchbvjL5hSqvs4NX7zqAOgd+2YngOp+ZjmO9w2e4EOwwHt75kOSZb9vTX/eeSc2f9dJ5ZIbgRwNUW1U3Xdgkm4lyZEEJJRcpH4ivvNmgpssnuB56NYex2ygDnMDyPXP/QAUxy6coPa4G8RdU6cglRVQcptdvLS8T2keLHf0aiVFFhrDspSGCG+KP8d+9Zr9q9tcOHbVJcelfF94TnCz1CWNfkdLwSB87Ln+SOrCVPLkMpKkNoOeqdUXthExQKyjQLoDqEaE7i+TuZMA9t1ZC1KPRWjWAAIUSf9Z2jRHieAxx8hZwMVPhgv3FQaHdEO+1MYw+dyzrrFQtfA+vGLSx+6+iRzPcsVMsWF9XT7nd+HMkw7pu82Y1gZeh4U8wBb8lYl88BByzXjgT1sPvIbwcVrz1b0GCEoX6svB0EmDBE/Wnqy0RIAGDwxxixDfItnIS1p9/X55oyNtPYdYMkGzJEr+QymSI9jtsLLpLexgZzT2blNvw6FStw2FW9gZay0EbSA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(316002)(47076005)(6636002)(1076003)(2616005)(426003)(336012)(186003)(70206006)(70586007)(26005)(7696005)(6666004)(107886003)(478600001)(2906002)(86362001)(8676002)(40460700003)(4326008)(4744005)(41300700001)(36860700001)(82310400005)(36756003)(5660300002)(82740400003)(8936002)(83380400001)(54906003)(40480700001)(110136005)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 10:20:41.4164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2f8fe4-bb29-4969-4ccc-08dac3ce62e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XHCI host drivers may override the default xhci_hub_control() with
their own device specific function. To allow these host drivers to
call the xhci_hub_control() function from within their own
hub_control() callback and be built as a module, export the symbol
for xhci_hub_control.

Signed-off-by: Jim Lin <jilin@nvidia.com>

---
v5: new change
v6: modify commit message
v7: change commit message

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

