Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F26A0A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjBWNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjBWNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:16:06 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6041570A1;
        Thu, 23 Feb 2023 05:15:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FevKyoode8hIwr5ofA8N0S7odp1Cfi1ZZJC+bVyiDWIr3J+0N5SDFKHXB38LZUbN0MG3cWC47ykOR+AvU2uMK9/uDtpu5pGC6aZGMfVDLIJElfuAp5TVytY76Z1erYcivKVXBOBUDmIRwDCTiw8z4lEq3x6HG7sPeEceRQdMT9p7AjByha4WmS2D6meaJMi6sRiEc7I2NxSdvywbR19JDNXeTH6dwOEV8XASZJZyT32RnmxGk2M5vkmTV2qUFfZcNno77ysAAjsj7E3U09R1p/MffkoaX/SkJ8NHrv6JMkow+fCMzrDnZIJLlW5oJZdJnQW1L1a0/TX8kzC8mXlJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYWzur4IshIY+aGD0QnVMrVbfxNszHreGXjz04l9Jwk=;
 b=Alohi5V0NyM5qj4P/hXWFeqQy9uA5BI34C/+q+MaXyB6Siq/lSOUOUVxGN9d9httYMVLqUBkw5EmH9LaUHuj/7MpCqZb1XzjYJAOXs7T5e3ntNjF4rPnYwC8xJRaJo0Pk7txV++g2lH52cUJj60qoJ7REi6onjsSdtbo+MFDY2ZDdmLcCE08FuntXMvRW75ZG03OlGVb3BRU4G05L5wk2scy3b+/1xizbN2lQzxTkKN3zoCZ5iL3EHESoZq8iUntTj6SLYZ95wsrzUEiKamgJ5pN7prTS/5ACxm6v+ooZEIDXY+zvLCfVXfnZJBB1zILkE0xzacASTxAh66tZIFVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYWzur4IshIY+aGD0QnVMrVbfxNszHreGXjz04l9Jwk=;
 b=Nw3Z7gEev1qygw/ZIqJo+6HB84YsmzEo+3T3zwPvdSNxInSK262VbwguKhU3hm9786Pyka69KbCbuGhofb1H78OuR7T37Wijuu6z/6d3DDMN7hJo1rNq1xoIwi5ObNTyYKdimg9RzVE5FrgE693z4Ogs7Gj07Uq28jFAcn8UzA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 13:15:48 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 13:15:48 +0000
