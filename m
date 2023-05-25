Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2647C710BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjEYMVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240158AbjEYMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:21:37 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B212E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APyYCEYZ4KBwl2ooQ7S067C9v+5iArzk5aQ4X4VZGteX7sc1K3LtLHe8bSkS7QlzR+N5DD5K2aH7Gd/QANmESof7NdWKklQ0b3wII3GihqvVcIuU3oznizlGZfRN/782i9qUH+lyc4o2/jKtJMA089RdQYGZoxg40EtXjBV48/V6GPgzCmFo2xxwpt59j6GEHdYFBs2uI0l+um/5Pl3NU2jbw7x1bAQt2vpspBDp5h3D5K3I6ODOTAusAXNGBiM5+vRp6zNtZesup1Lt+AeWJC73OO7+iRDbtqAn+aWht1XDZn7XyhPi12CZOJvlpjpxcNC38skspXo+yjIWNBQOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZWk6nYJzM0QB/E5Ee6bee8iaNZ42fwEBldISEsz+Eo=;
 b=MI1rAP2usO0sz5LnDY3U4b1aGUUhZ6Oj/rF70b5EFrcbXmdxpGqHXpe6dt2QhctnK0rBxVAKs9FjjlCBtXp5KVV2cQ+NXjZxAKse6qIJIJpUfd0gWKDouzFADLmibkDHA+zpP8iwxqbzW3VoAF4LOxS4m6T3+Bg6mnINsMd3oHO+xCtlyUxBUdcYfY4QG7r/IahO1TD7PT+vfa+Auty70uOBtN4b4wX+Y/VzsJmvkuLt6GwSCM/Hfdv/G2MUGsQ7/dyaVz9RavzkJFpA70dgwEVXxVSMUjk1u71KvB3OuALOLay4B0qbiBsUozxboTfAfNiw4B6ZX5cSt12MR4r/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZWk6nYJzM0QB/E5Ee6bee8iaNZ42fwEBldISEsz+Eo=;
 b=D1Efp+tsXYv8LiWziZsrUbWDzzsaVLwR5FQltlBvbFL1AFjgxPRd5uoO5hyr8Z1aHIabooMgAD8Unq1u4sEyntoTJdz7siQfcBPHGPf6tK1L33/GeOXty8r/SIPsLsMFJXUddicP7rijqUEKqRbqweNQltFr6ZJDnDgwWkqruZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAWPR04MB9815.eurprd04.prod.outlook.com (2603:10a6:102:381::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 12:21:28 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9%7]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 12:21:28 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@gmail.com, kai.vehmanen@linux.intel.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH linux-nxp] ASoC: SOF: imx: Add OF machine descriptors for i.MX platforms
