Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02151704F39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjEPNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjEPNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:24:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370293A9D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDoebli8+vzuZocTQEIC2hWIukLGhuN7KErIQ8nLtMftOoboe3op9C/mTeXsbpplAFOEtoZPlmCP4ZKkvZKmLKe6ace24EVkxGdei8v1Or2mFCfkPZfSzjs7Uk1QCltjFc4YwWadi4aMmV/QXMhqIvA3EzvZ70XkQC8+0WurZ2vcS5VQxNpaIEyE4eebOis9AC4UYNIK0eIO5KddjNpsqhKbk71SKswUD0M/ZKRaX3RmqNpZT26U9ksw45IFz0ni8eF4pSD0+YAcMzhBMwoFbnrk3otLbSdOtY/OcH3qc5/QK6X1/h0wz2VDleBHQ75FHh/me1cugC/k3ML1r+Ouqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXAvWKaynpHsAI1tgqGNwCOSqmltsAuQnpT0Am+tucc=;
 b=YZ1f2nsWjtIS1UeAh/ZYJL6u/ol+ouQX60pU0pnEq2FrXB5WCVJ6C5xmsqBDo3ClzaXfCay9mH8HEXtWzQ+EQCM1wy5CtmFvI1rviJjAphkMqYUHrkJwIO8KcYIvgnStrS3FQohDCXf/LWqyaknIC6G7A41eLuR7DrqJUt5wpHSN5HBETFtmFt6k45byyP04Rbn+ltaJf+9BS1hJFPvuVrtbRcTzojfcHo9/Z/hTy6D4qN6dQVkQNzeJ1lLsr6l2ba+410w/70mVWt+yLnWhpJm+cn7EBDrp/FRPH9dUr2JRpVat0a1V3CzboCeDDrfDWmR3FckAvx29IE+wSopdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXAvWKaynpHsAI1tgqGNwCOSqmltsAuQnpT0Am+tucc=;
 b=l0Je9Z2/+lCH8LHuOYAhhqJSE3w09bTFef0BdmyTvoRnbEWzIgz/vTfmo6NDSxSFxp/UtpUhM9CNPKolLVVo6o8kHyp/m66ubCI5lpa054KDMuA5tf1rEiM1OX89XW9/Dgx3kU6oCVFzh06K1MBGzVT2v3gm5uIa16yBTzjKUl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 13:24:25 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 13:24:25 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@gmail.com
