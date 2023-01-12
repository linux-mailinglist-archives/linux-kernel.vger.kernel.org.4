Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2B667F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbjALTol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjALToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:44:05 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C33C321B5;
        Thu, 12 Jan 2023 11:35:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEDCp4ZGrykTq75QYHYuCVq1OOWZsFNiVKVaxBXzu3049wtLA/OZ8gCBf3uvr5AUWOd+tKMFo1rLVokZaARAsbZKHhBPBxauuM80DrMMVmBX9N7sFRQQM39RA432JcGqS4/t9gxzBKuGUhm6+LTpb7dys2Y7gfQErlTCjmXCHIvJqJrJDaP3bf+FJ1N7zMQce12p7cs569KQUIT98bLhylg1wLQWGUh0ICASmsgI75qOvHqi3QsLJMUikTafAffIJFpLddENQsX+i284TMiroa0qByFF0Tl3hfjuX0FxIpgvBFhBXBfDml7mjv4q4/tmlFmw1bWVc0AoBRTMqb2UJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACfxK11EiDUn6YifuXZI+iHQNLz0XFnMCJjfgAYt7kg=;
 b=H2IXaCdU3x9sCQcVNBstwILdqKHn5FAEY11zk/CNdcTT+ec1WZHYJy3Zsbee6Ts8sb/edmdVvl8pm4jRRKVYIE4uJkB6YpgPq60E2KXTKlIRRcyGmPCsh20aLhn2ebvEqjBc3A0MOEB0Ul/U8j3At+LbPvacMKAW0GbMiF0779SvryFEhWRnlarOgiTPXijWH4BJJVKA0p1jd3/Id3EeiAlO6uGZZNROlLR55OtqShJh1kT0w8CN7vmmt0/stxJdChO6pSLZAcizxIGfSSQ6lrsTiYzb1UM5L40Nl6bey0OVFjzEQkaOND9WblhtyQKyeobhlvPIpi9towxF1L5onA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACfxK11EiDUn6YifuXZI+iHQNLz0XFnMCJjfgAYt7kg=;
 b=Bw/Y+Rkd2o2goXXvaIAvbZw2rcoR/Jwzj/z50GZiuS8MKzQMNlYgExLB7Srlt+xcv0hAg6F9C3C3N+XmyplilDjOy60PTP2eX8BDuKHb8XynXbrQH6zyvDieRTyjWw1C4mrkj8adgF+IpP26PJdoppH1lQ3QaMQ5LI9lFIc7a54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 19:35:11 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 19:35:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org (open list:PCI DRIVER FOR FREESCALE
        LAYERSCAPE),
        linux-pci@vger.kernel.org (open list:PCI DRIVER FOR FREESCALE
        LAYERSCAPE),
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        FREESCALE LAYERSCAPE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v2 1/1] PCI: layerscape: Add EP mode support for ls1028a
Date:   Thu, 12 Jan 2023 14:34:42 -0500
Message-Id: <20230112193442.1513372-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AM8PR04MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7bfa9c-38bb-422d-ce68-08daf4d41e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhsgZsjSmBj8Tuvo8noo5q6lDjBDuv4qLbheF7vJwmrApiakeA8NaUS1+1Z3sjxa6RKBiakMDFd5W2ouWIiaqFmRinU0GonzUmeGHgQUo9fOis2d/Jd+5uzi5TyDib6YZLO+Sy/Qa6aS25tsMwfezp0tltTph2OU4iAkDUA8V32pXRW7RSw669lBgzLf3WdZGUmOr6JgRLcXEd00gkggcttCDk1uLWMqbw46Yl3S1COEQ31g9MjTGyAjvMWntBf7eiUwQVwaC6jFyr2TsbhDCHufNMq1ejtk6VaWQZNv15gyyJe65mJGgLHwmU2TMmEOEzwkGL2zpx8exLuMo47YTR3wltSBlyzyJrQYB0ZGGBGzPPQLR/+4CuvwEraPe5KLgCrrHYkj9HZC6LGUbxmdAOMQ1SqbgLUCKKPSaDdM+ctGPR/azJqKU7+ycCnkN3qFWEvjZVidUaFErxnTgW5jQEEA9K2nBccmlA6QqJ4Grnx8NKV1M8wlcBpQY372EVLUF34KaWPAfN9DgPWPqe8VGoS2Z3EzYbXclf6hVabGGGHjyHH3XR13b4UgxM3ISnBHt6Ez9n52miUpYmwACupqFMlupH9KjOkGUfciUp1vJED1t0Q3wGEEXYAwd6/CNh3/tdZ5VfYM84bElqCQbk3OLaTXSb71xnM8lfOqc9ToSZGahYlqyRalc3+nTdb1kMVA5fPwrDT5QuZypmvSUgQlSvz+jMCgA7/qryvruSewoUom8hi+B+33kzsmHO1wtq8L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(38100700002)(38350700002)(8936002)(921005)(8676002)(86362001)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(966005)(41300700001)(6666004)(6512007)(26005)(6506007)(2616005)(186003)(1076003)(110136005)(316002)(478600001)(6486002)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PE6UXabMdE1WpV+vBv40ZMh1ViGo7+f8lykpiyVSXyrXxWwzSMrR/AJMwqGx?=
 =?us-ascii?Q?qICGy65nBs5aFDgUnpHbyrA7FZPG/+qZX72psjw0LXICr5/Yl1e44C4YibXy?=
 =?us-ascii?Q?0BXoC/CGRv6rH/9ftun12n027UVUedWrNVXHdYJAbY7Hsur38masbSjmEEHe?=
 =?us-ascii?Q?RgJi5qayu6f7tD3Ae956tz4ttxX/92YqtzWC/uZHhyHAOuXUqj5SturTzs9t?=
 =?us-ascii?Q?+/C6ZxMLjJVLgFdVeDCePNVszSik4PZJv0NJC42JKYeTq178/TjRZfWd5frF?=
 =?us-ascii?Q?QyUvJZ/IVUpETR0r2IZX61DAZXYrz1S3raXgWaLP0xlIB4J8B6OJLJbHPkMH?=
 =?us-ascii?Q?EyRBtj0OqyPuCiOuxaqSoKUkvrSQeRmYpV3i6G+bVkABbphvGapR3RpIzkwl?=
 =?us-ascii?Q?+QFhBTetiLavERVR2wwQQJ4yXcaUsGikD/qNQXS2qNHZHvVkWmbAKfyZ3Sh/?=
 =?us-ascii?Q?zCUiiteYK5eIWFPfFgV8Hz1Lj6Z7z7YPLLd+bPdiwGHUUhL085tS6xtFtpZ3?=
 =?us-ascii?Q?jMrizhJrZFzY2QXW3RATXBuHtUgHM2SLYooHLhFnZU4hpkVQFYcxJC8EOSj/?=
 =?us-ascii?Q?5Mr6AmNeKHWi4Ot10mxd9qNKKf2yrfoaAfD0bsiGk7EV8jQrXiHgEpK3SUyF?=
 =?us-ascii?Q?CMg7CCXFaogF86dsLsRf4nbbsssBU9/Wk53aQ60jQY+Qg/TYYB4ElETayoP1?=
 =?us-ascii?Q?fxtd9PhdBaRFXsLabMr9V1XSyncg36jvBVRMdEczRCGBs6yorDQ8obd8BTc4?=
 =?us-ascii?Q?PHXKR2P6TQQInnAc8//fS1guJ9KwNeR29MUJw9cJB6uG+ANHtuQChywFWwgo?=
 =?us-ascii?Q?E1ksltZjtC7i1CqS/tzBykOPg346tjwt9IS2Ainb+s5UPyev/cgBViTrWZ7K?=
 =?us-ascii?Q?QzxNqDizgGhXW2jEn1RT9H3/ELIuojoFSJKJCWOT0hsv0Dkt+8B8z1n/Ylwv?=
 =?us-ascii?Q?o8xyfiEiGwdDI5cd9sly1WF7t8OJ3iq7i6dq48J3/i/66Uv/3zxUaHQ/UZ1e?=
 =?us-ascii?Q?jjAzlPAUW1zxwVyaG9hrwxi6NEnPsEzqGcMGyJuoEwKz57EFarKVzQmaSxPy?=
 =?us-ascii?Q?hyiWN8F85/UrxCN/3QfAPCGBIKlueWbeqgnVdgUQ6IJbZoPteZytZQFWrHvA?=
 =?us-ascii?Q?aCCT/zpPnLk2MeaxSGA6N7GV/IHWAc8r3DHMKU1ciIhzsk5kLhQTOutdNmhj?=
 =?us-ascii?Q?A02JEj/cl4jFJ9bKXZS8u4OU1Y2AeAnJTFxpqeQSIy2UxaZcutoQtSGN8pi+?=
 =?us-ascii?Q?jjJQ3ynCy2PX0H3qHzVbWUhCw+OJQOq4SC8T2zY6tKkkLggxmpL+2QltV4N2?=
 =?us-ascii?Q?fJzLT9AIfcyLOlNmj4EppBYheQX2/oAr1V7oXNpn5QhqUS7TpUgjjMFf78lD?=
 =?us-ascii?Q?ifXS0P1AoVnuse86pPQtjcTdUrYOG9JlqVlcNDrf4Edex2ZL8Vejn0prshQp?=
 =?us-ascii?Q?4dh8nigwUyKYRbIcC+wvhz/hJoKI4+oCa695bFlR5DQSClSLXDbxXafsJrym?=
 =?us-ascii?Q?8YDhyWrxybHRyXo9rgWs0tfPzYwm/UY9E4o6YAYbEl6JQLEs+2qaZTF5uzEy?=
 =?us-ascii?Q?+NZeDBVoOQuMlb3k/Cd8W8/FdhHXRBiKkdpvDrzC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7bfa9c-38bb-422d-ce68-08daf4d41e36
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 19:35:10.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTPkaMnDbS+y2HH86QFTBatWDkJni4q3IoefxPeHoEeeZzTqZkxJMYmZWd+cIzpWKHRMwphlUbePsblEaZARrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add PCIe EP mode support for ls1028a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp>
Acked-by:  Roy Zang <Roy.Zang@nxp.com>

---

Added 
Signed-off-by: Frank Li <Frank.Li@nxp>
Acked-by:  Roy Zang <Roy.Zang@nxp.com>


All other patches were already accepte by maintainer in 
https://lore.kernel.org/lkml/20211112223457.10599-1-leoyang.li@nxp.com/

But missed this one.

Re-post.

 drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index ad99707b3b99..ed5cfc9408d9 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -112,6 +112,7 @@ static const struct ls_pcie_ep_drvdata lx2_ep_drvdata = {
 static const struct of_device_id ls_pcie_ep_of_match[] = {
 	{ .compatible = "fsl,ls1046a-pcie-ep", .data = &ls1_ep_drvdata },
 	{ .compatible = "fsl,ls1088a-pcie-ep", .data = &ls2_ep_drvdata },
+	{ .compatible = "fsl,ls1028a-pcie-ep", .data = &ls1_ep_drvdata },
 	{ .compatible = "fsl,ls2088a-pcie-ep", .data = &ls2_ep_drvdata },
 	{ .compatible = "fsl,lx2160ar2-pcie-ep", .data = &lx2_ep_drvdata },
 	{ },
-- 
2.34.1

