Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD5731E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjFOQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFOQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:41:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E8826BE;
        Thu, 15 Jun 2023 09:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpN/NmmGiNpIeaQRp5XS+Z3lTIMPHZLhNVsC/E8wFl1DkTq8mSWBtuLfCj276/lBwtl2bvHxdoN2iS7DhmbFA0zrKWkGNUKWRNj/d4sAcdVrHcTDg+emz0jqGMppQVj+WKEL/tsoyk5V5WzWMNnuC0RyrWF7qers+cIDiwbxKHja6gRqjYI5M6OjrvpEfrgYqkdL6UqGbRlhRaoAOqvfLVhZ674nz1V6vRRczWi36V7G7UuI+3AS8UNucmK1G8BisyIskyIGeyJvuHyhQDTQiQGP1G+h4zXTsDmSW4/EEIwY9pdis2nw4DBgc9fXKe2K/CC8Mcq03fA+px4Pqx/PQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY13Iy66TAijaXO/TIrdxtpXHWr/pIGI1rk4vPNjT8g=;
 b=RSt5wfITXMOFMicshpnsE2WMUpSsezUYhI9gjNfVKubfpRTJ6rQo8XTvdrgsLv5g98BNWpHqFqXFg+CYUbvKRU6CfgLIScYXqfkNeB5ZqdbNrKdas1zilObXEollXxz04j2qyWpdmBCo4ckmHnOy3BemLcRaMC/9AMgON1hriyOoz/Zl1edKhWe8IOk1oxN6j+SWMjUeJBhwuljlqzq712ooiS93sUDSm5HjdPPj2k6ojZuFkSao/2Bo0gdrqkFj5prksfphdY4TqBb366TYX83hOh0zSJwzo0CrJ94ggIMWYfY8pzyBsolx1sNDllZZ2HMK1z0qO1EKUu8zDJp69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY13Iy66TAijaXO/TIrdxtpXHWr/pIGI1rk4vPNjT8g=;
 b=DAPnDUV2WNslr0FIPq38e8BqVGM+jWD1KdSxkZ39nhRWslYBd/+ppurb2KAFjrLvhMRM4l3tH+UjZxkvnMhfuv69vGiXkIo3UJcMhQR7oOmf24UjvPonhi3lYHPwZ6KP7wVi74hTg//g/wovpt7/QIisUpu6j6hAs+7LteGAwNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 16:41:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Thu, 15 Jun 2023
 16:41:49 +0000
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
Subject: [PATCH 2/2] PCI: layerscape: Add the workaround for lost link capablities during reset
Date:   Thu, 15 Jun 2023 12:41:12 -0400
Message-Id: <20230615164113.2270698-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615164113.2270698-1-Frank.Li@nxp.com>
References: <20230615164113.2270698-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 54adf62c-5a7a-4374-9831-08db6dbf6a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIB1cNzQg3gdbMUduBwZTUO0tbeb0Vjm9eu/4MbVIkefqjHQ4NRb7y24O51hQAP4B4PVmclYmovGhw9tVHNm++Fwtm/eEYMJHe/rVK5TQoQDGzLdHDPpzeyeDqW2pRmc+UkcKKwbjsMgyki6F78TmKNgX03M5HmZMwKk1JSKgZg+fEkfa12Lz8vUXAXlRQVhJowShRX1E5ksUawl90aogqwE/bmeksU9FvFvI/c28sonSJ1bpckQ+/ZbppnQ8ho97amxeohmDf89Jg8t7VEpUOgp1XPIbtnvjb5Sb6uK+EXSslhRiHhCYKXeuc7aQrJOSVKKoyYWG1zSQq7bENIJJ5EG/0zZIcWloFF/XB3KMoftWOTg5+Oc90q/yvG1p+h7YkgdStE/cmqQP2vJGKEDezbtL9oHrmxMAe7Ss/IYLIrXuSLPcs3gmTWarptoIRc8ObgfOV+Bopgb3slUkiQg3TbI5i94IkNtfH6CmTd6HV3YCiAANkSfKLopjBIoMeajPU5Jp8oJ13CDl5bi4haGu8tfSbMo+Eg27dl/8xpolEuLWSNdMXI94lhaFoLvqGu1wPmzJVS+nFXPHWD2Hl+T+XvCiThunUBf3nGhpt6IHzpkHR7kcKSeBfDi9BDLzoMIP3rYw0vNwEgeP6qZ0uypAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(26005)(36756003)(1076003)(6506007)(6512007)(478600001)(186003)(6666004)(6486002)(52116002)(2906002)(316002)(41300700001)(86362001)(921005)(8676002)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(110136005)(2616005)(66476007)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5KpThGf3lAtmTcJcgNuwEQbwdv8GfvouajbFfMepqshO1XmHk3zi1REKZQHa?=
 =?us-ascii?Q?MCl24xKiGrO78UJg347my2sqovzkJlz/Y6W1A0hZQLf6H1LrnhOk/80HlsfL?=
 =?us-ascii?Q?MD8+UAip6fNBmL+7azhJkje+44dlfrC6Gz5quBiU0Df85NiP7hwm5QrtQPZT?=
 =?us-ascii?Q?oHKG+XeeOasrlEwH6Tb+Z/ILtQyZqjiWAIYWrqxUjrb1x1XNpMJoYU3gu1O3?=
 =?us-ascii?Q?YzXjn7O1zOJEyS1LaffUMu9kn7vtSwXjNo+Seb/Uur7DqdudxNbyabdNMtkz?=
 =?us-ascii?Q?tfOQCtg8a7EMi09FRHOqosZzygcGOtff1WbV9Gq+a6qbVcey6VUJ8yXNXd3j?=
 =?us-ascii?Q?b22ULTnzJBph9RxgC4b8UD6pBuJLf4VMDsxpq+9XKKl07BV/7X05dez9Yn1F?=
 =?us-ascii?Q?ExSMSb6vi7WLop1jGtlwQ6jA+rOfc+6Iba8A24HXc9lJ2sFwLU2vV1gJT6K8?=
 =?us-ascii?Q?obTVo9iVkkhsPGVVAlJzw+gkLOABUJJqMxubWbn8attg93LImRZUb7/IXzUt?=
 =?us-ascii?Q?Ie+izSso/Zv47Go4ZxE3LSj5DPuY/ODNt3gMSa+KIh8BAAlCvUehqAnPkrzr?=
 =?us-ascii?Q?w+iRKy4xOBskT+1zEHxUUW2gAv9TX19rdZ4ADCji1S8T49qRgFj2K8MtpH4S?=
 =?us-ascii?Q?62GLRKBDb13VpYz/e5V+uJb0KmcjQZTuw4bwEAAx7bsDL7DuJfOAxlz8k93P?=
 =?us-ascii?Q?sOIyqUUjGtOS9A30m+V1aitwRpKipFuJGqx/8/JjWhktpqoLk98sJCFtj3/i?=
 =?us-ascii?Q?w7TliecpIlh3soj3QWAopaaIKsl4RBb4KpY8gNFNbsb06JD/YHafqhYslIz1?=
 =?us-ascii?Q?Rol2VpNMAEY3SbiU+6yDYZcvJ3oPy4QItFH+hiP+Ew43R3LclCL18I7Qp+Vx?=
 =?us-ascii?Q?H6JF4XhpZkQ9faOTKluJa4hJRi844pHJ4eTThFrGBz3OiO+bk2lBzPpQG1+g?=
 =?us-ascii?Q?QmNg4WfkSSrtMCaCvULrp9kj0O5dicqfMUorqVqwiSHOZ5jQCkTLaj9x07E6?=
 =?us-ascii?Q?hHIOnZvGjqlYKBvnZmslFf2NAtrKq2IDCgFj68tw9C3KG11SZyyBOYg7unnZ?=
 =?us-ascii?Q?x6N1OzpWrG7TEV+C9pkKHbSv+PWAvwm8AqfFFOrWF3qrw8YQaFZjUGympsgI?=
 =?us-ascii?Q?eDdiVh9jD1+lf562EELtbbpSQ+LW0zpWQJAu2/F3/J/GzGMvHPGn0Q5zOD+s?=
 =?us-ascii?Q?IY3Gz71KJhZeLOJbuN20p7s3+IjJetppUgaTyUK8wi4vaWo9V/5zV+KfW0Rl?=
 =?us-ascii?Q?/HG0qKa07PR00SDUjrOnzJoySTDNiJwLXwyJedeNvl1m//F/k+5fwraaHi9/?=
 =?us-ascii?Q?S1l0NA/dgXYztquPimHqCEd+IcBlLSJWVC3B4jbS6elb60LaozXig5Ba5QlJ?=
 =?us-ascii?Q?W5G8Z1Y+raiMw6UJwEZaJDJ127Vj5cMFIBTE+pshE+gykyfJujLznv/QVAyj?=
 =?us-ascii?Q?mHmBLOhKo8nqcc0LyZzJ4VCtK9IyKy/PqozM0ELrldgJvhYSOCfiEsB1UJAK?=
 =?us-ascii?Q?fHWUip4QegUPr5J7QeH08N7FZxL4afkfz9Djg7Ywb/Uhre4Ksp3KkJS1cO7Z?=
 =?us-ascii?Q?oVunmza+lD+mtU82tiblMeKEovocomHWr2naaF0H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54adf62c-5a7a-4374-9831-08db6dbf6a25
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:41:49.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky+yVdNbR8Hb3tgVcy6S1469JSV8JwvJkmOSIW/pAL9tC07tira9nt1VpPZ3kCoQUszy4b7+w2rDR7cmc6ioIg==
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

