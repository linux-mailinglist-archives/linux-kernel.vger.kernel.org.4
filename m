Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15233735169
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjFSKCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFSKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:02:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA8173F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3hPzWHMYBvfewHET/bp7EOSpOYa7qoe0KZfo4qRVWUlJhIKhECfq6ZaMDjlESyjJdgZCj2CpdODmf+YOLIHCHOe5kTqhM5MFXjGkSHhOIjk68zvzNa7jI9tiXptjMpf15X8wzxJlsHszOOqO7ovVkcGGv5U4s5KG38S49j2KWWdVqGXvf4CBNitoq49T/JSg95XILUA985HxyoVlvhmGhAwmOxO6bd1UfVi2U9Wx8Fccr43wNuDvIUGSoNKwhgtYe2c3Ws7VFG9DbdnYuEyE+V6A+n8hzlcG6U1cm7cvlZbmMly0VYYt7CEoZxPKdS1spXCrGo7m4WwUAnhwqAkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMCL/Y+aVMyP7NQp7kmNAccAfxAz5lSgYXH2cDFWspM=;
 b=nfKjzSMfaeeru25IdI8vXbsGHlkDe/IjPHRpSd5xosj/cEsmVc/TSHZ36y8f/kO/c0dSC9UIA3C7lRqCJyURj57O9v9iRtK8Uwb9oZ0/wIVfN8tM/PCXH9WyDN/9YDkFbE6N71QWdqX3siL+wx+oUvyvNLVASsYez2cpWS73rTf3tKrYii96EUmvOULXmOO4RI3NMQ/K0WkeoqSbz7ksrd/BEVj/nDK0AQYr85SyX6CudryVIpYQTPDokR40/lfNdshiTaARstSITQXXA1IDHQPemysiVXjjlYEAiDZlJr939xlFl9iLPqjHb2BiwG8RH0qBwQ1JXhJ7NeBCk4JqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMCL/Y+aVMyP7NQp7kmNAccAfxAz5lSgYXH2cDFWspM=;
 b=CI57wA8M6qgu/+XgdGe1d8ixUc0iHJh7gK56pTILaB/I4jWvVu19MQCSQa8Bu15nfAvNu3bwDREcZ7vKn2VyQTFIMh5i6c92NlSS0GsrqHseQarlzpVN4Y5XsB0mlh2b77GZe2gfaMlQOYvu2aaS9+O7h8bTW6cbW8jTbItfgdx5Fy0bILx6/0+8AkQQEJcvOQ5T7Sduux9xKzcqjzQtKKf9GiW8ovVR8D/XIa4iCPaITaJ+yyiIYDSM6h3VSrS+qun+idZmuq6PXNth463M/rDKopHvoPXswYJxkzYrIHy/YySu80hMrxTwugL1RY3p1Gn8YCcNB8ICJ2OepQtclw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
 by SEZPR06MB6763.apcprd06.prod.outlook.com (2603:1096:101:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.30; Mon, 19 Jun
 2023 10:01:45 +0000
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c]) by SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c%6]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 10:01:45 +0000
From:   Li Dong <lidong@vivo.com>
To:     Walker Chen <walker.chen@starfivetech.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, lidong@vivo.com
Subject: [PATCH] sound: Fix traditional comparison using max/min method
Date:   Mon, 19 Jun 2023 18:00:37 +0800
Message-Id: <20230619100055.1680-1-lidong@vivo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:404:15::30) To SEZPR06MB5022.apcprd06.prod.outlook.com
 (2603:1096:101:48::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5022:EE_|SEZPR06MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b7d9e8-c911-4048-725f-08db70ac3083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzCxEKrs7cM1btU7l1Bv6Qd+2wvvIyxX3UT5pYvPX3kgZKoe+wOh2o4CBIaEUXo/Qa2l/3QdqR44xBh1vOLebP7R4KBHQ14E6PB3GaidnLjI5rZM60a7xCQ5mHzqCBzvXvuSyoCwuVC3HNARmW9/4V4yMyX70UI8gPE+JkohPx6WT2ORPqKW16w+gvhQvfT2f5UNA8MAhkRoXkoBpcO9Z3hfpLe8PuErff/tGSu6Sfnv8eKMn00pJQ++xHdUaXiCHV4PeLeekWfYu1hDzUyd0Vc5CTK32/Hdqm+mi3HN3BzRiQusywQinrVWDn7RT7PsysthkSjdIN2zxwy/0wLBwnIM60skwT8XlNWmW8k/xWe0tBue4cfvxPerkGhIrsDExh2FlcAvJ2oMF7t/qJtrMO+B5bE+CCtxVGgp+fmVsqUKQais15KpQjj3t9xKDk9AOoCKWYv3XM/1jIaoAGh7YhBEVASRI8sktyYIWVa8IW6Vjm0VeKTW3yhGvpee7xbX86VKZ56K5evILPcHf1UvjI5elSmW4dOQi8jF6wUZJPFkgihtL9iPxAJ+qtTw4KiiDrNClbSgOgrKstLkcaVZyWtYx1t2M85cC99AvRPpJSfrJH4qZlnkSaGv+FzM+sER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5022.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(83380400001)(2906002)(4744005)(2616005)(36756003)(86362001)(38350700002)(38100700002)(8676002)(8936002)(110136005)(478600001)(66556008)(107886003)(5660300002)(66946007)(66476007)(4326008)(41300700001)(6666004)(6486002)(52116002)(316002)(6506007)(186003)(6512007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4uVwT3Ik9ku4aiabFevSy38nM7bUg9qc5GUDb0JHDJ1XFu7ztVnflDJT9SxD?=
 =?us-ascii?Q?fQgpX9rCfAL1iPzAZSDtrmoQm+pb2Y4RTD1EqA7ogurSGx2lobVQI3Q7SXdc?=
 =?us-ascii?Q?F0p0+gk+vVH+VLTtBY0EuUvwVEW0Se3oN9b+lDKLXRLYcaGhCoMVMEkXGqHl?=
 =?us-ascii?Q?AngPVgL9LNpKOmPTN5fozYBoV2NWP/PYHpYpfM3TgolwUBZd5pGGLLtHfS5Z?=
 =?us-ascii?Q?wBNYsen2csbNIXxyW0rHtCYTTSyXVxHrIKQN+7UA3FtnSr1Q+u1TMZo6KsKT?=
 =?us-ascii?Q?hRPlnPy+Xvc29vPIE6Zdv1mWBOWxpC4gpLfDDRqzKKH0h4WrSfeP/iBwxg2g?=
 =?us-ascii?Q?59XUWd138SdZbkmYAiKSU9wSk9VjQ83Zt2dqWhsHfbU5CCyDVWeUCOCggqe8?=
 =?us-ascii?Q?SIL0uksLqK0JlOFuMFS0lavUB8fkTSPuFl6gj+FNXDlMSWVBuH34Q6V16NOV?=
 =?us-ascii?Q?cHmMyi9cVG/SJYcvuBXWS+QjcIMi8G+/01QsJaviITVQaqV+fkFvtMrgsI7i?=
 =?us-ascii?Q?PHLSuFjjeso/rU3rgD/GAxNUOB/dFozkabNzmy6OPAuO3ba1fX04badi1ZQp?=
 =?us-ascii?Q?OvrPWVNg3R7Wt9+AZQ1/YIH4IsAOeyq1h61Rjsi2c3bmmVKFWji7D5ojcHku?=
 =?us-ascii?Q?onB//u/7FwLNrP7+I9S9tB+Q5Tawqs5nREu21ctYRCGs+f4PcnJQ/CPP3+/k?=
 =?us-ascii?Q?0CefdxBoJbLMiU21VvbU+CcuNCXgsT/CJNT6/cxegH4C9QR5btvblIuXaKiR?=
 =?us-ascii?Q?eaeR0PN2qYbaFB50gUiNn4hVL7W/3rvyROfcYULIiSwiJnnZWaQt08eNIW54?=
 =?us-ascii?Q?mGkvsjoFLbBeJH2zg9zDbuCOoKF64rCV3AlTDp/B20J7bPv33MHTWTN4T990?=
 =?us-ascii?Q?i1UlTQBkxqoAg30LEwPzw/Tm0VWl21s/I5GIcEPEynond1giv7KEfYYidC6U?=
 =?us-ascii?Q?vA8HUgTI19nWwc0mj1s1+CJM5Q/lmtKL9urZiWzLLJNRMJH+nNHHC4de1Xzt?=
 =?us-ascii?Q?jpV6FbK/vLM60mYAtmBhYGAqxU4e2U2nAUAyveED6UAQYH34SG11RSWeTkUg?=
 =?us-ascii?Q?npntvImtZJYoqb927VKCl0f+uO4Z9q+V6FXUvOF/xTVYEVwEoiPgS/oSh/AS?=
 =?us-ascii?Q?y5Qmgx7sMe5QKKXfUlIBMzG29P1DPLvznvPcpLiW1BGY8U5itnHJh3soJt+g?=
 =?us-ascii?Q?Aep2DR8G2xw0Pdhal8+HZRRIrzNVu7InJNwr53wWsXoUpvmTjRi1F597uO+u?=
 =?us-ascii?Q?RUwKEkZp0dQ34/irenRFCRa/76yAunTSnL6Qveomm3vVKreLdy9ZSErj+tGI?=
 =?us-ascii?Q?lYloGhHg6/FcvY6y/z6fiPaQPWZiAb1Wcrk22noc29ss03I7FqVaREt8bAPP?=
 =?us-ascii?Q?Yu1wRr0yZy06J9bxPsVSRi1FqA6GNWV6HpaGxRljiEYFUZXDKJ6qeMzGRosJ?=
 =?us-ascii?Q?I2D/JB6H8XRoPCNFgCPx9riQCVDBJibEdRuBd/xVEj7RU1ZD/PuzH1xukMcv?=
 =?us-ascii?Q?Wc80SM+wdmf7qoOkTwHuHIKm4NYl2/DhpToJyrs7gT+JqD6U9Rqyd+EefRRg?=
 =?us-ascii?Q?YK65LG8048QUN17UTyqDJSJcFCa2b6HHSMKh0fTl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b7d9e8-c911-4048-725f-08db70ac3083
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5022.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 10:01:45.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HH5Qer7rRfgxvf8WqnKS7VJR6X2wkfK9fN1ZE/jHMcK4L4f4MJw7ezo8aM58KaM5qOFUHHpw49f+6cCJhD4rQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be better to replace the traditional ternary conditional
operator with max()/min()

Signed-off-by: Li Dong <lidong@vivo.com>
---
 sound/soc/starfive/jh7110_tdm.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/starfive/jh7110_tdm.c b/sound/soc/starfive/jh7110_tdm.c
index 5f5a6ca7dbda..a17437dd8c3e 100644
--- a/sound/soc/starfive/jh7110_tdm.c
+++ b/sound/soc/starfive/jh7110_tdm.c
@@ -187,15 +187,8 @@ static int jh7110_tdm_syncdiv(struct jh7110_tdm_dev *tdm)
 {
 	u32 sl, sscale, syncdiv;
 
-	if (tdm->rx.sl >= tdm->tx.sl)
-		sl = tdm->rx.sl;
-	else
-		sl = tdm->tx.sl;
-
-	if (tdm->rx.sscale >= tdm->tx.sscale)
-		sscale = tdm->rx.sscale;
-	else
-		sscale = tdm->tx.sscale;
+	sl = max(tdm->rx.sl, tdm->tx.sl);
+	sscale = max(tdm->rx.sscale, tdm->tx.sscale);
 
 	syncdiv = tdm->pcmclk / tdm->samplerate - 1;
 
-- 
2.31.1.windows.1

