Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24D76F52D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjECIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjECIMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:12:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36146A3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTqTlgYLnEMhsfYQROcOmprRN8oEy1wsfL66dIAnSiMgKXpZic+RKM3/DEub9xWO+dJDInbi2Oj64peQkWd71RX2+nFHXP15eIykKVTfUKPfdWq+/M7xSAUsnKLI7dWi/qNwFxsKJugncFQ+Ab5sphqPkU1DCnETNZQSym+sDScPK20VlF5jGQmr88wzBWD1y1LEb85rRzzYWaHL2wzdh0LgX01JEO8pgZRjgNPS7p+PNLk5i0dzDLhejBecx/dxbAUaogm/cisTyK4LjbXhjxL9u46RBAuSCKJueqWzEUUOSqg2UAMnH4egAa27jtbYpQF2uSHylfRuxCc8CkUwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdJB7DfPMN5TpI2aSmxNRf/xXhSL2fePyA3eXXbmOcQ=;
 b=D9u3pVrV01X8R/oQ4CR59qGi9EGEww6IqRc31yoG6D6nKgaQT5M9vp2CLvY6eomBLSmKNR54EDBKLP8mJyERKvJJDWB/M7GrMDgfZ4iuXKzharZFWowopbzcPUqFmwi5NgeHVfV4QzsyZJ+lbJv9j11HjW5gVPOFh4sDXCVTZQHR2HZ5F1LWDEfLPM2OC/vIZ7Yn9S7jMXW3nMChmcOqKFogE3rTK5CyNw1oX4WPLKJRMTHxeqX/iJqvAcin5Nww85m6eQG9sSdavs89cPJNpfnjG70nP6S5XJL8IveLygT/AdLL13BF4CBK08K5RMrPOuqofJEfN/tkiiQMNcU6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdJB7DfPMN5TpI2aSmxNRf/xXhSL2fePyA3eXXbmOcQ=;
 b=Lp0EW/wEoyHgm7h4Ew5qRJcEO0iQjg9MhPo1o/hrqEXkjOnAxeZlAlh/hHfwdHrBv6MwQyQo68GYfI8PvnT1JyN3bkw9sT6dUMehtOexvUpM4FUtfFQIKkuia2DyP667XnSbva8npa802Mc1h5vQjE121dOZfesA1iRp1CtjCUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 08:11:08 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9%5]) with mapi id 15.20.6363.021; Wed, 3 May 2023
 08:11:08 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@gmail.com
