Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B98471F81A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjFBBjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjFBBjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:39:18 -0400
X-Greylist: delayed 1108 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 18:39:04 PDT
Received: from mx0c-0054df01.pphosted.com (mx0c-0054df01.pphosted.com [67.231.159.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA2A3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:39:03 -0700 (PDT)
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3520iw4T019954;
        Thu, 1 Jun 2023 21:20:09 -0400
Received: from can01-yt3-obe.outbound.protection.outlook.com (mail-yt3can01lp2174.outbound.protection.outlook.com [104.47.75.174])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3qucyv7e89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 21:20:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2sNeIB97QDpVAy3jK8XXHQbG99TnkCQGkoq8Zfd9i70SyGNSR6jZTdPBFeTuU019E3C8l5gH6lLbsajCN0Sxe8r3fZJN8Y8WgD7uRjYVNhl1q5hQJDdfYOeR0XiyVkANRH+8LpDfqPOsq9nf2O+y56x7JhuqTDloXidg9qNyXwWI6m8jGO0uw1qCvFf2L3p+zc72OhtGLfojzo2dwID3nTu2WSJPg8tbIiZDSTL4FVXRkuaSGltPzIjz/0t6EKulglxw2Zs+IGoxu15yMbVTpbEYt9fiS5scO9D7cSyyTnkiJsdVa9Y6XjFl71k6fnzgLIVrp8prLnVG7+FHuAeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUK1cxlr5hycbv+5K6U1RQvfhCp2WXQeQ6U0UR97oq0=;
 b=hA1iMg9IIYvJOTbAv9F57mQtCfIplqR3V/a21yTBmaj3/Ej2vV1sKnFYq4OIvaDhprEHSqVKf3HDJht0Z1PVY6RPVt+V7jJPj1QjhjCzz5akB229V3Uqx6GH6VZrUYPjJ/yjZ0o8Dj3DAhYHu6vQscWiioqLk6vnNS/ZGwvwsyRPQ37HLrNecPigjaIVyfQWQSBNPq9/4LD601C8xtopDBMMcsZ/fNOqA2+bQq0IWnYsIwI8cjps7ejWyHrwr9NqtEGtf++ZehAbOCHxNdpN9cApwNVQkeiucPnPECxL3E96V/EroYakRT3sZWqaWFhi4tuw3/eQwmkoNk6KIdhHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUK1cxlr5hycbv+5K6U1RQvfhCp2WXQeQ6U0UR97oq0=;
 b=wHucbtLjHQGj86HUpI9uaYHbB0fCy+t9JyopLphEa0KeP8j81BO5SAzyW/8Tdm+NnkHObTMZhJLM62An4NhCudJXtHobyCrc4MnoqkqzxkJK5EUCBEJ2pGaBokbf3PkNGgSAjLklnOo7gl4k/BoBvY4cfdZvkVBud4UggokvEGM=
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YT3PR01MB9041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 01:20:07 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c059:dcd5:ca20:4a0]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c059:dcd5:ca20:4a0%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 01:20:07 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Hancock <robert.hancock@calian.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: simple-card-utils: fix PCM constraint error check
Date:   Thu,  1 Jun 2023 19:19:35 -0600
Message-Id: <20230602011936.231931-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0105.namprd15.prod.outlook.com
 (2603:10b6:930:7::13) To YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB8838:EE_|YT3PR01MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fde73be-5993-4e04-287e-08db6307806d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvnWJLPIPRdCAlU61pI+bRz7oWuYAA7i/+xn+FdlkZ1TBNcn15XjZTYCNm21Y/mhMEI56NWT7QM1wsnqq7SlGYNpKu7PO5BjuJPEw7hIMVNhdImhmPxglrioz7wNOMipDvYqT1mefhqXXB9CGefzQDN8A4MvPCvAWenAas4aQdNEvwESvwegID9at9uJXMj73e3+4p1Lod4L77i+3qeIwwAjJqr9rT0ckpZOGHhlbdVkggDHqZazFD5D87iHSH4ZmeqI72LR0FgPAS3VG1HIXkwCRz4Elg1dsdpvv1XWD58RyfifoKPVAZFeZJyrkjyQGUskpBrxFWIVYIJyq5wbhVUSI68utoeYzRMsAXf5w/k7t0XZXbsVirWHQctdbHtE9p2wD1/37jq5TYzprR/E8M1uz1Q3qioINXLNGBQaVGvqjsyAht2YcDmuK3Gl2IBhsiTIULwSdEiWCO8ohht8NB7HFV2jZKIp3m4Yjw/jxLkGCArcXJcchUictygkJHGXEvPC48w1f5eE/jEuvW2JweLCo2BEgIQwgxmb3fDWboXcGenKuRgQ74snFQkqkY7mx+MFMh7IvYyDIE50TAuNpHUm/ABWu8Ci5HqzwYPS9t7wvWv4Z/bUjF/Dqt7v7cBy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(38100700002)(41300700001)(316002)(38350700002)(4326008)(6512007)(6666004)(6486002)(8936002)(86362001)(2906002)(8676002)(52116002)(66556008)(66946007)(2616005)(36756003)(66476007)(110136005)(44832011)(26005)(6506007)(1076003)(7049001)(478600001)(5660300002)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSBIBA5wmG0NUkIeOGah9yTJ5hlby9og9iRObQ1e3uPxR+i7fO+I+FNWXlht?=
 =?us-ascii?Q?7RH6TNWNcCpXxyUvsDwDbd1SUY7G1HIMDg3KAUz9dsLRY87xIRgEwmi5TYm/?=
 =?us-ascii?Q?fe350TJyqQRLn/Zvry58c6nMJd6LblBzoiuzd+2nZI6qBBFFcLAYCbDwE8PH?=
 =?us-ascii?Q?tTWqj3wGxYYUEdBvIyiXb20xqWSN81wIpgT7+AG2ahEVFTzCl2fLIONLz47R?=
 =?us-ascii?Q?h5T0wH6aQfnsplirJDSiKLH8gtjYSL0C0YpBQFUv791SA6+F98553F3CYDCA?=
 =?us-ascii?Q?B5/LF3HPwRk6wsQ4J4azZsE+mZbxIayJtnMKZxzmv6I/1znmq60eXId8YRvu?=
 =?us-ascii?Q?KEs97BIYTjdpeFPrSjl4gOx9kSr0ez9gKPiNUdoQy2x1N5hXI/sNH6jykBWl?=
 =?us-ascii?Q?OZxwATnUo2Cp8UKK3mtKAQ4q+m7ukAFt98OsLmSx/2efUcORqHVToAGIxsPl?=
 =?us-ascii?Q?BRSwdFIjnrb/L5JDHqyGlMWnal3y3ZFv9qBhkc4p4q3YY25BpeXoNUZeO9I8?=
 =?us-ascii?Q?/KabDpK5VbKbV1H1S3BvYCY1FyJfVrNZH1MZlp0P8IwsUpC6XMzItRtR3RcE?=
 =?us-ascii?Q?+mSmNa99NIsSxBQVGq45ovM7Z1xgTo90n5x4sfxFdxcb1t+FHzY/OKA/Lq1m?=
 =?us-ascii?Q?R25RT/lvFSoBfibTzpJDuSJ8DjlEPUbq2LhzzzKr6O3M17UiLZOdAbeMHWQ+?=
 =?us-ascii?Q?0Tel3ZLOBHUFiJoMVntGrRehOZ4PLXCPheLatuvn91sYEpSLAfTrgHfdTclV?=
 =?us-ascii?Q?/fQ6iBC+j8g3kRYQwTIUPriIvQDgUYfXAsn09ytP6KWxTzc2ZXN5Sw6iXSpD?=
 =?us-ascii?Q?YDNESAmjgvb6gCb5KaJt2+q72mW6udiJtLT1ZOnR7aTPC7EAxQLN1irPAfIf?=
 =?us-ascii?Q?AdGmZ5wEoDD7pWHvaI7jv+1V8OyRE3p0JvrRBM/nVEPSQzgWBBkQteaStLy4?=
 =?us-ascii?Q?HV9FzvR99UfuPzGgwf3ZdDpUHH6NGBRSY9b6spB6FbdpNDA0euFqWBFNTQp0?=
 =?us-ascii?Q?1NXpyYdAzdmSyimllLxm6JW8O+tesVHJLszKG9qGabJPTcDn2Q+qfSoEr0Pj?=
 =?us-ascii?Q?2iL8wmFHNXKNCS55jF1SAKIwlUg0wamVT7lBaWhTJzMgmvc9Gi8hIP3Yr/Jh?=
 =?us-ascii?Q?xg78WmiQ6N79Eaa6wmVZZKawEszXiWoArpVn0dvQC7iFKc8k5StGsJ393Fsu?=
 =?us-ascii?Q?GUEcGeRJQWSueUgr6ErEeBS7SHhNJQAfH7CPMoUP82KTW7zV8ve76kKGHT5r?=
 =?us-ascii?Q?EZnAxPOwujKQZaBYS46AdrKbADwFodvbYZmTJFxHQYVIZhywuO1gsPPr7rPl?=
 =?us-ascii?Q?JHK1tTTSAPCLFnMtW3WK4fT9JD2XqhHzqZLDwt1infvUHib3B4k0AI2vaMUI?=
 =?us-ascii?Q?fuM3BRV9K0sDcKeHuaOai8/DYPS2e6gN0B4TXNhpif7HQ7UL5OyffiIic5tf?=
 =?us-ascii?Q?Ed4EHsR7tKYuIUcojpKFczu8zehgffR0p6Fk3Fkcq26fvUkoelSh6VHolOMR?=
 =?us-ascii?Q?3Mauem+GLBVQ2csy17qAAAJZYer83XeBLk13tF0t2i+BKoRNypQ0neIrIejC?=
 =?us-ascii?Q?bx1izRsyaSh4Y6ZGp5+vFI3YGGaGRBj8J3B11pQYSH40kVEA3DEY6xOTBQHJ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +ad82ihB3Ss9S/I68BMeIvUzR6CSJi7LsKMx/maQApeCgDDvuEkwE2yZtSO9kwMQg8ZvUaIdbDoKYikmuNn2R4N1f3cfDbqqTmJlZ1jtRt3ymmPTFvtN9WMSe4KJmlZJqHoQce0DRhankIDukBoKEBnWuHzLNmo1Axs9jHxFG17QB79vNWl14dehTeC5udDG2rTODyoPjdGZ3BAJ6duMdi0B3AY0Cl4705Mw6cE/GcFD3ZUDfIHmcdDmvgwR2Lu1pWYcYHSUbibxsYZvO9FK3sjqgDzszz9jexq0r64QO9vOwB6EhQ1xgSv9GJdgd7ZaQMuFrlXyp5S6Niot4QhY/HSBbHIm/jHFmtHEjeYqRS/LrMmSi1Xf4rm4TpmSOSDEFcuiwJMQql5LAfRzBfNX4KrjA3HcNZAdlVsLjQpFIp/8P9ZuNil3EFpZAaTheRPbUaRjJr8963mix1XP5afo3mUvruz2nU7tp4cAOJ1bvabKcTyD0sAwHC7XVXHaiQIxK/xktUjLsdUp1YiimaMV/rTE+kAUe6PTK70ZZT0QNNS/CWxcWNmrht4lOIFDwTpLdIglHO1l0/Nz4RoUlDjJc92rk5dzyV3mf/W6E7YRXFahclldzRg82qBdk9hMYM2BRo93zRylb6rfE8eBAPvq72OhbqsyoxjBgYcdMv7dW4CiKnQF1Ekq6ifwT+lRGAFyQHHDntO+as0itiQq1pTb5OQWxXv1GcJmcMQmoI92LtRXCZ97sNUxXlx9vc6OU11n6fOxNYSXb+JMog/KVC1f3oT3FFp6mgf4FC5ED8Ux4rD8ZM5Ns48jSTn1mhD7VXF6qsOrWSVNCqsDvfxnXQNIuKelSQtr2jUsx1EJ0srshvj0VoSHVeJiUAXwmokjgnAAtdfqhtI52KAElAVVhq0oDyZjt9J8cTQmHC9seLtWiGM=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fde73be-5993-4e04-287e-08db6307806d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:20:07.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTofDsJSU2rScqda0h7fQD/yV7CPWAY5OUJAYYrJYklF9MtHmtWBJmrtcnOowOnFhFn9mOf/zhvIxf5PLdB6pxf4dU31JJjqG0+rokiETWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9041
X-Proofpoint-ORIG-GUID: uzE6DDM11TCfSfKBX6rRaG6xwfWjzS1U
X-Proofpoint-GUID: uzE6DDM11TCfSfKBX6rRaG6xwfWjzS1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in asoc_simple_startup was treating any non-zero return from
snd_pcm_hw_constraint_minmax as an error, when this can return 1 in some
normal cases and only negative values indicate an error.

When this happened, it caused asoc_simple_startup to disable the clocks
it just enabled and return 1, which was not treated as an error by the
calling code which only checks for negative return values. Then when the
PCM is eventually shut down, it causes the clock framework to complain
about disabling clocks that were not enabled.

Fix the check for snd_pcm_hw_constraint_minmax return value to only
treat negative values as an error.

Fixes: 5ca2ab459817 ("ASoC: simple-card-utils: Add new system-clock-fixed flag")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 sound/soc/generic/simple-card-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 467edd96eae5..e5ff61c1e9d1 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -314,7 +314,7 @@ int asoc_simple_startup(struct snd_pcm_substream *substream)
 		}
 		ret = snd_pcm_hw_constraint_minmax(substream->runtime, SNDRV_PCM_HW_PARAM_RATE,
 			fixed_rate, fixed_rate);
-		if (ret)
+		if (ret < 0)
 			goto codec_err;
 	}
 
-- 
2.40.1

