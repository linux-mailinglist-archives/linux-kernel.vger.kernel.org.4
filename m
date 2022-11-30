Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9DB63CDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiK3Dep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3Den (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:34:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01565E75;
        Tue, 29 Nov 2022 19:34:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXfCzLS9fiKpTjD3b5cBSafE9Yiz7D+/9ZbcW3yqellZPus+xQeQjPlG9W+Wfqae0/v6OVInk+WtrPMyke5lu1gOXcURTWGvvC3J8kDVebsf1Th9TS/d1+OMD23wjLVrius0dprVkD27JBFb3VAiCViybkQjWfz4+j75qxN/8enUkLdDUbRij+FMEaQRbTdvaJ863iO9YpP/R/PXhC5lPdHbN7/Hjk4n6Yw4nZ3vl/3Tkyaqr3XJmnqGoBjS1dYKclXJBZhE/WYDXXJzpb4ShMv8/3Ech0hmc72aYYJP/ApR16Q6tXEwXcUCoQZm59RFce/m7Zp1ePl8HR/oJ3l8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyRgP0HoF2QXuGR5aYpnpMmSFjwqsM7Gqc9MgphN6QU=;
 b=RN5TW8f57NEfTR/9QIGwmPdM537+Nkbyxujv7/DmCHKsmpaMgxixN4h5ACKIfaD/oEXQTZ7oG5F1KVGYbjEmKv5QaQ5RBeYaS/5M+Vrz3beDx+jUhf8AS2Ji8vZAtTP71kCGz5m3Xkei9lW+Mwj6K1LuORmQW+gqA9dYDL35sScLIFMFrshBp68+LGFzNLn1/045WeWcug6y9DEZHQnHxSoJzPPA+6nR9S4pbPiV0CkmIhgV/Kf34CID6j98rpT19PPY9wSNaFBzZHSqIhTPH3fDCLlvTQo/yLJdMpVaWjv/MX2VxfY79CykwLGE1I3pp3SKMmOLEZhV5NKoXP+sSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyRgP0HoF2QXuGR5aYpnpMmSFjwqsM7Gqc9MgphN6QU=;
 b=j+jwi2Ky384ZqalNzq1a4SfK4iovXWREiMGAwlX4BwGWYO1geMdSKk9vWkpluo9msKUVOAAEHT7iRavUNiGMBAjNQcCApHl6X9ncN6YcnYJno0DLXvfbVWPY10hm+vNaLvndsEBrMKq6NjyKy4KOuE8S6DGEVmwkFkzIVtWZYOCnMgD6x72RPcb46AJhi1PvFtZprxOqQH0NljgikyaJ+HTjho2egH2eBqukXTnFVUnNeKsMLyxQlsLTtPLI3XnpdtMIDkMsHhoQF3MHdOvQj2hkMrXovNHk17f8VmJY6cS/LzbuoynVCZSgnhKTz/SxFctQYE6t810J9u22I+MPSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 03:34:39 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 03:34:33 +0000
Message-ID: <5145d9d3-d3ae-e95a-6583-803f31d6d9b7@nvidia.com>
Date:   Tue, 29 Nov 2022 19:34:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 5/7] hte: Re-phrase tegra API document
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-6-dipenp@nvidia.com> <Y2XZj4j/NQH2igvJ@debian.me>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <Y2XZj4j/NQH2igvJ@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3cc439-73ad-4aec-a6c9-08dad283cc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U550BkoAEdML41U2wiN0uP3ar/BrNpBLlcRKc+a+tCnRQRFN5nB4DdmjIiUfSuA55OfI1bIxk+Hsru7el7Oy9atPFhcTblwB/sE41bcaG8htaZb900QnyO+4N8Fln5ByeyShU/IZEi1qhqrN1r29pM/PQZ6aSw+uMCHK1KSMt+gB4X5BxVtujGkWvCYF7FB6XShIYed9VgOjR2XoVTsxvN9Iy9mq37C0L50LmVhSbg/iUeCHOZBg7aZP6vJbVxl7gHD5QTAtmA/urSgTvuVOY/3/p5bWM4bmbElYga05nHeuOnJ5vqRSQgRlx+SJq5hXW1P1k3PBHfQjMJC8VLS1D+Nvv9JI32VCm0s3q9PfPJ4Li6ThSxXBuilE6Id8u97WUJ87Vw+bjV0rtIRRzftwsqZBi78WD6conn3EyKrK1fccjfmYIZXteQiKRlXaHOOKtXXDP7KfnL9fBZK3O5/LTqgKVIzm1UAYqw/GGh9zrGJq4dqfITPySgvuxsDJXP3i+Th5SLzld74UQMVPymuu+MAs3jRqqfIBbpXSnryp/glxmnKF6x0Z/iT8lt+UjhfMr2XsWwrDLgaabxm+I9JW9gTL5+rpm8Pc+35XdLVsK1XC3Qs6pOZc5mwFKE8nuwUZy0y3RQSS9DQ+ZYLAF/Qb17cABXvh8D7l/AN5tVXj/Q15d01dCdV4kHWnT9ns62lLhnUnNCo/dgwCjiTv/l7uMtNTB9CfinFM/091HHMF24E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(66556008)(6486002)(53546011)(36756003)(26005)(6506007)(6666004)(6512007)(38100700002)(8676002)(41300700001)(66946007)(478600001)(66476007)(86362001)(31696002)(4326008)(316002)(6916009)(7416002)(5660300002)(8936002)(186003)(2616005)(31686004)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXlyQStoS2tPNGdXanFPVXJpY09JTk91cHFYQVcyOUpZS3NNcTkwK25sUFFZ?=
 =?utf-8?B?RjJRZ3RsSm81L09zVW8vZnNudUQvY3J0L0xEUTJJUkRkdEE3VVNnUkFHQmla?=
 =?utf-8?B?Y1k1TWc2UnlLWjlRVFRzWXRTSFhvRFpETlFlamlFNUpoZDBvSGpaT2loMU9u?=
 =?utf-8?B?NUhZblZWUytKaFQxemIxaW9sc2NmREhrbHdVMWNYT3BKeTgvYWlHY2crcy9G?=
 =?utf-8?B?MDZjYkNzWW9MNGh3ZjVDclZQQkFmdUZEL1RiVDlaWnpkczY3M044NTNOTHFm?=
 =?utf-8?B?dkdNNG1mZTM0WHgyU0RYTGg1M2kyR1QyVDlZdjRhanlBZlNCajNndXZvZVNF?=
 =?utf-8?B?T3Y2VjZEdERIRmh5QnB2MllnL1BrdjhIZHMyV3BENUFOSTlsckREQmNzS09P?=
 =?utf-8?B?RXRNaDR0ZWgvdzFwTVM5TDQ2dXBpWVkrNlBvd21RWE45MU9MNFhqRlFyQzN1?=
 =?utf-8?B?dnhjcW5sZytNemZyY1ZEYnhtUnRYQmxGU1Y2aVlzNWZ5aXJUQjhVSzhOWWk5?=
 =?utf-8?B?Q2pkSjQrZlh0TUtKcUtSdFc3QXh4NkdZbHRsbVRJazVkS3BtY2lnY3NYcGx4?=
 =?utf-8?B?RFgwMGZQMUpJMFEvamZYQzQvaVNxVVBHZjlibmtqYk5TKys0ZGZEZm1NZ0Yx?=
 =?utf-8?B?cThVeFJRM0FEWHJUeTMwVVBtNzl4eTYwY0NyOVdBMXFaRGFzYThveGlrcmtV?=
 =?utf-8?B?UDhvdjFKcHN0NFZ4TStBSjJPVWo1QmVaSGc4L2JRRjNYL2svUDVnTVI0cnRt?=
 =?utf-8?B?c1Zab2NNOVkrWHVhaUwzNmt6NTBUSE5IM09mRURHd2tqQngyUDA2NWRWSTJk?=
 =?utf-8?B?QlIxQklGWlc2Zkw0NEZiWjBtSlpWT3RxYlo3WWFRdUtQL2VTQ2NxbGlHVXNr?=
 =?utf-8?B?R0gwSnhRL2YzSmIvbEkwbklrTHZLbUJjV2FKcGNMbFNNVHdmaVVwcEVIV3pu?=
 =?utf-8?B?SlVWTUZwb1JKbzVDTGRDMWhLdk5McUMycHNoQ1Q4aWVScG9nbSs4WDluaitx?=
 =?utf-8?B?TTk0M1NMVFN3N1o2Mk8vRUZaZVA2bmxEV1JYNVlCcnBXSU1jZ0kxaWhNeXc5?=
 =?utf-8?B?ZVZGWUZNMWlJZ1phOU1BSTBlWm9xekR6UEVqNXhkMXRvazhIb2ROUjM5eFNW?=
 =?utf-8?B?Z1hqdkc2S1Rlcy9nTVhNY2tyM0lBZkdidTJGOVV2SnpXbHlvTkpqVlNLbi90?=
 =?utf-8?B?ZWM2cGRsczBZZldURDhvd1lWYlJ1bU9YdFBYUHBpNGFjRnk2NDdvMzh3dHZk?=
 =?utf-8?B?SElhTy9XOWF3V3VZSzErYkphR2NxQmZkTU01NSt2QVFpWVFMRFdLcUt3MXVI?=
 =?utf-8?B?dk4yWXBJTjRueXlTN1lrOEJXU1g0cFBzRk5uSHFUa2Z2U3J3cHc5Qm03TzJv?=
 =?utf-8?B?VU1VQS9FRGtpbGlVdVF1Q3FVSXZKYU54a0xYdVp6N2h0UUIrTEtJeU9wb0hl?=
 =?utf-8?B?Q3gvcUtvMGxBTFZzdXNPYWkyZFovZGlaQjU0eHkvY044RVI2M09GL0JGeG0x?=
 =?utf-8?B?aVlWQzNKTWNJbGcwL3Fjd3FERmRFSm1iaXBqR0VJUmpjNTN0UXJOclFoU0d3?=
 =?utf-8?B?TkgvMDdCa3BoMnRsRzRQSVl2R3p0MGhsSWkzdU1RclltZDJCOEtXVTUzdkVW?=
 =?utf-8?B?VWhtaGtUb0J5eDlNaklsZjM3WThVYnh1V2UxaU5OYWw0UjFjZjJkN3Z5VnFU?=
 =?utf-8?B?OTJoMkhrY0xRdzk1RS9mbDVlKzVGc3BRSnEvZHBhYUJQU0ZENkd6TVVnQkh1?=
 =?utf-8?B?T3FzRzhvZUYvbEhhTXBOY3JOK0hyQ1ladm9Rc0ZFakRCSC9KaFQrTm5aWGg4?=
 =?utf-8?B?UFpHdmE5L3dmcENoclpwVEFRUmplZE1OZmk2R280VjBIK1ROazVxNG11d1lq?=
 =?utf-8?B?YkltWmlQbklQNUpiZWZIVSttVWpoek1ENDYxYklrb21JLzJMSThyUktkUUpo?=
 =?utf-8?B?L1ZHMUVVU1BXaEJBU1JDeDhyYUVjV0FQSmszd0dhd1M0ZGVoSFlFZkFVSE5u?=
 =?utf-8?B?S3BESzRneG9ISitGd05sK3BPeHZQRjhyQ3cra2hiY3pWN1BHRm5hekZnVVUw?=
 =?utf-8?B?dlMyVFJ1U0JGMTYvbktMM2VpeHhYVkNiNnVuSGI1UXJzK2gyU25qS0VaOXIx?=
 =?utf-8?Q?KHvjo9hmNr8/HpC+gYoMuIslY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3cc439-73ad-4aec-a6c9-08dad283cc4e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 03:34:33.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slFyX1b2XMbJGdhoobxi+1leX5hMHEOFCFKEi3e+aKVTFCU/xuOmTXSlpYJD5oACszAVFwZFmBQHZcqUAndR5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 8:33 PM, Bagas Sanjaya wrote:
