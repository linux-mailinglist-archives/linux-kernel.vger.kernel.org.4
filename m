Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFEC6A65D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCACyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCACyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:54:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2118148
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMolBzzYX+lMp3lSpKGaACIY0NuSJU9Imuv3/IxV0rD1/urRra/KaHCJTfuPW9CLBNH3vB8d8w7rnDXwCVVDNfeAKDibNqZyErBXm0DI0rNdt8Lue+kIKVFdJ9eNWDwSARCpHUOw1t7v1FahGbANV+YD4CvaecfatCG50oFWv4wbZlbo4GvAwGZWJlHyD5tgNed2t5nsnXL8b0k0H8e7Lb7dX+d9fMBINaASbdTR4TD3XEnr/3LOrT/Y4OJLZ1qeQhOBemRuf+3wjEiSByltFX40fgp4oP940D6cCCJnx56o1YBgcAzKlcRlScYWX7pQWUVVDGyLSmH8o7lwsYc+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trTU19dZ5DzZOxx7Jl6vHg+rVSAFMLYmV+hDPSwsjpo=;
 b=meLSVoSRMOBBFmu/0B8K0JeUySY1U3FIrnrH/P73YduxCBQoqpgdomgR1amFgGxvqi/JNgReiY2HAiZfpQI2aQA5Z/crSzqeBFx2wD7KroNTByCSifIQI6qpizodZHMDz2dhFlOStGIN3P4k8CJvMYvpXI9LZmWaz9vxb7WXQiASvDTH+Meh6ZgY7D304gTjjZNtr7aLbrmvdBH7tQbtOIj4qbvcoRryLGJDhwpT1+saiqX7C0vik31usxaMH2wY7PLzfup4cEp968DHUYdiSRmJESaut0CkVwNE4PmmkjM5HN/snO+vD4lCl/kDsX55Oxr6EeykaBAAv4V+csYOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trTU19dZ5DzZOxx7Jl6vHg+rVSAFMLYmV+hDPSwsjpo=;
 b=p67ONS19F6cgPJx/w3YPEi3l5QRGJZEvp9KASYBTxyP5NBpa+yy37yLDrfi5/PuHdrmrfg4CBsxQxut8/BoKjM/fNlZIrhpth1YZAi86lGCNeq4eI6k8Eq9AFNa+gawOINpvbyiaCzP9246HbzzLbsIpl3j6aOsVSUooz2A+PKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:54:12 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:54:12 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH v2 1/7] soc: imx: imx8mp-blk-ctrl: Use dev_pm_domain_attach_by_name
