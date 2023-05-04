Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6C66F62B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEDBoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDBoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:44:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3448C0;
        Wed,  3 May 2023 18:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShvNxanLC16/Zomji5kEsx4BlQojqx/ySBKF5dqoNuX23ZbBYnB3y/YPgjC2thCctxipmkzIncTdR73VuN+jc3Qu7eyby/Wvin+3MbXOo3UyC6oN9XgSPDIdZ0K2AWiNkh6vNj5C3udIihvU6dT/7IS6Z0NbNX/rq9iCcoxBNXgaqyavNNBCFWDDvG/RdcnCOGIjHXqnEXrD49qUbTHaeYAZ0YUAw/hxN35BXJOl+axoPzskXzi46fcd3C/m9PovDhu2UW3Nwprh1WW3YRBVgSXBaZ14UK93HEo+10rU5612Vr4y07o0sE0CQHMKGzWzitptQ80tk3ETWUKJ+G6fPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBMxwTzHTckEbheNM+ksxqPdcohjkjTo+ynefJ3i9jA=;
 b=EfUQkHbVvP8zCqBVsg2tcE4Bik1buM181FlDsLGxXb0AA0vqcOfPqtu1RUxhCkea4dH2Xkl+8ISzTqLnIxYPeL1rFgP11NXnjioKjUej3JJtl2l3A0TDeJQmEd1S+PNUp3sGVvx64Qv9w0/7AnoT6c/U/8f9nrJt/OVHOOc6dfWtWFdKFM3FHyZSW+vd4+Juh9N4RosgQlMRo3kLAL8RjeGRkG4nMIgjgeFFLHr2filbsJIJT8EbWMgb8XoBVc08amGZcEjehDN0Nmv6MTnAsOUB9Uj5TbEeE2QjqFFDS85b52RYaOvBJ+216vZmgSp5G87BBOVSGkKlfcnUM/GHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBMxwTzHTckEbheNM+ksxqPdcohjkjTo+ynefJ3i9jA=;
 b=DClywvSoOllWW+wlCuiLwg+zaarx1M3r0+kAeRp5BzZCRQn7mw4FzahAEFh5kX5O4vKXLd+tbeDkc1cmSrdZEYXHW1Ini3eKqsDcLYq5qhIUdtWCXkqi/4qzkuFMlNyFJd8jPqCpzt8JHep75inNGYgVEwEsYRTij1Ft8qwvvio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB7844.namprd08.prod.outlook.com
 (2603:10b6:510:113::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 01:44:09 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6340.030; Thu, 4 May 2023
 01:44:09 +0000
Date:   Wed, 3 May 2023 20:44:06 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZFMN5nmqLAX170SE@nixie71>
References: <CAH2-hcJYVpBNwnMS6qUp4=MW8kSryDAz7G5cNA8R00QabC9bjg@mail.gmail.com>
 <20230503153231.1136114-1-tomas.mudrunka@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503153231.1136114-1-tomas.mudrunka@gmail.com>
X-ClientProxiedBy: SA1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::13) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cf2979-27f2-4f4f-e1de-08db4c410d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7R/v447fYck8I3LLia6RmR5QPC6fmuUIDOoHbCOBj9JoHkcpgKXpbmSrAaD2QbcmSPBBgtfmNvNuJC3U94GMp0unrAAc1Mp5M3TYLWag0h4DAE9utD96CJvLxsRXe6YbRIAugu4cqWZ3r72iMrKu9C8YTv6HvFk5L/s2ZUThPcLj2/+6eqbiM2bi9wEgwno+gMbAglSJh4hBJDcPDyY2MOITvIaK26I9zShFs44Be9wpA5XiHMQuWZU8pbD2NdD+ZHYQQgDYFtac7cqVPnK2vo52DCiWlY68Jm30SyMzRQ1NxE1fnzakzNFJn0emmqxG19Lp1liAEIPRVJmo0sIdNTANwmKL8OcNNpLLeaQbhflkwCnwTNNrndSBKtd4H6yxPbc7qdQeQ5EGic6zC2TeHU0yDCVqTqfxNR+56/HZRIhKWRwxr3U/W0nt3zlXztHZTtZq/EkL0GwQ3a0EGhGuGCQhjSOJE59tRkykALwlNpePV037pxDb/2xz+M+Y91cW2Kg5MT7jM6Xb4dU6QpSW8AnBaw+UiTSVLP8eHkhsl7ffTT+3nyX2ED83nZbUD7qV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(346002)(366004)(39830400003)(396003)(451199021)(33716001)(2906002)(5660300002)(8676002)(8936002)(66476007)(66556008)(66946007)(6666004)(86362001)(6486002)(478600001)(316002)(41300700001)(4326008)(6916009)(38100700002)(83380400001)(26005)(186003)(6506007)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CoPuvmup8fQBIUjziDsAizvhQiRdd0zGDt7isMDITpVjDFVENA1DHdgktRyN?=
 =?us-ascii?Q?IEWZseXJfvlaiRnA2i2tgqr5eRTVVDl2iDppiXL79T7dDp9UcBhJ+e1D+Gi8?=
 =?us-ascii?Q?r8airs7wv0OPhQMCjfZq63UOFJ6HcPpXtFo49anqV5fimM78IxEtUdtzQZ2L?=
 =?us-ascii?Q?yKAOF02GtZ0nCSNe6Aoz9ntZM6AYCb6wjtC5hSnHzlNT4y63DM5x5b8g3WZv?=
 =?us-ascii?Q?U3jlSxmJIrpBktdZd6G3N02JS1mWrhdi+F9Y9kfblnm5RNMu7r5RrhG05mB0?=
 =?us-ascii?Q?nLggMEOqrXNLw6c3b56GANppYhmooBJuoYVoTMPniaCtanwY6BojecjQx2Wv?=
 =?us-ascii?Q?65HztuRgCXWk6aqTQQt78vMBGn08o1We4ldDZj6xDVB0Np3e9nltgdBAmH40?=
 =?us-ascii?Q?pLZ6NoqLtX/IwA+Fbzt3LndLMm3S/h9mKzH+KmgO9iaWGNNBI+HDx5Db/w9I?=
 =?us-ascii?Q?xXiA0y1EXUf/iWlUxRc8vIhAgOmLUpip549fsr9ud+c+Tk38g+Ssl1MmuR/u?=
 =?us-ascii?Q?+NHYXJVn6pIFKpBRaoLOLNqt1n5Ku5RrWhGR7Qq5rXDQ4NKFTnyffJtnXuoD?=
 =?us-ascii?Q?aqGuzStCW/u8IKvE3nGxgyIAEI4YGIp6Grnre1JrcQSC+neouuoG+jug9miV?=
 =?us-ascii?Q?oAWPVkGMFUDjywp3iaQhpUHdaeglP04uwW/VWdyuGV2GjBkSzdxlho+U70G6?=
 =?us-ascii?Q?krejkfkGgT2M5uYZA/Pbqv/A+7JvuW7ifjCMC+sr/Q8K/sU/+GWLaXt19Zqv?=
 =?us-ascii?Q?1vXPIQmaBfioy0aYuzyHUjY+FA2hN0bHWPasqkltjeKM5WZqK3rMo1FlrIX5?=
 =?us-ascii?Q?0osjh7h4mqEuFUJgPZ0pHtiE/yNG7Ny+9ag6WgSYmPVVIBngork68EXktBHk?=
 =?us-ascii?Q?RPA04zgxpPBq3+b0eBTDVL/jJckYAWohwlKIMptCcxH/DcHmUWv01nx+E7L3?=
 =?us-ascii?Q?kougFXcrqYy0WlIhg+saLEMc6C0zfVtFU4dg0QZLE+L7ledhVUF/fZqVKAfc?=
 =?us-ascii?Q?Jt70ez2o8ZY2DtSrcaSJwnffGwjcT93WEEtKLZf8rMHzELt7KwVCn3bIKC7h?=
 =?us-ascii?Q?bEvqT73V9+UbLgY5ROoBUW6R7CizMf4zHyDDAQK0dSbRhU7wH54wUsbxJVdf?=
 =?us-ascii?Q?YB0FccFve8wSzNApcntmHHy1liu333JiP6tYMPAvDLl7pNU3AvAfRSQRPXqk?=
 =?us-ascii?Q?ztglmOLuvsH49EZtLLW3INj6CLUj++799M6wdY8UJJTl9pwN+sbD5I9rQxpH?=
 =?us-ascii?Q?qH/WNojCfZk34NPp9RUPPGlfNnghits5I2EjGvETsKvVgsyNOZTGEQey882M?=
 =?us-ascii?Q?nQxC51SRgy98FfSC78g5O73V7mGnv1BNzlwrlIqQhvE74FHvYdIykjXV4TgB?=
 =?us-ascii?Q?azgRd4fT61Bk6+CXRiC37gD6ZNgVG/1w3rUTkq14qGObufVQwqilFa4pq4Wk?=
 =?us-ascii?Q?gOhBDygBHrvgzHRgx5tv9+CSxkuVxtWlQidSnVkSapTJJGSxnaeMhCaQxL1a?=
 =?us-ascii?Q?O5Xpb2tdBTmIXzBKs6hl8dVyQvSdIa/QDZdUXLZFFr/MNFR7XbxDhedFbhAS?=
 =?us-ascii?Q?lOS7LOch4FeiSLBN4JM1yLn1pfwc5gUt2S9Ymb5z?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf2979-27f2-4f4f-e1de-08db4c410d69
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 01:44:09.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GheenDt+S60qBPgfVAeTAthrvL0xansz/E9z/1cphlzelfVZdQYFqBbOUTxIuER3P/6ksw0UUEMh9hsOPBoFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7844
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On Wed, May 03, 2023 at 05:32:31PM +0200, Tomas Mudrunka wrote:
> LM8333 uses gpio interrupt line which is triggered by falling edge.
> When button is pressed before driver is loaded,
> driver will miss the edge and never respond again.
> To fix this we run the interrupt handler before registering IRQ
> to clear the interrupt via i2c command.
> 
> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> ---

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

>  drivers/input/keyboard/lm8333.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> index 7457c3220..52108c370 100644
> --- a/drivers/input/keyboard/lm8333.c
> +++ b/drivers/input/keyboard/lm8333.c
> @@ -178,6 +178,8 @@ static int lm8333_probe(struct i2c_client *client)
>  			dev_warn(&client->dev, "Unable to set active time\n");
>  	}
>  
> +	lm8333_irq_thread(client->irq, lm8333);
> +
>  	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
>  				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  				   "lm8333", lm8333);
> -- 
> 2.40.1

Thank you for the productive discussion.

Kind regards,
Jeff LaBundy
