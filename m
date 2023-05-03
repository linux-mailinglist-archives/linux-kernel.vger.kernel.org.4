Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6DB6F52D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjECILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjECILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:11:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBD146B7
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXQX+UUJY2bu9LxYIgsO52Mqckz5jwvkjluqLGppct67bkVjxvot4eYZIoVTAP8vEdKzfP7MNswEHvMFHcbZ+UnB1odcR3BDl0JOwRHKFdqmfbLl2T2wZ1CMYN52E+25sjvVTzfpZbGRqkU+UMCYezO7YOiN4xXo/XMDN3XYfMNYmSCvoICMxDuAx8BC4fhnpcY6SuA+UAi0gaAxplcuT91pjrwwPDRoCzEAxSHmIz39Sr6vSjFSZysfpRfMkFIMh+QlauX2uQ/1ARoaNIfM5qYPgtxdA8zr4BCW2Bq0lheH44Z85pIyThhFu8dFHoHkj91L42uQT8Gy05f0d6+M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXAvWKaynpHsAI1tgqGNwCOSqmltsAuQnpT0Am+tucc=;
 b=Bll+tRMMUVTb/QwX30GKU5G1rBAbUCPGNNrb91Y4RJ5iftf7YKwVCOmCGBfp29Uqk1e59LwC9EeLHDrMUF+zYsQOH5KCejNUY7qLxsHsisSbSBsjnxDea/u0V28DERfg/wDdX2pL7MvRmr1eiIEZ3/kCiPxE+o4IwlhU8Ei8OIunwsMA3a0NEKDNaAPzBH0VCI+Zkx+gOYTfvUIvd6JE46go2y/7lQTMKi7Qy9R8OubBOgi+tpKKaQWmYlPhUT9w4f/ZCAb1ofhzk9bzvi1y3chcm9msMuJDhxq86NKY7BKiIag1DZISf5mjUtfLyCABji26YeNzKAIJT1j344QTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXAvWKaynpHsAI1tgqGNwCOSqmltsAuQnpT0Am+tucc=;
 b=gA8B2WrPgc0Av1aDvFhO+dr8ETd87lm38hJ55WzONcnqtXAt+He+skg/5urpo/bzr3hn04aaXPmLWf9zasvcP4KGWFrJ5JGHsOUh24VKLPQGGs4JFjwRuidv/uMAwjusUzco1kKPVel2BvZuXi16QVEGJefSahXc5CDbWsI2ArQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 08:11:07 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9%5]) with mapi id 15.20.6363.021; Wed, 3 May 2023
 08:11:07 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@gmail.com
