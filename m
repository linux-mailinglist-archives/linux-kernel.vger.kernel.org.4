Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5836161B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKBLXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiKBLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:23:36 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B66C24950;
        Wed,  2 Nov 2022 04:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABSKv9PmUJ6Fdw2YD5ar6SIua0/w4ByDC2wJcM2FRSqmdbKHsAWr2mw0LFOd6lrSn91smbIbEohIr9JZzrQcfSTvcdiK8Hnj4no5QLjfluEoIDrZrAwscbVWz8XiNfLFxtsMdTlwKJJOctG0APW7x6BlaRoOzqd0UOJmVI9OFkiQ6f5CtDPN0LhXCPP8+egEkmbWhPmyEK9vZqoRhKktLwr1OcOY3WmOvN/ZIrVJCX5+GnCixq2LRFYYpkrjSTIv1pLsQ/K1CoJYpQyCMC7OeJJQWYtw11xggrKmRSBl57TLH6krAS6FsRkcPS1cQg9Y/dKH0wKrBpfqR8WXL3H2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiI1PAJBeTVWWsbWM7xDehXIJvyqs2SmUGws0WLMhP4=;
 b=Vt6aaFPseq10WiIH9jVySrLvSrfrhKj6WG7lrJYLvb8/pJ9ZaeWf91C2TeGQAdIRXwJk9OojqZbFiabKFbWtshKxY9EwxdmeEbl6S14OYt7MwuvshP/YxUrYURsUpc5k9bbGjnJdbiwg7jgaDYZbEfcic6TQn0yRP+QVVd2DxV6VrkQikv7nfg0vM06iEff+JIzlvFSYTcayo14laWT9K9krQ4Ted2LmZvL3uBs0GMU9L4kHvCpQCvLSrnOAoHOvSaJ9kTTRXKRQ7LQwOKp3xlGvCqKutgrzu2IVSnvrWe8kuaU2Iwyn6BxGhc4jphT/0tNPhfTVkHg/4rFPwJatqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiI1PAJBeTVWWsbWM7xDehXIJvyqs2SmUGws0WLMhP4=;
 b=fga49r+MhY25eXDOgZkvLT6cc1Lr1IUqG2UEn3iQNL/9Y0/73+4W/HGECZRh6S2t0EAQdzAUexC6jcXXGIeyO7JPkmAS0ui8QCIzQlA0JFGeXDpLOr33ogBfzU79yZJH8KdxGNHf7JmTKdoq6qSiJWW1AuKbzCNtiFHmcndEAxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Wed, 2 Nov
 2022 11:23:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 11:23:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] remoteproc: imx_rproc: delay after kick remote processor
