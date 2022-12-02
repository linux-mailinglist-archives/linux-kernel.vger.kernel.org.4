Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB85640D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiLBSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiLBSYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:24:02 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F3D80C0;
        Fri,  2 Dec 2022 10:24:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGfjsEbejo+aOtOCLDuUQ9x88IUNd7t4QGu33NWnkCbT8E4X75k6ScrhpFm6w0eJyXkewlVKa41EQ0b7O+b4EcbULvIwcRPHIv7xnTNwRfIJWlgG3/mz0PmuxQ47hn9p3SYUb0XvbzM/CAmmwFexX0KNAvyYgGD4c0UKOEnP0ur7wZjnkm5gcbxA9VAjyk6A5Sg6jMEA1SmIzILbFz37jw3AOVb8pcm4VKjKoSWj7DZaxLMLKGrSbIYhavFKZ8LB5Im4tbTV082VuKEBGBq0FOPXk5iK8EIoJaV+R6zOPD1vBWRbw948dLKuTM/CM3667Wp8FzWD/mHev98zRWCKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmY1Tki5zuS1ratGNsULyLIjzraxPdsz3LSd8Z2HoGQ=;
 b=aSsZ1tdlhdTgrp4VF94Ww39DyYwkCkjeRsMIsz1Rc61O+xLxTktAhjoJlHybeSeZPjztZ8L1N6CjdfjhxYUMTMzTRz0K9sRh3kjb7z3e7d+n2+HnrWCbGck09NdCEzHuwD9u8sd+bb2F0GK2VIV/DUvYPBtsn7524uJpkciWUpXABxXh91j9/oOgeHbd97mb0Lo+9roAUXfGv6bOPueKXYeQsGMHOml6XNNDO832uB0tylB4mLXXVCKL2vefDQ8/H+PKZSvwMOimGS0tSEzlLj9TUNWalV9bMWTl8tj+0+zyRqykg7/I2ZXq2VWpEFCdPfPkTGsHJVAJxWyIQuRqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmY1Tki5zuS1ratGNsULyLIjzraxPdsz3LSd8Z2HoGQ=;
 b=OWtTmdVzc9hVDZh4P9QHt7Dn/Zj0FsLqSSaMfm3pde5W8JYru2mwYTsrtPZgoM1u7BMZ4UJ6HR+Tbl9Yrk2P6FU2SGYnNs7qoCoWRuoTSLjm6zzfcRGELWK58vPTPN8yOKp+sE/DIOHJiN5a/KMZRQSWK/6Hs3NfLRqHNlk5pSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BN6PR08MB2579.namprd08.prod.outlook.com
 (2603:10b6:404:ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 18:23:56 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%4]) with mapi id 15.20.5813.019; Fri, 2 Dec 2022
 18:23:55 +0000
Date:   Fri, 2 Dec 2022 12:23:50 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06 - always do msleep(300) during
 initialization