Subject: [PATCH 1/2] ASoC: sof: Improve sof_ipc3_bytes_ext_put function
Date:   Wed,  3 May 2023 11:10:48 +0300
Message-Id: <20230503081049.73847-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503081049.73847-1-daniel.baluta@oss.nxp.com>
References: <20230503081049.73847-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1ef4e1-761e-4dba-7643-08db4badf271
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLFmu42TyUzSMTz3BtVhR1LaoyTdAkNnQXMAqw8uUeRU5zO2dsNtyRbO6pZ/XrQg/DyCVjCBxQZ3pIr+PGSkI42tsZ4ddWF+b+bACb4Y5sqj5DowzciAjOP392JQp1zjNwdqXcMFSKF85Fi7mkngQyYaKTE3QRp5rvWuMjap+XvGQT4vfPcVLdCxR4oVZBfiu8XzSO9ss3T08CrSLDn9INWGwEKjQq3t5gD33RhdoIXlneUxfeTlJUPt9n70wkuIg4M67H+W6qiwU47aQ1iidoJCQ2SD0tjSaf4grzZ90QPuHdMMg94vkP4UcAxbVTckXy/iFhOkzXozdTI8VbdFleo2W9w8OkFTLnVvKZK1L2+SkG3rpn8qxFlydpX5gwCGRILZXb6q6dpKgVItbnksuHGHt6VYsFlrcOpp7xDg/TdS6Gcprj+3r+lmr7HCTJqj/UKcz71fYxBLy+QZZC+KLkXSJZYBnQuZOcw7NVJwzE8yWR7sO7jutBcHKM4knvgdO7HTw9msMiq4bkrkWqd2+qHoR6csKrBOB8d2AfB3ITlCKZDFgfWa59VxYptlwtBdugnYF/dpYVS+jr4pSjGMlEHJuUn4VH34wNERV3/mSWW9TgSHK1KmMZU01xcmv0lC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(2616005)(83380400001)(478600001)(186003)(4326008)(66556008)(66476007)(66946007)(26005)(6486002)(52116002)(66574015)(6666004)(6512007)(6506007)(1076003)(44832011)(316002)(8676002)(8936002)(7416002)(5660300002)(41300700001)(2906002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVxV0JKdjdncmpDVTM0MkZRSGVpUEZZZlFSTUROMnBacC8zZXZwMDNuT3FI?=
 =?utf-8?B?ekFoZVRkVWsva20rN0N4a3pwaXIzVEdENHVyRHVBaU5NRnJ0V3NRdkszUGFv?=
 =?utf-8?B?d21qaDQvZFo0aU0zVGdCaVRyeWJOckRqTFpKd2djQ1RNMFBvV05xSjR3ZTVN?=
 =?utf-8?B?cTdwN0VSK0czOGNHOUlJZzE1R3V5OEk2U3FGNlhGZlF5R09meFJGL25kTmJi?=
 =?utf-8?B?L2ZoaTFjVGl0TW1ybTVWTTdWMGJqd1Fqc3hiQ09ITVpabEdaaDNRc3VqUVA2?=
 =?utf-8?B?eWJBMDFNSnNydzFCL3dxTnkvY25DSE9xVWRlRkxIMXczMFVVRExadXpDRDd6?=
 =?utf-8?B?QTJsRm9GS0FaVjJrLzhuT0hQeEZFMHU0dUtESHgzelhOZmFXK3kzbFduREI5?=
 =?utf-8?B?N2Y4cUNsQ2s0ZExjYmFrWXNSSk0xYStqbDlqbXU4T0pJWFdvUFBTYzdaVDh0?=
 =?utf-8?B?QnlyMTExQkxjYlNVZVZ1RW5haGpuTEJDMkhZRStsQ1ZqbUU4MzNpem82dDI1?=
 =?utf-8?B?QmQ5clJRRDZlQXVQS2VPa2tFMzdwRFVMY2tMVUxiZ0pPQWtoeUxlbFZhSG1D?=
 =?utf-8?B?SWs1aHdMWmQvWm1rTUlKeldCUVd3T2t4TzhDY0VESWxZSjZLMTkwQTlwZWVo?=
 =?utf-8?B?UFhHdDRXMC82T3VkZHBLcjVIN0R2Mk1uVzczc3lIdUNwOTRLdk1vYXBwNFls?=
 =?utf-8?B?YUFPanVoTllpRXYyVkt5MTY0cDIwK2dWbytZUDNuUXVyelB3MnVHOHJDTlhS?=
 =?utf-8?B?d29nSk0zeE5NRG8rTnpjQlBsQTVjR1FEQUg2NU5rUVRVcloybmh1R09WMDgr?=
 =?utf-8?B?Y0ZIck5pQzJ1S0JNUmRLV3lldnFlZ1VXenJOaDFwbVJXSmtDZHcyellHZ1JU?=
 =?utf-8?B?QkZPWmpXaTNISHdreU4vbG5sbVJTdmF4S3UzU3pBN2NJeGUwUTBkQ041UUZS?=
 =?utf-8?B?Q2VvL2U0Sk9tWFdlbVh3eEorc2FTeGVqUmNhYittZHFnSzRHZDdXaGo2NUhJ?=
 =?utf-8?B?TUU5RVlSY3dJalg1STczd2RXbmNBWHIvM3NmL0lObHFHd2NXemVJaXEyMy9m?=
 =?utf-8?B?ekM5aklZeUlEQ05GL2lTK2hIZWVSRE1mbk1VSjJ5QW5Bdi9rb09rSVBRMys3?=
 =?utf-8?B?dnNOR1Y4R0VWb1lWVTRSR2pZYWF6VDdCUm4wTktWSSszK21FM3k1Q2F3ZExI?=
 =?utf-8?B?NHVML2RyUU9JMGFmOFJic2RycGg0R1ZXemhMZ1pNS25XQ3ZUT2diYzlPSUF5?=
 =?utf-8?B?OEJHeWRyUnJ2ejY4MG0vZ202ZVNjVjJLYS9kWGVMa1k3eFpVM0EyekdhOXFi?=
 =?utf-8?B?clRuRENjU2N6MGNuRERrQzJQaktqTjV0OFYzMzRmU0VFQ2VtV2NrYmxkeEox?=
 =?utf-8?B?ZllWVWVwT0lDcUowMFRWV0JWaXdJRHBWTE1VdWVMN2g4YnJhSTU1d1ZPeGxT?=
 =?utf-8?B?aE9JNXg2dzJjZWpJYStsbW95NmhLTWcrakVHaldhVUlJbC83YnhPWHQ5THpi?=
 =?utf-8?B?YTh3Sjd0TGVmZE1rbG1pNmtXT3FjaUtuT0NmMDMxVmFqUGNnUnl1c2xMNEJZ?=
 =?utf-8?B?U1dnMHpHTFdaekx3bkNLVkJmNzdNU2ZxNUgwL3dod0Jlejh5K09oZHdITWFt?=
 =?utf-8?B?blRRUklBQjRmT0QyenpVUXlaTGtkaXJzV1huNktsYjVzcVlnWVcrRFd2WlVk?=
 =?utf-8?B?TnBBb2ZUUEw5Ni92bFMvSjRHUk5vVDFROGVmenpvemNlZ002b2RDNk45T1c1?=
 =?utf-8?B?b21Rdnl2YkdKKy9UTElQYTRyWFp3WHdNOGdUVmFNR3lublNDQXpMdTlmYldK?=
 =?utf-8?B?WSs2M1FUWmN4SjFHVGM0d1Zvd0UrelJTczFQcmFtM2Q4TzFQazVoT0ZzK08w?=
 =?utf-8?B?SERuNkphV3Q5dVVXWGFtMjY1WjdlV2x1Z0NPUGkxSUVOTi9hMUZydGY1ZVY2?=
 =?utf-8?B?WnB1SEdXYXBNQWRNOW9WaUphM2lLZGNYaEZoNVNTNjNhT05HdldpWlI5ZUs5?=
 =?utf-8?B?Y2U3ekJNUERkYlk1TThXaFFkRWpjaURwL0FtSjlLVVlvbjVwbm5aa3FFSmxQ?=
 =?utf-8?B?WjMzV01XdWpWYzVGa25FV2xjYUxyQy9QbWFJYWtqa1B3ZC8xV3FMRmsvUUZk?=
 =?utf-8?Q?l3Izic7UOp0+RpolaDzakkPbh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1ef4e1-761e-4dba-7643-08db4badf271
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:11:07.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kALIMjIkHythEsRteD0X3ao3NhR0L7SP8+apg6/75sOffi4vsy1pqhBQwr+TpmMp+jgjGOOVnaUXOjYSFqYz0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Olaru <paul.olaru@nxp.com>

The function is improved in the way that if the firmware returns a
validation error on the newly sent bytes, then the kernel will
automatically restore to the old bytes value for a given kcontrol.

This way, if the firmware rejects a data blob then the kernel will also
reject it, instead of saving it for the next suspend/resume cycle. The
old behaviour is that the kernel would save it anyway and on next
firmware boot it would apply the previously-rejected configuration,
leading to errors during playback.

Additionally, the function also saves previously validated
configurations, so that if the firmware does end up rejecting a new
bytes value the kernel can send an old, previously-valid configuration.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/ipc3-control.c | 54 ++++++++++++++++++++++++++++++++----
 sound/soc/sof/sof-audio.h    |  1 +
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/ipc3-control.c b/sound/soc/sof/ipc3-control.c
index ad040e7bb850..a8deec7dc021 100644
--- a/sound/soc/sof/ipc3-control.c
+++ b/sound/soc/sof/ipc3-control.c
@@ -96,6 +96,26 @@ static int sof_ipc3_set_get_kcontrol_data(struct snd_sof_control *scontrol,
 	cdata->elems_remaining = 0;
 
 	ret = iops->set_get_data(sdev, cdata, cdata->rhdr.hdr.size, set);
+	if (!set)
+		goto unlock;
+
+	/* It is a set-data operation, and we have a backup that we can restore */
+	if (ret < 0) {
+		if (!scontrol->old_ipc_control_data)
+			goto unlock;
+		/*
+		 * Current ipc_control_data is not valid, we use the last known good
+		 * configuration
+		 */
+		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
+		       scontrol->max_size);
+		kfree(scontrol->old_ipc_control_data);
+		scontrol->old_ipc_control_data = NULL;
+		/* Send the last known good configuration to firmware */
+		ret = iops->set_get_data(sdev, cdata, cdata->rhdr.hdr.size, set);
+		if (ret < 0)
+			goto unlock;
+	}
 
 unlock:
 	if (lock)
@@ -351,6 +371,7 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 	struct sof_ipc_ctrl_data *cdata = scontrol->ipc_control_data;
 	struct snd_soc_component *scomp = scontrol->scomp;
 	struct snd_ctl_tlv header;
+	int ret = -EINVAL;
 
 	/*
 	 * The beginning of bytes data contains a header from where
@@ -381,31 +402,52 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 		return -EINVAL;
 	}
 
-	if (copy_from_user(cdata->data, tlvd->tlv, header.length))
-		return -EFAULT;
+	if (!scontrol->old_ipc_control_data) {
+		/* Create a backup of the current, valid bytes control */
+		scontrol->old_ipc_control_data = kmemdup(scontrol->ipc_control_data,
+							 scontrol->max_size, GFP_KERNEL);
+		if (!scontrol->old_ipc_control_data)
+			return -ENOMEM;
+	}
+
+	if (copy_from_user(cdata->data, tlvd->tlv, header.length)) {
+		ret = -EFAULT;
+		goto err_restore;
+	}
 
 	if (cdata->data->magic != SOF_ABI_MAGIC) {
 		dev_err_ratelimited(scomp->dev, "Wrong ABI magic 0x%08x\n", cdata->data->magic);
-		return -EINVAL;
+		goto err_restore;
 	}
 
 	if (SOF_ABI_VERSION_INCOMPATIBLE(SOF_ABI_VERSION, cdata->data->abi)) {
 		dev_err_ratelimited(scomp->dev, "Incompatible ABI version 0x%08x\n",
 				    cdata->data->abi);
-		return -EINVAL;
+		goto err_restore;
 	}
 
 	/* be->max has been verified to be >= sizeof(struct sof_abi_hdr) */
 	if (cdata->data->size > scontrol->max_size - sizeof(struct sof_abi_hdr)) {
 		dev_err_ratelimited(scomp->dev, "Mismatch in ABI data size (truncated?)\n");
-		return -EINVAL;
+		goto err_restore;
 	}
 
 	/* notify DSP of byte control updates */
-	if (pm_runtime_active(scomp->dev))
+	if (pm_runtime_active(scomp->dev)) {
+		/* Actually send the data to the DSP; this is an opportunity to validate the data */
 		return sof_ipc3_set_get_kcontrol_data(scontrol, true, true);
+	}
 
 	return 0;
+
+err_restore:
+	/* If we have an issue, we restore the old, valid bytes control data */
+	if (scontrol->old_ipc_control_data) {
+		memcpy(cdata->data, scontrol->old_ipc_control_data, scontrol->max_size);
+		kfree(scontrol->old_ipc_control_data);
+		scontrol->old_ipc_control_data = NULL;
+	}
+	return ret;
 }
 
 static int _sof_ipc3_bytes_ext_get(struct snd_sof_control *scontrol,
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index a090a9eb4828..5d5eeb1a1a6f 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -362,6 +362,7 @@ struct snd_sof_control {
 	size_t priv_size; /* size of private data */
 	size_t max_size;
 	void *ipc_control_data;
+	void *old_ipc_control_data;
 	int max; /* applicable to volume controls */
 	u32 size;	/* cdata size */
 	u32 *volume_table; /* volume table computed from tlv data*/
-- 
2.25.1

