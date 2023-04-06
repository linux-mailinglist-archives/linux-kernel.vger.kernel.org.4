Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342276D8B6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjDFAFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjDFAFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:05:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF51132;
        Wed,  5 Apr 2023 17:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTOrYyefg8IBMaozPONH1w99S51AR0+0UcmMiULcyvMMZCY/RJgH2yBk2aTdouREF0715Kyl19Y03jQcfQArmvySpnTmfQapVlpvOrHvLoFBG1OHl5xUZmxL6YXhgd/XxjLZMtsnlNyZdPXdBK1GFg7ERmHZK+DX3vO0su98QeMl0iT3rks4r2BWkVM1lTAzUV/46sE2bXvNXJJ3sr1ZszDm2XvNlw/9R6z8yHxrACqjlp91HREuB4XU5Ezyiy9KS9rpWbVbm7Gj9CN9hJQ95d0ozjT3l6Ra7H/oR3e09oDgwXiOF0awDDXAeMv/G6n+4V5p0vw3fYkp6oOv+W9lOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CzskpIuQeyxVoHOiOiu8v+PZ42xvFd8ncVWRZ5es/I=;
 b=X9EyA2eUFq81jknu1QK1HjWocZ5bPnXtbCcT2ob/DrtTjjWdu6uQfqkX9B7xTEVNlaqI5AEYU7OznP4sDlOCll7b1jj/y83TPuwML0ywLd09tXDpkz4Yc8WVNo2ChCw6cDpXwy6hkgeK6h+PM8mcdB2WxX7ikX9PJ8Pme3fX82gbr3S5Y0M4bCqA8Z5T2hE4/3jRIJUigxr821dmraNQKNZbMcTy5CFY8ltdYwInMQ/LK1lVb/1KLZKn2uS7JsMqUDweD5MYUjKGvuB4nlsseCI7tFFiWx0XSs2qpFrE8WAjsyHKy4hCt7LCQs6qyKF71qBs13XmgNHle24gxzEqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CzskpIuQeyxVoHOiOiu8v+PZ42xvFd8ncVWRZ5es/I=;
 b=BdwVkV6bC7i8BIMbTzQnJMyUIS8rvQ9IUIqhmNG6N1DneW2+SxBPYRmg1ZFc5Qd/tz35eqPWeSztdEujhSnugW5zIUYHtEgCshoYLgZht6cyGL6yrxVer+CmSrp5/sODQ69H7aV+b6q55Em3kCUbOqXE8N5qXUmdgoGt0ImGfrxWzsQGwojydjEyVF1NSxZipQ9y9i3vb/UPXKKJbPdf4/Zn/Xd33UPIAztiPt+QBow0KZEmZZD3U2fktSi+Y7h19jo8p7KP4nyzJSgrkacK3QqPWDITnF31nA4uQTdoub6+T7y8QoKc7IYqYmZF7xYUHlbbgnQ6eUx6FRA+b/TzXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 00:03:46 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%4]) with mapi id 15.20.6254.033; Thu, 6 Apr 2023
 00:03:46 +0000
