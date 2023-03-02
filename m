Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095BD6A7B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCBGWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjCBGWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:22:46 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414553BDA8;
        Wed,  1 Mar 2023 22:22:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad8q4bpPZqTkXMhPC/C/ikn3LP8qaDCeWx2Uq43QQanPr/hmC6lmwJkT2jYJF9iCcFYezr+Ga6xuWpYyyTuBW8T3VnctuGpv7ZF6+hgoxlUZxLpdJqlw5RP6mROrSR+/n/niTpQK8uPQTgcqEfq2ZmafJT9Uf041XGoRyJcHcokgIHI/sA9U+8YMC/NlU6Jo4i1XbZHTDfmhbt/q5dTsMxXX2JPQDUlczOjrfa0P8gSAt17sXuPT4WyIFBMIdoLfVNcjR1gt8M0iiOrIGRge4Rn3SKelQ3pvmgJbQKrN+vIdnbhZRrauLgS4/rcQEnqWmQWGkxVa3imUhpj63lbReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0L8UxVO0mJp5RvLSztyzX4a7F21cDJJjEg31u3E704=;
 b=OFvcst0eVtplvwaV2M8E234JMjRYInWKNovuoS2W45SFmfiMv/3mQ1ZMSzIFqx2zLLANkCgrOmIEyfFKMMrokiv7e8FFF9EXqMCMDWS8RAql6v8Jn0FfvVFHtsFFQq17USB/07PkWidK8qFAUxAGWsCZz759Z1PBZ0n/JsQ2NsSeGZsyqye3OxUCJpmIsbiS1rUxPbyzKlGNbIVplsIJQQnOoNYg10yZAxBPBMLFWHpDEFu84BdJw6SA6tTfMH7FQthjdPReonVbtz/h1jOtFGLAtoCWnobU3J8KJvEfkLF5DR0NBU37p58wV4hSnnyQHId/9Ou1S6ZzSbSFEc2efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0L8UxVO0mJp5RvLSztyzX4a7F21cDJJjEg31u3E704=;
 b=D1mCjsn95HgeoIRowEC656l+2SBmlHEX6pjWAJVaczWwYRZ04UAL7mmIWXGo7AutUKGbu7/y2UWPBLbGyiXXaqPsfv5YVq8P9iLA8R6Op7KaHdVnS+qzNPGo/hvvwGm8wnKbnzRKIsCmsgTuI0rrfjVnVetWxLJBvNZq9FTKrz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DU2PR04MB8632.eurprd04.prod.outlook.com (2603:10a6:10:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:21:31 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%4]) with mapi id 15.20.6134.026; Thu, 2 Mar 2023
 06:21:31 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 2/2] crypto: caam - OP-TEE firmware support