Subject: [PATCH 2/2] ASoC: sof: Improve sof_ipc4_bytes_ext_put function
Date:   Wed,  3 May 2023 11:10:49 +0300
Message-Id: <20230503081049.73847-3-daniel.baluta@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b490060-08b1-434a-ceb2-08db4badf30e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKoiAFxfHhWB5Gy3NX0lff7IHkHv5gHc56JewxRByijYaBWHdYQjjhxv/FJGEEHY3DdwEXYIWpafuyb9BAr5opRhHimVeuRTbiD6LKemscH8SuvA4rTKOHcxn37Jq9gTVm457Y4hZWs2xy+Mk1LrOnqHH8DY/fhaEMKtJs2bXrayLR1iRbxBBguDnoWu+rG2FIJMlDWD9bgNIFOI+8gwXFA+2uu/9EgUexJc3AvOVbH8bNOQLVR+ExCFDEsiEqjLwFhyTGKRb9z8R9Ec5V5dO7lyEvKP3Jz9KUr/Ic123P3j2A8eZqmPpFiF1BCi3ucRnvD8w+maCY3e7e/VdAdCFPsn+N4lZVP7/RosRT8GszdaF6OHt5nj8HCOomP8tE7Gm09Z2YZ72nlSFPLqppBY1LTXpoMpebbSWfPlMdlu3b4ze4Mlh3D41/3YOSBwI9FJB7oKkX1ZVvSp3wTbnNQJfwgStSCO0aGAngoXxyFoNyZe8ppSngHcY4KYhCTaoa7lca/uvEi7l5DMovKV8dlc9OGw3hIkje6a1HVPgYAEVNFn88FPbdYs0Riu1jNVVuEu+Y+rjFnYONKRWMqcXFO+VPKnpWCIWWbPL89GmPOwZEJp6zbLlwyN0ESgx+Nw7VQW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(2616005)(83380400001)(478600001)(186003)(4326008)(66556008)(66476007)(66946007)(26005)(6486002)(52116002)(66574015)(6666004)(6512007)(6506007)(1076003)(44832011)(316002)(8676002)(8936002)(7416002)(5660300002)(41300700001)(2906002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFg2MldlYTlMSnFCTmR1YWt1aDhmYldDdS9kRUh3enBqVDNMS1VtcEhRZXhP?=
 =?utf-8?B?Qk0zYWZWSk5jZVpoaitlMEFZVkZnaXdVYi81SjJSNFB5TUxsd2EwR3Evd3Bn?=
 =?utf-8?B?V0FJREFvQlZXeHEwbld0TEY3NkxiWWp6WHpGcW8wbUdMamtsSXJzT3BNajRx?=
 =?utf-8?B?elpFQk9HcnpTQXRsV3pDR0xCNzFkZmUwbGpDdXk1N2FLbUQxSGowbmdQS3Zp?=
 =?utf-8?B?a2YzVDhJWFYyekNvbW9yQU5QV09TNlZLN2FaK1JMUkc2SEtUcU5ObGZsSk9F?=
 =?utf-8?B?QmRZTUhQRHdaOHNIeHRIRFFVWEF2K2VsVzY4TzBaUW9VMGF5TnB5MTFkWkNF?=
 =?utf-8?B?K3BwWnR1SzJSM3hKUEplUjlWelB3anlVZk1YWmowRHN2RldtVnYvbFMvVFVG?=
 =?utf-8?B?Q3c4RWJzMWRsL1daS2JXK2lsalV2UFdqcmJkTE1GdWtYajBnWjNHakhxdktz?=
 =?utf-8?B?MnlBVnF1L05wcldmcUZPSmlSNmNrSENBY3JTajRZb0dTUXlOemo3SzNFc0hC?=
 =?utf-8?B?QU5TbEc5cnM0SnZSVTBOcXp2MDhjMzF4VVJsMHVwRmIyd1VOMFo0djV5c1R2?=
 =?utf-8?B?M01ZUFVaNkREdksvWG9xZS9UcjM4ejNPYUIzVnhWY0ZlVmxQdzdCYlJKemsx?=
 =?utf-8?B?RXIvQ281REs2eUM4UUVLT2RwdHU4YUdpU1RaTzREL3lKbmJtbmgzSnpUOUds?=
 =?utf-8?B?RTk3UksyVGp3R3M0eDJJL2pnaHEwQjZNYU52T0lja2JJelJ1d1ZZMUtIOWs4?=
 =?utf-8?B?bU1TWGVtVXR2ZlVzeG93b1REd0w1OFRCNkp6cll2cmpuK2FuU05GS1RaTGdN?=
 =?utf-8?B?T0JSVW50bWRLRStmcVQraEVlMWVNTGlhQ3ozVXNzcVJhWkRodkd6Y0Z0emdz?=
 =?utf-8?B?UG54R3Rsd2dzN1RGdUhiNGdEL1RBa3o5T2ZBRkpURTRIUENOVnBuSDJUUitG?=
 =?utf-8?B?ZTdSdU9RbFc4TjRLSWprdlZHc2tlUDVyZjJwOEhBVXlRb2g3cDIxd05pc0FB?=
 =?utf-8?B?NEYxZXFLaTQwMVVjT2pPZkU0VHNNLzlaSURRN1QwRlJERytQdStNSmhPWjU3?=
 =?utf-8?B?MmtNUUtVWjJJV2thd3BBSmJMYm9aR2szQklpM0QwL2F6VTUrWnRyOC9kTkw3?=
 =?utf-8?B?L1QrT0Z4N1k0OGpvTG0ydUgrSWlYME5KMmxERnByMjZsSExVS25RZExhR2c2?=
 =?utf-8?B?T3E0cVVZQTZaWHhVNHkxNFI1Q1JZZ2ZLVnVyTW9HT3VBd0NOV2VMcEYvenlu?=
 =?utf-8?B?M2p1VERhZGpiSlFhc2crSmxwdWpobitUN29uNkhueW9VR2RqV3o1U1ZxL0Uv?=
 =?utf-8?B?dXoxa1lqNSsxdUNUbzVHenhmLy9zTGkrRjRnTjVHZk9tc01vaklOSE94NGI5?=
 =?utf-8?B?VTVWMm03QWYxUDM3aUxOM1NQVXdETHdGb0liTzRjazFta1VHSXVkelcwekpI?=
 =?utf-8?B?d1VGS3MxZmRCbHpZUFZ2dytXaENyRGNLcXVsamJ2dDVQcXhXNGN5Q3JSS0t0?=
 =?utf-8?B?U0dicVdjQVp6bmtzbVRWd3I0NWVEeDNvS3NuelZtZU5uY0lFWkhLVnZLUG9j?=
 =?utf-8?B?bjlmbmZIR091ZGtCV3VScTdOeFVjd0lOc1hRZUFna0kvTkpmWmVRVnJHdXBU?=
 =?utf-8?B?MCs4ME0xVzB3Qkp0cndWeFd3TUNGbDBTeUZoaFZ2Mis3WUN1RzhKRGJFQktI?=
 =?utf-8?B?YU5SSDBqMWpWQkZYQ2VVdnZUQWxIYmljUGQ5a1FhK1ZwcVdqVFkvT1g5YjIr?=
 =?utf-8?B?ZjErM0FYa2ZIUFk2dDl3VXFJeE9xNjBiVHYwN2szbXJOUXhCbERiczBkdnpr?=
 =?utf-8?B?OWlPVWtFSFNHdjlxSTVOMkw3V1lFSFFyMy84b3FvN3JCRVVLODl4QkZVdFlC?=
 =?utf-8?B?UFRrV2NZTWNBY20rZzUyYzBKTFFseFkvYisrNFd6V3VjVGlORndBZ3REQitQ?=
 =?utf-8?B?RVY0bXpwdkxlTk5LV2VUanYyZnFJZHdWUEgvOWxTQ0lSS2NBWnFlbzF4L3RR?=
 =?utf-8?B?OHVSa2ZpYXQzY3NHK2JOU3RmUGFMZGpFb0pkRklOWnljcWFSdEVyNWhyaWpT?=
 =?utf-8?B?Z1MyVGxpWFRaSyt4cE1OcFU1QUEwUHRicE9LN1lDRHhNK09STi8yS2hUa29P?=
 =?utf-8?Q?psv+XMOZsxz+OoDJRuWODLI7c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b490060-08b1-434a-ceb2-08db4badf30e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:11:08.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kpfy4lJV8SZ7TSiSS8U9gvcq2I5U0qGjLzo73+lwHn09r4jLPB5SmMBixFRnz/j5VTWXXHDCaNOr6BDLBJdqzw==
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
 sound/soc/sof/ipc4-control.c | 39 ++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 6f0698be9451..c6d404d44097 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -54,6 +54,26 @@ static int sof_ipc4_set_get_kcontrol_data(struct snd_sof_control *scontrol,
 	msg->primary |= SOF_IPC4_MOD_INSTANCE(swidget->instance_id);
 
 	ret = iops->set_get_data(sdev, msg, msg->data_size, set);
+	if (!set)
+		goto unlock;
+
+	/* It is a set-data operation, and we have a valid backup that we can restore */
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
+		ret = iops->set_get_data(sdev, msg, msg->data_size, set);
+		if (ret < 0)
+			goto unlock;
+	}
 
 unlock:
 	if (lock)
@@ -327,13 +347,24 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 		return -EINVAL;
 	}
 
+	if (!scontrol->old_ipc_control_data) {
+		/* Create a backup of the current, valid bytes control */
+		scontrol->old_ipc_control_data = kmemdup(scontrol->ipc_control_data,
+							 scontrol->max_size, GFP_KERNEL);
+		if (!scontrol->old_ipc_control_data)
+			return -ENOMEM;
+	}
+
 	/* Copy the whole binary data which includes the ABI header and the payload */
-	if (copy_from_user(data, tlvd->tlv, header.length))
+	if (copy_from_user(data, tlvd->tlv, header.length)) {
+		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
+		       scontrol->max_size);
+		kfree(scontrol->old_ipc_control_data);
+		scontrol->old_ipc_control_data = NULL;
 		return -EFAULT;
+	}
 
-	sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
-
-	return 0;
+	return sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
 }
 
 static int _sof_ipc4_bytes_ext_get(struct snd_sof_control *scontrol,
-- 
2.25.1

