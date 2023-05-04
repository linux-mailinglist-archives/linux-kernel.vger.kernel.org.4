Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0E6F6FFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjEDQir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEDQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:38:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BDA1FFD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGHkglYmHrNDPF05Var9oZwJGMDRycfG2DuRKJSb4FpT4Bw29wBcEJpwgvL41Uz8JI38NTQa2uSM2xi9rb9v5rcRpWfy0t+SP9pHjHjZ/BSLt53B0bqvg/xOuVfyWTE9FAmvhKWcOGHkDT8EP9IWZ4CGKkuRMIBY++85fn4boBQXIut7LaOjdAcdzTsqSFP2lbVg8L/3Z6sh1k40oMlmD7ms84pNuL0k2zXKDN8uRGwhz0ffMfBIXscJS7H9RLJkNDK6cyKY2j1/t7ltvbdmNIdhbiHjoND1FhDM16cVcOyPc0dMWIqslt4FnRo5DOIm+Y0i8MDjEWbAmu2tP5wsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtWYnOrf0ytrKDRoMMy/Tju6ZjeHoP6pEX/EPRSr/fE=;
 b=oEo3vimJ1gdimI5ArS8ZvDKIrq5xMLRnXlyWRmxIPp4aHK3lK1+soyxbbv7k4rO5wzlMETQ+m1aec57PjzQaGPD0JIHyNilzCOQ55HObpBUaGzu8TrnO/nImu+Oy4nROZmdR0eoUpCnaTHoXPYsV+Ewfv6tgyRTJshFztN/bq3mD/2CSvOf5EhcNteL7txflgKZaZ11gSaxpofAeOj8rhHer4gWyBQ3pcWa5b41k1MqT1zUv2xthGu6bG8RjYSp/0LB41L51om9zLtxJvp9GlfYFW0p8dEUCk48LWaI3+6eXl5uDnOM308DGPROHnfuH6oFUOFmUUAcebQypdoK5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtWYnOrf0ytrKDRoMMy/Tju6ZjeHoP6pEX/EPRSr/fE=;
 b=CCitgbgc+bXz22LsTSNjAdCCmy6cfrybDrLsMnKz28n9EQBbLFrSZNn8TebfWefnfuPKNwRcO6fKtiPaVYwqwSL7J7Aj3XSf02ymRf6fK0Quynzr30QWY/FQ0z/MtxkZw5PQI/yL84xDF+UqYxO34MXx325TTnLEkLLVC+4gm+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 16:38:41 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::13fd:6611:29cf:a351]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::13fd:6611:29cf:a351%4]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 16:38:41 +0000
Message-ID: <835c3de6-7460-226c-96e7-839aeef6064e@amd.com>
Date:   Thu, 4 May 2023 22:08:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Hang loading initrd since last Friday.
Content-Language: en-US
To:     Ben Greear <greearb@candelatech.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
 <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
