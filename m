Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082363561F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiKWJ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiKWJZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:25:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2548B898DA;
        Wed, 23 Nov 2022 01:24:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/Lbl118m+mOI3j5DSus5nNhCwdktKX2qvlsOeF4rb3RqFXUWeu9/Y9WuudnXNF6Tj2CEFKnVXXq/LAm691iIg1GN6gZOB46ow3gVXeRf3okmbmWAYH8IFYRJOzdeNEbA9C8lWR4AiGSAUHVfyqB3/mPYiPKde45bECkjU4njHIF873oVGGfxb16Ln0R5+O1i+IcRtjuL0yD/Ote7OAziaTISLNLCJL2fPXKljbjPTxVqO1H8XJyZ4504tg6iK6EymFVFB8EE8xvsgVGHPOqmaj/vDTI/1IXA5Uw8F4zvisAjDMXeHZc7Hh+vJffRCa2Zj0gMoNtOkNdy0K5G2vGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR/ZziWtBZWDpsvMQCxlA9Pjokn8pzrRCD7G1BTIAP4=;
 b=XBFRwe+hBsFaWx5iHk66yrlX0nxkJr/Ie/VMCOaMw1yPXT11/NeorRUO36CvrPBCi69mMjvnRycS9XAOhC4UycTJb0WQJ7ke3YzFvbUSaPkLCKMH9BFhfyMIuBqhE3cd8SQIUyYBtnjyCcfsDg67FD/eNRkDftplzEiNdwvT2vpGnnstUvi6kWrorwRdPUtl+KBTZjRzX3cfvxe0VcgShTci6QFBcr5ebSOQg5wiBGZU+CbD7uU239nLE2D6JFM606RFq9dABR+hqP2u61sNGisZpvJSbpVwojgUXnyyq62XZwao5BktrS68XyAPIWEMoLhM8pcDRIf1fRBViJ2e9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR/ZziWtBZWDpsvMQCxlA9Pjokn8pzrRCD7G1BTIAP4=;
 b=XoTG+EbNnYGqeUIjs6Ki9JCti4QmUZIfmMM28nBlA9a02KYdxaa0kF53Lcnsg4fH9FGBW6zSMJl3QrQ9+xTIPa28V4TYiSJ09XMCvCMA1QeEtTKtW0JUwbAyPlznYj3JQdN54Iw5Ybcp7lAjPXVUy2INsaOCpqOJdhtVgqp7DGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SJ2PR03MB7041.namprd03.prod.outlook.com (2603:10b6:a03:4f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 09:24:49 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 09:24:49 +0000
From:   Hsia-Jun Li <randy.li@synaptics.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sebastian.fricke@collabora.com,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, ming.qian@nxp.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        linux-kernel@vger.kernel.org, Randy Li <ayaka@soulik.info>
Subject: [PATCH] media: v4l2-mem2mem: allow device run without buf
Date:   Wed, 23 Nov 2022 17:24:27 +0800
Message-Id: <20221123092427.76055-1-randy.li@synaptics.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SJ2PR03MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e86fac5-5d9a-45b2-4555-08dacd34912c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VFrv2z6N6YCnLFST++5KfqS+olOwvvj/HUVboivWf9UGIUFE3iIuKvw61yGB/MVDMb0ip5d0NwrBiC7LrhXQvbYicyZBieKI05wycTS5yIsxRMa0nIdqmP7xeDFpVEnh8l00QYlt+vgfa8pW1MpNTYofKePbg+ojskp3jKS1xC7Ji+ZfEaKgIs27Z/7G+B0iq6XYgDNCf+Gxv0rqf9rPCPVjKObu9LKF0MDaencnopWz3AjoUb9E6V1qn6CK3Nb62H1B1OW+bL6YdsXgbOto4zlGyMJi8ZDviGTaJS06pTczHTZZgA0n99XZtDOATpuCsRFR7crki2fgRsaZr9+8S7ylljqY+vqw5MoclcBktfMMNe7q24BZXwI6QJjgbpEZ7sk44FhxXfM78Cg+x5yclcv1ZM2oGxv7GzRGws1VI1YxJR+aZJQqediON5OpcsQkXmhN7dnO5jVqR0NbfIQz3qyHroJ4s1H5xscnXsZ1WM704UPmsVyRgQX9kBHokPOxg/8C63bbYRT2Fa8x3XabxzUIu7PREDZJuKPjApEA9jfOq8DBdzH5KjUGNSLxEr5znSPGgdw6B1RX8AWtJKBGZUO8yCOVRAyR/SXLqwpOOdZJs02wtt78FfffVaflsFl4iJFnQxu2hkMUdG5atlcUwtbPACgEwPnhkb+Ysv3hv9mmkXWB9HsnVo+cr1v6JgRFoTuiaRy5EhujfHfSvJh4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(2616005)(186003)(6486002)(52116002)(6666004)(6506007)(6512007)(26005)(36756003)(2906002)(1076003)(38100700002)(38350700002)(86362001)(478600001)(83380400001)(8936002)(7416002)(41300700001)(8676002)(66556008)(66476007)(66946007)(6916009)(4326008)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d7RVLPMjBLt3VlyT0DXTqSF/y8ETmzN40xb+dARW6D+bvhhjOJJ4ipr+ngL1?=
 =?us-ascii?Q?+oD+sDauVLS8bdJEs4KlAa8MyyEitd107od56Iz1OgasjC2Jax2fvM/dtTdO?=
 =?us-ascii?Q?+grHUgJP6tU+508H9ok+H9g+/rghWYkmMMOw3F6mdtX5rTHvXzwAaXs9Ngcx?=
 =?us-ascii?Q?U8OBwsEC1BAjB1XB2qWH/a0LayVoVN9NYIumOTfs28tUWE3tjNQrVPQUr2W/?=
 =?us-ascii?Q?yJSG8srjtFMYg8MG9r3ZzZO5ioOPUnWgWYzHVsWAiVXffCUK0xZPzBEJ4qLu?=
 =?us-ascii?Q?HO0r/uAt3CoT1iVgZ4Am/2RK2a1htQtmwtIAQ+KrS4hA+nVYsBtlDiHbFwv/?=
 =?us-ascii?Q?dzp61BoWhwdJL06RxRVjYwlwh8kG7cii13srUv3mCorNNQioj6kA/OK88ZS9?=
 =?us-ascii?Q?yZfm5On9dhevCE9CuwqDFfe/nP0Q93Ws0irFlPVKIOyY7suQgS4RHkkIDFH9?=
 =?us-ascii?Q?VCsS6yTW+/VYVBvVgzMFvcf6Qj8UVx6uHL8bmrvePOJW0p2njdcoCqww5iVQ?=
 =?us-ascii?Q?f17PJZESwB4UarNrXoJq5hly3vSXAXgW3fNoWDs4zkmsiVk8762MQal8t5jW?=
 =?us-ascii?Q?Gkp2eLtlsS8V2Pn5efVV3qFKBpgBwJQthIs5ijei3JOmAeiX6FbPtTCPY2VI?=
 =?us-ascii?Q?Hy9bYaHFX7ZEhTdFnqK+D5SV/qyayX3s/c3JWZ/B4QHQZNZnhD960TkQgl1m?=
 =?us-ascii?Q?l9x8JAOh4LbgUugNPibOFKcf+JYkQnZc26qNnyJcBWG0a5mdI3fmwtCfbo4t?=
 =?us-ascii?Q?1/xjFwN3hc6vCBVIjgvTa6k58cKPm+Tg32N14Km0jJtKAGewLiPhs80HV5rP?=
 =?us-ascii?Q?FdnF6CyBqlJZ1dflmD63SJrUOAz1qKOr2vmas/t6IyLkj9gL9q5P+/5J1UlN?=
 =?us-ascii?Q?kB/QymUoteTagTMVjHTaxgNkmy002S99Y8lJlWDMsK2C3+Kgb7xJUDvEtWcH?=
 =?us-ascii?Q?a73FOiuKGceB/8ueEB0W/dc7dDmf3xbgiz5aNNRT/Eign/9Cx7ePCN2OIFCO?=
 =?us-ascii?Q?4S/Vf/Y9lUFCBTMNfGmln4VtndgIoLd5iQuBzAueJLuIwj/QdT1YJQxeKGpp?=
 =?us-ascii?Q?+dzvTYGPer5ot+wyC/Zm9R7O/bo+oz2RedgAlS21ZQWNdF7qr9XoT51Ye2ll?=
 =?us-ascii?Q?LopgUpJOg4KJWptZqjCmcY/jpZT6LgVnoVJgVHAC76sMvNvT3L9goYj0LOwW?=
 =?us-ascii?Q?iph2Inzog41q6VEhSbZ8y/oxW0MYC/gmhZ4TD2GVQ6NUqOQpT/9u5t+hBMFz?=
 =?us-ascii?Q?IKvn1+W5SriqqeXWC/OhbPk1VcsFT9LPMXGU57fTVI29ZlLSjh9QFTLa/dmO?=
 =?us-ascii?Q?lyxjhLK+4W2LmfVIjuv4ZPlXbjetmRiecxwdL7JGQV4tM7L7qanOwYFm+t0T?=
 =?us-ascii?Q?sL4UIDJlevZTRY1ufd7s21woYocyPcGJtzCfqwX7L/MJNWjaHiNZjLYRFym4?=
 =?us-ascii?Q?ZTXef4h4KDKk3HN5SLR6YpGAyVm7qU8SlTPsoVCPzwz2L6HY2H6GTITZkgpe?=
 =?us-ascii?Q?KjadTrmi0WDpVBt+c1uRMPkEDtisvbl3HFtfY+FmCQ+GSByJHZk5GKq1nURp?=
 =?us-ascii?Q?stGd9PXcQls9Gwf1pTPGWoPFtoeFv+GBgna9HXFZ?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e86fac5-5d9a-45b2-4555-08dacd34912c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 09:24:49.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLJZNrUZbsIe61lBX3d417RwuCVA2ygdGqquYuEur/FUn6v19feeZythaW3qwY1YQCN8JHCz5pJrjXWa2hMPCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7041
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Li <ayaka@soulik.info>

For the decoder supports Dynamic Resolution Change,
we don't need to allocate any CAPTURE or graphics buffer
for them at inital CAPTURE setup step.

We need to make the device run or we can't get those
metadata.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index be7fde1ed3ea..cd56d60fad9d 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
 
 	dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
 
-	if (!m2m_ctx->out_q_ctx.q.streaming
-	    || !m2m_ctx->cap_q_ctx.q.streaming) {
+	if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
+	    || !(m2m_ctx->cap_q_ctx.q.streaming
+		 || m2m_ctx->cap_q_ctx.buffered)) {
 		dprintk("Streaming needs to be on for both queues\n");
 		return;
 	}
-- 
2.17.1

