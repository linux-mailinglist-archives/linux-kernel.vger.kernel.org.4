Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0E657175
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiL1An7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiL1An4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:43:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58030DF6B;
        Tue, 27 Dec 2022 16:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJZXJ49/1df7d6X/MQZ9AHKE/9p0Sp3lX8V+ka0sZhwtpDzMkQJjFPiLEhwhpdwHwHCUNXdK0TqgLNVGSm0jaXFAMJ4oLNmcUlVW8XAn/FGUZmkbtpQGXzPEfoYXQmKL74vzPxRA1Yprsgcc5JJ2JTK1/ZlP4YPH9VOJAdjyYnVKAvGhUhbtrZCPeb1IzIj3+pTkmJApzCyl8TwhCbjvrFKtzRZDxEcB7g/hopMifPrhRhGxWNOe7BORKOgPpOGRfQad7tFuktedTBkS5lQpRDN/lgwO1OQa9Zy3NrYUSxt5enGaQzuGkD8u5FNXqNwmkUO+4JFpZ+KyFN4IBOCYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rT+rgQ5vfWVaCy6f6i9n6m9hI2ftZ+9nQiIfH2idIw=;
 b=CKRySxLZX6jZn3YwKvKzAWxITMeQrCoLxwT6uIcoFGqYHRKvmcMoLQrRXTLvFsIGXWNtOEv2gc21W7tjzH+auxCxswjEqpPcRRA1eyh2lWPjg/89c3+ujPORK9RqOTBBR5va6dBN/Y/YijPU+QUkVb/XdGTSo6lNNe4MGA3ssbzE6kjC5h6EwfNhgvMaWf5Ay21NOUtBtdn5/DrPJlfSLK9TfX7I6rxLfDQ++66TryAG1bEBVCBjnR2ybx6JK+ZulKFeOfY7++QHHZLFXPTPNjF5NspItUVaBOgffmyIcUjJSrO6d2+x20Np/BkZ0D7wUr8TNKPzk8QdisnGCSxgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rT+rgQ5vfWVaCy6f6i9n6m9hI2ftZ+9nQiIfH2idIw=;
 b=E8GmlFBzp0ddxo3NURFLjF14m2dVzIX32lefdZOp/MG9YGOcGObErfm2Z3o8csGPZb8PmygDFsS2PxrOgw2ziRp8vWu1Y9KWxKnyF+K+ozqr12tjswwyrnqIgcv0uikhNzF8bmjcx/qQ78eyncoA7+l2vwdfuvNGrWkvJEGapfl7ZIiLT7tHhKWat8V/DSbtKCmyZGHBxbltmZPDjhg/WRJe+LRErrRUAICuVRNLJSrRKdypbUSgi0tx5yyg87+tWFt4gr81cumOvK2r8mmaqopVsegUlLYNjryxz/g1pR3xrAT2s77EhAtt0Tz2yXIRbSR8kBaaPif8CGPg4OCVog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 00:43:52 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::72da:3d0c:a811:be88]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::72da:3d0c:a811:be88%9]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 00:43:52 +0000
Message-ID: <2cc8378a-3f74-d4b5-613d-f9112806ec92@nvidia.com>
Date:   Tue, 27 Dec 2022 16:43:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/7] hte: Add Tegra234 provider
From:   Dipen Patel <dipenp@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-3-dipenp@nvidia.com> <Y25x9gc4tpF1f022@orome>
 <1a186be2-498a-a63b-a383-c165a9f8e732@nvidia.com>
