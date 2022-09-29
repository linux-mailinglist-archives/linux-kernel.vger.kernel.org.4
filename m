Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6635EEF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiI2Hl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiI2HlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:41:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01F0139F63;
        Thu, 29 Sep 2022 00:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryx3yfXvtecTItWLsf2m+SiouZZjgMqWgnekfnO9wGVW7nvC7P3GLk/jeG2Irp6lAppjL0Svox4y114Ilf/Powokiy94v9KdiOsZ2YnE0yxBzhfGeF4WQT1Cb0c8GMM9O+waBr4I9zoqv1y7UUIi1NK81bcWJ4d0USIX0nGVs5z0IH5vLsBhvFHOKYVLx6+rxB+xBa2HwmARYtvlQ5cSI334wKvLrd42oC9r5GsZiaYS/FJGnJlfWg2rYdl2LgADk+SKLB4A9z+Yd8mSf/82yOhS8fewDhBAegH7nv1KpC2y/HmwhyuRLZyUWQaqO/iCQpYjRARGuwV2/e9+EJlK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uutAxfsB8lTZgqcsUKcFWy7Wd5Mg0iAJzh4uOoSrvlg=;
 b=mRHhbI3YDPo+gG41q2LftGenCaQ5RoA9SEab517JaRFvlhUgBWMzJJlqIYUMl3yGhaObku6PO6JY7ChkXACHqM/wZIRpjKS/6UEPM1rPJSphwlP+jqiNfBrkph1H858NGdthRGpU4Z4b+zLT5OZ1KXXgEHtlsW9HdOKzgMMtcwMT9z6W3IuXxArGYxHq00anCYtpX+861SqwKV0qwa5B2gPK3tQ2gblRQulhB9KqCQcVbzUtBicUnuzAuUKZ5PsKmBafdv73Yn3lNOx8/ufEmZa01Lg5x6g438NTgtFwZH+3gb6sZjuEp2ZMhZCpSzbiEURnPyoNyMwBbrJnM2de5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uutAxfsB8lTZgqcsUKcFWy7Wd5Mg0iAJzh4uOoSrvlg=;
 b=gOcqkHV0QOgVjmXF0mrAX8SksnjWuyXVb8AyU7pxF13jQPyvEkkWYswzdBdM5JCSPsmkj4zE9PyVj2TTxbujTujG/kcU+2WgLWPvUKoqQ+P8/17LXShBpgfALX7N9E4OfuEW2vFIlqEgKE8zbuVY+n/VXltciusa52gyLTQJs2thX0p5bLC14hHjK+wWEj6s9ZDbgQuy9zjsOUwvrdCs0Q6MblYc1W9U5UNC/U/pN/xcSflIcjPyM3PRO1rxAGPD328u8BSDoNcSYY5euQhsccoG88cPMPlHVkIQeD56k5FJ8XWHCrxc3c34IBYtK4mDaV+Py3nXvZEBHYgK+/Te+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:133::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Thu, 29 Sep 2022 07:41:02 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 07:41:02 +0000
