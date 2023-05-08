Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E048A6FA4DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjEHKD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjEHKD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:03:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247282EB2F;
        Mon,  8 May 2023 03:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWIomfRjrUbypvpdiSmYvjivY2tP6InV1j6A65qj9CN/wLx21bxCuxIFKqVe2Xev9Bq8Jpqay/J3LzMJAJjIELtrqS89IgtdiAO7hnFLH0dnpeS/2D2+03S7KfyU8NMV4bFaz/p1Z/Yry90Eo5huOqXOD9iOUfIPvkrIVbvZk0pB9ekyuJ+Y4e0VYbnRc+SMel0Tg8R+Ediu8R6fzczRunJpC8SaCdSSXU92x3N4w/zzPKZlorcPj0dM9R8QvkozTFG20kLqej4RXhJegJxzF5MbJ23sDqsNCpnfYtJVlIlDtgGCpct3IRku6T4uHU55sEGic1q44XSY9xWBQiPADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdobmPizjgA8c7qq/OQdJI8VgT79WaSn0xDsWl8x/AU=;
 b=Fce8BSXTmRJq2+3p3QmbufCG98RBz5GP2N3aPGz05xJzN2yJVzFQktSArCsPRs6OjWLLQywhfC9f+XSaJ8YNujn4d3sOrLMDJ1IV0KRuUAKgyYkgxvHW0bRTQArL7XBCEJ2RTXk7GcEHkxrV4vPSeNVLKCV3Vkg0HlME52kmlvMIsVoqMkTsE1YqnWxvILMDq2byPvJYSuCxG3UyRZz0KqPqTv6rfHe2lwdJy6qdBVpQB2JVAKsEcHinISeW3civ5CDJZTKZeYuWiOS7Qc/eo8rwN/iGwXjCaqvT9JRn/rA76MDkGZTzHkT9ODHHpVFqfhroyE3QCrllW5C/REOzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdobmPizjgA8c7qq/OQdJI8VgT79WaSn0xDsWl8x/AU=;
 b=hTCVSUR/tGEPCh89Kup1Ut9LGN8Q2j1+cfBCbHVrKpvYJ/pF/hXsUeLgvYkuabl92ZVRG2yX+3x9gegkUuLqbAgoqYS4icjKXWE1BFesOCcn/rzEaoR41u7WEGMr5NoTBKz8tiGb2L/cjNtH+GxgGidoQ7lhSUHnCKXg+dTwwbMPG2w3+ZFLxQpkLGSM5XzN5ySNglZIPIqZyQZDhvjagwBJxbz/ic2hk0IiUlVcGOKx/AZR4K7RX4OZxiN9SoW9fiRaCJQdL6Qg4np5hFlwk6ImS2PJxksEpyPhsL8E2l7loj7eNegJgEUbBPU8GMShi1uveqs1X+zdMTYy1z5o0A==
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 10:03:51 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e6) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 10:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 10:03:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 03:03:37 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 8 May 2023 03:03:32 -0700
From:   Haotien Hsu <haotienh@nvidia.com>
To:     JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wayne Chang <waynec@nvidia.com>, EJ Hsu <ejh@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH v2] phy: tegra: xusb: Fix use-after-free issue
Date:   Mon, 8 May 2023 18:03:20 +0800
Message-ID: <20230508100320.345673-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: bf16ac5f-4e6e-4525-30b8-08db4fab85ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEkp7hRFmzlhIwup7tFOjO6a25tTVm/kbg0vNcuZgXEN10SAb2XUMOT2SIwhBCO3R71wL1+yFr4SwiImaDj5cfXed1d5WaMRbTx8zMZx9hpm+kQmKwNn2GDPmgq+VxwdCf3g7/s9OEd0GfMS1f84B+5RgHpnY3vSbpPWGW3DkDQ9wb0W2gNI2CtYmZIrSpa5X46shG0re+iyFiKXi7bclmMu5+e1TI3UId5RHprYwF6fOaD4HMppSneUqBw+0/ma/qIQTSjdvxVikSmk3oQyD5LgDx0E63ziDqJmMdUjuWel9rGoIni2WDeoWg8p6nzoZSgU5wsQzk5CPrb+4SWm5F0k3mGSBh37ckE2an2IAnKqIgiiM+rfRnHOgeLyrRJZkUby3DzqGiW9ANQLFN/OW4I7nvuV3GIFEFJU2CZhPP5ewNSnkX91t2OUb/5oSXgj/Ca6TRkYtewsF6boDiDM+jaANACSGrxipv/7s79Zr/LgyhFnVrr7HEFIFhGRxIT9qhVVaSwnkimhjOkAAF3jOuU3ZVCiZqnOmGhAudUnmZjXBuM3oIeCsLjsNcibSLUIisFLCHjWD1gxn8MK3FqPRF6Se78XCZOojBSsg5zTWQvyPtVkZcfWp3z/pci0ApH0ZRRlwv6t0ySPMLp3l2PhL83aVaaakX6uUUs3I0MVBXEp0z8XdLIC7vbhvq1Jg6U7OPXUR3fDtvD5vNCb/U4flA44TeS4jis9taJa3tDdyUg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(1076003)(26005)(107886003)(7696005)(47076005)(336012)(426003)(36860700001)(36756003)(2616005)(40480700001)(7636003)(86362001)(82310400005)(356005)(82740400003)(186003)(40460700003)(16526019)(110136005)(41300700001)(2906002)(54906003)(5660300002)(4326008)(316002)(8936002)(8676002)(478600001)(70586007)(70206006)(6666004)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 10:03:50.6410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf16ac5f-4e6e-4525-30b8-08db4fab85ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: EJ Hsu <ejh@nvidia.com>

For the dual-role port, it will assign the phy dev to usb-phy dev and
use the port dev driver as the dev driver of usb-phy.

When we try to destroy the port dev, it will destroy its dev driver
as well. But we did not remove the reference from usb-phy dev. This
might cause the use-after-free issue in KASAN.

Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
Cc: stable@vger.kernel.org

Signed-off-by: EJ Hsu <ejh@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
V1 -> V2: Remove extra movements to clarify the change
---
 drivers/phy/tegra/xusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 78045bd6c214..26b66a668f3b 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -568,6 +568,7 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 		usb_role_switch_unregister(port->usb_role_sw);
 		cancel_work_sync(&port->usb_phy_work);
 		usb_remove_phy(&port->usb_phy);
+		port->usb_phy.dev->driver = NULL;
 	}
 
 	if (port->ops->remove)
-- 
2.25.1