Subject: [RESEND PATCH 1/2] ASoC: sof: Improve sof_ipc3_bytes_ext_put function
Date:   Tue, 16 May 2023 16:24:00 +0300
Message-Id: <20230516132401.205563-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516132401.205563-1-daniel.baluta@oss.nxp.com>
References: <20230516132401.205563-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::6) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: d32730dd-eca8-4ebd-22a7-08db5610de13
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WEZqJMY+C7hvnW9j57PyzeGRiNk1yEt6VX5qoVspeKIzpmMCLC1tJQZ2dpd7Uzd9tv1GFjR/g/kxoYXPzQ4Q7AIPJjAssNTlRWe7aesZBUD41RQ1K4KY5DvURwwDuQFv3vuI9iYLbg3JfAKN9FFNlrqpPdLhRCcDox+85vui0v+ZICf/XVvoXZg4mKuZL4PX7c6AXdQ1dSVUV8IWtxPXVoXBAZpHRihFR+E/FHqZoP6aaYx+fEs9gfDQsWm8+oJhh5IiM1bID57PHPjUwU68J5VOltJFpM7jsHbGirNNDncn84FpNKYM0cf5B3I1Vzi4F/Jkfl7OgAnOT8cjbwTowLbojJ/bI2km8UxNN+Ry27YLCDLxdZol5cvsJ7yXgs6VzsCUVrCEru9TwfB7MOQX5qPJck0aWy19p9QeEutdRwACyygQdTZXD5ltaUXwX7lN9Nn7q6LURWGeFxFQjcrA+G3pb9QHFT+OU4kohNo0Z847488Wk6+ZzJ2SU5K2Sq2Da9aQQADw3q4D4VFkPHo2a54YTWh7mwcWcAY+cyxVLnSLqUsRkfKaPqoApenfnZt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(83380400001)(66574015)(66476007)(66946007)(2616005)(52116002)(1076003)(6486002)(478600001)(8936002)(66556008)(44832011)(7416002)(6666004)(186003)(5660300002)(86362001)(2906002)(8676002)(6512007)(4326008)(316002)(6506007)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1RIdVV1RHNRNWZyeC9wYituYUlsRzhiUUpKNFlPU3Q5MVpXcy9BMUpqYmdw?=
 =?utf-8?B?bk5lclVXTjN5ck5KWU5IWkh5eUxFcVZoT1hrd0tpemNQOEsveUNWU2taV1Zr?=
 =?utf-8?B?NXE2L3VUN0MrVkJ2ZUVUaFdVcHVtSE80Mk9kR2ZaTzl1aU5mNkxuUGRNQm9a?=
 =?utf-8?B?QTNOazYyY1ZNNmp2eW02RmlKQVdBNUxmWHRPQXdCeUFQTk1BVWcrUC8rQ0Zh?=
 =?utf-8?B?ZTkzTE5BMDZPbCs5MTk5S21NY3pneld1Mlh3aUhuMG1IQTBCTHM4cVltR0pr?=
 =?utf-8?B?Njd0YjZCaTNVWTZGY1BhOW10QWQyTnJXVXNoV0dYSTdJVnJNSFRicDI0UHVt?=
 =?utf-8?B?VlFBMThobi9PRk5FRGZMd1Y0QzhKbW80ZXZDbU10U2xtREMrZVV1bjdxVEJi?=
 =?utf-8?B?VU9Ic3BOalpqdlJlVE15S0lXQWZZQUlqRzh4WWhZeXcrd040U01aK20wbHZv?=
 =?utf-8?B?dS93UlN1a295NWhKZFkrWWxCaDEwMXgzRnNIbHQweW5SNGtPajRSSEthbU9P?=
 =?utf-8?B?S0dPemU5K1JkTVZMUHNrTWRqZ1VERWlSejFuUXhobHFJeFE1cWVoYTRvd1hw?=
 =?utf-8?B?MDJlbUdiei83MlRjd055S2FFZGlnSmJOcUhrbmhmYjEzMFlsNllEbUNRVmp2?=
 =?utf-8?B?ZjhxQnF2SlNwSUg5cUl2b3VpTmFmWkRJRVZIVlBBaCtNWFgzM3RvMXRXMSt4?=
 =?utf-8?B?aHhycnZZVnFlVFBSSDN5L3BKdXg3bE1OV1Q0VTUxQjJiVXJtaStNRFNXOE5i?=
 =?utf-8?B?emp5UEhZd29mMDUveGwyd0ppRDlyL1RTek9hbmJML1JFN0J0RzFrVWp6TitO?=
 =?utf-8?B?UGsxN1NFbGZabS9pYytjbXU3c2FaNEJqVGQ1NnR2NmMvWWd6bVVPMnFJaVRH?=
 =?utf-8?B?L2EwdXpDYlFiTjhZRm1PRlQwUDlocHJIdGRiR2lDTXNyQ3Z1S1BlNE1sVDlE?=
 =?utf-8?B?UUE3Qkp5MEl2bDRRT21UZXRDMklpbkI3a0NpeW9xM2RLUGtLWDBiSW40c08x?=
 =?utf-8?B?QkpLUGFTQjFSZlFwYm95M2J5eXhVV2NQWnVOQlJLN0tuRDByTm5JVFFRT1k4?=
 =?utf-8?B?UXlPRWZtcVJlV2tiMmRjeVZLY3VORW84VlM1NWNGekk4Z2xTZlV5anViaUda?=
 =?utf-8?B?VGdWU3ROeTN0WkJKbEVRdzZtc1FmZ0hBaWRPWHQ3OEoxR3FZZmRsM04zeGNU?=
 =?utf-8?B?Ui9GNkVtMFBLdlFNcTVRZ1RuUWpKWDlqNDFSTGVMM2tTWXFEemRiME9Da0Z2?=
 =?utf-8?B?dnFjT3MrWGxGTjRLSHJ2Sm8vVWxZaFJRSUdpTFh3VUQ0Mm5CMjAxZTVoNnRT?=
 =?utf-8?B?bmlMZHJDaHpaWVhxYkVpU3NFM2hwTGMyeTk5Kzd3VHhJbVpwc2RjZGR0TGFp?=
 =?utf-8?B?VVB0RC9BdDU3TWYrQlhpdUlOVGJjN3RnenIvWUQ0NmhBdWlmOFg2RWJqQzhD?=
 =?utf-8?B?L21mTjBtVVU5RW5aNkFTTmhqVnBiMjR5VWNsdUhQQ1RsUGlFS3RPUGVzUDNF?=
 =?utf-8?B?OHU1RU9hbjRDMWUrTzN3MVFRZnRPSHN4WEJHR0xNQWY4UHBYR3pmL0RmdURX?=
 =?utf-8?B?WG9mbU1sVENMNkw1WW5MbWlLMzhyM0tvTXVpRkdrK3Fydk5acDFBcFpSb3hX?=
 =?utf-8?B?SExKc0ZnYXUwUlUweVAvUHlVMkJ2SUh2ZVZYVnFDc3FGTDltNHpBVXFGNUZo?=
 =?utf-8?B?ay8xZW1oa3lZak42SW4xMDd4UFdzanMrS1RaMW1JaWl1TVlPaTBLMldZU3Iy?=
 =?utf-8?B?SFBHSE5SQ2hIc3RFWHQzdVVVc2R4K1BQQi94ckJCUFhaczgySzU2NHFEUkZi?=
 =?utf-8?B?ODVMQmRhWGpCbUxBMW56WE52c1lEWWduS2VhUEUya05aMlc0citZOFd6ZEh0?=
 =?utf-8?B?VDEzeWk0NHR2b3BIUEJTSHpnSTNHczUwS2FRZDg0YVQzOVB5SUlEMW1jYStB?=
 =?utf-8?B?d1M3bFk3azA2TFROb1dlU2pSTGJXcFNyZ1U0Tk4xeXQvNjBaYjVNR0NPYUR5?=
 =?utf-8?B?RWNMYlV5NW5RTjhpN2RNVFpwVDJTcDhTdzlkbGFhcVZWWHRldTJyaUc3Rnp2?=
 =?utf-8?B?UlpxTndoNEpTUjlPcm9WTVJhdUtabURpNzFZUG8yVzYwZW5Yc1loWWI3T2RQ?=
 =?utf-8?B?VllhZXdZSS9zTmRHek52MjJVdHA0aEhtanVmQndkd0pyNlQvZXVEMTl2aXVP?=
 =?utf-8?B?QitibTNobzNTUWIyQm9Mb1J5L0lpL1lZWmdka1NnS2hUK0tmUjE0TEUxM2g1?=
 =?utf-8?B?WmVzMGwydTNSdGNXQkdBMEh3WURBPT0=?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32730dd-eca8-4ebd-22a7-08db5610de13
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:24:25.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu3VSr9ahasiJwwl1olRNPS60UJ11lnKyUuhPqNrFHZzLxphaErIsQi3DJiGOWmnhAyDogfl2PYsSW9YGvzJtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