Message-ID: <d9f3a797-3343-e868-b864-696cb3e7e878@nvidia.com>
Date:   Thu, 29 Sep 2022 08:40:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] usb: gadget: tegra-xudc: Add Tegra234 SOC support
Content-Language: en-US
To:     Wayne Chang <waynec@nvidia.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Sing-Han Chen <singhanc@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220928135502.3458833-1-waynec@nvidia.com>
 <6648ece7-0a8e-2217-0c5a-5d58dd5a012c@nvidia.com>
 <PH0PR12MB55006EF3D20D3A85062FAF85AF579@PH0PR12MB5500.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <PH0PR12MB55006EF3D20D3A85062FAF85AF579@PH0PR12MB5500.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::26) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c867127-533d-4cb7-7d9f-08daa1edf56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgsRrAN6eVVMU6j+td+5uAYXst+Xs5g+F8c5Dt09Oy7Mx8MBCF9xjuVa1uRvwpzeF7Tv1sSiY+MaMyTBuiMs55zIJ5OjGYlyni/sjSIJ7y1RcNk7v/7Wk8FbIe2AIE1Eue03IYExu9raLEtiY3NFeLaXtQkMCxqe28f0mk3eLzTdebhoNOf0PS63SBGnPvypLrOiEt85T8nlHWEAXgUcUsVVoQ3dXA21fgzI6N2xu/LzvBRP4/uHo7NIMf3jdFDqO8fvBBJETYjX6hxeQ+PYyc3oFFxbvByfxU0Gn9c5g/3+3qRZgWub2SadMchBb5Zvn9HqbXSqDjjeGKEqNQIJgS6uYYNvBga667/4uJZroMC2FFpwx29QYqYjuAAmdCzy5OHyc5xTBvLa5sbMELSsQ+AayUI3KCGtNRwMyLVLCgTiMCKDU5WBFsadjNQgRhQHgee2PjfFltjQf5e7qjWrV3xqiQYmY2C3TLMrMyfLt8dqpkW5dLAly+XgT3/rC8OEuIX9Ug7iBACXRCgf7kXfLoo1Vf+tthiTnKI/XLDjp7rZXOMq9DssrfrH0ISeEBqpkov998RwHNHGAAgPuydCqPcRZEVrdFQ0ADlUe9+QnByG65M9FQQpTj2dc48YPBdX0kY/4DbT0/qvKb1UTzyI0+MYTWeh4wWdCcdV4hOPgr5iY2xMxzGGK/qZTuLAdPLPDemp7Z5kwXOmWiApoo3RFQeDO9BNjDyuLTJgcRpeIxOytl8QGe3mQkfP1/v0Tq2eeJNeRFrwn339aAkd4gLVdryHqm0O3sH9F5wx6SRqtzakx4zUT/3di7xRH5EFOp9RObBI0//SVyb69rpKLc6k87WSyv91z4f42f3dvYuM/rnQO79aFmg5lk56uc280jdB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(4326008)(316002)(6486002)(966005)(110136005)(478600001)(66946007)(66476007)(8676002)(66556008)(31686004)(186003)(6512007)(8936002)(6506007)(53546011)(2906002)(2616005)(36756003)(6666004)(41300700001)(38100700002)(54906003)(5660300002)(86362001)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0Q0OEM5VUhEMDVhYmIybjhEM21yVm9OS3k3Y3kzeU85M2Q0M3VFOWVRKytl?=
 =?utf-8?B?azF2dVpYUTYzN2JnaG1zOFEzUVplV0Nocm5yOEdPNFkxTmxtYW1qUkMwYmtN?=
 =?utf-8?B?S1lTeHBzNGZkWUhrcitJOUpqbnFOb252eDJkYlZuOHl3ajFaTmdFek9taW5q?=
 =?utf-8?B?a3dnUUczSVRmTjd3UEdCTGY5aXVjL1YzWU9wY2lkOENyNyswYk5Ea0hwTGJm?=
 =?utf-8?B?NEZjcDhuODJyZ3lpSExtUlJMWEZNM0tZRGhHdFAyZnFKZnVJNDJxbVE4eUlK?=
 =?utf-8?B?S1FrWFBqRmNKc3FKcDlqYzJ1czBpRmFrbkV5VFhJZmVMa0tDYythcUVtMHFB?=
 =?utf-8?B?ajZMTHRjMVFXS1BrOWZ6dU9rZVpkSFBETHRCTGxCa0tVZTRCd2RwR2hENmty?=
 =?utf-8?B?L2hMckhvdDR5SzlZSGc5cmRaTDY2VEFYTHdsTVZZOUNPTUhYMGhtNlQvU2V6?=
 =?utf-8?B?aTVpRjhQeHJqQmV1N3RaSXU3cnMzZWhFQW0yQ3J0ZlFwUVRlTzAzV3R0Ymgw?=
 =?utf-8?B?TEJCYkwzQ2JZbFhGSHduL3llV2dsVEU3ei94OHVNbU9lSjFYTnUyNHYyd1Zn?=
 =?utf-8?B?Nm9sYXA0V1dWNDRkaFVlcWdGeEptY2xBSXlaMHM2ejRlTzkzWjVhWklaYnA4?=
 =?utf-8?B?bEF3NExEbnNYQks5M0EzaDIvdm45NENjaTdUaHAycUxTYnNwMjAreTA2NFM3?=
 =?utf-8?B?NHZaa1JRcW9wdzhXWnNSL2Rwd1BHdWxLN3JqVlArT1J4NUtWT01sNmhDb1lI?=
 =?utf-8?B?RGtsU256TTR5SENjS3JTTm1uNDNxbEhkN2w2ak1Tb1ZIa2JFMnkrNG51enVm?=
 =?utf-8?B?Qy9abGdqdEx6N0hQVXNmSnNQV29sSDgrczNRV2p4K0QweUJ0SUc3VW1kRXZO?=
 =?utf-8?B?Z21lQUxIQUlZT3h4ZzJNUm9WczMwNm9GMjRJdEs2RDNua1JaV1dJTUp4alVY?=
 =?utf-8?B?M0ZoWTBYTk1WNThaR21SSjgxRUc4anlaZWxvQzBrUHlmZmhGa04zaDJMcEVI?=
 =?utf-8?B?dmg1RTE2VGllRHdhUy8zRUxWQ0tKU3lzc3FiQXZLUnhtQzVRL3IvU1hoalNW?=
 =?utf-8?B?ajcrZEt2Sll4N2c1dEg0WXh2c3AwSnlRYzQzd1JyMkU3bGVNTlRtNTg4SkJZ?=
 =?utf-8?B?bFc0ZHlVdjJSdWlWTGpXS1hBMVlHMjVrM01JZ0JpRytNQUZPS0xSaUZrS3Ez?=
 =?utf-8?B?YnpYbEpqZzQ4M0lrUStNZlF0dmpGRGxaK2hVMGpCWjkvR2tzVVpJZm44NU0x?=
 =?utf-8?B?UnRPMGQ5Y1Bzc3RTT2JCQ3h2RXN5REh0ZG93NVJrTTRwQXg3VS9HUDVpT1Ex?=
 =?utf-8?B?QmF4blRoYnU5Zmx0U0VTVm1wZ3Z3V3ZYL0FMYk54MVdEQ2hJVWhiSEJzcGFP?=
 =?utf-8?B?UDFTWGRYbVdtUFAvcDFpZHBUY1dUd2tFeTNiSWE5dHd5ekNQUXZuUlpoM2l0?=
 =?utf-8?B?NHJ2S2twcEZJVDFFR3BFSHBjbkNJSSsxZmVWemVudzNVbWR4OTRrRUVxWVQz?=
 =?utf-8?B?MjdEaHdBTDIrUHpPREtab3AyZXlHYlRENXJwRHo0R1dwZEJYNWlTTUNuZGxj?=
 =?utf-8?B?bnhDeDNrWDlXdG9GekRsQjlOMGxVRWlMLyttZVB1VG4waUNXMXRPcWd6R21I?=
 =?utf-8?B?MWJMZTlCQXZPNk9WQW9UeHRHbVNxcU5LNXNVOE4yNG9ObHFLa1pGT2dwVnRE?=
 =?utf-8?B?OWs1eGdLdTBMVGZhK2QxTXZBQ1QyeGQ1UE1xRm9qQkl6M3ViZHozdFhYYm12?=
 =?utf-8?B?NG9ZRmhLRWRXZmwrZUcydDJYY1pSYnZiaU1KZVg3aGMzMWFzWDlkN0RzMzRz?=
 =?utf-8?B?d1hEMG8wc1VwdTFtdXNsSE1DTkxwZ0NZQUcrbE9Pc08rVVk0N1RCRjFDbDBy?=
 =?utf-8?B?Y1RNRDZHZTl6Nkd4dGVoaEljdFR1czhLdXJDYS9VNzZmazhSbEMzUkloY1lz?=
 =?utf-8?B?RWtqek9CcUMrNnJUVS8zbHhUaEE1RUprOXFNTFZnYVJZN2xOZGQ2YWxKK0xU?=
 =?utf-8?B?NUdGNnQ3Q3o3dzZaVVF0V3cwRFRQaTlRUnJVWWZRS3FlaHBiWTlHK2doSEFm?=
 =?utf-8?B?WEg0U3JxemlVYzBwVm9UYzhWUG8vU3BUcTc4R0tmak03MGFzTGFwMk5GSnY1?=
 =?utf-8?B?K3dPSVFvVktrNXdTSGRncW53Vm1IVDB1Vk02NXhrTkxiRlBtSVNLSDdjaHlQ?=
 =?utf-8?Q?hTsvhQkt/1k5roxEhaWIJX8xVbJ6y8ZKC/QOD3pmEfyS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c867127-533d-4cb7-7d9f-08daa1edf56f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 07:41:02.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wssn1HhEEXRSqYgpodnuTeHwD0sjDAi1FTPapo8njMJxKjn60GPMD3I1RDHT20nIPI9uE4/0noJ/FrX16DJXng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/09/2022 04:46, Wayne Chang wrote:
