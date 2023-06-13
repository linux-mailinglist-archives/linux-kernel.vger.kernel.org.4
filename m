Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57BF72D6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbjFMBZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFMBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:25:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04419187;
        Mon, 12 Jun 2023 18:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8BKkgNlnD59F8p0WRcrPBVkfexY4MF7rWUK1stuotTxaz8247aRDZo03FgrY0b659C5ut4+sfBHzmvZQ8cb8Msmp+ipZ9joJsNXUltk1NzwRHqqUvvpx8/758VvvEckRvucSsm3nRGkJNIVqU0kG8sB1XoPmUkHJaEXKv2kbqdcaNGvFVLVYhm2F4x4KWyNUc5fsuFojzeORiPu20d79jKCfXf6TXRwnAOIBHi8FhT1iXFNCUiJ3j78Yn5w++AI6eTZPKYhBBnjCu6dMyYaU7CoASBJkuxQpTPXizWlVY9J+7/piR16tJ/bnYiZi3+AxKt2zvTtqKmwA28thjKRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+ZW462oeYcWujXNvtFkacYIfoDoEtCBQzL3G+4iCFU=;
 b=P0YjXExIBDpJz9aEDLwfwlKjKtHExL5etlt8RNU9P5sqGc2E9UG075vzR+PyFd3gcjk+krrXDU2JmhDyg0kWjPmBuwRyMDQVjp/7jdPWUfAaLUFDjRNWIq69yIPFklEDQ7lV/DT7sq7Uz65kKfAu5cayA/pNehoou+MgehsWeJ+2A++4DNHn87iRVOyRyxfhxTYDQTSy8eIYL/p6W1fT9jDWAfTqjjlLSaxQJ5ofUJWh5jOTd53wFAz2SQ7k5Mq8pvrJ1iDR3trOWfSXSL+oS+XxHpezjTaMs10Xj2w6kOd7HGJ3HeASjfq5eJFZQCnthdx9BuXCdIs9MaxO1DU+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+ZW462oeYcWujXNvtFkacYIfoDoEtCBQzL3G+4iCFU=;
 b=hZQ77g+ruB1kYoi1i47ge9G85imnfJr1ge5hI4cqgqFn4lAZkGLkmdvnRbdUe4HSLFvH1RhBllzll4+sEsu50GQugBXKKdq0CRWfrGg5FsRDQpm6f3V0UbshO5/uYim9zte3OgiORguXQ6nVGtYbjmpIKlTOhiC6vfVQ/haJMl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB6469.namprd08.prod.outlook.com
 (2603:10b6:510:35::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:25:26 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506%4]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 01:25:26 +0000
