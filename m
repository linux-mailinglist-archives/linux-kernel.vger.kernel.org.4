Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502D36962BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjBNL4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBNL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:07 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83ADB761;
        Tue, 14 Feb 2023 03:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS3GK+l7i84OHROZRa8ybIBY2j/9UEojNHZyX/oo5NFUeMd2MK9BeJX7tvdhXyMn9Qtk4VixttPn9kJQD94nF3xi/BxCEhyjFqYnVGc4B4rUYkDMBKkbS8V0mphTP+tP5o7v1C5idKKCNmC5AYtVtEU5gbLpmRke15jndZxeYi3UDX0OOA4hC65eJi1x/cVbLfrUpMvXtkR12Yw2f17BmYWXr+5FwCl3WKaYcfFUfGctW1fmk0QEEkg88/JJ2vXZEo6MRWtI6kgmOKafG1tPt7PctNyINzi+buXftBKxOamdbr4U1Zp0KEfXmnRKo5OFN0WDph+BqI41dFyOq9Uz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmN+hp69IaZuaKAuYc1MCU3i85icCApcjyWflD348C8=;
 b=UqpFHCx7PutGMUHhMC7nuLwkelcg7DEzQlrncv4PO8ZC2GIVw+FWmqyeFL16qD0bK5XXC+441FTlExn/Vu2coQKEla/O0jJNyVvaB4/JZFyOcRZ4zU/qh5OHy2ZKT4BTo5c/4JITHG82fmWAsFtgtleGoJoy/pdV3cvIccSow0LNZ3rFGCuSz1V8jEcopuVaMG+oFq61/UFkivi73IHQx534uX7vLS91C4Dk96a1njeuNcztxdeQTSVOljO2uWKG6QT1+Yibh+vSGNhusHKn31mHxP33HyBbDzwS2xvl/hwKRpefI3Slqt/eP2K9AMmv2ZmI6XYH991etb3x8cVzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmN+hp69IaZuaKAuYc1MCU3i85icCApcjyWflD348C8=;
 b=Jdf2Yx19c9jlFlq2kzciNnaU2oMmKhFsIaHXPMj+mRgKZC5kIpvG/EElvyQnMyGhuqAoryyt9nkFBkAM0wuy1/vC43nHY72pG43JfioQI9SJYLO+/g/Ittk5Xpi7CoondxY+rtFpX9bQ8r5fCaUK2AVpZipn7RnikHSHMM3fxiCRAU2QiMdLUki5SkYN3bu2Zcx5pfA0cxawSQTiU/RC16D1jb2P07mQxLlucn4BebnhgNyRi2Vyqddqx9fK5iAfPy1Zj2hpiKfplrv2Ffb30baQgLOn09THuhO4WD9rlwmd02flaAO4xPi42TzLCFvFCMyU3EYTUFt07JdglrwtfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH2PR12MB5020.namprd12.prod.outlook.com (2603:10b6:610:65::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Tue, 14 Feb 2023 11:56:02 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%6]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 11:56:02 +0000
Message-ID: <3dc8575e-050c-5e04-ae7c-af380801a227@nvidia.com>
Date:   Tue, 14 Feb 2023 11:55:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 1/2] usb: gadget: u_ether: Convert prints to device
 prints