From: Xiaowei Bao <xiaowei.bao@nxp.com>

A workaround for the issue where the PCI Express Endpoint (EP) controller
loses the values of the Maximum Link Width and Supported Link Speed from
the Link Capabilities Register, which initially configured by the Reset
Configuration Word (RCW) during a link-down or hot reset event.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 4e4fdd1dfea7..2ef02d827eeb 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -45,6 +45,7 @@ struct ls_pcie_ep {
 	struct pci_epc_features		*ls_epc;
 	const struct ls_pcie_ep_drvdata *drvdata;
 	int				irq;
+	u32				lnkcap;
 	bool				big_endian;
 };
 
@@ -73,6 +74,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 	struct ls_pcie_ep *pcie = dev_id;
 	struct dw_pcie *pci = pcie->pci;
 	u32 val, cfg;
+	u8 offset;
 
 	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
 	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
@@ -81,6 +83,13 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (val & PEX_PF0_PME_MES_DR_LUD) {
+
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writew_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
+		dw_pcie_dbi_ro_wr_dis(pci);
+
 		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
 		cfg |= PEX_PF0_CFG_READY;
 		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
@@ -216,6 +225,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	struct ls_pcie_ep *pcie;
 	struct pci_epc_features *ls_epc;
 	struct resource *dbi_base;
+	u8 offset;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -252,6 +262,9 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+
 	ret = dw_pcie_ep_init(&pci->ep);
 	if (ret)
 		return ret;
-- 
2.34.1