Date:   Wed,  2 Nov 2022 19:24:51 +0800
Message-Id: <20221102112451.128110-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221102112451.128110-1-peng.fan@oss.nxp.com>
References: <20221102112451.128110-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b76d6f-1cc1-4600-63e3-08dabcc4ac1e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mJK+OS8Xsz24ytGMJNYLGOaHxCtYHn9HoqZK32R8e+JkOslNS8wt1PRGLHeKjBECCzPcdUFdxiSbp9LgZFfzYAq5rz/oE/+ouV5po5UYjZjG73ZPREN7Bf+IPcX55VwamJIXZRCuFvTaOy+4ujPqVwktgkNOCf6oj3sAVGr1Vq1Pya6NVjFkS0BkEzhQFAu+q+eZYKJh7d/hKDryrDM3VD1tZAxmDcxKjn54vsMgyJ0wZSH75Mn4OFq6gWH9N8u9MtM4NiO+UsYhMySZ60LThdDfTDDgo7HmcdA91WVqRcoxAEFh3q4vZ9Mk0L99zflYmDFSFnzi1jkpm5rcQUktvpJajIh+8UFs+c7S9EosP8ZS2E9R4ZjgQ/NuLtl9AEl3iBnZMskCk/+gXRQvRfcUtVTr6/yA/llnbYFXrCOqBXgPPySpl+Qj52Oku/r8yKoMBlZsR1BNFBEC98fg1GZoT5OhZZ75gZs3EaLq/grq3/xF6s5vOn2Pma52UlbRaYDkVzJN1q3dkNn2l47bnK68smigwFq2IzcrK2zYupHnD3QH6D8/db45c+S4oyL95NvzFasIuIVSMIWDhDadNrbGPcpXkJZCmhBBmAwUf9Q/oYerel34OID78Ng6Vt7Tzr+fZd1vlJwN6f4HUNstOxsENl1rqmtFn6EmE5vPwhXjMwuzJpHzGeAsiQTNxfdsENFtSETpf+o1Njh4//ZqqrimaQefdbiMRDSJmqV20/l1/zpeysdORZO1BeRjclBDvGaRuPg3E5vG0k0eTNk/9zcoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6666004)(5660300002)(316002)(2616005)(6512007)(86362001)(66946007)(1076003)(66556008)(2906002)(7416002)(83380400001)(8676002)(66476007)(6506007)(4326008)(26005)(41300700001)(8936002)(186003)(6486002)(478600001)(38350700002)(38100700002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?01l2ueiuiFK2kS0NgalC4RPjcEq3BET+49conKd02kRl2r8PKM8GRYAtBx/m?=
 =?us-ascii?Q?FSPgB4uj7Y3c11XQoOFwyWW0D9sFmA8YYS72+PuHFFjFI7Yht1hzN+1/eS0l?=
 =?us-ascii?Q?9cpA//J3xJOxtpK8e15N9J1udxOSYKkti5JQvYHd7yMFeFfbB12Qyg4Y2PFb?=
 =?us-ascii?Q?7+rqWS5BBPxLBsf4B18iMkQDXEIfYzVBIri+Z8eJrcTbfdq7FMrgbOU4eRRk?=
 =?us-ascii?Q?0Bkr0Ro8ykVnUu1WCc97hovdmkGnN4uM4KzgthqcMi2audE1y9WQ9AP3Ugco?=
 =?us-ascii?Q?VJ6tkkAdBCsryEjJrSGfdEIgdTYmdooMI9/HLei+k2Ymf1DEFP8rrm/NH2iV?=
 =?us-ascii?Q?axf8kN2wI65YDaTenXfIMEwdFYddEI8j8CTcnsOayJQ+N6bQmE72TsoVNaqM?=
 =?us-ascii?Q?4HO/7KLxxOY1ltQCcrIxWnY0pGFZh0s/A93XFdW+LOz4Nwb47r0tF+q0eShE?=
 =?us-ascii?Q?mLKiZisJEZqZBViswwkd2fLUTflr8u6pHJLWyPANreB4XwQbGV8PgOS00tVA?=
 =?us-ascii?Q?ZrdfnJn5gYv3qCFimnyqc9J6gAuQqqPlWh5v6GueOkcsdsNfEtBQfv+3EXeX?=
 =?us-ascii?Q?dBXF9iXilqNNWbgAGsoKut6Bg94ElaK++IaPa3xh/wlnsJiM1cEo6+PAIXCW?=
 =?us-ascii?Q?EZyvLYrmN8QGICEhO7W9zcieogO8zVknqpndxz+Sx0cS0zK0DJI24ExvZpvs?=
 =?us-ascii?Q?RDk7cQPQm5tRY67NPUAAAoA4gQgnT0hJlDCSnT27VTXucuyc2mXLYkDhUodV?=
 =?us-ascii?Q?dQpBg+LqhiMtRhSvRw6YLTU1hbw+F2q++WsRRtTAh/yhChgpJNXDqjb9xaW3?=
 =?us-ascii?Q?gXkCJAl81YJZDsqkE+mqjYNVxTElkizu03vxEMcmmDPSFi4O/NElx/pODm1f?=
 =?us-ascii?Q?rZkAIw7wUs+7aceFasc4UZgAITmjEtyr1C7SDWHejynMo3gb1Ex4y36WntCo?=
 =?us-ascii?Q?sX9bs1SQ83yoB+NEnQKFjw9c27PvuFKBxRJYqDSQwVJ5X6mqfOco9IRcci7K?=
 =?us-ascii?Q?Va1u7BxnvTuex2VgSIxLSNw4/QH/9uHjEPZ9aKF+9LFI9joZmpG1iCXgEEaO?=
 =?us-ascii?Q?pPVAqmquomsTSohTa+9jYnBjoE3rHtGgGERVFHvooEx3U1UYk6qfRs6ZlieB?=
 =?us-ascii?Q?RDB9CWpmYzAc3ntvARMQLNG6+zALV5O2J4VAmPvTzBssrMntHiUDxMjo4BG6?=
 =?us-ascii?Q?E3/1ZDkEPZ2iTgqUTiqPj65zgQ54b49cjxDuhNF0uZnVJtP+THPqxMYmhvfp?=
 =?us-ascii?Q?7PnpPfql9qg+u+2Ju+N/NcggOBhb12MQGTD+KFDf/2QUdvznqqLN6f2/Fhru?=
 =?us-ascii?Q?jkqdCVfqWjPeZy1twXijoFHiSiHpsT8tjWrFbxRLybYK2pn1e+2KjwM4/Bs2?=
 =?us-ascii?Q?00a6VvqhSJ9IpU27bmFWLUNFgOFhKb2cd7vMJNCcLOC/OT/t0fqVkhjQz3lj?=
 =?us-ascii?Q?/ZmKFmwM6y0WNwxTzmBtZFN2B4P6XuUZtqjfAuPuKHF4T0C8YCxyp1j8KPxs?=
 =?us-ascii?Q?/4tc52R2VTm+VvdqeuQUHJ/uzR9KFMJ3Y1Jb7K6KDVjd50bRoGSCgyHhRKpj?=
 =?us-ascii?Q?z/WMuQY/ECz2GiuxOaKk+k56xu+qYudqYSdLD4G8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b76d6f-1cc1-4600-63e3-08dabcc4ac1e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 11:23:31.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7K93L/9I9ZDJ+n4CeW2AaNR1qxg7yURDrGngDvWIPkZEN3O/KwzQcgpfIVwkn2RfC7Wi3aKwfriqDm2F9GCmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is case that after remoteproc start remote processor[M4], the M4
runs slow and before M4 finish its own rpmsg framework initialization,
linux sends out vring kick message, then M4 firmware drops the kick
message. Some NXP released Cortex-M[x] images has such limitation that
it requires linux sends out vring kick message after M4 firmware finish
its rpmsg framework initialization.

So add delay before linux send out vring kick message.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9fc978e0393c..aa4e06f54f27 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -6,6 +6,7 @@
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
@@ -110,6 +111,7 @@ struct imx_rproc {
 	u32				core_index;
 	struct device                   **pd_dev;
 	struct device_link              **pd_dev_link;
+	u32				startup_delay;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -382,6 +384,9 @@ static int imx_rproc_start(struct rproc *rproc)
 	if (ret)
 		dev_err(dev, "Failed to enable remote core!\n");
 
+	if (priv->startup_delay)
+		msleep_interruptible(priv->startup_delay);
+
 	return ret;
 }
 
@@ -1087,6 +1092,10 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	if (rproc->state != RPROC_DETACHED)
 		rproc->auto_boot = of_property_read_bool(np, "fsl,auto-boot");
 
+	ret = of_property_read_u32(np, "fsl,startup-delay-ms", &priv->startup_delay);
+	if (ret)
+		priv->startup_delay = 0;
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
-- 
2.37.1