Message-ID: <f0aff7ad-0b9f-c9e0-df27-23b8ec9b011e@nvidia.com>
Date:   Wed, 5 Apr 2023 17:03:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH V4 06/10] hte: Re-phrase tegra API document
To:     Bagas Sanjaya <bagasdotme@gmail.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-7-dipenp@nvidia.com>
 <364610b8-2c40-6a71-513e-4e154b077055@gmail.com>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <364610b8-2c40-6a71-513e-4e154b077055@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a03:505::28) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4f5f6a-6498-402e-48b3-08db36326401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/AX4q4DstHRFnA4uhh9PdkXzzU9/fBJCpP9GcG6/iX+NDZTfjxeI37n3OsolMS4MY4qcMXcCbQ29N9Yf8yjOFvf5eBlXxiJ6nxxPGQm0Xwv8g8+POVDFYOfOq787ncOMAVezfeQ5xuhCXv4mzZ0kIehp45qfv32DqEPL5fkeZ0sF4mn1WHAgltAVw2bZGgqJb5rBGjsfQjRTvtrZRetEnew0hmShRvvXrvQjx+QIQRFf3XwqJ8fxXthLG0HipdC5KPyD5iyfTLiq4VvMCIL96ZpDlQzQd1xUXFaTvjpPLSemOJjPYvayXaFIG0OPqbzQOfchshJMDUWwr86e+tvm80J2G8XVGYOaxR0EqAKoJyKOMNb3vlUJ7z8n/Ylh5tmrZ/DvVtaM0+5h6R2KiHFEBwjE3xIappeUz27yMPiAsEKN4em5b9c83LKRbDv7ejv4VHKOfZ37/USGtLvgmrxNV+EQaKLaD0Xm55KDVt9F4ok002cAngHQUEdfrb7uF6u9HdAHqGs71RyYPiZWRjU1amwI6JgNuNPZh6UG55AmsG/98bcs0FtiuSRAdkN4RAGAPS7gvN+6p3Yv0NCTluRtapSp59Tw6iCBzB67CdovBOJsWJ154J2yE3gWaNC0cFPzbIhqPzz+IQSNYRWm8IibGCC6P7dm2I/fkWcdJ1L0Kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(38100700002)(31696002)(6486002)(921005)(6512007)(2616005)(53546011)(6506007)(26005)(186003)(66476007)(8936002)(7416002)(2906002)(5660300002)(478600001)(36756003)(8676002)(66946007)(41300700001)(66556008)(86362001)(316002)(6666004)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNLZHg1T3ZoUlRBYWxJZldqV3BhVk5KbWJXaHpXN2ZtTW1haEV6YktZZjdP?=
 =?utf-8?B?ekI2RlZjYnlFMGppVVA5aXV0Q2pWWVJoRktvUldxRjQvUEg2V0FONGtFL2lJ?=
 =?utf-8?B?VzhmUGY0NTBCaDJrUWVhbkZpc05jbmk3ZlBiMERVbTREYnROTUtha0FuZk9Y?=
 =?utf-8?B?K0wvUGtrWk1CSk1FaFlrSnZjR2hGRDlqVnIvV0F5MUxLTkk4YmZPRHJkMXBP?=
 =?utf-8?B?NDVzTDJYYVpHZWZVSlUvUVRnRkNFbFJsRWdyN3FqR0dzMU1UKzltd3VXU1RF?=
 =?utf-8?B?dkkwai9OYk5lNGlEZFZUbkFkc2hxaGZBUkxPWW5qSDhJZUZRNHBEcjFhMEpW?=
 =?utf-8?B?SWRuL3VOT1ByRVVBSDJMc1E0TVBjUHRwUjhXdG1wUE5YdU54MmFzUGlFRk4y?=
 =?utf-8?B?RVRvSjlXczdsYnhWMEFidExrWDYrbytWNUxTei9lbHdFemZCc01kMWg4QlJn?=
 =?utf-8?B?a0VFc3Y5K3A5T2Y3cWJUZ05IbExNeGdWMkxHTnRpSFhlZVBQZG1FNG40TTdC?=
 =?utf-8?B?Y3dZY1V4R3A4bnVJSmoybStxTjl3UXNZQXJnSUJKMzBBMUswS1RyRGFOQXEy?=
 =?utf-8?B?T3FEdVhCV1ZZbXZQQ2JTOEJYUGhuVlFNOVRDWkNZbEdWVlZKaTNIbk1wdkx3?=
 =?utf-8?B?TXBuWEhpT2JJSmVBR1I3OXRmcXZ4TlBEMTZrM2RhUmN4Wm1OMkE1MnZYb0do?=
 =?utf-8?B?Z2hiU0xtK3ZteVZpd0lxS3BMUzVLUzh6ZGhoaXRBK0pOQXBDcVV3Z3lGcG5o?=
 =?utf-8?B?L2RZTTVKM09nZHpEOTJrbGpYaGFmTkZwUFBZQUdjQk40WVZYa0N0SUc2dVVI?=
 =?utf-8?B?RVlBSDhVTG9OL0JjcG5HOHR3WWJwVktrT3NwME55YXhhOVBQak9lKyt1MzZ6?=
 =?utf-8?B?Z0M0MktxQm8xd3hjY2ZSNXBPdGtJTERuRWpReWorNGMxdHE2L0c5N044cllw?=
 =?utf-8?B?bzRUSTdkOVc3MlpHaEFoRWRYVEgrNHNKTUw3K2ovczdWK2ovWTVmWGxHYjR0?=
 =?utf-8?B?Q29Bd0VacXk4VlArN21tclg5SEpsTDV3dTNBZjA1c1NVY0NaRVVOTzNWem1o?=
 =?utf-8?B?T20rRXNGc1d2NWFQYVdOWmszYTJuT3I4QjFaMFJzZUxaeWRENFlDYzVQTitx?=
 =?utf-8?B?WXNTTlcrY1dvbG9jV1JYM3FVeTJaTUhkc1FGTWNtcnVoL01WeFhQdkd3VjhE?=
 =?utf-8?B?SzdyM3JVNGx6WDdXQXR5cVdsWUxIcmF1dWFTK1UzMVNjNjE4QnB0cWRUakJO?=
 =?utf-8?B?QzREWFQ0cTE3Zk1rVXZJYk5JbjMxV1BQQnhqamlFOTRDbVMvV3lDcVFaM2Fu?=
 =?utf-8?B?VGQxNnYxbHhsSEJ0NUd2S0dESEM3YmNDaHU4YjlFMzV6d1BJOCtNL3BtMSsy?=
 =?utf-8?B?ZUd1dmEvdnJWUDVMazlnUUVITEZURldORW0vNGw5L2pHdUlxZXk1U0xGclNJ?=
 =?utf-8?B?T2NDV2xDWG5Rd1AxaTE0SjJyMWxscXVla05WWStJOEkvekJvUFJ6MXF1NkZa?=
 =?utf-8?B?TmZTRFAwOVVDTVdBTk9wNUxmc1owMlA1QUlPdkVhNnE3SnowYUdRQS9odDg2?=
 =?utf-8?B?ZzBuMzVKQVRLSVVEaEZ1ZHJDYi91eVU3Wk9zL0wvOUd5U01sK0xiYUw1bVFY?=
 =?utf-8?B?ZUJ2dStRZE5Rbk1xd2pEZkJQK1VCditrM3grZW5EQmd3a0hzRm1vMDlYRUt3?=
 =?utf-8?B?ZmMwRjJOUHpQZWxSWVRGdy9PRDJ5UGNnZjBIQnNKdmlTRWw5MlNKbW5PQkZP?=
 =?utf-8?B?RExKYjZhR3FuWW4xZ1FRaHdwLytTL3ZMSlpDeU16eVd0dDc4U2ZVSnlyRnM4?=
 =?utf-8?B?eWhOU3E2Z3VBdm5Rb1BvVjNpeG1saVA1ZEJxV3R2Z25RcUMxQzVzOXp0a1Yv?=
 =?utf-8?B?bDVxTG9XRitDaEM2MEhHMWFQK1VxaC9xWTBFWVArZ1J5WlNPVExzR1ZtbjF2?=
 =?utf-8?B?Y0xZdlh6cnBjOVEvczVIcEd1WlJRcFFjenB0TEZFWFdMWFBYbkcxSmNFc0Vm?=
 =?utf-8?B?SHhoekduVVI4WlIxNTJ6K2VTMjRQVjB0dDRWaGF6MW04OGlMbWtMLzBlcGxI?=
 =?utf-8?B?RUpySlVDYkhCOXN2RXU3aC8yamd0ZWVRd2paOEwvMXkzTG10UzhiaytWQ0xl?=
 =?utf-8?Q?Mni5yLYDxXkW0sZYdT892v4YX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4f5f6a-6498-402e-48b3-08db36326401
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 00:03:45.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCrBbTYQdCn2jvacuWo8QNjL8uLbQ/7tx8uNvYr0TTd+/6e0PRfat5pprl6AlOREKalPiuVUR1PwC4z4gmhAmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 7:24 PM, Bagas Sanjaya wrote:
> On 3/23/23 08:29, Dipen Patel wrote:
>> Make Tegra194 API document generic to make it applicable for
>> current and future tegra hte providers.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>>  Documentation/driver-api/hte/tegra194-hte.rst | 33 +++++++++----------
>>  1 file changed, 16 insertions(+), 17 deletions(-)
>>
> 
> While generalizing the doc, the doc file name should also be renamed
> (i.e. to tegra-hte.rst).