Message-ID: <Y4pCtm4J3HWhYl8/@nixie71>
References: <20221202105800.653982-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202105800.653982-1-linux@rasmusvillemoes.dk>
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BN6PR08MB2579:EE_
X-MS-Office365-Filtering-Correlation-Id: 7131e8a0-cdf0-4c18-f466-08dad4925f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSfvKz9elhUH8XtQp3fDbHH1pNAtlpY5GU4ti95tdd2WjxJsHwgbG67UOvJKRSUIapDeol6ZQYamwuyY6lqUO0TQocAiOEXXO6s8EdYO/YJChwYHK5mDvZn0WjWxCsUZkWOAnB3u3t53P0j/HKUHlROsjG8W7EsCLXhH2MBi4H5NJADqqo2GG6RWDaOEZpew4DWp/om+MRji5q4BjOkhyJ/VJNeeifThxYCOujShx4iDhalHm4kr1sq6ZGpylliH5MGeEj6GHv2XNPCHn36xuJsFByK08G+inpC8eoyFeecisJp6Pe6/w3ixKlqX0tjdCaPnuwHWz1NGpC0arc21++tWxvRsO7rdSL5xzK4DWGwdwkl1rZ9FWENkenq2Fev01XY//xRXKu5QSi22b2LrSdsATWpkUnryTzU2cIWncdCTJpet+6gevBW0f+bE0WwpUqx7xXVYmmq+3vRcEO1vNKHlNVlkbvUd9mZFPS2hRoJPtyz7EPsc3mHMayRSGbAsrSBorBZFsy49Itb2CgtRGoKYTa/sLN+rAPh21ufTM0/MiQz03ua1RfT21VP3Li6PXOTu9R4sDAJXE8flswdeUGcCjFbDgKFNn6yO/OzWoV6JsBducPZ2Tb241E08Qyc0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39830400003)(136003)(376002)(346002)(396003)(366004)(451199015)(4326008)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(316002)(2906002)(5660300002)(66899015)(6512007)(54906003)(6916009)(478600001)(38100700002)(9686003)(26005)(6486002)(6666004)(6506007)(186003)(83380400001)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0aX3FyDZNLUdMlpTSpN6EPaXJp4Z4qm9DXofSox6KYYYE+XH+xShY3tRy6n?=
 =?us-ascii?Q?FY9k9vTXLurao9ZL16imEc5olzgOd6j7xbgKLrotK7NWz/qXHmpFPIsrCKJ/?=
 =?us-ascii?Q?37uVkZPGN8Mt3CjF+hIFZ6eoGl0aoqTOMvY9ZgmfLhfMw6N87o1/rQh3gJk8?=
 =?us-ascii?Q?aTm4GvuZAqgceHW1hlw0mna5aZGvjgfqKNwcK4FqTF5V7p13pqblbRXzhMq3?=
 =?us-ascii?Q?6X0dnyvPLwxicUYJOUtX3Pb+I3WwrpYcZSOBwbYmBAp1hpo0t4SOwZEwduEL?=
 =?us-ascii?Q?s5th4VnS65cn4LspAUvOGjm5QopNqKfRxt4VNAGnzEIM5U5r1a4w20+qNzIS?=
 =?us-ascii?Q?ggYqBikcNyM3VvhWhcd9ZYLuR2EURGECWwHPuE4lpgFYVd6eF2ctsYRPgEVm?=
 =?us-ascii?Q?8ccwl33ia6OYg1gjBj7U/pblec76UCfXFxab4ecWAbPZzm76Jx28xgxUzrTg?=
 =?us-ascii?Q?X6qIJJrnb2KH6FPvKkD0VLX22XmdSggqGtN9Brsmo5jpL585P/PenpO9QEgR?=
 =?us-ascii?Q?ahXCHq+TXRgKasSRwpFPVdCmOaa89WWh2fJQbYUNwWChPCNL6Z4iDJ0Kr0s5?=
 =?us-ascii?Q?Jsbi7C1N45gphnLpIKEHtuNuvVxmvCdBGXS4Kcxy8gXW2Ce/uO0BEgTxMiwg?=
 =?us-ascii?Q?yulgRbYTMAlm3u39Pg9V//GE6LwgTtSWurvptcnazwPbXzPvWcxLBuYTrbhR?=
 =?us-ascii?Q?UV9OiijKd4G8WPTV2Tw2gfZg0lvVolAy0o4zRZflQMyldlHmiQSF20TpvwTN?=
 =?us-ascii?Q?INTBoPWJqpx0/9+jkMTDNDysxR1fMxZiEY+lAjfUoJfKbpWoXcBBeE5+cldG?=
 =?us-ascii?Q?7JwIHBaWjiigf3Xu5bUKrTpsKC8tVjHz1TqSVA36yKgPnzr9SpK2c0BdpZFt?=
 =?us-ascii?Q?30KX4cwKdqUPm6sZ6l5Y4p53NKsLjIJ4Wkqua1tfohk7M1qLZKQL4Mx2EDdz?=
 =?us-ascii?Q?eG5xd6msCPZKHRrk0runjz9MN/4sjX2jwhSTtAL4QkRj8WO7ogBNBTVjnPq2?=
 =?us-ascii?Q?9RkCEGY9fYNNXBINr24ztT39+0Ai8YzuRtyh75mPSM/HW/mYEgEDaof5J5Gg?=
 =?us-ascii?Q?bF0kBSfNN+Gg9yEoJqjgOZqnuiBNKE8vrWpPqv6asxpy1sbbIq9rdJrEn1eS?=
 =?us-ascii?Q?0FJCJpDR7nTdvx7f+YkhkxvORyBOaEZCxoRg4G5PTRWmrmfKqxggn2abZ51D?=
 =?us-ascii?Q?Ia7CzP+Lh51YrZMGwGdC2GQgogEC5Qkh7txPp2LBSTw6+z/uB/aJQHkL0aza?=
 =?us-ascii?Q?dMbSZS3eIQzJzLcJl8CBDsiCRmF2xjPCdIzek1wFTe1VfMP30dCjcdS53PLr?=
 =?us-ascii?Q?3iledmYFigL9l3eVjIvYQ8wdllOb3h6iPJUDrpdlpCw2kx/HA97XwhUEaCV8?=
 =?us-ascii?Q?yDkNbsfwcZvQVf7OuxZNnpAebaV67deeHtTHGPnp/fBgqw56fZbyNGbfJQUF?=
 =?us-ascii?Q?cED+WThnGJ3J47kr4KYyGv4IncHpiNOLab73w0nv3VxX4//nCzSA/h1kxB8f?=
 =?us-ascii?Q?IXlTbmvRkp+wmGS1OrvjqZHitxIPqMOA44APlNwr0pvRLshD1l8oDypierpj?=
 =?us-ascii?Q?a8GXexrygTA5J74nfTo1ubGXVM5jUf1tz7YVHaGX?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7131e8a0-cdf0-4c18-f466-08dad4925f3d
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 18:23:55.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1JKlnEb/3aIX90XWexlAMfh8wUzzSsDYtKfgHgRJzj7OvH78gZ/r+D0FaOhS7o3wbya4qGs+0ByjMG0wFzcsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR08MB2579
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mark

