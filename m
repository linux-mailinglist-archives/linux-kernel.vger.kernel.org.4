Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFAA6D781D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjDEJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjDEJ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:27:18 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693FE4C31
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQt1k27fv3aPTyp+t45CxfDIHguj5kzMZkHMZutk9QS8DRLyK9tO05K7iqppGr+iM/jj8YIcpDF+/KF38PoGnrNXHqwg9+Vr9ws282xburjptP5bQrjQvAYAqMf2AyD73EClxkGGWuhs3HDJHakApYBonGpuTgVg90OcBYZVPM7drWA9J76zFksc+yY2sXSqUjn/WUQNN2lhbn1MTt7YpISu6dIKNL1lAg32v364aU+nFh1+JjiGSQ4VI5wZqUOHDTe5jiK9XyI52iWI5hu2Ou2xUx9+eATO7gSkT2E09N0M8HlJjouyTE6EIQuR2sdwUKS2FrFuc6pRv2t0kQVjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyMZ8rwkzM3lxY0iTGssGNGMFvMXPUX+TEJNuP5yUm8=;
 b=RG54+2d7chjREQ/J2n2qwWdbUmrsWKYqZx4OqZ+e4jDKYIyoQL4NC5fdnTyvu7ANEmQ6EH9k3b05WQO7oNq6fVbzR3Wqbxjwtf5FtTcVezwe5Tbv5eDOu1hyl5rvobzK+WYtPSBSlGvLkR2WO5ICkwkW0BWVN4rPONoE+oOzEEDleIkamp2f3MWSxWdQX6H/jj7JT4+8WNZdnDpuXML1iJLXox8yKoloMDYLTAnEyRSFyqJcpYNbIkyUSTBGzdA8rpJc85CAw9ZTb2dFsVzbQ/CXFiAE27LQQAcA4/n3CLI1o7ZqbJNJ/+Egq339MIyTl3Jsth7/T2uVWlrCZihBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyMZ8rwkzM3lxY0iTGssGNGMFvMXPUX+TEJNuP5yUm8=;
 b=mhfCztYMPhTHVDzCnT5ona08u/P28IDkUxBxNCbKuZ5tUF6rUujtvi0LU1EpeW5OAoYYJoVkExPnHoli/4Jy71+RAyJTBm9Ls0fqPMLEItmzWjbbRVT64sHplnrljvL9pHn3lOjT1GHNMMoJW0a/9Or0P+En1/uzc6Fo0P39Vys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 09:27:13 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::9b57:1a50:24ae:7561]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::9b57:1a50:24ae:7561%4]) with mapi id 15.20.6254.030; Wed, 5 Apr 2023
 09:27:13 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, cujomalainey@chromium.org,
        tiwai@suse.com, perex@perex.cz, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
        peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com