Content-Language: en-US
X-Nvconfidentiality: public
In-Reply-To: <1a186be2-498a-a63b-a383-c165a9f8e732@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|BL0PR12MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2c8a38-5335-4e26-dc50-08dae86c9753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H99hE9Zx7L+z7F5MjTBK3s4pIqHJCrFTmLlYtm1/CaphU+ruO5gWRfSfsqb3bfqaIJc8jTDNhnP639k2DSlTZkbqdWlAN+WWjVQ6tHPUhiNajSs+YpTnch0wKw1vOfvEps3g4MeTdVBCKCe4d6vJVuj+KLjxRKklCvCAi7H/1jjMXu5H8CtlGn3x5+COAMFdeobxN7FLXJJpi5F3fXTBxjvrGferGa+cFiiwEG3tBswWvaJWht7UAdTKHKWGF9YaZQ8YSgXOkg7g9rOAmGdZfic3sJHnGNjtz2Kml68P6cLAn0XxUSbBK7UU+0fc8ozb0A0mDBtbHHUPPIHAW35uuqyPj+AHM77fd9svvJxeuHqVUfVjQFenOjR7fDoFoSaj6KIgufs/bovVuB4Knhp2fQXXKeGxEr2jo4fwQwTDywSu9i6Jq8vo1WOL7c7AU7Lpw8wKRuC7thSZqv1fCYcDP1HflFacZTMgA4q3FSZ0I0+Cjw/RaEezo2gnPu3finDQrQNrUw4LKQOvEABiM8Mtsigb6+VUzGRGfrhyCK3ttegXQQ/sWQ2vpCwOrhMsdM+ysi2zUmaB/IjuOi8H2TS09XZnAWg+61cs5jiDkO0uY+N9iG1kluuR6AEAARXiMTw9GIvZKiiSE2vLkFbPJXLd9HGVjXH66Zi+ImJ2nrm9iIIKXoydL96DL7RAqHlixmA8ovk63NN5Kk71DSgc/eBOQtnmtC/Ar+6kMPsju95iq4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(38100700002)(83380400001)(31696002)(86362001)(4326008)(8676002)(66946007)(66556008)(41300700001)(316002)(66476007)(6916009)(2906002)(5660300002)(8936002)(186003)(2616005)(6512007)(26005)(478600001)(6486002)(53546011)(6666004)(6506007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0lOcGpCdW9SM3JaaFZqUENkd2FqdjkyRVVDN0pyUWJaRzFJN2pqR3ZZdEYv?=
 =?utf-8?B?N0VSNnFtUnBRQmNPYlhPcTNXQ1lVTkpOdkVlNnF2eHIvT0NHenBkakxHdlpD?=
 =?utf-8?B?Vmt0ejF4L2F3a0NzTFVBWmYrY1pTVFNEaTlSYlhSQ1FodytJNlZtTjZjMURy?=
 =?utf-8?B?aVNUbG9RUmRkL3VXaVo1UHRsVjZCaWxORDQ3dld3RHI0SmUrcFhmR3ArWWZR?=
 =?utf-8?B?MVdCRGxrVm8wQndZK2FIaXUrdWhMbVAxczI1c05xQnIwY1NtVmpxWlZKdDA4?=
 =?utf-8?B?S1h5ZERxNDhtVytjVkxhUkd6QVNZV0VrY3NlVnRRdDkwRTZzaSsvbzQ0NHYw?=
 =?utf-8?B?aUJObWRkY2Z1bDVxQks3UW5nRjMrWWgwNmhQdGgyVFZibkdIRlRFTkFBdzVW?=
 =?utf-8?B?aElGcEpVZlc5N2hmOTBFZUZPc25LblM3SVZNVHlINm0vdU1KL015YkNHZk83?=
 =?utf-8?B?MnNZc2Z3MEFMVU93amZianluTkRFcENtd2t2Zm1HU3JibWhCaTZFTWxENTNZ?=
 =?utf-8?B?azNtcUlpWUh6V0MyWEQyWlpVV1VQYzBUZk5SQWpLOWk5RTNDUlRyUEJjcW5Y?=
 =?utf-8?B?eW9HWk5YZGpYT2hmeDdCNjdWM1Y0eHdWWkIxT01yUXhDZDY5WU1OMFJkWFNx?=
 =?utf-8?B?dVRIS1ZFNFJlbzF0WElpT0ZUeElpU0dPNDQyV3VUamgrWnY5UkNjZUgwV2Fi?=
 =?utf-8?B?VE94eEIxbGR3dnI5cnBreWdOZW9WUlJ0aDlUZ1dzSW9KN2dXNERWZ3V4dHRQ?=
 =?utf-8?B?TVh6R012Mzc0MFQvVnFmUFMvOXhrNndPWXlxQnNXZ1p0TndIT1JNN0NtS2tu?=
 =?utf-8?B?VFpwRGpPQnY0cjNnSnNSNGFhU2hGODQyd0taY2VaY3phbHB2ODZIZjZLSVhV?=
 =?utf-8?B?YzZ3amlFb3czYmc3QTlyUUdXWndQSkhxZWhSY3ZXN2kyNW1Obkw2YnhDQ2FT?=
 =?utf-8?B?Skx6bDFHcGlRRTF3MDNpZTUzaDIrOVlaaVV6K3NibEpXYUVGWDBqSXVac3k2?=
 =?utf-8?B?a0dwZDZWbFU1VDNFSGJaWjN2a0VWVXhXQ1ppdlhUUFFVTW9aVFp5c21sVnZB?=
 =?utf-8?B?cGlsMDlQY1F4YTVyZUI5Qm9OWUZsZkJvMHFVa1JJL01MWnp2TUVTb2ZoQWZl?=
 =?utf-8?B?OTM1eHptZENiblJTdnFUdWxNek55K3RJNWtEZzF3SmptV0lYVTNoMVUrNTFq?=
 =?utf-8?B?TVp4MS9TRDVmLzRTTGdJUmFxUTk3U1BseDdGNnc3aENNT2NEdjBUT2loN3Rp?=
 =?utf-8?B?bjRuQmRFWlZMUHpYTjVPaS9ENlZ1RFFBYVROSEJGVk1hZlNiekE2cURzK3Rj?=
 =?utf-8?B?QlJuN0lXQTJ0YXpRVEEzWDhNdzlEa1ZkaEJjcmZzNUpmYS9UbGhTcFFWcllh?=
 =?utf-8?B?YVdQQUovV08wWmtCQjdmY3NIT1hWdStwcURuOFcyY24xMXhLd080SHRwZVd4?=
 =?utf-8?B?N2t6MXJJZmdiU2lUTjVRVkI4NzRreXI1aUx0UTFuQXFoOGJJb0dvUHVvZXVK?=
 =?utf-8?B?M3RGUTR0WW00S2h0bCswdkRuemVlSmdqZUpMM2NnUzlLYSs1UWFqbVpVQzQx?=
 =?utf-8?B?K21ObkVIZFdxZUlzMDNrWDV3Rm1HTk1Ydi91amN2bXdyM1pxdk41ZUlCb2lM?=
 =?utf-8?B?amNsMWNiWnN3SUkrcHhPT3pYVEdnYUhmRnFyc0xPWUpxMTgwY04xb1lNaFpi?=
 =?utf-8?B?MERidzdXSWdJblJ4RFJFd1M2L2RiTFRFWjZLemNVYmdsanhDekhuTEhKZXF5?=
 =?utf-8?B?bE9XZkFLRFpXQmppOGlad25NQzZaSVhmSndkbUF1VkZEWGo5NFlOekNpWC9K?=
 =?utf-8?B?TGR2SFdwdmViRGM3Y0xLZGtaNFFMSFV3WlptUGtCUGJlMVdLSlNlTWNNWDhF?=
 =?utf-8?B?Z0lRVmpaenJaajlnOFB1NXU0Mjk5Z1l0TldLUG45UVREdjRpSG1ic0lwS3BQ?=
 =?utf-8?B?bmlIUUdUc1A0S3NWOFBaV2U2ZytYNDRwRDU4eUF3bkttT1I0c2hYNUZlRitt?=
 =?utf-8?B?djhESmNkcWFjVmJYdVBnRXh5c2t3NXg1WS9zNFBrUTk1dmIzL1BsaGc0NGJn?=
 =?utf-8?B?WS9KRUlUbEE5WHRzNHhNWTF4ZExmblVVNjBDc2lTa1Q5TmNRWGdtNDJVTG1K?=
 =?utf-8?Q?9IS+nkttzjIr2vZ9+bD9rJKq0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2c8a38-5335-4e26-dc50-08dae86c9753
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 00:43:52.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW0oIIS8I5icDfqPXJVZPhfCiqxcr0owp4sym/S+VG7ggkZ4p9QMOpYTX3WGbO45VkehZiQfPBwcgXy37oR4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 7:00 PM, Dipen Patel wrote:
> On 11/11/22 8:01 AM, Thierry Reding wrote:
>> On Thu, Nov 03, 2022 at 10:45:18AM -0700, Dipen Patel wrote:
>>> The Tegra234 AON GPIO instance and LIC IRQ support HTE. For the GPIO
>>> HTE support, it requires to add mapping between GPIO and HTE framework.
>>>
>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>>> ---
>>>  drivers/hte/hte-tegra194-test.c |   2 +-
>>>  drivers/hte/hte-tegra194.c      | 124 ++++++++++++++++++++++++++++++--
>>>  2 files changed, 121 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
>>> index 5d776a185bd6..d79c28a80517 100644
>>> --- a/drivers/hte/hte-tegra194-test.c
>>> +++ b/drivers/hte/hte-tegra194-test.c
>>> @@ -16,7 +16,7 @@
>>>  #include <linux/hte.h>
>>>  
<snip>
>>>  MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
>>> @@ -635,8 +742,17 @@ static int tegra_hte_probe(struct platform_device *pdev)
>>>  
>>>  		gc->match_from_linedata = tegra_hte_match_from_linedata;
>>>  
>>> -		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>> -					   tegra_get_gpiochip_from_name);
>>> +		if (of_device_is_compatible(dev->of_node,
>>> +					    "nvidia,tegra194-gte-aon"))
>>> +			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>> +						tegra_get_gpiochip_from_name);
>>> +		else if (of_device_is_compatible(dev->of_node,
>>> +						 "nvidia,tegra234-gte-aon"))
>>> +			hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>>> +						tegra_get_gpiochip_from_name);
>>> +		else
>>> +			return -ENODEV;
>>
>> I'm wondering: instead of doing this cumbersome lookup, perhaps it would
>> be easier to create a direct link to the right GPIO controller with a
>> phandle?
> Possible, need to see if gpiod framework has API exposed to get the gpiochip from
> the phandle.

Thierry, I can not find any API which can help retrieve gpio_chip from the GPIO controller
phandle. I need gpio_chip->base to map GPIO line to GTE mapping.

>>
>> Thierry
> 