Message-ID: <2406f0ea-8e54-3b81-ae09-c459786facb0@amd.com>
Date:   Thu, 23 Feb 2023 07:15:46 -0600
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
 <c5317c66-fea2-37da-26ab-091117880d26@amd.com>
 <CAPDLWs8mXmCXwP=tnKNF+Ffouf+a1HU2FYUgL6Npp+_imWwPjg@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CAPDLWs8mXmCXwP=tnKNF+Ffouf+a1HU2FYUgL6Npp+_imWwPjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:610:57::20) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BN9PR12MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: c9261d14-0ecb-47e7-087a-08db15a01460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lntmjRM+Mpo8WduFBr08olz8pqdCQV+4L9fIyWCYgZ6ZmCX01qEI/hqzk4zfxiZ5eCY0cVglW9X7tW1zkyjGT0mH6lvuj6JTw/owb3VZOgf5AFbHwrYLhQdA8KNss3BLuWxjqyZxw73YklXKYivQhZhjyqqP6Y1l0TZ8V7LMrAdGyOwDEtdio5Uw0ISJQ/cEmfM1r0Fi+9jsoZ8imyuQ0hcmI6uDprgcs8pPPjYwrZKlyRQUx1PcgpNu1eEQ4hzsawqsMZJ4rwmarKrTm02RDZZC2fuW0rdIiF9lg/mAof98vDqbNFl4u8yIObiE68EoCq1hhMJDUcmKtab/eGBkJabYgk8ABkQacFgCSiIF95tQui84o7xXYMoSrjAeIpNymgFfPeUCo5jDj/kB1EV7pAABlcMUuMJyjIuFBJ+VYm+ECqlsvhTOPHv0f/6e7u3JZ8SRcuVkvIwo6Gig1mNRmGFhLEdYvuNJmdkX4trG8RTKKOy3vzQsIk5QYs1MTGxeNHVAe9PsWvbIYwWLuLNsFOmr1qgmbSJ8tUDIWLfKmUNkTSRoCYXsWCCUNlRti15krKVR89Wmnj3z0L7GSoSTYt77AEqDu04/J7nSwCQD5lmjWMSHtx65MBaVr0mzteT4eS8yK5h+8DqMcNsrd7JK5OpI1zRSQgrALN3dGLc8xs9sijtno35pjQCXHXVX4urjoOpAxaRbysEiK+adL18NtcY1fO7kukTH2FzL7KeLHw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199018)(36756003)(44832011)(5660300002)(2906002)(83380400001)(26005)(2616005)(186003)(38100700002)(6916009)(8676002)(66946007)(66556008)(4326008)(66476007)(316002)(8936002)(41300700001)(6512007)(53546011)(6506007)(86362001)(478600001)(31696002)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTk5V0hWZE4zaU5JREM5bHJzV1N1K1BnaW9BbXZwc3ZRVndRVytBM01Hem1H?=
 =?utf-8?B?N2tmcWJjdlFNZnhmMGh4MmVac0lqRGtRUVdnMUh4SEhtK0FxaGRHemJwdmVl?=
 =?utf-8?B?cE11TzRDWHhvRDRpVlVOT3NYMzlSY1BWR3NESTVhMWI1UkJSc2pJRW5YY0Nt?=
 =?utf-8?B?NEVGQ1JvZEVWRlgxbjNOSDRXcC8weTlicmdEaUthekNnRHBOVW9NYkYycm56?=
 =?utf-8?B?d0l2T0VwUVNNNVhUenBLOEFMNHJKMGRjdzdSVnUvc0s0aG1wTkRRb2x6bGd3?=
 =?utf-8?B?R1V3c1hhL3ZzcWcrT3p5OGtwRmxWOGJCd2ZibVJadGg3RWYrMWlVNDZwbTFj?=
 =?utf-8?B?MEVSekZOYVdJemNSUnlHeDF0SFZ4b3Z5eFVjWEdHZUFQT1lmaGViL3B5L1Nj?=
 =?utf-8?B?d2hwT0padU9uOUwzczFzRVVJcEJLVWlBb1VvUjI0dTBBUUZtakREQ2YwU3Av?=
 =?utf-8?B?cldoRm1EK2w5RFlDbU54a1pKQmdKeHdxbW1semRCK09jWlFjQ0s2UWJxMkNZ?=
 =?utf-8?B?MXVlMElaQ0t5dml0ZkdqaHI0Ly85b3lORlBDb0NjZ09zVGRQNjV4cG1kTVRv?=
 =?utf-8?B?T3dsc3B0UFNzaytFeERTS3JNakI3Tkl6dXN1NlFXVHJqRHBqb3NCc01ZekI3?=
 =?utf-8?B?dGZ0MGJZaVYzdHVUQkY2WTdZUFNVSU02VWdtek9oYTNYYWswemVPM1g2TXJw?=
 =?utf-8?B?NXRGNlM4NDVMZ1NsaWRmaGp2WG9pSXpnejJIeHZSUVUxeGd4SFlESmRmVXI3?=
 =?utf-8?B?RmhiQWxCSzhvck9EK0dwMlRpQ3REc3l2MW9laTdtNFNvOXl0N2ZoMlFwam1y?=
 =?utf-8?B?aStRQ1RKZG9zcHozaFNyamRickFsMThXUnJJMUx0Ymh5S2pSbEF6V2s5M3Qz?=
 =?utf-8?B?RFowelcrUkU0ZW9YOWZ0RmN3aE5ZOXZldmtsU3dxY1dSWjUvb1RYNWtoVkpT?=
 =?utf-8?B?Y3JNODZyNmx4MFcxK3IvZll5UDFoNGV1QWx4YitaTUVyeUt0eUNuaUw2a2gy?=
 =?utf-8?B?QlEyL1hEQWRsUlZXZDczanp6QlpsallGSmpkQkM1SVRWVFpBZWR5bHF3MUhr?=
 =?utf-8?B?elAxTVBqOWxTNHV1SjdPTmxpcTVoZDBndHJEM0pMU0ZQV3VybjRQQjFlYWpo?=
 =?utf-8?B?b3g2bVROWnRyenk2WWttajd3emtBN1JDaUY2RGNDOENOKzA1SVB0NVlvTDI3?=
 =?utf-8?B?U3FqQlpYVTdOb2pUbXZRRzBZeWFiN3VscWxyaXFuTng3WjNmdmFpR3gyaldl?=
 =?utf-8?B?K1llQ2ZTdW8zWmZmalYwWUQ0YXFEQU1icFBEaTAwajYzanhlT0o2MVZka2hy?=
 =?utf-8?B?K3RlZ0c5NzlIcXRabEU4Z3FHU25jdVJWTTZnWHAwNW5hdDhvaTRoVnpHbmJV?=
 =?utf-8?B?YVk2MmJta0FZSVN5MmgzUmhrY3krdW5GZkZ5eDRJL2NuTi9ZWUdHSE9TL1M3?=
 =?utf-8?B?SjNDd1NCSHVEQ3laQzM4dldQdkVBeTJScS9Db2t2Q0szckd6UkdzWlgwUnNy?=
 =?utf-8?B?UTJsbTV3WlJ4SmdtUUFFWjVvRm4rV0RtdElVUDhVc21JREJ1NHFHWFJrd2h5?=
 =?utf-8?B?dmduSkh2aTlNRGlxSUJGdVFqeVFmRTR1dlZnTk5lc3ZYOXJMZGM4SVJTSHFz?=
 =?utf-8?B?UnVUZnhmQmtzaU9BK1MvZWpEZzJqRXIyeVBhcjJxeHFiTDBibEppUkdWSlNk?=
 =?utf-8?B?QzBZMTVTOXMvODUrSUpsYXdVbWJrREpYWXhUNzcxMVdPUjBvTGhDL2NnR3lG?=
 =?utf-8?B?bGM4RmN5WVNTcWoxS2dEaGI4N3V2N2R1bGJ1d1BBZDFpOVR3cnd2NzZDZnFr?=
 =?utf-8?B?UXFHREVyb3o5bk9rVGRzQ2Eya1B4ZCtYeFhpZWdNQXdLTzQ0bDhhcWV6U2JR?=
 =?utf-8?B?V2ZlNTQxU3BWL2hVckl5VkVPNEZ6eHU5T1NlVnBYTDVIa3ZoUmh6UGh6dTFL?=
 =?utf-8?B?RXRTaldtUkwyZUNYdFM3c2wyaWJVM1dXZi9Vb0xUTGtka3B2aVZkem1UbVFV?=
 =?utf-8?B?MG5GT1RZMVJ1OWxseDNyZSthc2dLK1pVdVZFVmVnYTVxQVgxTGJGTW1LaDhC?=
 =?utf-8?B?UVFod2JyOGZHcktzQkw1aWxWN0wrN2JNVlNpZXhhU2psM3pvOW5oK3RFeEwy?=
 =?utf-8?Q?NxudY/wCADDzPOPangdXgsm+w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9261d14-0ecb-47e7-087a-08db15a01460
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 13:15:48.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb1NjsR5Hn/ELgiY7Shic4cqZe/ABFuBNUh/n/f0hJDxAVgBK/U0K2Jd+YH8+0IkF8d4ZKF8zSjPE9t76OKFLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 19:12, Kaiwan N Billimoria wrote:
> On Wed, Feb 22, 2023 at 7:44 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>>
>> On 2/22/23 05:08, Kaiwan N Billimoria wrote:
>>> Hi Carlos,
>>>
>>> On Tue, Feb 21, 2023 at 11:30 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>>>>
>>>> For the list of kernel published books, include publication covering kernel
>>>> debugging from August, 2022 (ISBN 978-1801075039). Also add foundational
>>>> book from Robert Love (ISBN 978-1449339531) and remove extra spaces.
>>>>
>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>> ---
>>>>    Documentation/process/kernel-docs.rst | 29 ++++++++++++++++++++++-----
>>>>    1 file changed, 24 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
>>>> index 1c6e2ab92f4e..ce461d981d0a 100644
>>>> --- a/Documentation/process/kernel-docs.rst
>>>> +++ b/Documentation/process/kernel-docs.rst
>>>> @@ -75,13 +75,31 @@ On-line docs
>>>>    Published books
>>>>    ---------------
>>>>
>>>> +    * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
>>>> +
>>>> +      :Author: Kaiwan N. Billimoria
>>>> +      :Publisher: Packt Publishing Ltd
>>>> +      :Date: August, 2022
>>>> +      :Pages: 638
>>>> +      :ISBN: 978-1801075039
>>>> +      :Notes: Debugging book
>>>> +
>>>>        * Title: **Linux Kernel Programming: A Comprehensive Guide to Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
>>>>
>>>> -          :Author: Kaiwan N. Billimoria
>>>> -          :Publisher: Packt Publishing Ltd
>>>> -          :Date: 2021
>>>> -          :Pages: 754
>>>> -          :ISBN: 978-1789953435
>>>> +      :Author: Kaiwan N. Billimoria
>>>> +      :Publisher: Packt Publishing Ltd
>>>> +      :Date: 2021
>>>> +      :Pages: 754
>>>> +      :ISBN: 978-1789953435
>>>> +
>>>> +    * Title: **Linux System Programming: Talking Directly to the Kernel and C Library**
>>>> +
>>>> +      :Author: Robert Love
>>>> +      :Publisher: O'Reilly Media
>>>> +      :Date: June, 2013
>>>> +      :Pages: 456
>>>> +      :ISBN: 978-1449339531
>>>> +      :Notes: Foundational book
>>>>
>>>>        * Title: **Linux Kernel Development, 3rd Edition**
>>>>
>>>> @@ -92,6 +110,7 @@ Published books
>>>>          :ISBN: 978-0672329463
>>>>          :Notes: Foundational book
>>>>
>>>> +
>>>>    .. _ldd3_published:
>>>>
>>>>        * Title: **Linux Device Drivers, 3rd Edition**
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> Thanks very much.
>>>
>>> A request to incorporate a few minor changes (I applied these small
>>> changes on the latest linux-next I could find):
>>
>> Sure, I will send v2 with your changes and signature.
> Thanks again.
> I have no issue though with your SoB, pl do retain it... (sorry for
> the trouble).
> 
> Also, do you think specifying the free download URL for the LKP Part 2
> book's a good idea?

