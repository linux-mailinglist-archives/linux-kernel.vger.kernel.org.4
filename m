Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA069F636
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjBVOO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:14:57 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3315144A3;
        Wed, 22 Feb 2023 06:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdZitmzAj0+nOpDyN1ZPmqs+EE1Raay0VQCax9LIguRsHvEOEAOK64uu2KC1XFhIdhsbw/xcDBRPWwFFtKE+/xY3sXu2HyENYFe6/sSI0+cb4/I0RyATpktkuv4U60/ntbhtT7/+OWp247gsmK8Iixi/Rmq9Jt3VtPfAJbr+Jr9rYRD+qWoUKnh7/hLYdDkWA1shJ45uFwaruY0E60duBtbTAcrgBXYCQgFPB6tObQXI/jrV6tM8Soo21ay4JhZTk8fchFmwgZZgqGp5yombHtoqWY44vRtri+3sibZtjouST9Kb1WWbArJ6euqAcW+N9s2xxeG5ppIH3Cp7+Hf9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhmmDYzWRUtj+RkaGPEk3zAV0g++rXM5xKL7Jpig4jE=;
 b=JmL5pvF5rRef6Rqo119u5ZW82FsyqVky2iPh9kg7jOISb3LJuctHpME3frr9Eispkvc4y/plfemM/3KuoW2wTN1NF3ymrOHH2YlkzrLFQNmk/0zwX/zl0yIRg1S9LfDiXZGs4ZfgcjjfOfWFb/jzTkPchmpprxnhW/aTKedYgIgDVNvw8FYg2bPYo+Utzwj0eFqPsCh0AsSAKBAb32z6cj8MO6WWsjJTcv37U1xIyGZL1yau2swYxMobw52K+QwcZHKALldy7M9Iuljnflco0SshT4g7qo7ra220UfzQHe7KdyS6GqVrvLFKPZ8WlIXn+HGWd6QFMRg2/UZRJdQzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhmmDYzWRUtj+RkaGPEk3zAV0g++rXM5xKL7Jpig4jE=;
 b=JrSh1CXvixx86Frd0AGS9tWs6Vu10l65BZvm8AE/lGcqr8ugxHRCgYoNJTL0TNH0Ps2x0R3IExTs1bUPVPcFlhOBjyoGcC43cTD6QhJ/3VV3ZwaEzOEfyRSUg2Y45y6Yq8euesVBKBO/EJJ8bjLb+cwt72cTYXMoK9XGJORpDHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 14:14:53 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4%6]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 14:14:53 +0000
Message-ID: <c5317c66-fea2-37da-26ab-091117880d26@amd.com>
Date:   Wed, 22 Feb 2023 08:14:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] docs: Add relevant kernel publications to list of
 books