Content-Language: en-US
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230209125319.18589-1-jonathanh@nvidia.com>
 <bcbf9d22-c90a-a4d1-2931-0da43bc7371e@collabora.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <bcbf9d22-c90a-a4d1-2931-0da43bc7371e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0439.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH2PR12MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 7170e9f0-7ce6-4709-a1b2-08db0e8271f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOQP9PH6ql4/ra1xC3TIopupo6lmBmWIQ9Ys+Ev3kBh0ZjG9OeEiX0rO+6W5gpq3a30RzpoZ5Z5KnYjskD3r9IA/OxePBj8Bum5BjMCjhl7p5r4l8zy4m2B9lu8XdDq9XDIQGFdNzKJ3Dlp1DL0uQuwAdfr8Y8Mu+wW20RFfdgERT/m5lZjVJ4HuSzQ1OWm8sY3akHGXQKdgNYQLbYHlWJpcyRysMWNnpUjowBpqEpdeP0w73giuTwbjwy60OwyFU68z336xtv0WAIfwsxhwra9JFP589W5XcmxaETG5EjHQmVtcJEGF9gf5CxvHvHa7szRvqeCH97scbZ0UYu+ccnSQH+SwSG/3fFWjlpACvyixWa0ac7QN0PGFiT3dORHOAMeuhFCY5eT8J5O1N6A+ph9NVH3BgZBfifF94HJFiIHyI9unWvYh/xaMSSz7n5LRZrIrPaZjcp9o9W9HKBN01paM+ESlKubXjHcVWBGTIN4LucYzTXOHF/s9Qq1fGuZdSGLBNYU1Y9FD3pFWk3GsTxTpUtK9Hk36YA0NURaSrU515tQ8HOUmrZ05Fr+QBMHfrnQ5zcIyCeCGlwjlRuenVquypdv6DObWwM3T59OLMUHEyQsOxxCZjL7mmNrOg3jGGkAgNLRVITuslbymWwHDkm2KRuBZhQTNR83EF/vY1ErMY5O5WQhQ5vLB4ARORRi517P2+RUZC1uNH4QpjRSJrP41jKeOYoQcRs3NRSfSTy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199018)(5660300002)(110136005)(38100700002)(31686004)(316002)(2906002)(8936002)(31696002)(4326008)(8676002)(66946007)(41300700001)(6486002)(66476007)(66556008)(478600001)(6666004)(53546011)(6506007)(36756003)(186003)(6512007)(86362001)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJzVHVTWm14UXJVQ3ZJMnB3MThXanp3UnRTTW5vQ2VadkxpckZ2Wjg4UTRx?=
 =?utf-8?B?cVJ3NEdmMUJ6NUJEVDhEVTgvV3p2S25oOVBieXRHRWhWWHNVdm1YSGVPN2pR?=
 =?utf-8?B?ZGtkREpENHFoNUdOSVNUWEVPalNpQjRPVjRoWkgxTS9OeVJYWFc3aFovWVg5?=
 =?utf-8?B?eFcxYXNvOEs4bzUvQkNjbmcrVkVuaC96TWV4ZVVKWGtwNHFmR3ZCUDhaVW9X?=
 =?utf-8?B?VHNITjMxejc0VEl6YWJZSXpHbmFoK2doM0hoTUVaTlVVbVorUFQxMmlhL3pO?=
 =?utf-8?B?VVdEQU5VeC9sUTh5ZHZ1b1d0MGhwRGpXNWNhWHBpUHFCSm5wTWZidjJrdjNo?=
 =?utf-8?B?MUZqNTd5a00wNVVLUmpmQm1nWDdVQkNWbzA5bnYyblQ1OWxUZENWTTQwc2Mw?=
 =?utf-8?B?cEJjYmlEcG1jazhmaFhMLzVmYkg0WTFpOUh5cnVBbnJzTERMTU1QZDB3R2VM?=
 =?utf-8?B?ZWdrL0NnMC9RRFZSNFlEbnJma0s0Tmp0K2NTYTZ1V3dJQ3VDOGVjbXhFOVpo?=
 =?utf-8?B?SHBDVlB6Q21hMlhiR2JseTVxVFFJU2U4MndBVWVlK29WaDl1cUsraFhBYzVI?=
 =?utf-8?B?aFB2LzhMbG82VkxKYmZBcGwzTm1RVkFTeVM5dHdtMEVnK09ueEEvOGJNNnFx?=
 =?utf-8?B?dWhZN0ZlT3Bna0xVZDZoQTZuSmoxaE53VkU1TTdzYmtpUXdpYWpsZklreVJN?=
 =?utf-8?B?RTBuaUFBbnJqY0Q3Uk9BZjRzRjNHak5zWmE3SGpwd3E2dmxuaTh5cWNzd1ly?=
 =?utf-8?B?VTB3UGVTUVhDV0hIdmNSMHR5TVVoNThBcTBra0Y5WHl6cnhwN0h0cFlMdjcy?=
 =?utf-8?B?K2lkVTh4YXUxUWFFMjRlY2hwTFJXT1RkR2dxSTZWanBnQUNqckdIV1NVR0Ji?=
 =?utf-8?B?SDd3cHVocUM4V1ZXK1VjdzVETnRLajhKa0ZNaWFnT25OZ2NYRG0wOUFjb0R1?=
 =?utf-8?B?SEwxcVo0ekZJTVRkK2JmUFFJVXQvekVEdVZjVDlGQjl5aUloZEpMaTlPN01I?=
 =?utf-8?B?dkU0QllLSG5IaklKWFZJR29MU1BXYUluT0RYdEhpVjArVmplQ2E5Zlh2elEz?=
 =?utf-8?B?b0ppNDl6Z2FOd1dnNUx2dGppZ2lvUGd4MkxGbGJkQmh6dlEzOEZLNm5xSVBL?=
 =?utf-8?B?N0tSaDdjRkh2S3RsN1EvVXFyUE9tZklTUGw3ZEpseUIxaCtwWTJTbzBSUWZD?=
 =?utf-8?B?WDcyUDJ0QWlNem14dk5EcEVBZGU4dEVxbDFhQS9IM0JSZTRFVm4vekkzVXhz?=
 =?utf-8?B?c1U3VDBhYXRYMVptaHVKc3dzaWpyQnpYM0dxUFQrRy8xd2tuWlZFMmpQQjZz?=
 =?utf-8?B?amFGYTZyWHo0aVZzNXRFb0JkTGpDNXFWOVkvaHR3cTkxYmR6VUJESXRjTW5x?=
 =?utf-8?B?aERScUltcDVkSTkwTGdQclV6eXZ1V2lNc2lNbXhaQ0RZNjZORmxjM01FUThF?=
 =?utf-8?B?U3pyRjg5QTk5QVkzaWFadnZ2Zk5GWW55SVdnRW9OY1pueFJNOWdRVUg0WURB?=
 =?utf-8?B?RW1qbWk1S2NFY0xkYVdTOU1tTzlXeGlERkwwL09KU2JjN2EzN2l2cEVpVUx4?=
 =?utf-8?B?Z1Ryd2dJb3djV2NWYVBscnJ2NG1wSUpYS1JyMk4yQ05yZHEvcjBhWnNmWlRT?=
 =?utf-8?B?VVF4YTNFYThQWTNEdDRWL0FVRjRIOU53eTkrVHBnbkNRUlI5WWJwcGM0TEU0?=
 =?utf-8?B?dGVhcm8yMkZFQld0Q1pwU0dqcUFnRUx5WmcwM1NreWtPOTM5Y0ExbGw2RmdR?=
 =?utf-8?B?WEVsTzdLODVVTEg5OGlKYVBuSUxRdmhSOG9aZVJaZkdpQ0NNeHZ4NzBuMXpV?=
 =?utf-8?B?M1hZeUJ2UkszUFR0ejk3MkpZZzlyYnAvSkRRaWs0SGFmc2JwNkQ4UWVKakw4?=
 =?utf-8?B?QkNFeThKZldIUW14N09uZGJMbWRLUWVETEhyRUI0S1IyZ3BxV0c4eWJVVXov?=
 =?utf-8?B?OFJNUUJnRVdScHNGUVl0S2FWUytHRy9oZ1BhT3NValZtZWtIdGI3Y2I4bzQ4?=
 =?utf-8?B?cVg4RWhnZjFtN1RKbjNRd0VzMlU2MDQ4UVVLZk05VGFCNnNNdmZzdGdta2lT?=
 =?utf-8?B?b2hxUjN3cjNadUFZSXlTam1FTlRUbXNwaFdRQnY0RHNvNENJMWlGUS9zYitz?=
 =?utf-8?B?MDRiMGhIc24vS3NtSWM0ZDczSWZCamlRZHVqQVlxUlJzVlFBd0ZES2NvSXRJ?=
 =?utf-8?B?UEVQKy9qVWkzSWZITFNzM2xESmYyd0dwZXIzekEwSkhLbFgrVEJKd3l2dHN3?=
 =?utf-8?B?eGVRUzVoQ1ZuTWc5RmpqNEJvM09nPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7170e9f0-7ce6-4709-a1b2-08db0e8271f6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:56:02.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnOih4UsuwsJNfBgkFP978uKu7RYcK4q3jOt/BbMZ37hRrVxkJHNwKfi/UyPo5fh+l7tenRViFeDqofRFjKYwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5020
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/02/2023 13:49, Andrzej Pietrasiewicz wrote:
> Hi Jon,
> 
> W dniu 9.02.2023 o 13:53, Jon Hunter pisze:
>> The USB ethernet gadget driver implements its own print macros which
>> call printk. Device drivers should use the device prints that print the
>> device name. Fortunately, the same macro names are defined in the header
>> file 'linux/usb/composite.h' and these use the device prints. Therefore,
>> remove the local definitions in the USB ethernet gadget driver and use
>> those in 'linux/usb/composite.h'. The only difference is that now the
>> device name is printed instead of the ethernet interface name.
>>
>> Tested using ethernet gadget on Jetson AGX Orin.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> V3: Added this patch and dropped the patch in V2 that improved some of
>>      the prints.
>>
>>   drivers/usb/gadget/function/u_ether.c | 36 +--------------------------
>>   1 file changed, 1 insertion(+), 35 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_ether.c 
>> b/drivers/usb/gadget/function/u_ether.c
>> index 8f12f3f8f6ee..740331882e8d 100644
>> --- a/drivers/usb/gadget/function/u_ether.c
>> +++ b/drivers/usb/gadget/function/u_ether.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/etherdevice.h>
>>   #include <linux/ethtool.h>
>>   #include <linux/if_vlan.h>
>> +#include <linux/usb/composite.h>
>>   #include "u_ether.h"
>> @@ -103,41 +104,6 @@ static inline int qlen(struct usb_gadget *gadget, 
>> unsigned qmult)
>>   
>> /*-------------------------------------------------------------------------*/
>> -/* REVISIT there must be a better way than having two sets
>> - * of debug calls ...
>> - */
>> -
>> -#undef DBG
>> -#undef VDBG
>> -#undef ERROR
>> -#undef INFO
>> -
>> -#define xprintk(d, level, fmt, args...) \
>> -    printk(level "%s: " fmt , (d)->net->name , ## args)
>> -
>> -#ifdef DEBUG
>> -#undef DEBUG
>> -#define DBG(dev, fmt, args...) \
>> -    xprintk(dev , KERN_DEBUG , fmt , ## args)
>> -#else
>> -#define DBG(dev, fmt, args...) \
>> -    do { } while (0)
>> -#endif /* DEBUG */
> 
> Actually there are more (at least hypothetical) changes than the declared
> change of printed device name.
> 
> If DEBUG is not set there can be _more_ messages printed
> when your patch is applied as-is (i.e. all DBG() invocations will
> expand into some dev_dbg(), whereas before the patch is applied
> they compile into nothing).

So dev_dbg() messages will only be printed if DEBUG is defined or if 
dynamic debug is enabled and the prints are enabled.

Greg, let me know what your thoughts on this version are?

Thanks
Jon

-- 
nvpublic
