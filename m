Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51596A6CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCANAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCANAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:05 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F6305EB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrzHW8JCNu5lKNxDotLlJmFnuSLftnncJbIOdxqmFenOcQueQxFpHx9JWm3qNbbMWcqFEKRfgyZri6+Oahtwsn5nfqlLrj6CoCqpPY8PVSjGNNZ9okkh2zUm2JoO6UHO8lmW6vBWKxpXF33Q4SknNQAHXVO2kD752S3K8P2cppoiiDGaK71T502CPs43xajSZ1cwxADMxVjbhM566BF8YgfJt/V55q+b3+xxoIl1Gm0454zJ/SleMKlNGGLezEB5YwCDyibJoal9SobXo5l46rEOZGNNGWOfYimEfvG/aTQYdHwfSp8aaph7GgvlGHF3cEfhZl9+Nl4UuRoJiC9h5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2m7SQ7vij5zkYPlEW09xrH3eQVTXz7GjkQc7pOCCv4=;
 b=KaHBJbYn9nX58RvoFRpROO9az8mlYrSqVi8KAxgVkJciFrHM9yRi/9aoxvxufES5hcFowIniingiPc6G89kPHz4BzI5juUqCEWwwuUEkV4G7FvM3rlMMat/Jrz8c1S1DcrBnDXKD30gyP+W9Vu5rpIO+Q2KWxygHoGyXROtDCVG6PkWuJ4OqB+oHlhhYf/kRcj9DIpOhZlWpNnBWE5bgZazTmf1gnkvbI4T3h/G7IHYymy3HmBKlv1fti9AMr7pqjD/EVX0dCIruyeR2m/1elKA2ZM/UoTKlkE/8dd+Pjraa+KEuxtfqJ8pp7FfJVamoJU1fVnatTRFNxobdw8ezXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2m7SQ7vij5zkYPlEW09xrH3eQVTXz7GjkQc7pOCCv4=;
 b=E/oe0wDn6g087KuIrmYV+33QkjTqzz5FkHTvwm59WaggrIa7KtVjs09sAIGhnXEvFW30UHXoAPRdFU7ZdcVGZ+FfBIQTIaeIZ752obX0DC8oS2DQhyBJ8k4V5Mt6mAwe+0lV6Ph3dxyLhBBy2DgqMkYElh29XAGHRzJbdogurJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:59:24 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:59:24 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, m.felsch@pengutronix.de,
        jindong.yue@nxp.com