Content-Language: en-US
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     corbet@lwn.net, rlove@rlove.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230221180049.2501495-1-carlos.bilbao@amd.com>
 <20230221180049.2501495-2-carlos.bilbao@amd.com>
 <CAPDLWs99LUCQ47huoiiZmQfAsHX8Esmepu_hSCXWoqcpEoPxKQ@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CAPDLWs99LUCQ47huoiiZmQfAsHX8Esmepu_hSCXWoqcpEoPxKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0053.namprd20.prod.outlook.com
 (2603:10b6:208:235::22) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: db1d6bf8-96ac-4e77-6f82-08db14df2adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvPQ/5VdJRKL7u4UcE6L6C7Orb67yzAB/cN99x3MFaMban92mX6Z2FbKZPyVjd+/UmMy1HX717ACd1CZc28AR3fmkKlSB6DtZ+azlBLYd/jw+KRodh0PPF+CvcEzRtx5H39CMJnNzFQPULaiTS80X8JsYeeIwAG/IIXnRhAv0kDzvoQ+ktivTtSaOCnifdACWqfdy8+9NlTvf30HWHTBIGKi6GEWVVIvLc/i2IWamtuP6bFEz5em0QrMzu8Y8AIE9TpUph2glzWEBWAMLy/xaXUfayNDXAp+NHnSWBDMM/Rtd37sfWV3dAzIHSmrFCauuMFLpH4S1sbFATON3sN2pPZKQ46J/eOrFgZD76PuFMWzt/MCHHBhZqCCsTn0QmlePoK3/S63YyaRHAUZv2zn0oQeBRzQKZeuNia4X2APW5bB7fSSxZRiMwfQJTZb3iEZveng0gE0Hb4VyjxCSXpyT+lwUpQZd78DVoJu7f2rYj9x+2KCDbfQ6iaAJ/NavSfHrfvhCYVV6CmmBSRLtbJmQNOhupF34NOEdtk82K71uy2v8LdhSCLrnI5Scknv0dXnteTrLpeqhjOMp5nZeK2VS1pFzLplM5YXrBG45PVHNluI5PVCB2vMch3xiMS8DtAFtTmrLADsedmnAKaj4kyLJotIFzhuuEWXFIs1rxwWcRWM32Y/Mb+qu6MRi7H5HMW+0GSitrfc1mgIj8vHXpq4JVVJJmHd8y+yw/pl3ktWszo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(478600001)(26005)(6512007)(186003)(53546011)(2616005)(66946007)(6486002)(83380400001)(6916009)(4326008)(8676002)(316002)(6506007)(66556008)(66476007)(31686004)(8936002)(41300700001)(44832011)(5660300002)(2906002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJMUU9tVjhUc1h3U1dyTWZLcVRRa0UxdGkvTWtTcDdXNU5tR2UremZBNFlQ?=
 =?utf-8?B?SHpsMlFvQnpmMXlMN2VtUzBaVkt1aXpicWdpRXJNNWJMRzQ5QkxSVXY3UWt1?=
 =?utf-8?B?ZE9ERDFNcEN6WHhiODJHN2ZaWTVXWlVPR0ZuMnhIeXBpOXROZzVCQ2lNREJI?=
 =?utf-8?B?emFHaHA3Q3B3RFVEaDQ1QkVJUjM1ZmpPYjByMlcyRnJRNUVNaWQyQUE0T3BP?=
 =?utf-8?B?VXpMWmpZV0lOZVI1RmlJUGJacm5US3BjdXVBK0FmUHFJdFpWVlI0YWxibk81?=
 =?utf-8?B?MXJrUTRRbWdpU1JGVFJQZDFJdFV6dDJFc0UwaS8zQTRwb0h6UjQremVSMXF0?=
 =?utf-8?B?YlhPMytZdUFGblRiN2ZJeG1UZjZvVDNTZStNeWF0cmllZjd4NDA5OGczUllF?=
 =?utf-8?B?T0o3NTRzN1RPeVNQZmFZaVZtUkZ0bkliSG9wK0o5REJBTTY3M1VNbjZyMnJ2?=
 =?utf-8?B?dzhPYVg3dklvYU1pd2d1ZHVYeklDSy9TdzhiOVhLMjE5aGUrSkVwb081Ym1I?=
 =?utf-8?B?cHdDeEpObDF3N3NFVklzT2Z6WjNsellJVWlXc3hXU2pSTm1HMWlLUG1DME4y?=
 =?utf-8?B?SGs4bXdGOURLbDdPUitBSlNTeW5lYVV0bVdpY1JzdXFhdWlMUHEzdVB2SVF2?=
 =?utf-8?B?N25vREk5bis3N2ZuZkNsR3FVL1Jkam85VHgra08xRmVra05iUE1FT0R6alJ1?=
 =?utf-8?B?OGVFakhNbEFQcEF6aU1GRFlFSmF6MFV3eFR5ZXAvaitNbnpjSSthTkJJdU9E?=
 =?utf-8?B?cXZGUUF6ODAxWDdsNFJWRS9SSExZVVVqRERIbDFuR1hEQ1Y0RVlXTWNwUDRS?=
 =?utf-8?B?TU5MS2ZVQVByWWVwcEZtWjJ4dG1mbXl2OXVZaEFxWDBMQk5rMkVjR2p1b1gx?=
 =?utf-8?B?dFFEQk5ZMUw0eWVST1FYVkp5S2FZdHJ5L29HOHNQQ1hJSWVZTDBvcVoyc25Q?=
 =?utf-8?B?VHFyYTdjaWZmZ0NCWjZLdFZHbUZqR1lBM0VHbmt0akpYNXN4WnNVbzFUdE9I?=
 =?utf-8?B?NDREdEp1SnV1MENaOW1EbjZ1T0d4N0prZVNjMExKdVV6TXJRRjRMamFjY2lW?=
 =?utf-8?B?dzk5TStYNlhRUUl5Q2NxQ1dVVGVtbGgxbUh1QmJnd28yZ0VPbEZOUlA2Wmxq?=
 =?utf-8?B?azVTT1lGQzRGOUIxUjhMS0tDUlVSNVpzY0hSUk91VlYxVlp3L2FuL3ZvQ2Jh?=
 =?utf-8?B?MkIvN3djT21BN2VGYUpQZG5BVDVFUUZHWUNNODZQR2hZLzFuYzhwdDNHYXpq?=
 =?utf-8?B?Q0piWkJZUHQ3cnkxYWJFNDI0NEEwQnMvMGVLQ1liRTkxVGZnOVc1L0NFRU5y?=
 =?utf-8?B?M2VaRU1FcXFjeGdGa3Jzb2NBclVQYzFlVjh1eXlkbEp3SVgvQ1IxbFpFMGZj?=
 =?utf-8?B?aFVBKy9YUDJzbVdVK3VEc1BLVTJEUUJFYUkxNnBjLzUrYmdzWmowMVM3NjYv?=
 =?utf-8?B?N3R3L0M4STZXYnpVWE9zVUJzT0hvMUJYSi9nT1kzUmZsRFlNbWs5NldBQmVC?=
 =?utf-8?B?MWxPc0lqTjdlRVg4OWZSZ1ZFQzE3ZEhudHBsNDdQL1RIVVdkSlVYVUpPSk1R?=
 =?utf-8?B?SHViTWcwb0NCUHU2QlZ0S1dVRXpBeFE3V1JMRG94YVdsMnlvRFdBYzNndGo1?=
 =?utf-8?B?WkYwbjhPdzkrKzcvc2d5Rk1vNlpjenRJODhlRGxZZ21mSDAyV3JIekJIZFo2?=
 =?utf-8?B?Vjdsb3QzeU8zN2RFYURuaXJpOUp2Tk1PdXl2STM5YWMvcFU3S1hrbFgxTms1?=
 =?utf-8?B?eUYyK2JUVy9qRk9IdVVPcDZMSko0ZTVSejJCZHlUUnBWU2xBQjd4NnNDOW10?=
 =?utf-8?B?VW1SNloyQjJMSmRac3VEL2VYYk1UZ2xQZXAzc1NuUWxTQnZvNE0yMzBIWTlC?=
 =?utf-8?B?eVRvRncwYitITDJSQ0NVQk0rVGR2OUdlVkwra1dUdHFZa2I3MEhVVmFjWk9o?=
 =?utf-8?B?L1hha0ZCRHYwdTVHTXIyNmRSSU9ocWh6MHROSFRpTHhORHdSS0FIbnU4SHI5?=
 =?utf-8?B?WERwQnozdEVUYTQ5VkRLaVE4VUNqbW5uN0p6T1pBaXhBWGZTdkw5bms0ZWsy?=
 =?utf-8?B?Wkl1OG1ydWpKV0F3THkzRm9iR2dhM2lWcmVoYWtWNm1IOFhIaVVJc0pWRkFy?=
 =?utf-8?Q?mo5TDpYzsSZZYj/IVzcTZQqkD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1d6bf8-96ac-4e77-6f82-08db14df2adb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 14:14:53.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rreTUrkCHJJaPDTUQ4txV5BQ7DCsqz7B7t7wiCcf3oWF4VCQw+pB4PNyQvB93li78c1W/6Xei/9WOZ2kYYZAIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 05:08, Kaiwan N Billimoria wrote:
> Hi Carlos,
> 
> On Tue, Feb 21, 2023 at 11:30 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>>
>> For the list of kernel published books, include publication covering kernel
>> debugging from August, 2022 (ISBN 978-1801075039). Also add foundational
>> book from Robert Love (ISBN 978-1449339531) and remove extra spaces.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   Documentation/process/kernel-docs.rst | 29 ++++++++++++++++++++++-----
>>   1 file changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
>> index 1c6e2ab92f4e..ce461d981d0a 100644
>> --- a/Documentation/process/kernel-docs.rst
>> +++ b/Documentation/process/kernel-docs.rst
>> @@ -75,13 +75,31 @@ On-line docs
>>   Published books
>>   ---------------
>>
>> +    * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
>> +
>> +      :Author: Kaiwan N. Billimoria
>> +      :Publisher: Packt Publishing Ltd
>> +      :Date: August, 2022
>> +      :Pages: 638
>> +      :ISBN: 978-1801075039
>> +      :Notes: Debugging book
>> +
>>       * Title: **Linux Kernel Programming: A Comprehensive Guide to Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
>>
>> -          :Author: Kaiwan N. Billimoria
>> -          :Publisher: Packt Publishing Ltd
>> -          :Date: 2021
>> -          :Pages: 754
>> -          :ISBN: 978-1789953435
>> +      :Author: Kaiwan N. Billimoria
>> +      :Publisher: Packt Publishing Ltd
>> +      :Date: 2021
>> +      :Pages: 754
>> +      :ISBN: 978-1789953435
>> +
>> +    * Title: **Linux System Programming: Talking Directly to the Kernel and C Library**
>> +
>> +      :Author: Robert Love
>> +      :Publisher: O'Reilly Media
>> +      :Date: June, 2013
>> +      :Pages: 456
>> +      :ISBN: 978-1449339531
>> +      :Notes: Foundational book
>>
>>       * Title: **Linux Kernel Development, 3rd Edition**
>>
>> @@ -92,6 +110,7 @@ Published books
>>         :ISBN: 978-0672329463
>>         :Notes: Foundational book
>>
>> +
>>   .. _ldd3_published:
>>
>>       * Title: **Linux Device Drivers, 3rd Edition**
>> --
>> 2.34.1
>>
> 
> Thanks very much.
> 
> A request to incorporate a few minor changes (I applied these small
> changes on the latest linux-next I could find):

Sure, I will send v2 with your changes and signature.

> 
> Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> ---
>   Documentation/process/kernel-docs.rst | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/kernel-docs.rst
> b/Documentation/process/kernel-docs.rst
> index 1c6e2ab92f4e..f7ecc04b509b 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -75,11 +75,20 @@ On-line docs
>   Published books
>   ---------------
> 
> +   * Title: **Linux Kernel Debugging: Leverage proven tools and
> advanced techniques to effectively debug Linux kernels and kernel
> modules**
> +
> +          :Author: Kaiwan N Billimoria
> +          :Publisher: Packt Publishing Ltd
> +          :Date: August, 2022
> +          :Pages: 638
> +          :ISBN: 978-1801075039
> +          :Notes: Debugging book
> +
>       * Title: **Linux Kernel Programming: A Comprehensive Guide to
> Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
> 
> -          :Author: Kaiwan N. Billimoria
> +          :Author: Kaiwan N Billimoria
>             :Publisher: Packt Publishing Ltd
> -          :Date: 2021
> +          :Date: March, 2021
>             :Pages: 754
>             :ISBN: 978-1789953435
> 

Thanks,
Carlos
