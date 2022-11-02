Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2A46168AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiKBQYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiKBQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:24:27 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261DF10B0;
        Wed,  2 Nov 2022 09:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUHhx+XRUrMUXCt93O4F29t82/x2JqLs+LbCB79seR+/voqCqWNTQ0kfyNQptKnM8g58tjD4qEqvFV0kuxvlBfexLtbpEwCFD9Cr+V4QHOPC6O03t/NyV89A70trfxV1DedgRdnu1ELyBIiNKX3E5IVw91kJGP7acxQBaZ7pbhBaBEwby3MX7idIg5RAuFVuQ669BEceMhGzLh6lBTDy1BqFXBcj51JmsrfvHSy74ylokxBV8+7wnRNORQ8JK8DG/b7fQAxFliwZbLFUSYYLWB/HLtt42r3cpickzZW73wYHUoCRvd9Udv8acpUnFhFRyoILix3P1NB5inMv1loTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRHwGvU9yE631/5LDD0Kd+w+A2lWf3Z2FpsezYO1xX0=;
 b=iSztURlPTg7/qncAZZ8klIeS2qpBvRsvxBFYvipcMqX2PGMt6nGBTQwqq8b2Fhe6UTLyyShTt/vrz/Mfta25BzKYx3EVBRdrRNh9UCrXDQ9asg2mfxxwDxD/hzhT1QXEUZ2gTAJiRb71TKQbV+MiBmCquoYzoGtWc6p3T6o89IAkbQky3i6u9MG13U5hZJnNa2cTexa+cy/mn8XiGHzAWAvTC3/p7v2Sk5Q4qHWosT6/Uk1hqLILtMrY7K7wDyKI9Ef3YGd1ShYO4/1ZMZ6/4nn8ToDVJL2o5T4ucsYORP92kNNHFAoCx2FC99CXFOaN1uHsnOiRFnRGqHNoPaX10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRHwGvU9yE631/5LDD0Kd+w+A2lWf3Z2FpsezYO1xX0=;
 b=oCbutUqRypDjjLxZBvFiTD+SVpHRUCd6ezXvYyetrvw0hI6fg4WNEAS/VjFshR371B3F12Ra63Z2JJgSmBzZ0a02KgcSBHax5O8Dnwci8cXDO7MfUDRIfrbnZ5Om6ovPVYYpS+qRVvPSp7lD53CTvDF9h5MaN58orTN8wWUIkP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AM9PR04MB8257.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 16:19:25 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::e244:87f3:19d6:5849]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::e244:87f3:19d6:5849%4]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 16:19:25 +0000