> On Thu, Nov 03, 2022 at 10:45:21AM -0700, Dipen Patel wrote:
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
> 
> I think the wording can be better:
I do  not understand, can you please elaborate?
> 
> ---- >8 ----
> 
> diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra194-hte.rst
> index 85e654772782c1..13c45bfc03a75e 100644
> --- a/Documentation/driver-api/hte/tegra194-hte.rst
> +++ b/Documentation/driver-api/hte/tegra194-hte.rst
> @@ -5,11 +5,11 @@ HTE Kernel provider driver
>  
>  Description
>  -----------
> -The Nvidia tegra HTE provider also known as GTE (Generic Timestamping Engine)
> -driver implements two GTE instances: 1) GPIO GTE and 2) LIC
> -(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the timestamp
> -from the system counter TSC which has 31.25MHz clock rate, and the driver
> -converts clock tick rate to nanoseconds before storing it as timestamp value.
> +The Nvidia tegra HTE provider, also known as GTE (Generic Timestamping Engine)
> +driver implements two GTE instances: GPIO GTE and LIC (Legacy Interrupt
> +Controller) IRQ GTE. Both GTE instances get the timestamp from system counter
> +TSC which has 31.25MHz clock rate, and the driver converts clock tick rate to
> +nanoseconds before storing it as timestamp value.
>  
>  GPIO GTE
>  --------
> @@ -19,17 +19,17 @@ needs to be configured as input. Only the always on (AON) GPIO controller
>  instance supports timestamping GPIOs in real time as it is tightly coupled with
>  the GPIO GTE. To support this, GPIOLIB adds two optional APIs as mentioned
>  below. The GPIO GTE code supports both kernel and userspace consumers. The
> -kernel space consumers can directly talk to HTE subsystem while userspace
> -consumers timestamp requests go through GPIOLIB CDEV framework to HTE
> -subsystem. The hte devicetree binding described at
> -``Documentation/devicetree/bindings/timestamp`` provides an example of how a
> -consumer can request an GPIO line.
> +kernel space consumers can directly talk to HTE subsystem while requests from
> +userspace consumers go through GPIOLIB CDEV framework to HTE subsystem. The hte
> +devicetree binding described at ``Documentation/devicetree/bindings/timestamp``
> +provides an example of how a consumer can request an GPIO line.
>  
> -See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
> +To toggle hardware timestamp, use gpiod_enable_hw_timestamp_ns() and
> +gpiod_disable_hw_timestamp_ns().
>  
>  For userspace consumers, GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE flag must be
> -specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c``, which
> -returns the timestamp in nanoseconds.
> +specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c`` for
> +example.
>  
>  LIC (Legacy Interrupt Controller) IRQ GTE
>  -----------------------------------------
> 
> Thanks.
> 