Subject: [PATCH] ASoC: SOF: pm: Tear down pipelines only if DSP was active
Date:   Wed,  5 Apr 2023 12:26:55 +0300
Message-Id: <20230405092655.19587-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::12) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: f4214f8b-2265-4acc-8948-08db35b7f070
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: koiy9nNeSsTPpULGgFxSqB+K4Q0L6WwHPCLO7iBbR9Ibz+uMK8VSNyNuDgU+LKt3W2YtzGyZeDXE29XJV77qqwLPAB1UzxsHFgBMoxwFEYNE+/YbUypFkfbN4fVbjZGFmlNkZna4HRiOrOE+JOYMq+BqU6d/AwV8SQMRb38vRPMzW2vylcMrOr9psXIJKuhU+j599vwpFAswg5xSn2mxC5LpfMpY+1ymUFxZBnJnCZJcQ4CbB/FUkCAbZR23L4Hp77Gyco4SlmwNByQuTYFLUzgXFwLB8l+v7OwNQdd6BqvAo+k2HU6HAaCyZH+8Ad2j7//3B3fD2TbTj5TUYCiRhtfFe7WTV5e8z3d9YLIBovp1JMuT3+UFh9p7RIRiQASloU+fSP4szKzOXSu/O1OE1MctLNUUUW+LY5pcwAKJ/EcqAE2f0z3yc9VhohpcKuVbRo+92gdQOIgAnQNWw0xaWNLLGGKDccA3xqq+p86SpoAZuNXWN9KZ0wLuJtQ0Rxv2zSv8RT8d9j469lm4TcYPOCoMPLQxFnwcJ7Q4FbFUDUi2IyJEnnp60MM4cz+8AQNq0KJgiY5kMSDZBI5k3eq7lVRnglVUyVTGPZ9d5WHp4jW79V6kJJcrDwW34GgXAy2M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(66556008)(41300700001)(7416002)(66476007)(8676002)(66946007)(316002)(4326008)(8936002)(478600001)(38350700002)(38100700002)(5660300002)(83380400001)(186003)(2616005)(6486002)(52116002)(6506007)(6666004)(26005)(6512007)(1076003)(2906002)(86362001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y551rUOrk70pwYyEj8GoMDWRyu70u6NiibwPajysIL8/emjQtaTnrQTdZjar?=
 =?us-ascii?Q?Rx6fiorWAdpxvigLBv7siFNPXt4ElAFiGdLV5vw6A/firfi76cP1JNlZlWqb?=
 =?us-ascii?Q?lVLiqfSyt1Jv0VQgL7I/VYXgvBQyU3qEVcGQHXNBQbrD1o+1DMmmkxsmDU3C?=
 =?us-ascii?Q?AAInx/SNaiN/BQVpHXajV/6jG/K8Rm30MrEgeSMMBwALcxBL0U9yWT5oMGag?=
 =?us-ascii?Q?TTK+z5dLE+xQZ+XY7ktnYCJcluHNJt9XGloYSqFFeOcPnXyjnYpb/pYGvIbk?=
 =?us-ascii?Q?OjvsxtOrJooVmDGA2EwXzK0qU43IzX7WsO8WEuYQxZv8rgF13D129+9tYtUJ?=
 =?us-ascii?Q?5wSklGZmUXoan+Y8cSJiDOAwvrgG5WMBkiMskH+kQuYmofZaMkRQHJl9sU+l?=
 =?us-ascii?Q?JZ/sL9YR9jW3GokNav/i0A52/OXtorxmM0wDsD9KzWHKcG/LgPT0M0AVfMj5?=
 =?us-ascii?Q?mjN3xLoi3v3K4xOMYOJ1phH6gDqn7doK5V8rhfHplQqCwp7tV0l/BwbS7bUX?=
 =?us-ascii?Q?X0fIQbkTJpdADPH13y7NKC/Qunfuh0Uzo6IaIQoP3KuemCUgRmPpwEaMBOhv?=
 =?us-ascii?Q?5skpzkIpSOzE2TmygK+GIJ2ftqG8OLLLjw5LRCP9RGbUzxGS9jckXiuMFIAm?=
 =?us-ascii?Q?ziJTMBn4uBuHbTFHhT4v0/k3NI8XzTOoYyxDLz9R1tjqXYLL2d9yJTRtcggc?=
 =?us-ascii?Q?9UHknHWTPQfqoQXWlEZIg7pxDrNtUdGOFrUJNoFn43t/YvGmvs7ZPDd226tJ?=
 =?us-ascii?Q?YdRyd2UdwNG2pDW56ZPKcqrKSe8wUhaWIg4NVgImkxRxpvwH/Y2nkMAYmFkt?=
 =?us-ascii?Q?mRc/er39cCZ8v8MF1rLy9GcbLzDRhTT7eAa0KQSwnhd1ko8S6C8EifRzT9na?=
 =?us-ascii?Q?SE6mqFU6ti8qAVT+57miep7d+BvalbKS5BUFqKGayIcBSAyQVjHW6fEHp6sy?=
 =?us-ascii?Q?8zjZyNyCdISMWOfedvRu35m09dj3DYERiM2kdSvbBg4GOwLqOv72kiIYuEVY?=
 =?us-ascii?Q?5i1ezHiwDGZqwUIgBCE8ZIgHJCyopZ+wrq+XMfj57pHGjylyj3L+ssI1LF63?=
 =?us-ascii?Q?TfKAN1i8UpWBYEe5I0T89BIdK4VLpvpe69q8sxEx+aChdtEj/vEiwv08+pGY?=
 =?us-ascii?Q?ZXkfE3MJ6s3qI2XxUlFiogh5piuIDsxu3NA0zi9sH193rtXL7rhFZy8Jvfd5?=
 =?us-ascii?Q?nC05TM4w4Lx/fJrnWRJHDhB8l+mwCX5oRWinl7twTTPZjACCKv8IUByX/hZr?=
 =?us-ascii?Q?59hthKW2NuBLsh0B9sT2xoFtcG1jWFOZXXkkPvi4xUBKlSCmBOt2WUl9rv6X?=
 =?us-ascii?Q?y7KTydgWd//wxYftB6H0/fs4xmnJP8w2Ix/+QaJMl3NDyfeI/Qj4Zaagg54g?=
 =?us-ascii?Q?w9jrcYZ4k4i5+lUobSmQsnHnj42/vp2AIoZJJzYIS6S82QjJyY1+qkhkWP1v?=
 =?us-ascii?Q?Xv4hLqryVYA4gWryjYoST3tt3YtEfi4q4ZJ8R6v1IR+TRT1SlJAl2PYGJ4jM?=
 =?us-ascii?Q?jNrARoI6R52tzVofbB+3AODoERM6plsEQzv3K7x4VyOGjSGY2inEiA6aWMn4?=
 =?us-ascii?Q?TBop+JfGnfVunAf/8hW7P1VrmXYe/I0zqdumv5Ut?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4214f8b-2265-4acc-8948-08db35b7f070
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 09:27:13.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Yhekw7MF2X3GzFgEPoLvuiVTriyapgt9wGRqMnzt3h/vVJKUMJtp3iU/vJSkDvfUbsGnpUFx/SQnjhz9yH/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