Yes, that sounds like a good idea as long as it is a legal download. If you
share the link with me I will include it in the near future in the
successive patches of this file.


> T&R,
>>
>>>
>>> Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
>>> ---
>>>    Documentation/process/kernel-docs.rst | 13 +++++++++++--
>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/process/kernel-docs.rst
>>> b/Documentation/process/kernel-docs.rst
>>> index 1c6e2ab92f4e..f7ecc04b509b 100644
>>> --- a/Documentation/process/kernel-docs.rst
>>> +++ b/Documentation/process/kernel-docs.rst
>>> @@ -75,11 +75,20 @@ On-line docs
>>>    Published books
>>>    ---------------
>>>
>>> +   * Title: **Linux Kernel Debugging: Leverage proven tools and
>>> advanced techniques to effectively debug Linux kernels and kernel
>>> modules**
>>> +
>>> +          :Author: Kaiwan N Billimoria
>>> +          :Publisher: Packt Publishing Ltd
>>> +          :Date: August, 2022
>>> +          :Pages: 638
>>> +          :ISBN: 978-1801075039
>>> +          :Notes: Debugging book
>>> +
>>>        * Title: **Linux Kernel Programming: A Comprehensive Guide to
>>> Kernel Internals, Writing Kernel Modules, and Kernel Synchronization**
>>>
>>> -          :Author: Kaiwan N. Billimoria
>>> +          :Author: Kaiwan N Billimoria
>>>              :Publisher: Packt Publishing Ltd
>>> -          :Date: 2021
>>> +          :Date: March, 2021
>>>              :Pages: 754
>>>              :ISBN: 978-1789953435
>>>
>>
>> Thanks,
>> Carlos

Thanks,
Carlos