Date:   Thu,  2 Mar 2023 11:50:55 +0530
Message-Id: <20230302062055.1564514-3-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302062055.1564514-1-meenakshi.aggarwal@nxp.com>
References: <20230302062055.1564514-1-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|DU2PR04MB8632:EE_
X-MS-Office365-Filtering-Correlation-Id: c8404737-230b-4671-2004-08db1ae65d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVlXWJpMrOw6mubJ9WOTv5QmNxPyS3SWMrzwuDT82gmaJW8Lssp5dSbxgKj0G+FtSOufpqyhIpEMy8j4yO93aL50FON31/dXzrY9nrHSaG6pbuIzANCs8/OiNrjbvz/hwhzUzT2y9h/BznB0iCY0241CUU+jCf2+SZrqvsBqlxiDk63ZfH3xr5tZvD761wx3JbpPBvZjBaSYfj5zDnoKO57AnNWBlF9pIPRmScTREUbBlOLJmZnv0d8zYidO1fmDRL9WI5dC7q4T4Y9csCHAN1OmsNkBNI+Ii6k7UPTfMMc/u66vThNNfCFwCyDDNZzEfO9vbR1yDDYXYq2aAvrczq49o6n8pWt9a0PYHzNeThTeLTdl2iKX6qmsQRgItj10ZkDFBAvhm4a6gQx4U8OYZUEiRu1jV1Da9tAIa2zC7B7RmlB43zrFZkjObrgSN6PH9f10K2DhmxaY/iJci6VB70vynQ1zKOjMNM90zojhFsuocCuaJKBVqOkSuivmEorCLKWEZBuFsE93lCd4kTAu7Z0nmJ7Q0jd0OkOJaV5dTAfCpVRQMDalvtR8lX1MVemc9H8r8nNg9LVgC+cnczl3VK2ZnA7THFmWXiZ0ydQuy54qB0D+LihaJkJ1wn0C48iwmIkSHDmFpw9Ez0gyjzec5QSG4zx9UWRkFJFbGk2lDIlJ2nRweerd272HqdnqNjFAsbFF4DKrJcnbFneMPJlBjj+gn9/Dzk0lgLp/rLRhcJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199018)(5660300002)(41300700001)(8936002)(38100700002)(38350700002)(4326008)(8676002)(83380400001)(186003)(2906002)(66946007)(66556008)(2616005)(66476007)(316002)(86362001)(6486002)(478600001)(36756003)(9686003)(6506007)(1076003)(26005)(6512007)(52116002)(6666004)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzAvWTQ3WVZ5VDFlVmhidFUwbzVHZ3lPLy9lVExITWdYakdpckZaVWt5NUZt?=
 =?utf-8?B?bWZCLzB1dEJUcXRyNmF6RlI0ckRFZ0ZSQXVjaUtPT3ZJTFNXZ3d3bWd6bmtB?=
 =?utf-8?B?cVR4V2JiajRNR0E2SkNxblFpdUFiaGxlcHFaOHIwMkxoWTNqaWlCTE5ITkdL?=
 =?utf-8?B?eU5DN3R1LzJvV2gzZWZRZjZoR0NER2Z5cDhZYUt3N090azZXeTJqUUo2OXdB?=
 =?utf-8?B?eXRCdUpkMndPRGRCald0YmVNMnNCYjQvTWtnREc1MHNTdU54MVVFK0JCSWp6?=
 =?utf-8?B?OE0zdGhzRUhWMmErVFFCZkRZOXdnWkNLb3ZiQmVxN3k3aDcxMFo3Y2FLcGtn?=
 =?utf-8?B?RXJ2UHZrQlVjZ25wUnNrMGRHaTV3cmJNQ0RodzJ1WXVqUlV2VzZ0NHVnY3F6?=
 =?utf-8?B?Q2ZMN1ppQW1HWDZ1QXdqME5rK0ZNUy9rRjAxcU1HOGlEaWhMZ056bFdMZmpK?=
 =?utf-8?B?dTNWZ1NZNHVlcXJDbDc0MzBlR0JQTXpTUUJPWHZuN3NLNmNDcW1wTExMKzZC?=
 =?utf-8?B?N21HNnNzbDVzYWJoSmFIWVMyVlNiNlVzRnVjSWlDMHgxREF1VUNiQmFIN0Vx?=
 =?utf-8?B?b2ZoMkRGZ294bGNMbnB4SjJDTEtFOUl6dW9wdnhYSk02Q1NqUkhMWjVwRFpj?=
 =?utf-8?B?UnZIdFFoMzhmQUpzMDRxMUxQU05oZjlCVHZxNENKc2pSd2JkdHBpdFR1OXUw?=
 =?utf-8?B?OHUwdVNYcVVpVlhIcDUwRHp4ak0xMXg3OEtUV0E2dTFsTE4vSHR6WDhTalFq?=
 =?utf-8?B?Z2V1OWNRN3hhMlpQRityRXBVQkVFUklSQVRSV3dVWmdhNGlMeklpLzJweFFq?=
 =?utf-8?B?YXFCdDRhaEJmM3pZNGhUM01zdkN1TjV1RTRhdXZZTzNnS2ZhQWQzVDFCMFhq?=
 =?utf-8?B?NnFKSFRDMUhvbXRSNUxjVnkxUEhqQjdEZktxdTZSTlR1bXAya0tObC8va1k5?=
 =?utf-8?B?U1NWRm1IOE5OdjNZV2FGZ3ZvQ2Y1Ylh4aVRhUEUyL0RTZWNXQ05NUTJsOG9H?=
 =?utf-8?B?eHlaaXVJZS91bjBBaGlkaTBqMzNBTE1BN1gyY2lySzY0SXBpYmZxSFRKZ2h6?=
 =?utf-8?B?ZEhQVDdKbWI5UjdZaEdhY01ic0JvQmdwQ1NSTHhLaEVkMDlsRmZDYnBueUZu?=
 =?utf-8?B?Rlc3NDNWSDdZaThaL2FWcWtuQUxOYUNvdnlQMlN0Z3lrbnFoMHdZMTdnUVRh?=
 =?utf-8?B?cG91RU0zMzFvbFIrNC96RmJ6WUszK1FwbFJSRVUzdExvanBoUHFHbDZ6YmFv?=
 =?utf-8?B?b1haN3Vvb3o4b0lXZFAyR0hVeWpEK0VzOHYvOFdsbnZXRFp3Tnp1ZjVrVzFJ?=
 =?utf-8?B?U3dGbDJmVjVHZENEajRtdWFNUFQyUGdsOVJoK1JORUFTRG85cmg3U1JIdElI?=
 =?utf-8?B?WlMwd2tPNTZlY3c3a3lXMDBNUHZxcEpDTW0rdmJsNWdvL1J1ckVVMWFVM1do?=
 =?utf-8?B?dGlQaDlnV2J5UHRtdXkvdnhsVWZiNkJFaVBUYW5Ub1kzaXRGU2dTVm1wdEZJ?=
 =?utf-8?B?MS9aaUZUNVErWDh0RVV4WWtvVWZJSGRwbFlRK0d5TzU3TnBNQ2x2eDZIRUhq?=
 =?utf-8?B?VzV2WEpDTGhVTHRXUXoyUnpCVG9mVWJVbXZvTjFnbXZ5MTYzSEtPNWhhck1h?=
 =?utf-8?B?UEg5QnBackZYM2NkdVNMZkRmQWJOYk41TXlkWDA4cXdrQm9yRlJIZzZpL05O?=
 =?utf-8?B?Wkg3OUQ2TlVOb0NQK3dTK0o1bGoveUFxR3crdkg3SGlBMW41ZkNQeVpaa2lG?=
 =?utf-8?B?dlBnVW9qODBTVnBiTDgwNHFNWVpqQVplR3FESjZpQ0tJcjV0MEJ4YmM5cERW?=
 =?utf-8?B?TlRKR1B1aDVpenBPcHVJRG0yYkR6ZkppcWptaGRPeTdFbXBmMklXUVo0MVZ3?=
 =?utf-8?B?c1dVejJsRVkxcXMzUW1XYVo2eUppaUIyeDRhYkFaeEhUTWpZOW4zSlFFR0du?=
 =?utf-8?B?Q0Y1Rmc5akhzTGNqcTh6dWtUcmxlbjZtTUpTL3FVSTdMTmdVYVdEWkhCSUsz?=
 =?utf-8?B?TFE5bUVma3RDTEhYUUtETDVkbDl5NEV0c01SYXlmSjlIeWdlY3Rxd3RIdmlB?=
 =?utf-8?B?aGxPK2t3Q0pGK2RMZVlOWFMyMTN5eE4vcXZJNVZJTUlqMk5GMm5FMU1vZE9h?=
 =?utf-8?B?QjRLaHdGN1drRGI3YUh4Z2cxbGliSVNaZStyTmM2Y3BYMVdHTCtsOGZQQWw4?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8404737-230b-4671-2004-08db1ae65d6d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:21:31.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7T4kVdN6g4pw2KvJ75uPyvfi0WDCXn18WS/DRQdTOzIVAXXGnYawooYoQb/qfZlaUjXwe33G93VUtfII3K9p6xcUUe1pm0s5qwW30IIsAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