Date:   Thu, 25 May 2023 15:21:12 +0300
Message-Id: <20230525122112.647963-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::24) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ba0b64-1bc7-4b3b-c006-08db5d1a90d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oNNZbk1srzSkfXjSLWnjogCi7M1ygZshDf0fGivXyHfoPWRcI+8eaBjgcvJXKaWB0fbbP22TFjV5gHCCIXeOyiHpatGs8xAhkAVgClIZUq52Nvngjp4T7q34Qds7iQvrjQ/9WV6qzBK66oPR8Y2ylm657wlVv5L/fehnpsQj5NciANv6zvR+7lVi7FtOqO5Hv3kcPtHJun6n+4RMRY/3fFarMIgSRheX9IEqdGEP7m3DUBczQ1KtRyWcrNblCkQtYzx59ZUGVb4zAhG3S/inZRaQlIWXqeAxWkZ82CnK7ZfsNgn6bsN7mJLnE+n4JdBhSeK89UWnyQMOKmK+RXrrzagdGwyJtHg0IKfX0u69jNluKHy5b5dNwDkMvXe0HkCoNI4P1VnrW4Rdz+Pocf/qWn7syl+57EOsP1XFOTq2KUZN092vjyjiufNIzL8UMcpEjPB+f6PTz2ndsEXx2Z7dtqg0l3BeI7JVtMvW1h7TRwa5xFO/3mRQty0SwUwg5Otu2PdPKKbIe+oRiv4i9svNX72wqpart8apwYA7hv1NeVFT5T6tfKgZa2EC6R+NG/yb9IcgWZLMLKjnSc526Ng2s/42MoUAasY3TIS2nvOwiytSw/BufeWy3fJY81ABtpU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(478600001)(4326008)(66946007)(66476007)(66556008)(6486002)(41300700001)(6666004)(52116002)(316002)(5660300002)(8936002)(8676002)(86362001)(38350700002)(38100700002)(44832011)(26005)(186003)(6506007)(6512007)(1076003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZ7UZv8kDf0F+M/FAsEfW3FVP1bnQd4kMtlsClGylJzSS+yV97bcEIWDt40K?=
 =?us-ascii?Q?A0K6huT0+vPeyRX6oUN/tppFKRqwozpz25ihGMFqHc4VrCBHfKj/AwurIofA?=
 =?us-ascii?Q?Mcnj4BPDbGUvx/rr6DbPWmpadbC+PI/xAR6knuXAt6XZHK3j0ZgnBfiidXYw?=
 =?us-ascii?Q?nHV3J2eKpt35h4nGtn7nOTRyi4k0yj2gtkbXh2T35zKhxizvOz8GSnByuK4W?=
 =?us-ascii?Q?GaEPA0mevQbxGcRLHVjdYlULzlw8YNIhDnps5yo2MftNPG7Edl1+Ic/tXFV9?=
 =?us-ascii?Q?HROF8O86PWAhRapXLDo+h0NQi6atDyabz6Eb/f88p+b5ZW2u3H5qqiDMXsJc?=
 =?us-ascii?Q?3BzHRPqfTEqolt+JORTCBhMJzJjUd3c9olPsVP1uRbxWHONLyQ41VrRMjYgt?=
 =?us-ascii?Q?ESD3v45J8v9CjmlMERV1NX8h4PMZgfgByaqfsZTV1LVLy/EuzcFSo/PAhS+z?=
 =?us-ascii?Q?ITV2f9stNx+qQZ/M3leEhpxF/GklCXCJwlVETyF0RAhrjD/G6iNcVGSIDiZW?=
 =?us-ascii?Q?Bsq8CxUuaa/2tYCzuzW7Jd5EkTYzs2EhdEQx8pjGOQWj0fyr8LA0OMUk8eb1?=
 =?us-ascii?Q?0bFqj9N860hQjQK4nXHFCPIZyXSNSqo7jNVgQz5G0VkKyunMoZadiMM9OLK4?=
 =?us-ascii?Q?COvfPWpG4OVtrR0WFFyGwt6DWZ92zf/Pnl1aCxVZSiwaNhvRJmq4RaGS3czP?=
 =?us-ascii?Q?zd+hL/FSBGzSgouKGDoa6NhcMGiPJ7LP8KPQT48JcjfVKvsAZlO91chL9jMh?=
 =?us-ascii?Q?7U2cgu0cVsP8XljMFNFZceXvnKwFsgNM5HOyBMQsexm0nOUEwDYr0pcHn5z/?=
 =?us-ascii?Q?1sCpuExM/2L/MO3FKhVR+ZIaRmGoQVSvAQZsumfPIPrd8l9lB7M/wqucTBhG?=
 =?us-ascii?Q?e6N1ctlmJZ3bTgclwsVUEhPkhOyeEzAFYZKPFz9w8VMQOueOzlDuHyxYhnBx?=
 =?us-ascii?Q?MJc3JnFvuxsyg2iIzeb6qCis2jdoBRGfHrLJhp2TUl1MPHLINyVIQrme6UlT?=
 =?us-ascii?Q?uZym7+7ybVVXHimjpwpxrrmmdeGItd9ygVvxRyVIJ1wC84BzgNaKW9TPTYNU?=
 =?us-ascii?Q?NDd/mwdhfjUQGIpWzOU1z6XnijvsPg33GkkTzB2sZecjhnCR98Ojz16QGM/f?=
 =?us-ascii?Q?7euHbTBbvI4KO9okIXOnY8dYxAs/OgLubMD9G058lDPFzfFr9RDuPgK+A3di?=
 =?us-ascii?Q?2dyzve3yF7ZTc3VZLRZmwQgH30wwRHlZZtRPhTny/i3qXI37zYp9K36Uf3kW?=
 =?us-ascii?Q?MDNpIcLtp5tQ5IR2zK3WrHpZvFbmF9LcVqo7eIXh3atadQKCYmM2eWF4rvaa?=
 =?us-ascii?Q?v79SRHCPHgQOGoKiLNmz3B161zY7K5qP3JxlRlkVMVcOAGf/QjQcmq8+pNFG?=
 =?us-ascii?Q?Z+lW3WILmyNpPglM4rQcKTymowYpCAghxUATwM4EOEFowcb2l3gzJb5SWYLe?=
 =?us-ascii?Q?n5E3Miwy6DlOPDMYuClZGhQ//OEIXacHtSVYysCSzFpDjItXjq6En0x6PMRC?=
 =?us-ascii?Q?zqle2WUoc8DxhHTXadDqmK5dR9VfroTShjctSphUQ2hke3iwfxrGs+ZfiFC+?=
 =?us-ascii?Q?2oUz30+2yi1PfgUpJgGCr26pXj5f1C6d8Kdz7tKL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba0b64-1bc7-4b3b-c006-08db5d1a90d0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 12:21:28.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRM/S102I6dVE8hRiij+J22UQBHdm9HzHXRNU2CozxQWikhCj8ZbsTfeT6bHiCE+1VX4NXYc8yTnvR2fB8wZ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Olaru <paul.olaru@nxp.com>

Covered platforms: i.MX8QXP, i.MX8QM, i.MX8MP, i.MX8ULP.

These descriptors are used to locate the machine driver and topology
filenames.

Note: because the compatible values for the boards do not change between
the cs42888 and the wm8960 cases, I have selected a common topology
filename, which is intended to be a symlink to either the wm8960 or the
cs42888 topology file. For uniformity I did the same for i.MX8ULP.

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
---
 sound/soc/sof/imx/imx8.c    | 16 ++++++++++++++++
 sound/soc/sof/imx/imx8m.c   | 10 ++++++++++
 sound/soc/sof/imx/imx8ulp.c | 10 ++++++++++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index 7e7d1f5c1147..2b91bfc8fb5b 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -624,7 +624,22 @@ static struct snd_sof_dsp_ops sof_imx8x_ops = {
 			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP
 };
 
+static struct snd_sof_of_mach sof_imx8_machs[] = {
+	{
+		.compatible = "fsl,imx8qxp",
+		.drv_name = "asoc-simple-card",
+		.sof_tplg_filename = "sof-imx8.tplg",
+	},
+	{
+		.compatible = "fsl,imx8qm",
+		.drv_name = "asoc-simple-card",
+		.sof_tplg_filename = "sof-imx8.tplg",
+	},
+	{}
+};
+
 static struct sof_dev_desc sof_of_imx8qxp_desc = {
+	.of_machines = sof_imx8_machs,
 	.ipc_supported_mask	= BIT(SOF_IPC),
 	.ipc_default		= SOF_IPC,
 	.default_fw_path = {
@@ -641,6 +656,7 @@ static struct sof_dev_desc sof_of_imx8qxp_desc = {
 };
 
 static struct sof_dev_desc sof_of_imx8qm_desc = {
+	.of_machines = sof_imx8_machs,
 	.ipc_supported_mask	= BIT(SOF_IPC),
 	.ipc_default		= SOF_IPC,
 	.default_fw_path = {
diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index d20011349b43..a05497eb8d89 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -487,7 +487,17 @@ static struct snd_sof_dsp_ops sof_imx8m_ops = {
 		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
 };
 
+static struct snd_sof_of_mach sof_imx8m_machs[] = {
+	{
+		.compatible = "fsl,imx8mp",
+		.drv_name = "asoc-simple-card",
+		.sof_tplg_filename = "sof-imx8m.tplg",
+	},
+	{}
+};
+
 static struct sof_dev_desc sof_of_imx8mp_desc = {
+	.of_machines = sof_imx8m_machs,
 	.ipc_supported_mask	= BIT(SOF_IPC),
 	.ipc_default		= SOF_IPC,
 	.default_fw_path = {
diff --git a/sound/soc/sof/imx/imx8ulp.c b/sound/soc/sof/imx/imx8ulp.c
index 52c357ba570e..0c9878c2c420 100644
--- a/sound/soc/sof/imx/imx8ulp.c
+++ b/sound/soc/sof/imx/imx8ulp.c
@@ -496,7 +496,17 @@ static struct snd_sof_dsp_ops sof_imx8ulp_ops = {
 	.set_power_state	= imx8ulp_dsp_set_power_state,
 };
 
+static struct snd_sof_of_mach sof_imx8ulp_machs[] = {
+	{
+		.compatible = "fsl,imx8ulp",
+		.drv_name = "asoc-simple-card",
+		.sof_tplg_filename = "sof-imx8ulp.tplg",
+	},
+	{}
+};
+
 static struct sof_dev_desc sof_of_imx8ulp_desc = {
+	.of_machines = sof_imx8ulp_machs,
 	.ipc_supported_mask     = BIT(SOF_IPC),
 	.ipc_default            = SOF_IPC,
 	.default_fw_path = {
-- 
2.40.1