Date:   Wed, 2 Nov 2022 11:19:17 -0500
From:   Han Xu <han.xu@nxp.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: nxp-fspi: make const array ls1028a_soc_attr static
Message-ID: <20221102161857.7t7dqipgfsh2cgtf@umbrella>
References: <20221102152904.143423-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152904.143423-1-colin.i.king@gmail.com>
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AM9PR04MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bbbb68-8ca2-4462-905a-08dabcee0216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8cP8Qs1h0ReUR0WvQRrm7ZN38ENV2MAwq8O7wD0PR59J0MHuSSqgXuhpGP0pIc+fou5DNEfRBigNX7rDSRZ2V4LJQVHCOd/kbHvsYALQNxkqeb6v9Nx0x5ZyV+8GA3kSDiPXQsTOwwD1fi7GauZqwE3DpJPnmQRQAYs5MAcqnur0Clb+2fiztPWcED64nlegIgeiHeSx48YUjimSJhMg7sFRVRh+U4zi54NjO29kmKJjDLTByVW/jhKFVWKLvqgGnGppXlAuB3FgEBiYoLkbWqB+BhTAMf0c5zt2xs/D0tyjL4aGWB1qnyZUCFunpV2FFckqUrf5LHjWUJ+XYb5s87rvwrutLpJfQO1r0OMLxB+CEG17fZI8Pf1Mg9iyWTiDrkv6cXx1fKHKuQjoFnbYIympczZvKqx7HQI7MhAw/f255sQNpKNTzBCJJjbuTvaMAzwnkCuzyPjiwlINdFKAZE53qo2YUEXQPwWZm2Y4C0SASQmAkPOY6UmuQXfmvEFKNQJ2J9f1thNmMZjAKc231BOGMUeeuhrQ+QnuD+f4GD9068ndW5dZlFQBBy22htCk6+62+QxmTuVCSzRZKG002Ek1uM3BPJooSSu4z4WVJUZRBcLOoybRuAX4fxyWjRdmjUOdV9tI6D8p9abbG1xMDDMDY7s2+N8uHaSr35LjjufEsmfdH3h9qEdYSHmd5O7e+zTMVgRX22JxjpzLA+k23Ryb1493Uob6NwjJAmppE1Xp0GujjTWAUwqhc24SkJk+jK9uuwDy7nVwyfp8IOIOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(2906002)(186003)(1076003)(44832011)(4744005)(6486002)(478600001)(41300700001)(52116002)(66556008)(316002)(66476007)(38350700002)(8676002)(4326008)(83380400001)(66946007)(38100700002)(26005)(6506007)(54906003)(6916009)(33716001)(6666004)(8936002)(86362001)(6512007)(9686003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?20KI3I+O4DWF73d4U3ktJICW+2vunuTzQT44bJJiblrJ2azaiD/tmwXuPcuI?=
 =?us-ascii?Q?7tFNkNZbu9zmNKHeEGj2q5LNnZaD47BrtmcMfYQImZfiBT+JicDLXNq2DkZv?=
 =?us-ascii?Q?ycbvI7EOiLBDs1b/MtQj48zQkl1jxYIr9lr61Dxb+noFdWK7TNGLpb9Li8xe?=
 =?us-ascii?Q?U5fBhP5SmPmof5nJZILrL06eYkExdWoRjHem3QV+ZaSWj23Ml3pIGlvx3okx?=
 =?us-ascii?Q?mGR+v4rQ4tyS8OfHClsSlfGCKBNK9oNmUZK67+qoI9pRzvHUj6XagpziCGBZ?=
 =?us-ascii?Q?h8bowl8b8QPyU2g09l/i1C4BxeI76CB6hc5BhXbL4V+Btjz7p/fGEuDZQSp0?=
 =?us-ascii?Q?3Qtid0FFT3rpePyRNQJ1KRW6pM8sIPbipBXluYlZwJd2aty8ADyOqNfY3/Oz?=
 =?us-ascii?Q?Mgz/2DpqUlzj2TCKNfYKXZ/z82B3tV5kBVIfS9YRQ3ZSvapQDTyYtBFVLS0s?=
 =?us-ascii?Q?pYL8Q1S2yzGjoy2VVQWHtNthiZpBm+x0gltw6Q75vFioKqzyT2Q+6v/aR2yh?=
 =?us-ascii?Q?sNpT26RwjWgGr5rG69uBEDxMB/TkdEY452pf6t2GIkD2xHiHmoDwVirxdrXR?=
 =?us-ascii?Q?+Tje3x8BniBP/EU/JGHXUYTrs6Zg+EwZKhOY2RQeuspX1Wl4z3S/WekuE/3U?=
 =?us-ascii?Q?m3onVJz5osQ+W5RR7fH6KBECeUWJlsTH324qWomRe4TlqBbwf2Rw3VLmbcS/?=
 =?us-ascii?Q?2I2SmgaVTs6JbNHsuKXg5C4HvXcS1sfplZcKCblP20xvljjsEagd8Vb0R2o+?=
 =?us-ascii?Q?eSfLM83koN94ZDftFdyJw9cIbDNCFCnHfi9xI7rZhyEHqvJM+hg7NvcE/DI/?=
 =?us-ascii?Q?0wUEx5kDUmPr6O7barCV6bZq6vpdMejtTBVi/10ivETIhxhUBRJd81uA6aF3?=
 =?us-ascii?Q?WThxIpvqp7NfHdpPWnbAQX82KSsFZiKnoL/KsDmNdYiF8TOWkMELY1Wdf3/n?=
 =?us-ascii?Q?C1+80SCCaqX0jYqUAIniTZc1bRr1Oc8q+JKwTppZrssoVGKHClusOjbn7lEw?=
 =?us-ascii?Q?lU0FEs+p4kIEZAiez/q9Rd757mQ2i+WsHR/DevkIzUOAS6edxGaBWNOa0izz?=
 =?us-ascii?Q?AYwh2kocdnd8SsvF6vMBao3sD9JpK+uM93IYeq0xiDXfqt1o1ZYsLRGipegs?=
 =?us-ascii?Q?IIPrAZshyg36cZoJUFX88g7hLZoAA8r6JE8DCHNLtu5aP9KYLbI3u1CETaEh?=
 =?us-ascii?Q?/0XYWkbSboNYFhT44B+W7u1hms7FKBQuTIJRc3hii5g17iSnjvSevXAfSqyf?=
 =?us-ascii?Q?qiOIznKF424Wyq9thrL/LBWlScoNfFEslbkEFeKSUqRrTEIQSXfpo88fOQhy?=
 =?us-ascii?Q?vyWBW9qMTEvF3grsOd7ehTwd6uqCk8z76KJ6I0AT2RboW/NbXm5apjYBaDqt?=
 =?us-ascii?Q?5AfXTTuNpyv3vM57Gu/c5w21NBZQPMhx/EKuGDkB9sCFVOkhCLiQRoBmX8dh?=
 =?us-ascii?Q?IVJpP1dQZBYur2LOarxCWRsDLYejabK1jvdRu111z69pGdUY+/XaHlsl7JjC?=
 =?us-ascii?Q?rdma7NqfadfQqPHUf/PwrLP+koTa7KQMbdXEzwPpxDJUju1KmbD8Ewbo1J//?=
 =?us-ascii?Q?B0LPmCQnOS4MPT8Lapw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bbbb68-8ca2-4462-905a-08dabcee0216
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:19:25.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwoeijSQ5LYercJXgRdTFw/8Mn/EkD3M6yF5z8z71jEYxpHyvbdWEKJuIX+IQvkR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/02 03:29PM, Colin Ian King wrote:
> Don't populate the const array ls1028a_soc_attr on the stack, instead
> make it static. Also makes the object code smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index d6a65a989ef8..1c1991a26c15 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -924,7 +924,7 @@ static int nxp_fspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  
>  static void erratum_err050568(struct nxp_fspi *f)
>  {
> -	const struct soc_device_attribute ls1028a_soc_attr[] = {
> +	static const struct soc_device_attribute ls1028a_soc_attr[] = {
>  		{ .family = "QorIQ LS1028A" },
>  		{ /* sentinel */ }
>  	};

Acked-by: Han Xu <han.xu@nxp.com>

> -- 
> 2.37.3
> 