Subject: [PATCH v3 1/7] soc: imx: imx8mp-blk-ctrl: Use dev_pm_domain_attach_by_name
Date:   Wed,  1 Mar 2023 21:05:51 +0800
Message-Id: <20230301130557.3949285-2-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301130557.3949285-1-jindong.yue@nxp.com>
References: <20230301130557.3949285-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb49f2c-7350-4b9f-fd98-08db1a54c7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZzzLm2947UFFCzYuiCZUH3MIDqhcC7rxzSlHcPykXuT5DYIYFa220e/HUOjRC8/3UiT3xTSD0blzflSw9ppcpORwhmA1zDkUdOlc4sOCpKjIcx61Zn5RT5q2VtXTcg6demhJB9FNzVYPjKBo6beudRr6VFLcpC/fVpqbY2RKs7P3Wp4QrG332p0eFTisHCg6y2NEMwSXWXogYrlo+8GcVu/72sVDTmMty9zTJSUtt+EfyyhGWwUmw+q8vkE3cwMit0htYcvNmmk+3DqWYZAkR0PQiExGjx6q4gZLE6dRIGk5fuTwZ8WMRhUWGBsEUQSuYfRCFMhLBsJWDOhXQUVph8FFiI9TYTucS+FNylluUMUQXB1Uc/K5SHs8nDW2AQHUQ2W1YX0VhhoWwY8utiqn7hRW+h43ROnPqekQ+EHsXfsr9pPZm6vM9GWij+BRqTo8h5FjgatFOmVXROvNm0nhHBVcyuANM7i2smL27QEQVKa4BYtD4OHvS2RB9TC8r/Wm7mKTP7fhkzepmqKLOap3UJ2Yy8KUx4mhcvK3kXnRPDiNLiqKt4k+7Wm4FOlBpW/J8jR+YfJXDrBA5oTudfDLh6BA5JUOZRoOU1MvEri21oL5EXtcyzhhk2OnwspXKuoE/qBnY8h/K4n0dFGCXl3WBLl7Zl9Cxla5eQGwiuL0p0rBBRFSV1lQ92BVqy5BAH8yxcLOYP6KRl9NM8qAG0g8JJuKpz71sloDfrr4BxCuk78=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(36756003)(44832011)(2906002)(5660300002)(83380400001)(6666004)(186003)(2616005)(26005)(4326008)(1076003)(38100700002)(38350700002)(66946007)(8676002)(66476007)(316002)(41300700001)(6486002)(6506007)(86362001)(478600001)(6512007)(66556008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtcK53/VB0bvUCvK8pMGxgZIcJH5p6rCaxBIJ5ubf4tQ1Szrz6rPd1QHlwwx?=
 =?us-ascii?Q?MekzmUT8o1knvzVKGrtXnGqI+tXzQN5+qfeQkKOq3t0F4FmmXhhS2wSvZkR0?=
 =?us-ascii?Q?ScaxIaDngpDAw4muZrbfM+KZlsTom17jYlM7BQ+dlpn5t9NnQyGZgpheg7Xe?=
 =?us-ascii?Q?ppCJxe314dfxh+A5RWJEJQuQE9iRdUKcNm4+UX8ZEMjrg8zU1Uob3+jSJcBU?=
 =?us-ascii?Q?clfBeFnt0VMmHtiv7RHvXr1qReGKlDezctfetBDupzVKMaXrnjEJa1ba7XOn?=
 =?us-ascii?Q?BzJpi17+/SgKOGQWX/Zj0WwXmSwWOC5j6JpADCcjpj7pTO//D47Lux61ue6M?=
 =?us-ascii?Q?8OZMu7Ci51H2oLc7ITqyg9VhCS/kfyghlNLgP9ZNiL4uYWieGJMcaLo864xf?=
 =?us-ascii?Q?zdhRbLyZxFpJbznUx3KEdW2Ob6txKrSIn0rCNpKya5UwD12icdB4qTbNFTyG?=
 =?us-ascii?Q?tQJPF0tEx60WMz7ZV+LBSha46iVyO/gd5KeLvuhLNjTZCkqxTEbgXSKTbP7O?=
 =?us-ascii?Q?c7i9Jw0djfHGJ2nPnoamzaUTXjwlph+fWWn1uS5oWNMMEvLDQVIb6to7RWMg?=
 =?us-ascii?Q?VsbpbhUyWaKbAsOnYZJI5RqiXAYdz3nk8R66csInNSiWPxC6Bsl+EosZL4wG?=
 =?us-ascii?Q?ihAlULyIp0bnTJsTI9754THXIZ9MnYwxhpTX4GbMwMd6lCoRAImxo9TG+C+z?=
 =?us-ascii?Q?usu2ug8WjUfBXNY4I119fGX7MldNf9IyXB9QSiXryf8cbYjSwxyvhXIcAttv?=
 =?us-ascii?Q?7Hzz7izCUbnFrcjAn8RWKc0VzpXYDKKi4Q9fpS1sI1snmJR2cbVDuU5niZA0?=
 =?us-ascii?Q?wTR1eQhgBM8IHBQ8+sAOWyvj4ySO0nVbw8rK0VmSBsSODZjO0g47Z/S8OPZc?=
 =?us-ascii?Q?plDrqxkkFOLr66TweDtqOmuaac+9N8C+HmKVt9vGkb8tus5zWnGVpd8aROtM?=
 =?us-ascii?Q?QHyH7nVjpGiByb0rplltnnbzZdmbNPixg0rJWiJlvKcqmSXIqPWMRZluNXAY?=
 =?us-ascii?Q?Gqxbjfhjkrd4Pb61xVNIUWVGsmNXuVkb4oTU+WJXgDpXhfdF1fiZC+VzvIit?=
 =?us-ascii?Q?hhCl1EuE60jZyp50vufuegBNZNsAy8qZey/oMASRuh5DRLnUHO/gkwjXaY0c?=
 =?us-ascii?Q?+WRQp6ROUlXGZ6mVOfGf2oQt3zLxqgjCH34h2mMLp7PBERftVyOrS2e3Fxxa?=
 =?us-ascii?Q?M/7mAVjDMbkSMg8t0QQ3e8Hd7Wj4o8KBYzFofHu2khZ1cFVqEJB47PUyn6AJ?=
 =?us-ascii?Q?K/b0GMczDTexUYTjrrIuaZ6OWt4+1oVQ5JZE7zU2rDpMIb4WzYcjzOxqkQmA?=
 =?us-ascii?Q?yr+/dVbb3woEUJCWFT9Py3tYX4CZxbVxosTCFFK22e6AzI/WfhCv2L1UVdc4?=
 =?us-ascii?Q?5kHtkvBLcUznTEMT2HPBem35lWIUPyvfhkCQOeveyzIPCtwxNuTEUiVVPgqD?=
 =?us-ascii?Q?03oT8m/qmbOwB8X59QAOCeJEAuSaiKCi5F+95jrnE9qXswbwIpRprf9PLxPI?=
 =?us-ascii?Q?SZgCNLAZGAgP49FurlvCHasZJtN/x38rLkXr3MWos2eN/8lDNjo2FSTS1fFM?=
 =?us-ascii?Q?GYaSzL2iAWx+dWV1xLqG2oxL/RgAZgajHfT3BRuK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb49f2c-7350-4b9f-fd98-08db1a54c7f8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:59:24.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMYmLq95bNhIRHb7AMBtxSDBUmBAIBFZwOhwhf3ayH8cUkvUR7dcEk2H+JwX1twG9PJdfYljYSnGjcezRid0AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd_dev_pm_attach_by_name() is not exported, following error
occurs when building imx8mp-blk-ctrl as a module:

ERROR: modpost: "genpd_dev_pm_attach_by_name" [drivers/soc/imx/imx8mp-blk-ctrl.ko] undefined!

Fix this by using dev_pm_domain_attach_by_name() instead.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index a0592db8fa86..1892c2c78831 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -642,7 +642,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 	if (!bc->onecell_data.domains)
 		return -ENOMEM;
 
-	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
+	bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
 	if (IS_ERR(bc->bus_power_dev))
 		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
 				     "failed to attach bus power domain\n");
-- 
2.36.0