Date:   Mon, 12 Jun 2023 20:25:20 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     James Ogletree <james.ogletree@cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] Input: support pre-stored effects
Message-ID: <ZIfFgJJtGCfyIne4@nixie71>
References: <20230612194357.1022137-1-james.ogletree@cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612194357.1022137-1-james.ogletree@cirrus.com>
X-ClientProxiedBy: DM6PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:5:40::45) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b017995-eaca-489c-e23c-08db6bad1113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFvuG9GwF0KEtG+e4rh8QTBgezdXoLckx2XCd/pYaUGNCrrS3Zq3rr1Q11XFgh1aRrjabnJnLar8hhB1nGM44lk2g2JDfpyMIYcxiHyrplWYqQSGN2OBps9vAS0YBQujXdQ5Ha7mFIfu0gga2kOidFcV061WwvKL3BMox/YQphzlFxcgIWWIEpaXHYaaLcgZDJGcwcHxpmQAZoiobSbevtMpo4m+yFMsBtXgqeB4SpK4EoldBx8DjnR1nJAJgpeLzV/tLuCPKduydl3INWqXxvETOFas6Iyf7B6IrsEr8/+89V7+i7z9HOWKg+q8YyM8X2tgPLz3FPkSVcY2Jyqc92bFHCt4m9I8Ow38knGRRfey3WQGg5YqbXkrKdEBSPg3u1aMRUiN/LDNxW6AGLuBFpWRfn+GLPue+AiMoWzE1awE10oDPXG/l+U+7TQTQXsCPwLiFh7VqcAepXhFqeGpnRc6MKpXTJqLoxduRrmuI5FepB8Efaki6x3+Eld9xpS0vdHCEYUoZuMkr4tHxsZPKGuDlCAH70qfR8pp6Gu5eC5HZf3LgKLdg9m1WpVnQONYFuiGPgMpEk9Cy5FJk6bHv43+jMqEbtB79yjJaM2+D5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(396003)(136003)(346002)(366004)(376002)(451199021)(6486002)(6666004)(9686003)(83380400001)(38100700002)(86362001)(33716001)(6506007)(6512007)(26005)(186003)(2906002)(5660300002)(8676002)(316002)(8936002)(41300700001)(6916009)(66946007)(66556008)(4326008)(66476007)(478600001)(95444003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FReBpOhW6Fq0siYFUKjPROgcIN5Pqh7pAsIYSjyu+AEg2dYWxCySOoWw5C09?=
 =?us-ascii?Q?r4c7TKUDHui28ew0/GtWTnh9hVTAch3w5kMWO8lpfZNWxIvlCPu0DppqqnKg?=
 =?us-ascii?Q?cnSFUogUr1kveiG5UO2XBtb52nDNyDtysdNSF7f05YkNiyiGeKhBG8QhWu9M?=
 =?us-ascii?Q?WSUepMBRA0NAHnqz/32Zz24ftZiZUPmYCbFnBfzNegjiRKkS/Fx+Wzu4IxUt?=
 =?us-ascii?Q?GSQK7m4QebU1w7jkgChdVYrz6AhU5V1O+C63JVtvoTG1JQtvd8Lhk1qGDmXF?=
 =?us-ascii?Q?g2zVwJ+ez8mqRZftLKtg4XQnobFbhqKNmbFMM3+ROv/6H7fUuJeS9Z8o3UNj?=
 =?us-ascii?Q?+PXwvBfwCWiKHjg2xf+cBQi7fVXsWwSYvzBaxWfgIY0j/CCYpfgGAMgxNYkY?=
 =?us-ascii?Q?YVePFNF/G/ZMFCZQGSPZkqBLQsZOAfeFUEb9lhad2fuGYXWLJ4QzDwamm3Hq?=
 =?us-ascii?Q?UCDixM6SNQvUhVeFGxRAX9sJzvGyhLFAhWZYrQu6/gNPSBsilqWhHqqCULg5?=
 =?us-ascii?Q?Ssnf64QIIOMXZgwH9vqRP5M3NYx9kTbpVCI/BqRVcILv5Y6/lWyC79AabmDA?=
 =?us-ascii?Q?a2IPPV+AaSfzF9hq+f+uccXVDbU1PUszxr+Wk6zFL6ZsXUEkKm+Vv7uW3hAx?=
 =?us-ascii?Q?k67qOkDFbBBIDN2U+Ttm42dA0NBjMkD5d97XOItgPc6MrP5SpzbkzKMgZCQ2?=
 =?us-ascii?Q?KWG5x1ipeIOA6PXxlZwchAkw22DE+Ng/xybWX2xy57xvseMALsjkUqTaaZrp?=
 =?us-ascii?Q?jHDjOD95IcCvG2YgzsiBokn0nlWPqopGj+93m3y3F9tnz+dnXxkm/0mDzyR1?=
 =?us-ascii?Q?q+O5j4eOPtWJuencbFarRFTX93uaoG9lUEUk7Hb8K7QiyaJ0RUZ1UT8OLfUN?=
 =?us-ascii?Q?rBvl9VfN1oOOvHAtHS0NSSpWIAf0sgqfjgcFZJZp3zzhXW3c7Ii0p5KFKmfh?=
 =?us-ascii?Q?zWIlmzMRbI+nkKPae8K/2dOZ52NLs2ukDmQWIRzCOdBSoVG+Vwgq2pbQ43Dp?=
 =?us-ascii?Q?i+Z3mmufM9cfx6x3it/F2vzo+iJJ3t3M/uFLGlQDLHSBAT5ppxUgV/eYnUh0?=
 =?us-ascii?Q?sW/qfgnmS++JktNbhBCEmWz2VQM9lDg6Ojr91f4K+iXzyqkQfV2BGovvjvQV?=
 =?us-ascii?Q?Z65U0PjXIuMt4vO4rIZ2uTyFI0/XleHgis4AWxlHEhu8amrgHg5E2ZPafNvw?=
 =?us-ascii?Q?57QFsykPWP14Bc55xKsx86IXbtjR/bkuuaqF0lH4i606+9JMVV/DMqpuktRb?=
 =?us-ascii?Q?ywugEzMpJkZvuSICJ+Fu1L6srRtWAGZ2nMfYvd79FH/7+qRNsW24rrdNSGaS?=
 =?us-ascii?Q?iFwsc7YI97zvTr6tquqqGfMBfhs2G+NAeHBVOe0Z6PH6Ze+VvLkWj6CjVVQ5?=
 =?us-ascii?Q?2IAWg6REwEDqgUi9zMAJqAETnuU9vWerPNE6htRyqUvF1kWUy0Ya7WpHkZ/H?=
 =?us-ascii?Q?s3i1h74KX2GO6Qdz8thf11wOQOjLYIxp6OnqAGZlBAFF5A+et5TZGd2EJosS?=
 =?us-ascii?Q?WJVYRC/oP50ya9ina2v65DIacUddrfFpIaShnUIWnekKXIv8xqy6yceFt5vf?=
 =?us-ascii?Q?4axiAJO4vCRSUIhEP2ERXRAtio2M+SXkvZ0gOD7v?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b017995-eaca-489c-e23c-08db6bad1113
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:25:26.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXb25kghWV+amFfVwoDuOEduUpFsMImP5/JUSdqOn81Bz8vHWxOYjHUSW95PdujHlL1vyBjOMZsdRSfszF92Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB6469
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Jun 12, 2023 at 07:43:57PM +0000, James Ogletree wrote:
> At present, the best way to define effects that
> pre-exist in device memory is by utilizing
> the custom_data field, which it was not intended
> for, and requires arbitrary interpretation by
> the driver to make meaningful.
> 
> Provide option for defining pre-stored effects in
> device memory.
> 
> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> ---
>  include/uapi/linux/input.h | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 2557eb7b0561..689e5fa10647 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -428,17 +428,27 @@ struct ff_rumble_effect {
>  	__u16 weak_magnitude;
>  };
>  
> +/**
> + * struct ff_prestored_effect - defines parameters of a pre-stored force-feedback effect
> + * @index: index of effect
> + * @bank: memory bank of effect
> + */
> +struct ff_prestored_effect {
> +	__u16 index;
> +	__u16 bank;
> +};

This seems like a good start; I do wonder if it's useful to review recent
customer vibrator HAL implementations and decide whether you want to pack
any additional members here such as magnitude, etc. as is done for periodic
effects?

Back in L25 days, some customers would assign click or tap effects to one
or more entries in the wavetable and then use a separate digital volume
control (at that time exposed through sysfs) to create a few discrete
amplitude levels. Perhaps it would be handy to bundle this information as
part of the same call?

It's just a suggestion; I'll defer to your much more recent expertise.

> +
>  /**
>   * struct ff_effect - defines force feedback effect
>   * @type: type of the effect (FF_CONSTANT, FF_PERIODIC, FF_RAMP, FF_SPRING,
> - *	FF_FRICTION, FF_DAMPER, FF_RUMBLE, FF_INERTIA, or FF_CUSTOM)
> + *	FF_FRICTION, FF_DAMPER, FF_RUMBLE, FF_INERTIA, FF_PRESTORED, or FF_CUSTOM)
>   * @id: an unique id assigned to an effect
>   * @direction: direction of the effect
>   * @trigger: trigger conditions (struct ff_trigger)
>   * @replay: scheduling of the effect (struct ff_replay)
>   * @u: effect-specific structure (one of ff_constant_effect, ff_ramp_effect,
> - *	ff_periodic_effect, ff_condition_effect, ff_rumble_effect) further
> - *	defining effect parameters
> + *	ff_periodic_effect, ff_condition_effect, ff_rumble_effect, ff_prestored_effect)
> + *	further defining effect parameters
>   *
>   * This structure is sent through ioctl from the application to the driver.
>   * To create a new effect application should set its @id to -1; the kernel
> @@ -464,6 +474,7 @@ struct ff_effect {
>  		struct ff_periodic_effect periodic;
>  		struct ff_condition_effect condition[2]; /* One for each axis */
>  		struct ff_rumble_effect rumble;
> +		struct ff_prestored_effect prestored;
>  	} u;
>  };
>  
> @@ -479,20 +490,21 @@ struct ff_effect {
>  #define FF_DAMPER	0x55
>  #define FF_INERTIA	0x56
>  #define FF_RAMP		0x57
> +#define FF_PRESTORED	0x58
>  
>  #define FF_EFFECT_MIN	FF_RUMBLE
> -#define FF_EFFECT_MAX	FF_RAMP
> +#define FF_EFFECT_MAX	FF_PRESTORED
>  
>  /*
>   * Force feedback periodic effect types
>   */
>  
> -#define FF_SQUARE	0x58
> -#define FF_TRIANGLE	0x59
> -#define FF_SINE		0x5a
> -#define FF_SAW_UP	0x5b
> -#define FF_SAW_DOWN	0x5c
> -#define FF_CUSTOM	0x5d
> +#define FF_SQUARE	0x59
> +#define FF_TRIANGLE	0x5a
> +#define FF_SINE		0x5b
> +#define FF_SAW_UP	0x5c
> +#define FF_SAW_DOWN	0x5d
> +#define FF_CUSTOM	0x5e
>  
>  #define FF_WAVEFORM_MIN	FF_SQUARE
>  #define FF_WAVEFORM_MAX	FF_CUSTOM
> -- 
> 2.25.1
> 

Kind regards,
Jeff LaBundy