Cc:     Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: f21667c7-69fe-4dcb-6a19-08db4cbe0487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55VKnDlZMA8fVkWe5xfs1cyUfYUwYaou3ws/Uig2wfzhjfo2Tv1px7FFamOssF7fxizV1bRaDvvaAq/o30vdCOIMiWPuHhS0q+K8VHlSDT5n5coIN5JXA1Wk17MnmIlG16IpLPoerX5jPIgMlWWd8I2mxeab5LWWt9v6TJe0J6XanOzLyqLcUKt6AAkejcx5FrNifWEXQ99yAiCw0UjH9HsXE0FF09a1oiPOXM4b+pdrjXAAFQuDaTXjkyXyWV1GSiT7iG2aCzClE0OJr16Sr8sWDnGhIznNAj6RrYYgzq1bZzyG+9gKdmEfIGD1m1rSJY6VUxgQmQ14MBZq7vt6fncXf7W53S5gf0GgaF7GB+oozKqRfy7bK7UgH2GLuwfU37uM3AkEF+qq44a4vqNXU8eHFA5fTxjYUe6gmmj5yUBQBwNZ9LNqfZtDtsA73VA8cfG+thbKOgKaiw57DoweyL40zFvqnuHeJdjEqhjBW7kGkPavy92UM0UjSiHg0HHp8JZoGrAAChfibFtriQzGQvTUaxj3kgPvuzejarbT8wA5bxJ2xquEDqLjy04ZcVhgRQQWu/N1hTjuoEnw4KCLtj0Z4nPv5FzaSjau5Cjtq1AYn7wVbrDJvLBiq3vxDQ+xfQ4sSf1RI3dRWu6MWd/VHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(2616005)(6486002)(26005)(41300700001)(6666004)(83380400001)(36756003)(316002)(4326008)(66476007)(66556008)(66946007)(31696002)(478600001)(2906002)(110136005)(38100700002)(31686004)(186003)(5660300002)(8936002)(8676002)(53546011)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmE5WWZOWmZRN3NTTkplWUN1dFk2U3diSTdWRjlvckpTeWRYcUVNT3l0K2lL?=
 =?utf-8?B?c0NLUzByYkdIUVpzbjhxM0Vrc2F0RjFtbVlZR2ZEL3hTc3FNQjV5RDIrN05x?=
 =?utf-8?B?UXJkdURHdmRNWGI0K3d6eDBoUnRKNDduQ0xZMGZXbXBkYkhBU3FsdmlVTVU0?=
 =?utf-8?B?MDBmWFMrejRZdks3MUF3UUxTdVJrcUx2bDg0VUh5U3RVZUlkM04zVU5XZXZ5?=
 =?utf-8?B?M1RSelFmTkovcm8xbXhMalBGTWxyOCtRQ1ZqZmVjaGQvNFZzVHVhZStXK3ZD?=
 =?utf-8?B?Q1pqOUZONXdEek5iWjZTaldSSHpaanFJMThPV3BpR2xhamI1U3EvNWVZYzhE?=
 =?utf-8?B?UGZkZTJyMktHMFk4QWozSE9udkNodXIxaXozNjFCNE02bCt1bmNsOWJFR1dO?=
 =?utf-8?B?blE1NjYvcnpTcmxXUnhEMW4vdjJNTlVyL0ZQSEc0ODZZd1ZCSTZteWI4U29T?=
 =?utf-8?B?aDZnSXUzS3pjcDVsK1FSMVpxWnRjTHZNU2ZKNVIwZUJUb3BmRUZGOGFZSDZV?=
 =?utf-8?B?RC9ZSGptSTg0SkRIMkdTVG9zRC9PS2p5dmRMV2d6T0c1LzgyZzA3eGMzWGR4?=
 =?utf-8?B?WkJ3dEs4RnA2ZkpiMXZIN0tyemp0bEhuM21CZEszWjFDWVBUZDduVkpmTHRl?=
 =?utf-8?B?TE1RMkw4QXFvd3ZTRDhQQm1JdmVFbm1nMEJ0K0V2bmJOeXRWTlB1WVRTQjBD?=
 =?utf-8?B?S05uRWNmczFLSU16bm0wK2lnY0ptaGc1b2pxMjNzWUZ0NjB2UVpNMkFzTWdJ?=
 =?utf-8?B?akMxdXE2ZSsvMkM5d3BIZzkxazUzUGpBREpaTFplVDhhTHpCeFNmdnIweTJU?=
 =?utf-8?B?QnZ3cFR5UEp5NUxtZXFaOUZCcFl1S3VkUWZHVVNsL2srTFBPZUh6d0NzYkRh?=
 =?utf-8?B?MFNrQ2ZFdjVLenYycnYrcHdvR3hsbWExTE8yb2lJVmNiM3JCTzI5TGlzdFo5?=
 =?utf-8?B?TGU5a3JkQThvbHVzY1JmYlFTMmxjSFpUZ3hMaGptT2dDMTlNZ1pHaklOdGdZ?=
 =?utf-8?B?SkZFVEQvZGRLYjE3dUVOQ09JYXpXeEx4azUxQklxKzhjZk91SU5VanJXa2NO?=
 =?utf-8?B?UzA3MXJyQXNEVDVKYndlUWVHeVJmSklPT1NUUldyZTRiOXpscWZxM1JLZlRM?=
 =?utf-8?B?T0E3Y1h2cTNldEg0MHc0UU9OMGRMa0RqNnNXYXBSTm1oTlBwUTNZTXpXanpj?=
 =?utf-8?B?SncxcTh1OTgyeFYxdXRmMklXZDMyc2k5YkxKU2svNzVnOWoxU3dlWWovdnAx?=
 =?utf-8?B?WXROdnpUU3p4OFIxMjRSNXY3STVYUG9jQWtRNnlLTko1NDFZekhNV2dQZUl3?=
 =?utf-8?B?MFV1bGFnZHFhc3BOanFuSXp0a3pCd1JVbk9HUjFNWk10dkZXTmZxaE9DYXdq?=
 =?utf-8?B?TGhMTjdzdGxzOHV5WXNmdVJNK0lMYzU3ajV2N2xHWkE3RmlQLzhsQXlPYUs4?=
 =?utf-8?B?L3Z1cmZsOWtaZ1I2V3BqSGxLWUFsZHltY1lWL3hLYXhpKzh1dlVsdE5Zbkpw?=
 =?utf-8?B?MzZucFNHODhNYXdlNWZGSGZIZHF3aWc1V2VLWHNtb2Y3SHZaaVBhelRqY0Mz?=
 =?utf-8?B?KytrNWJ2enhWNlFOMENFci9DemFvVUt4cUpNSU5YYTJvakhIaHJqSVBQR21q?=
 =?utf-8?B?TnZ4YjdoZ3NUZlNMRW5JWUJFRTRjc04xbnFaQWRwWlVQK2JCalVaclBIaktq?=
 =?utf-8?B?czNOYUlhcGFjWFM1SmxRQUNHK002LzNhQVlHTmovbC9uOEtra2cwSEtZMTBY?=
 =?utf-8?B?Zk1HWWlKNkFwYmZEdSt5c05PZ0NLZ1d2TURNTlpHbVI4OURrQTkvWHlrVlNk?=
 =?utf-8?B?eDBDTGlkSVBSS2tadHZHMlI1ZThobGUyaTAyNnpqQ1lkZW5aTG1PajBOSFM0?=
 =?utf-8?B?T3JuY0MrblFYcjMrL0NBYkJoeHdwSVRJRyttQXhoQVB0WjdaODNwbC8waGZN?=
 =?utf-8?B?WTVNVlg2Vzg5Ty8vTDlWK0cvWWlVM0UzaGUvRy9FUkZta2ZyU1Z6S3pCTlQr?=
 =?utf-8?B?NXNUU3pjR0t4QXJ6VUFHRGpjTG9hSU04S2tFelBYeDdNNHVXaFFkMlQ4R1FH?=
 =?utf-8?B?c2x0MW93WHRXRGxMUUNsYmUrckJtVGZ6QitKZnpGck43MUVDR0s5cXppU2pa?=
 =?utf-8?Q?okRscHH6DsVmQLW4YFEfeYi68?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21667c7-69fe-4dcb-6a19-08db4cbe0487
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 16:38:41.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r9UAx2zoTjQRzvaWaXAiMjIdytIg/soMivdx6NdDJgHLZMJZtbhfgXrOmrSux38Bl0ZKpT1/KfC8n7qeLmCxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/2023 5:19 AM, Ben Greear wrote:
> On 5/2/23 21:46, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 03.05.23 04:31, Bagas Sanjaya wrote:
>>> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
>>>>
>>>> Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.
>>
>> Just to understand this properly: you mean after the boot loader said it
>> loaded the initramfs, not when the kernel starts using it?
> 
> I am bisecting...it appears to be .config related.  If I skip enabling 
> things
> during bisect, then I do not see the problem.  But I copied my original 
> buggy .config
> into an otherwise good kernel commit, and now it fails.  I'm manually 
> bisecting
> the .config settings....
> 
> Thanks,
> Ben
> 

Hello Ben,

(CCing Jens here)

I was facing same issue too. Surprising I did not hit the same on the
guest VM.

After bisecting, found that Reverting
[9f4107b07b17b5ee68af680150f91227bea2df6f] block: store 
bdev->bd_disk->fops->submit_bio state in bdev

Helped me to boot back the system. Can you please confirm

Thanks
- Raghu

>>
>>>>   Nothing useful is seen on
>>>> serial console after that.  This was working late last week.  Other 
>>>> older kernels boot OK, so
>>>> I think is is related to the kernel.
>>>
>>> What is your setup (especially kernel config)?
>>>
>>> Is v6.3 works for you? I haven't seen this regression on my computer
>>> using v6.3.
>>
>> Ben, you just to be sure might want to check if a kernel image that
>> currently works still boots if you regenerate its initramfs: maybe the
>> initramfs generator or something it uses changed recently and is causing
>> your problem. I've seen a case or two where that was the case.
>>
>>>> I have not yet started bisect, curious if this is already know problem.
>>> Certainly you should try bisection.
>>
>> Yeah.
>>
>> BTW: What kind of platform is this?
>>
>> Ciao, Thorsten
>>
> 

