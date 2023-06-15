Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4790F731E09
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjFOQmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjFOQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:41:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DF426BA;
        Thu, 15 Jun 2023 09:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKRvywB3SU5xRBToUy/V0CZL1X7eArpividqjktfcNugXa6DLYunIyZeyoEelKDT8yfqMUVINDsVXvQsPEdI5A5Y8Jl/Ek1ZeMLno1bmRrDnP+4YxP1f1DtEQ3FltPdPhn52xhY/wtbQO7Qndg5rSxZVKJA/PnlywMGZklou58C34Y+DMGyjEZT3q6ulntvfvVx+7PZ87aTnpQt7CSi8Ye6heGFmvtEJCaU/kwx9fSKNXIgpxmcuiE0TpiefNXCMKKHMamwn5d3LNNkDuEYQo4dn8ilVv+AlFcU63poqaQZLtDeePqxr5LN8y/T24S9lyXFZO3rJ0xH5OcNJWuMOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od7s/aecYSsiEVMWSHVuy6fqo4SO9q0ZMyHX5kEmUYw=;
 b=EBkR4Lvxfg0I/QkGLc+lr2+zfxFjld23l2mGRP3941pX4xiQFbugvdCSLYT6zmrzC5RVEMpRSSQjXn+yvuRYH28c060aQBV3xmmSuUP1OOxITliUJ/AO4kdcuLFZK+bRgkiODD1oWgT0VgCkTAB05z6QabQcN9kg2JRmJfqSDAkSpxVNlkypCAYt1cBMfOMEF5SH4tS4fv6A71lAZjr3k05rkwrP7M9cd4hcj+VZSeLZMDRokcqsEwPbzQqMqPYyAQezmRVpB1DATEmfUzNiEScCwobv8Em6N22kkoSydsDWhCF5m/JI1pLpXN8fQKWTzz1TgfxK750TUrRW6RSW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od7s/aecYSsiEVMWSHVuy6fqo4SO9q0ZMyHX5kEmUYw=;
 b=iVwffbvHZTy+tt7xevFLzDDNBAq1Zt8fA/atGbuj0f9c+DLcY61twlv79Wr0ff0mhKBVP3GbRbBJYrRGnZ7lXaAU9q/4wcuXpVOkiujy8sFMUC2KYk8rDx0E5PQL+aGrnaz4XID7d/xWhtIFe5fKzq2RS7hS5RPs58QFPe0x7mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 16:41:46 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Thu, 15 Jun 2023
 16:41:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mani@kernel.org, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org (open list:PCI DRIVER FOR FREESCALE
        LAYERSCAPE),
        linux-pci@vger.kernel.org (open list:PCI DRIVER FOR FREESCALE
        LAYERSCAPE),
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        FREESCALE LAYERSCAPE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/2] PCI: layerscape: Add support for Link down notification
Date:   Thu, 15 Jun 2023 12:41:11 -0400
Message-Id: <20230615164113.2270698-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d002aa-4ed3-4f30-e2f1-08db6dbf67fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k531FtoaLgkufPQmEz7XveST05CKVue9+2CqHTPxiuztYRgDVunhq9SYqqtOmhObQvqw17f8oNg2W2coSrUkcp50/zvf8hkirQs246W3h1pjMZ4/FrQoFpwvglA6IgM9ba88EKKJA75XeSJw2psT48h2I9aIdqJutrnf6hEJiiWcP8qZ/VUymek2yT3YRA9OB7kkvzsioeEhl+2njcRkYvEz/JgXgLdJCox+vnNESGouqdDhqLH+r54Gz0lDJc4zY5o751tJHRAnDLB4VaU45oEflVPsZysB+V+pAwhRXtZ0e+ZEss1jsCeVYjZEcU2lYKbsN+kD9I5bMAt0zdGFV4VuTMey2vQdTCRbTdWtbOxe0jElAmp0br7l1o5myKAfnfGGEjej0F9x5CukDYQtypSBhXTTXet0Qj7J7B3SqeC9e/HHLtZ98I3z/6QDuUepzmudwKFhsfcYO0THNqSf/1xaw8ihhBYEGwjdbh5NJxsGQfBcy+kQfKFYHLxH/kw784+ixOaOUv6E7ljZNLkHgSKzq8VDLL0Pyoph0DHO5K76lCmBhCTYJJ2h/P0d7WahNpdT1CSZ2DupqQGIHAU1RUA42c7AFE7WbNeTw4iPV6EE1U+A7lD70CwdBxtF/DoxRTFpqDBDHKUg8ONw5P2M4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(26005)(36756003)(1076003)(6506007)(6512007)(478600001)(186003)(6666004)(6486002)(52116002)(2906002)(4744005)(316002)(41300700001)(86362001)(921005)(8676002)(15650500001)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(110136005)(83380400001)(2616005)(66476007)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0KtBu6k6Y4qDPzDXh4aBiXwBL4RlE5vZqkNd2CY6YjcxbT2AdnSKhSv+Lt3h?=
 =?us-ascii?Q?rlF9DsGpYZAyIQXbyvtK9Y95KrBECqUYrygiFmqDL8dw3ZMtwyntFEA9TIso?=
 =?us-ascii?Q?7RVxWAXa4cAtSsE1IPq7D9ZOulZ56M5EtAv0HxfFQbP1FGymLj5zkeeed6GF?=
 =?us-ascii?Q?Cw5VytF0vu9YK/3mIEa4rFSbmr+QpoE9gUbZiV9DFzBXTjSrBZU1fsY0vi9J?=
 =?us-ascii?Q?Cbh8otg/NoVu742NGwekiRvJYfSFVUytVjypMJqlOUgM3X3RF24BRT/dAoRm?=
 =?us-ascii?Q?W548HlJAB/Y9vynRi9LzZVwdv91nIKXEfmFAD9FV046zFtY2hzmTZ8YPSYiR?=
 =?us-ascii?Q?fLM29wtAois+muS87tXU9IfokuYCIZufRS0NJPBEgPJI9TrIy5UontX9o802?=
 =?us-ascii?Q?XLub73up44Y9ovM2tIybNIAcCN5z4O/l46u/JZ0VqPGcJrwC1vUfEgwFKfXT?=
 =?us-ascii?Q?fwFxOSfuqdNcLPVzgVmsYVm+2sfSh6GOC/GVYnik6GIM9lprcqi6eWOWYqLl?=
 =?us-ascii?Q?eBe7AyDA/yoZJjbUk9g/1hWPFcYGhk8PY/ejgftNcVsjUSPxlbVUD5Fym+IU?=
 =?us-ascii?Q?nYs+bQBo7dRPKfqLAiAAxf9wE4YU03/Uia1AAqVKaNmGUDwoCXX1m1ozuLCm?=
 =?us-ascii?Q?mPNXfkd+e094uNJGLPTV1WMyNqGkmZqaLU9/mtW6cHx79U1bjZ4LNcvsI1HB?=
 =?us-ascii?Q?UcZdJZrWBUNfX7Wd3z3r48RrxbYkjk4HFdHEABh+eTAwlg0oRBvMwjyBVJYa?=
 =?us-ascii?Q?GbyeE+enDaXdGw/B/7myw6XZJO3hsuIM4X7S6T918QmTQpTRKZIUtYryMQCW?=
 =?us-ascii?Q?BePHN/axUUdb2XuKduljgfMc6Ru5FITobZH1+IrxR7ae/0gZIuCv6z/Wbzqr?=
 =?us-ascii?Q?8qurqS3AJElkLWWl5bj8577HbundAW95zgxRM16jUuBPNtmMda4TN7WA0s5Q?=
 =?us-ascii?Q?1RCkth9G0eAkKNg27VnbT9nN9rRmT4QPDvo2VzWxeh6xnVEwEYWbf9WAac6x?=
 =?us-ascii?Q?cwDZNjJNYkE/jg4m1PfmUoAEXqfQPpB2Mte1zpheIp5FqDg1xyZWWdIRAMy6?=
 =?us-ascii?Q?EWmtkbuYmTt38roS0bzw2tnVg953+Wzlbz0fH2jNvxOVfyE2XMgf1Dyx02EF?=
 =?us-ascii?Q?fpqEM+om3FmQdp/QOxhR/dPlpTkaNC2/9Qhj+09Wy1kX6y3w2DEufIfXrkpT?=
 =?us-ascii?Q?7cHgxmVFbd66P66QHxjMgcsqRJ682cSM3SEm6NsbwuVbtG0kB7PBIjef5eEm?=
 =?us-ascii?Q?f+mkjueXQQjJN9QLbJb4SVkMjY7Y4U1PwvMgsqoYyUwHwtu9tCoe3Er3Xfaz?=
 =?us-ascii?Q?Ci3T0bQHoQQewSV7zXi3tUNzVDlihZFzNVhdbxxULH/GbutRf5I0hlOTa3nV?=
 =?us-ascii?Q?EZNx/24uxK7mT1pndy4vzYT6VJdihnRHu9+5BPNUeECajEdMI8aTy3Ei8SWR?=
 =?us-ascii?Q?KUz8C/vs8N0uwR9N+7OLUYtHU45HFZmMJ8bmD3xBRn1/sX1dhnso+de/jkn8?=
 =?us-ascii?Q?sEpRWJAXUcxR8lj6KE21erBgLBM1QB3ElTjoACzWigUkUbKcbkIkxtSkASsK?=
 =?us-ascii?Q?Hrc2bxuG9Ido9lpmRgSPIo17CjABQDxzbcEwxx3X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d002aa-4ed3-4f30-e2f1-08db6dbf67fe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:41:45.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRqMV1oqhUa6oStQjEGUG0e2cz/g3sVo7at0AoVM/2a3kIjM0QceJhtRYLjR9pNrKfWEXH+HlvS0D+icBEEAVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to pass Link down notification to Endpoint function driver
so that the LINK_DOWN event can be processed by the function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index de4c1758a6c3..4e4fdd1dfea7 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -88,6 +88,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 
 		dev_dbg(pci->dev, "Link up\n");
 	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
+		pci_epc_linkdown(pci->ep.epc);
 		dev_dbg(pci->dev, "Link down\n");
 	} else if (val & PEX_PF0_PME_MES_DR_HRD) {
 		dev_dbg(pci->dev, "Hot reset\n");
-- 
2.34.1

