Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4715866C496
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjAPP4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjAPP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:56:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB9E396;
        Mon, 16 Jan 2023 07:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoe9yD3zubIMnVGhNTH1MXpRnNlQuswCabwK1HR35TQ0XLJqgDG9M324Kxqu2jNP2KVjejH4tu6lHNYqgGzKmuBPDgaP8XVNOKS+XFXJ9qKlqqrUqykwoOJZqRTXtzZO66E+X4uv3ZKev0Lq6ybwdhedSEznvBuvR5hwmECJLmbLcGlR9i+nLjgpzyHEgk4eRjOnNeiJfTIspAnS7iCFEcYUoqitQvGWuVO2ZWkiCDlT0B/6t7pcYMwElauQAMthdmrFkbR3AU8T9Fu/o6qnzKjGJDJ1SCoEGsYIVdpT5mjzZl6OuJM2TWHELOyiDq3qIZ7N4r9wZzdrIQqcGxVoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3t1QreyYmTpM8HnHUqYPFD3J63MgZtnckuZuuVaVCw=;
 b=LBkFntueLj50JC9NVHh/Dw1Xuo2C7/3tBn487n2CoiAYdmJpWRf2VtMJmfcy2eTjiJlBVmeFO3LszWsxJgEqUx5mseKibR/DjA8mqvFDRo+f2gr9NiuoWkhM4AKPv3RFg2eohyeBX4uz1msrr5c/iahk31J4PhxiGH7/7R8wfsHK3vW4fNDBYePEvtGQlHQ6FKRXfW1AbJgbxoE2qWwuFU5RhAIc5tfM/NQ3j2infY8Dz4xFSiGJlQA3snGquD5aJlo/hc8Pmr7PURZ2/MH+nxjB9+yrmws7G5zjRfeNEvGhtemq8npT6HZYZPczdkpDv916OyDNIzqqX8eIkMyEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3t1QreyYmTpM8HnHUqYPFD3J63MgZtnckuZuuVaVCw=;
 b=SU90INM0QruQF8hQ2TPGFRDMP5LSa0H2j3JdoOxps13N4zveEdo22seh0sPXbk1XWFkCnI4Fls+P5qzaE0sUeWldghj/82EdvoTPgBjGQFeBaTFoyYSOpiLLfTQHLdWM8oTTF+wsdHQkCQngjgEpeDGuBxgSl1ku+Jphr7pS9uF0FLoPbkcdts1ZGHmnH5gUMf7u3OoaksS3bSeCLwCUt6V5QRZUj7EPxUJB/dxATFHhOCvCdfEqB+F882q9yhmUF0dOIsAycoVCr8PLu4SYVenX/bzo6VeXAeDcl58GOZVtxvOZBL3yLCljHr9NKF1FI5hvS07RQ3iNzaz6oG7u8A==
Received: from BN0PR10CA0005.namprd10.prod.outlook.com (2603:10b6:408:143::19)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.21; Mon, 16 Jan
 2023 15:56:03 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::f6) by BN0PR10CA0005.outlook.office365.com
 (2603:10b6:408:143::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 15:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 15:56:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 16 Jan
 2023 07:55:55 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 16 Jan
 2023 07:55:54 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 16 Jan 2023 07:55:53 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 1/2] usb: gadget: u_ether: Improve print in gether_setup_name_default()
Date:   Mon, 16 Jan 2023 15:55:44 +0000
Message-ID: <20230116155545.101391-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: c12126bf-1c71-4112-9784-08daf7da2b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mk11Z8hLyWnLA7cPRIzERRqWBu0snPV9lca/FMJAMonC4kV3v2ifTdRc6hJuLfLN37CpfauefJUDHoV09uJ1NPjwd+GqaWAeYLZ4J8uKw/9yS2Jk3BF3P2GBGSbVm1iqG4ZS9CuzM6hLN3rzNReNaIZmua5Zj/jvDHexqkOg00Qyb8rMFQRnG9ehCylB9fB6aGO4Fl+2t29flrw2TbJIPlTkbK3U4Jdf3sM98p+HwlyRp6GNg/2m7vV3nh9eLM/DXN4JLgvhOm8XMRH9BhbR8hQtSU1asyCFr7Okquynovvn8HMBX4903sW10joAfKj6x8IFloFSZlC5IsTZ3ywUHL36d93DKVnzkPR0djFfLuGbsFygDaQRL54WC3nypx+6MefETng/Wnbr0xtDCi4WiGV+ovcmtZ2KudBIzzwSddeKX0nevt6kIbwIc0kVikcJlI6jYxlJxAWHK/ekX374b5yvwYbkLTveV6aeod0axr3w7d5TbeWEuSzM+201gvzHtw671J2Oaxt/uoAMFiP5RwMZOgzcaEdQtbwxqxh792Q6RJlWSflYlpc0CwJsvPfKxZsgGdAGBqeeqnChNOSR4ZuctM/nP1N4sJZ2an9nqXcSSOh6otESp6xnJMISArqr+YTuB5ru0al+sCKdedGqReoxNs3xowR/i0KaygClyIFhC+oQCC1A5beikGbvLsxETDpllvZthu5o8tY5WkaI8A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(186003)(5660300002)(336012)(86362001)(426003)(47076005)(2906002)(8936002)(83380400001)(70206006)(70586007)(41300700001)(1076003)(478600001)(6916009)(36756003)(4326008)(8676002)(54906003)(7696005)(6666004)(107886003)(82310400005)(40460700003)(7636003)(356005)(40480700001)(26005)(2616005)(36860700001)(82740400003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 15:56:02.9658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12126bf-1c71-4112-9784-08daf7da2b8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print in in gether_setup_name_default() does not provide any useful
information because a random MAC address will always be generated when
calling this function. Rather than removing the print, update the print
to show MAC address that is generated which is similar to other ethernet
drivers.

Finally, given that the strings 'self' and 'host' are static we do not
need to pass these strings as an arguments.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
V1 -> V2: Added this patch

 drivers/usb/gadget/function/u_ether.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 8f12f3f8f6ee..be8e7b448933 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
 	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
 
 	eth_random_addr(dev->dev_mac);
-	pr_warn("using random %s ethernet address\n", "self");
+	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
 
 	/* by default we always have a random MAC address */
 	net->addr_assign_type = NET_ADDR_RANDOM;
 
 	eth_random_addr(dev->host_mac);
-	pr_warn("using random %s ethernet address\n", "host");
+	pr_warn("using random host ethernet address %pM\n", dev->host_mac);
 
 	net->netdev_ops = &eth_netdev_ops;
 
-- 
2.25.1