make sense, I will do rename it in the next patch series.
> 
>> diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra194-hte.rst
>> index f2d617265546..85e654772782 100644
>> --- a/Documentation/driver-api/hte/tegra194-hte.rst
>> +++ b/Documentation/driver-api/hte/tegra194-hte.rst
>> @@ -5,25 +5,25 @@ HTE Kernel provider driver
>>  
>>  Description
>>  -----------
>> -The Nvidia tegra194 HTE provider driver implements two GTE
>> -(Generic Timestamping Engine) instances: 1) GPIO GTE and 2) LIC
>> -(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the
>> -timestamp from the system counter TSC which has 31.25MHz clock rate, and the
>> -driver converts clock tick rate to nanoseconds before storing it as timestamp
>> -value.
>> +The Nvidia tegra HTE provider also known as GTE (Generic Timestamping Engine)
>> +driver implements two GTE instances: 1) GPIO GTE and 2) LIC
>> +(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the timestamp
>> +from the system counter TSC which has 31.25MHz clock rate, and the driver
>> +converts clock tick rate to nanoseconds before storing it as timestamp value.
>>  
>>  GPIO GTE
>>  --------
>>  
>>  This GTE instance timestamps GPIO in real time. For that to happen GPIO
>> -needs to be configured as input. The always on (AON) GPIO controller instance
>> -supports timestamping GPIOs in real time and it has 39 GPIO lines. The GPIO GTE
>> -and AON GPIO controller are tightly coupled as it requires very specific bits
>> -to be set in GPIO config register before GPIO GTE can be used, for that GPIOLIB
>> -adds two optional APIs as below. The GPIO GTE code supports both kernel
>> -and userspace consumers. The kernel space consumers can directly talk to HTE
>> -subsystem while userspace consumers timestamp requests go through GPIOLIB CDEV
>> -framework to HTE subsystem.
>> +needs to be configured as input. Only the always on (AON) GPIO controller
>> +instance supports timestamping GPIOs in real time as it is tightly coupled with
>> +the GPIO GTE. To support this, GPIOLIB adds two optional APIs as mentioned
>> +below. The GPIO GTE code supports both kernel and userspace consumers. The
>> +kernel space consumers can directly talk to HTE subsystem while userspace
>> +consumers timestamp requests go through GPIOLIB CDEV framework to HTE
>> +subsystem. The hte devicetree binding described at
>> +``Documentation/devicetree/bindings/timestamp`` provides an example of how a
>> +consumer can request an GPIO line.
>>  
>>  See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
>>  
>> @@ -34,9 +34,8 @@ returns the timestamp in nanoseconds.
>>  LIC (Legacy Interrupt Controller) IRQ GTE
>>  -----------------------------------------
>>  
>> -This GTE instance timestamps LIC IRQ lines in real time. There are 352 IRQ
>> -lines which this instance can add timestamps to in real time. The hte
>> -devicetree binding described at ``Documentation/devicetree/bindings/timestamp``
>> +This GTE instance timestamps LIC IRQ lines in real time. The hte devicetree
>> +binding described at ``Documentation/devicetree/bindings/timestamp``
>>  provides an example of how a consumer can request an IRQ line. Since it is a
>>  one-to-one mapping with IRQ GTE provider, consumers can simply specify the IRQ
>>  number that they are interested in. There is no userspace consumer support for
> 
> The wording LGTM, thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 