caam driver needs to be aware of OP-TEE f/w presence, since some things
are done differently:

1. there is no access to controller's register page (note however that
some registers are aliased in job rings' register pages)

2 Due to this, MCFGR[PS] cannot be read and driver assumes
MCFGR[PS] = b'0 - engine using 32-bit address pointers.

This is in sync with the fact that:
-all i.MX SoCs currently use MCFGR[PS] = b'0
-only i.MX OP-TEE use cases don't allow access to controller register page

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/ctrl.c    | 24 ++++++++++++++++++++++--
 drivers/crypto/caam/debugfs.c |  3 +++
 drivers/crypto/caam/intern.h  |  3 ++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index be9724d05d01..5a6cd63742a4 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -633,6 +633,7 @@ static int caam_probe(struct platform_device *pdev)
 	int pg_size;
 	int BLOCK_OFFSET = 0;
 	bool pr_support = false;
+	bool reg_access = true;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
 	if (!ctrlpriv)
@@ -646,6 +647,17 @@ static int caam_probe(struct platform_device *pdev)
 	caam_imx = (bool)imx_soc_match;
 
 	if (imx_soc_match) {
+		/*
+		 * Until Layerscape and i.MX OP-TEE get in sync,
+		 * only i.MX OP-TEE use cases disallow access to
+		 * caam page 0 (controller) registers.
+		 */
+		np = of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
+		ctrlpriv->optee_en = !!np;
+		of_node_put(np);
+
+		reg_access = ctrlpriv->optee_en;
+
 		if (!imx_soc_match->data) {
 			dev_err(dev, "No clock data provided for i.MX SoC");
 			return -EINVAL;
@@ -696,7 +708,8 @@ static int caam_probe(struct platform_device *pdev)
 	caam_little_end = !(bool)(rd_reg32(&perfmon->status) &
 				  (CSTA_PLEND | CSTA_ALT_PLEND));
 	comp_params = rd_reg32(&perfmon->comp_parms_ms);
-	if (comp_params & CTPR_MS_PS && rd_reg32(&ctrl->mcr) & MCFGR_LONG_PTR)
+	if (reg_access && comp_params & CTPR_MS_PS &&
+	    rd_reg32(&ctrl->mcr) & MCFGR_LONG_PTR)
 		caam_ptr_sz = sizeof(u64);
 	else
 		caam_ptr_sz = sizeof(u32);
@@ -761,6 +774,9 @@ static int caam_probe(struct platform_device *pdev)
 	}
 #endif
 
+	if (!reg_access)
+		goto set_dma_mask;
+
 	/*
 	 * Enable DECO watchdogs and, if this is a PHYS_ADDR_T_64BIT kernel,
 	 * long pointers in master configuration register.
@@ -799,7 +815,7 @@ static int caam_probe(struct platform_device *pdev)
 		clrsetbits_32(&ctrl->jrstart, 0, JRSTART_JR0_START |
 			      JRSTART_JR1_START | JRSTART_JR2_START |
 			      JRSTART_JR3_START);
-
+set_dma_mask:
 	ret = dma_set_mask_and_coherent(dev, caam_get_dma_mask(dev));
 	if (ret) {
 		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
@@ -842,6 +858,9 @@ static int caam_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (!reg_access)
+		goto report_live;
+
 	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ls);
 	ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
 
@@ -945,6 +964,7 @@ static int caam_probe(struct platform_device *pdev)
 
 	/* NOTE: RTIC detection ought to go here, around Si time */
 
+report_live:
 	caam_id = (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
 		  (u64)rd_reg32(&perfmon->caam_id_ls);
 
diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
index 73fe8530c0d6..42081224f568 100644
--- a/drivers/crypto/caam/debugfs.c
+++ b/drivers/crypto/caam/debugfs.c
@@ -76,6 +76,9 @@ void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
 	debugfs_create_file("fault_status", 0444, ctrlpriv->ctl,
 			    &perfmon->status, &caam_fops_u32_ro);
 
+	if (ctrlpriv->optee_en)
+		return;
+
 	/* Internal covering keys (useful in non-secure mode only) */
 	ctrlpriv->ctl_kek_wrap.data = (__force void *)&ctrlpriv->ctrl->kek[0];
 	ctrlpriv->ctl_kek_wrap.size = KEK_KEY_SIZE * sizeof(u32);
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 572cf66c887a..efe2bc2f1103 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -4,7 +4,7 @@
  * Private/internal definitions between modules
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2023 NXP
  */
 
 #ifndef INTERN_H
@@ -94,6 +94,7 @@ struct caam_drv_private {
 	u8 qi_present;		/* Nonzero if QI present in device */
 	u8 blob_present;	/* Nonzero if BLOB support present in device */
 	u8 mc_en;		/* Nonzero if MC f/w is active */
+	u8 optee_en;		/* Nonzero if OP-TEE f/w is active */
 	int secvio_irq;		/* Security violation interrupt number */
 	int virt_en;		/* Virtualization enabled in CAAM */
 	int era;		/* CAAM Era (internal HW revision) */
-- 
2.25.1