> Hi Jonathan,
> 
> Thanks for the review.
> 
> On 9/29/22 03:04, Jonathan Hunter wrote:
>>
>> On 28/09/2022 14:55, Wayne Chang wrote:
>>> From: Sing-Han Chen <singhanc@nvidia.com>
>>>
>>> This commit adds XUSB device mode controller support on Tegra234 SoC.
>>> Tegra234 XUDC is very similar to the existing Tegra194 XUDC.
>>>
>>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
>>> Signed-off-by: Wayne Chang <waynec@nvidia.com>
>>> ---
>>>     drivers/usb/gadget/udc/tegra-xudc.c | 17 +++++++++++++++++
>>>     1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
>>> index 3c37effdfa64..53277aa5a270 100644
>>> --- a/drivers/usb/gadget/udc/tegra-xudc.c
>>> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
>>> @@ -3656,6 +3656,19 @@ static struct tegra_xudc_soc tegra194_xudc_soc_data = {
>>>     	.has_ipfs = false,
>>>     };
>>>     
>>> +static struct tegra_xudc_soc tegra234_xudc_soc_data = {
>>> +	.clock_names = tegra186_xudc_clock_names,
>>> +	.num_clks = ARRAY_SIZE(tegra186_xudc_clock_names),
>>> +	.num_phys = 4,
>>> +	.u1_enable = true,
>>> +	.u2_enable = true,
>>> +	.lpm_enable = true,
>>> +	.invalid_seq_num = false,
>>> +	.pls_quirk = false,
>>> +	.port_reset_quirk = false,
>>> +	.has_ipfs = false,
>>> +};
>>> +
>>>     static const struct of_device_id tegra_xudc_of_match[] = {
>>>     	{
>>>     		.compatible = "nvidia,tegra210-xudc",
>>> @@ -3669,6 +3682,10 @@ static const struct of_device_id tegra_xudc_of_match[] = {
>>>     		.compatible = "nvidia,tegra194-xudc",
>>>     		.data = &tegra194_xudc_soc_data
>>>     	},
>>> +	{
>>> +		.compatible = "nvidia,tegra234-xudc",
>>> +		.data = &tegra234_xudc_soc_data
>>> +	},
>>
>>
>> The device-tree binding documentation is missing for this compatible
>> string. Please send a patch to add this compatible string to the
>> appropriate binding doc.
> Thanks. Sent out the change to add the compatible string to xudc binding
> doc.
> 
> https://lore.kernel.org/all/20220929034221.3817058-1-waynec@nvidia.com/T/#u

OK. Always best to send out these patches in a series together. I see 
Krzysztof asking for the driver and DTS change. Given that we are 
already at v6.0-rc7 this will not make v6.1, and so good to put all the 
patches together in a series and resend.

Thanks
Jon

-- 
nvpublic