Date:   Wed,  1 Mar 2023 11:00:36 +0800
Message-Id: <20230301030042.2357706-2-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301030042.2357706-1-jindong.yue@nxp.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b9d62e-72fd-41f0-2822-08db1a003c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raafJxpPt1LKKXKJVexUhA672OrtodHBbDgkS7wSvuinIvKz+dOOQia+YhtZCY08wUjxXtBvU8VENSRs3C6fLodnEjKKQzUTJIwpwtKfTMHq26kyMZo+CnLmaJZdQppTt1FMryKwCGuBhLA9BPPTErW7of7j+tKnJ4gHQpIkWR+dIt+j282GIlY64aQQsusMlIPs6+bl1wzPJIj2TTUIHKMHhM/BVfBc54Mqn6z5RiRXFAw9rRSL8wmaVoq2iC9ZyhSRt1DXqr1+pqUlcX34bNYahdAW7i5qcpJGfdM5CQtaOgL57GOjqoXCAVO8gSmhRE81TjPiUdhDoMjga15JB0Uc9cv0rJ0QinmfvZrLHBE4yfllrPdUOQA1azmXp0O9vAghEkWd9spDrEops+YnNW1hUO5jD09NBMxhRSvjCQriRDaDkzuGmePwYMm2zcESIUxurCr/1XmrISzZEPLUPQpAsImSlYXiwuuRW6UZ49oR56wrDVYQx+k0dkpFSARZ/IQakQ1odQHBK12i/VrYF6PUgu3MISxgRotvzP+Fra06dkARmQBzMYE0EciOfF37f63CKIT2KsdvkCGhsi21G7RvIFTj0EVXI3j8foDtwHj/mf4RfOgCPVdJ5aARFukzFb943eTgqydDBBb6eqcOBEXgRiockGXqSavDGl4v8w1J7gTJ8Cy821oB3zUp+rEG8SJnLX4/s/c+5A9Asz6uwEKMN5ZFvLikiGSy8K74zAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(316002)(86362001)(41300700001)(6666004)(2616005)(66476007)(8676002)(66946007)(66556008)(4326008)(4744005)(5660300002)(186003)(478600001)(36756003)(44832011)(2906002)(52116002)(6512007)(26005)(1076003)(38100700002)(6506007)(38350700002)(6486002)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iqodBJvqgiFORt44gKWHSoUBv3nr5E9df/88RmrlmNUr1+djwBKBlv+xvG2/?=
 =?us-ascii?Q?4NyzQJOwaV7BKjdE1LawbCBEHReVIfiFy+bBe9jd924exgIul1GadDYFNqFA?=
 =?us-ascii?Q?iCS2E0yaBwE37ZAHbtmFSJ2dKb90kT/6W8D7MnNRd8IDGz/aXj7ug1zAxJ/T?=
 =?us-ascii?Q?+UdkHybl7TnTSISjCSIFAtwbNLXMN0HPRhB/c5UZuxyNkcY70VlMEhKcrBrU?=
 =?us-ascii?Q?6QUoRly3YYWfeMXwhVGFDq7WXymCVCfIZC7gSEs6I0uCbVydL14IDI/yqRb/?=
 =?us-ascii?Q?nCbrbmZljiG1hA75u+2bGeNNo6SS0DK9ufHGnsR3NAf5w85gRCIzS1mC8eIQ?=
 =?us-ascii?Q?0jqcBFRpcXHc9BtJEB6MXReZ9ZeQoZdTCrsZ2zVpqnWrFWgvZ6WOXOkdUblf?=
 =?us-ascii?Q?FPzUzVYflm9OgimJJeEeWHqV3IowxYSHilrensyqRoc8KvYTah9R1yk69bYW?=
 =?us-ascii?Q?sX10mhqkfZEYq0upDnJQHWdWTristhnMjUetESs0na9rBTDVooixwAIiqLUC?=
 =?us-ascii?Q?t1PmmNG9r0VY23oKZAJ2GU6s+sxOgptB6xlxSXGihEMI+XM6VqLSx9SmxhqR?=
 =?us-ascii?Q?wPiC5/kQ3nGNH1KWGf9Ttn3dclxheBZoKJhzMPehYQczAvd9Qx68uRwxteHX?=
 =?us-ascii?Q?mU52pcGqiqFRVKjuH1r75C4z/eOH7j3P+3bMdvgdrvrvdMihEKFBmkzy80l1?=
 =?us-ascii?Q?475wq+QQBCNFWouB5Kk43kJsyz69/rmwzoKnnrujADIEgvYVqKEwZl5T/Qqe?=
 =?us-ascii?Q?3pwrviIGYHjB11Fv3WprceZU+AAcOXoLYT/AdGyrPaP/Jdnc0or9v8fdWdis?=
 =?us-ascii?Q?GGcKudyKiifkq/d+jjLe0PnQw7NBQhna85cseMzUPbjG1oUVoPYljhq/fMCe?=
 =?us-ascii?Q?4s1qmEgoXlgdM4zIn05B8p7KJqcvzhe9CteE6h62q2Zk7Kdk1OMSTKOv7AXu?=
 =?us-ascii?Q?+hyBYQIBTFpVcQn/NCkuY7/9Y4tDxWZjG2YVeupvUrglpViqMiyZph8gb9fk?=
 =?us-ascii?Q?F22U//gR5+JetcwAWLyVTEUU6MCe1+g4jrI2RO7bd6iKbwkWxch7lz9X7egx?=
 =?us-ascii?Q?fUMSBuAA3rC7Ps5wqUFXzt1h+soI6fqir2JLhx9Bv5v5JHM0GTbZJJFKCxJw?=
 =?us-ascii?Q?eyuGdv7nmn6MPhizq6PRgVgSgYw4HUgmX+DVNHES9YaFKSf02CifTeGmLGyR?=
 =?us-ascii?Q?Y44ozRlT8iIbRU7nFPMLxaIBwwUeBfLXIZuiU6x+L+cJG/uPAwLaaA42gfdr?=
 =?us-ascii?Q?GhfdZdf9FSd/CcFoV9pC0jXa9sXWHFKwiFxHnnsDtX0EpUatOsJ9q98o9o4H?=
 =?us-ascii?Q?qsePHqh4o4e1TTYPHcRVDr9nav7/oYF/pjvzP+ml8YPHUnmS6gWvYQM9D7HI?=
 =?us-ascii?Q?K0MasxiHwgedIr1E203sK2Mz5w8Fq31fJw1s9pQn+w/DlbMybcE56McO0+Bx?=
 =?us-ascii?Q?tFGXojNDBCQOFmSkgqedeqRffX3FwUHOegemnQDpeSxBK8jIe2JtPjtSrjxe?=
 =?us-ascii?Q?eNepuy0xVB5FhbFnu6nGHoo+eHE91YPblP7KSc8k2ckKNwXryehOTtCVkPzI?=
 =?us-ascii?Q?FB/DKkvg7RQ87tsVa0gMF4lX+rl7RggjScfF1T0V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b9d62e-72fd-41f0-2822-08db1a003c41
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:54:12.0187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGpmT/O5153mf392WPAbC39VDfNUrY41U9o5Kp+3G51btTM+yNnKtRqL4/DrSwzeg4YG6G7LJ6JVqfiCSPSZvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd_dev_pm_attach_by_name() is not exported, it should not be used
by consumer driver.
Use dev_pm_domain_attach_by_name() instead.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
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