Hi Rasmus,

On Fri, Dec 02, 2022 at 11:57:59AM +0100, Rasmus Villemoes wrote:
> We have a board with an FT5446, which is close enough to a
> FT5506 (i.e. it also supports up to 10 touch points and has similar
> register layout) for this driver to work. However, on our board the
> iovcc and vcc regulators are indeed controllable (so not always-on),
> but there is no reset or wakeup gpio hooked up.
> 
> Without a large enough delay between the regulator_enable() calls and
> edt_ft5x06_ts_identify(), the first edt_ft5x06_ts_readwrite() call
> fails with -ENXIO and thus the device fails to probe. So
> unconditionally do an mdelay(300) instead of only when a reset-gpio is
> present.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

This is just my $.02, but it does not seem we are on the correct path
here. 300 ms sounds more like bulk capacitor charge time rather than
anything to do with this specific IC; is that a reasonable assumption?

Normally, we want to do the following:

1. Enable regulator
2. Wait for voltage rail to stabilize (RC time constant)
3. Wait for any applicable POR delay (IC datasheet)
4. Deassert reset
5. Wait for any applicable reset delay (IC datasheet)
6. Start communication

Here we are dealing with step (2), which is board dependent. Some may
require more time (larger bulk capacitance), same may require less or
none at all (e.g. voltage rail enabled by default and stable by the
time the kernel starts).

I think the right solution is to introduce a variant of regulator_enable()
which does not return until a delay passes, where that delay is specified
in the regulator's child node. Unless something like this exists?

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 9ac1378610bc..8bafa123083c 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1239,8 +1239,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  	if (tsdata->reset_gpio) {
>  		usleep_range(5000, 6000);
>  		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
> -		msleep(300);
>  	}
> +	msleep(300);
>  
>  	input = devm_input_allocate_device(&client->dev);
>  	if (!input) {
> -- 
> 2.37.2
> 

Kind regards,
Jeff LaBundy