With PCI if the device was suspended it is brought back to full
power and then suspended again.

This doesn't happen when device is described via DT.

We need to make sure that we tear down pipelines only if the device
was previously active (thus the pipelines were setup).

Otherwise, we can break the use_count:

[  219.009743] sof-audio-of-imx8m 3b6e8000.dsp:
sof_ipc3_tear_down_all_pipelines: widget PIPELINE.2.SAI3.IN is still in use: count -1

and after this everything stops working.

Fixes: d185e0689abc ("ASoC: SOF: pm: Always tear down pipelines before DSP suspend")
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/pm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index c74ce8d414e7..2fdbc53ca715 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -188,6 +188,7 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	const struct sof_ipc_tplg_ops *tplg_ops = sof_ipc_get_ops(sdev, tplg);
 	pm_message_t pm_state;
 	u32 target_state = snd_sof_dsp_power_target(sdev);
+	u32 old_state = sdev->dsp_power_state.state;
 	int ret;
 
 	/* do nothing if dsp suspend callback is not set */
@@ -197,7 +198,12 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	if (runtime_suspend && !sof_ops(sdev)->runtime_suspend)
 		return 0;
 
-	if (tplg_ops && tplg_ops->tear_down_all_pipelines)
+	/* we need to tear down pipelines only if the DSP hardware is
+	 * active, which happens for PCI devices. if the device is
+	 * suspended, it is brought back to full power and then
+	 * suspended again
+	 */
+	if (tplg_ops && tplg_ops->tear_down_all_pipelines && (old_state == SOF_DSP_PM_D0))
 		tplg_ops->tear_down_all_pipelines(sdev, false);
 
 	if (sdev->fw_state != SOF_FW_BOOT_COMPLETE)
-- 
2.25.1

