Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283676B8439
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCMVto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCMVtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:49:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA045BAF;
        Mon, 13 Mar 2023 14:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O25Q/WShW9xKC5RrujI5u32ToQybzbvnEyxT7wXYVLB9yqOccN4+PxKdpygjUNwklpeS3i48fwXZT/c8WotYAbpvqaECuJAk4LQoRk+MY3Rrfjf3XRSbLue9Qd7od7Ji0C1JOJQGorMgsmIKpjn83lAQ1OL1I9sjqMgsRmAiFeCBPnUT2r4ZuVYb68de4FnY55bA/3CuVlO3gp7K7wypEqvB6s1jvd1mrw3vYs54dUPzmw6iToCwokS39ln+rUMOt73tY/BOVuMB4kRVGnsvLWRcS4L8g1mscwEceK4ajoCqzAJVtwJraynk5hYPfSF/lfTRQJAxwlmSX/toZ+FGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XscfZ6ExWVgvdlAbFXqvZ64vDj7o5fvbUh6QeOXLVEE=;
 b=NPDjkG7RuEo0Kc37pd6u4yHTS5Ek4fClVMbjOz6CgMmvVH6+uynIBe4OFqeZK2abhy0OfTxgUfDwVu7aZ6f/g2TD6gRxC74k9LAotAA0OQRTJvDvU0Nz4bzRIUQAMxckf6jha6OCyAfxUp7aXa4XcFkh6ypbEz1/cOMM9OVxZ8R+dPgjnbXm5hJyF4b3q2yc1WCeGq7lXpCLhHtilB0H2DjbstpBdkSF0Sb0Mlk5Qt5m1u1YcFLQi0qyBoN0groU1RLnaaK50XPq93oqnstktKtzppD8BQ20CGymnzUWcjtUiA9t8xbGoypKeUQCq0v3BRxRZssH/zEMeGfsjQglCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XscfZ6ExWVgvdlAbFXqvZ64vDj7o5fvbUh6QeOXLVEE=;
 b=d/isOfUtsf4wzNzkvMKjpddBky/fqjuZ/83vL0Wpzs9CKfmpvrvrjv57b/kMQB5NXqAQcDp3C1DXbSeiXxTohBt2OPWLS+89vMoShsBTVR6rpVed/jLxLIZVdDoN7BoMNKDSLaALxi3OLp0vlYtv0tZO/H0b4EZqtoIA70XJ1zq3ZawKXOysSZeEIrt0NtJjcdwRjgKwp6j1eiS37DpKurAjRoZxix+L95QyBzvs/vJLZCBimOostWGDu9eO5F1reTD3JBmiHBKaLlDXpiwUdeWWKE6K87OzeSlpS+536f7XClT3yvJ3bGJA39AXOs/faZk/O19rmqKjPMB6PVT4Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 21:49:38 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 21:49:38 +0000
Message-ID: <fad52df6-38e8-ba8a-117a-8514e09af0ee@nvidia.com>
Date:   Mon, 13 Mar 2023 14:49:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl, corbet@lwn.net,
        gregkh@linuxfoundation.org
References: <20230310190634.5053-1-dipenp@nvidia.com>
 <20230310190634.5053-3-dipenp@nvidia.com>
 <f6d9c84a-1c75-d9b4-59ed-39d6c5b310a9@linaro.org>
 <b4195142-6cfe-df3c-6edf-0c40b64ad02a@nvidia.com>
 <6c5045d9-4f4a-5018-3f3f-7746b08ab2b5@linaro.org>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <6c5045d9-4f4a-5018-3f3f-7746b08ab2b5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15)
 To IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b567cb7-c8d7-4602-a5b0-08db240cd784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVXG0FUSU24+7qF5bN6T5nWL2vif/GzkHWok3VA86MFs6Wb/a+u1Aij2ZV5JQGbY2J5p8T9U8WiRoZZIuEeARN8cvlsLpjLhZ3AlsOUq36IUzd4eVukrUWMFy2JJrNeu/XPV5LvoHjQcM8jYiW355O7JACv3+XcEF0Jp3mYiyIuOgXdoBY3MkNQUluI8gaJciieXDuPJKldZsvjmIGi4IpCbkDXwSjxc0Rmr5fwAU7rrAT6RuizMzhRF8LpJ0/F8FbQO4rwoNCfLbQc0kbwAcHKi3ypiCBuUK+fSd33U/hGI1DBNmb+ktqEZ66JKuM1kbmTwCTnZ/ZMl9CHOiprFB26swYo7vUVYazs4PYU1Jw3P9ZYkcp1dvjcbt4e/ee5xg6At29VQzczEbparPoHrBZogzhec4nCdlizdpvJJTNV1C6xZ4tlxSecSpRYJy7Z8Q0T5nnjaIkbsM0NRLAM9E+XD/Qr/HN5Z1wH0KQHw/oAGmO2lNHNHLP4JdQdqyfEmv+j1iLF7JuRaLgUc+yY/u41yeIqTYxKnmcgY4AX6rHeGeM1kdzEdUi4HKeI9B+Ou8UXvGRz6Vqp6vG47EiuOqtWWyekLdgqY+Cd3spCamTjnr9/BneyN9p22KVOZnGsfGSarB2hklzngoI482SoGQZXD6+QS8/5EzvmlQp2V/BPwft37jKebgx2gZVUsemtgMcy2YS+jqim3A/8HvC1PGc7N+acep6PJnZu1wSf0U8kKkxEzxHhR1Xmas4lqkkOI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199018)(36756003)(86362001)(31696002)(41300700001)(26005)(6512007)(6506007)(186003)(53546011)(5660300002)(7416002)(2616005)(8936002)(316002)(478600001)(8676002)(66556008)(66476007)(66946007)(6486002)(6666004)(38100700002)(921005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFRQkdOUVVNYkFzbFdWd3cwNEtJaDdnMTV3V0FLM3B5dExVbU51TFRPU1p1?=
 =?utf-8?B?dzhhNktzc043RG51bzRjb3dTb2VYK2hTNU9ZdW8xVUtCY2xSWTlPdUJUTDI2?=
 =?utf-8?B?SUdPQTc1bmpXMFY2Nm9VYlpjVkhvRlNLMnBIUzBkVVlDUVdyZ2lkOHY1K3l6?=
 =?utf-8?B?WlpGRjhGbk9BVi9vTjQ2OVk2bjhkWFN2WUVMamFUakJPUTJ2M04vZzN6UEl3?=
 =?utf-8?B?K0Q2VDFmVmJySHVYOWZOblNxQ21ZdDRtWnpxN0dpWXE1THc0UlpMZ0VWTTBN?=
 =?utf-8?B?NFNPazU3MWdPVUNsbTRHaHNBVXdSTGRiTTdOZFh6VWQwMUZIZ3l3bVdLSWVY?=
 =?utf-8?B?UzYvaXFFMGdwUTRmK2VZcDlrMmZlOFNkQ0ozVUNaN2ovUFJIcjNHOTQ2NnZ2?=
 =?utf-8?B?N0NDMVBoV1ZKeVJVaFlZYXhGaXY0dXhrc3FQdTc2VEZ0ZlRlK3dHdmQ3U29r?=
 =?utf-8?B?cFA3dDlwNUZWZElKK0RXNzNqMVorSWdqbk55NDV6NlB2cXJtWmVUclJVSG96?=
 =?utf-8?B?YU5TK3d4NU9hUGtxVHYrRE0xNFI3NnN5RkgzSHNjRVhOcWZHUGE1dm1QeUww?=
 =?utf-8?B?U0xRaWM5bUFsNTl5M1h1NmdRaEdzc1p6Nnh0SmM2QjF6U0l3TERHdWxzNTZY?=
 =?utf-8?B?UWUwLzVlNk5hRWhZN0VHWVVTd1F5ODU0MXRJMTgvLzVvMFBlc2xySkVRMW5n?=
 =?utf-8?B?U1lyYW1rdGV5S3lXV0lkdzcwTHRzbDRGVWNVeGZPRnUydDJwTVZDc0UxKzd5?=
 =?utf-8?B?MmNCVUZlLzNoK20rT1lmQkMyemUwbHlLSER1dE9GS0YvaXZJZWdmamMzTHlo?=
 =?utf-8?B?YTZjSmNTM1piai9VTEQweGZ5ZVFQVEFUU3B1d3pnTjNWNWtIRE03eEI5TEF1?=
 =?utf-8?B?TnZpRmR0RFJ6WVdadUc3ZTJSc2szaGJrUzIrQXcvOUNLNVh4dEY1QkNJUWxa?=
 =?utf-8?B?b3ZKdDJTc05zSEowVVdCRmdPK1MxWGV3WURjaVpVdDRLUnlwdWhxeGFPdmEy?=
 =?utf-8?B?eCtCcjl2K0s4TzJ2OEhOVmtSRkpxdnJCNXFnOGxMdms0ck1TZHhnZjdIL2VH?=
 =?utf-8?B?NXp0TVNJem1jVHdNWGZaTTNvQVlWbDFmZHhVWXZDYUxQYVhWVjY2V0tzQlBE?=
 =?utf-8?B?dGZkckxNNmR5TU5YelJ0aWpUYWtJY3pLMnpOR3dVTi9jQ08xemJNcW5IYVdv?=
 =?utf-8?B?Uzh6aVJhZUFTSGNkNk1EMUdPbnJNTmorM3dTclNuOHc1VWZBTnBxL3Q5M1BP?=
 =?utf-8?B?NHFLOUR4ZFdjN2pRSG5iMndWZk1UQ0dmRy9QVjJVVVJYcW5sZE5ORTBPZTlo?=
 =?utf-8?B?MXdGZVN1Yml6bHE5TXkxemx2L25jR0ZZQ1lKOTF1Q3JFUjVoNmp2ZjNTNFZy?=
 =?utf-8?B?aW1rVHJyV0wwM3N3bE1aQ3FOOEpCOWJrQk9qUzlHcHFtRTVKSmR3OTNLaG0z?=
 =?utf-8?B?WEsvTEFOV3hmVEo5bXFCTzltNElhNUdpUzRzejRuVm1kZy9ONXRqcHFxdDUx?=
 =?utf-8?B?U21rZG5HRndneVRMRllka0NSVWVUWmtlcTFlUVJhKzQ3dXI1NE1sUjZUbDRI?=
 =?utf-8?B?UlRLUzRGaVZSQWdpWkw2S2g4MmRoNkpNOVI3bm4vWEdKRXJ5bXovS0h6eld4?=
 =?utf-8?B?cGl0QVpMY3hWbWRRa2krd1E0ZXlWY1RQTmRKenZNMWhmdExNYUdvSzd0cUd5?=
 =?utf-8?B?cFp4UHFsMGpxSXh6WkF3anpuNnIxOFlzL2laTWdFdjJKSlM5MHBHK00wRHVJ?=
 =?utf-8?B?T29kSEMveHV2QTZxQm5CeHY4ZmV4eXJYcEJNZDV1YUFjN1RRNUVQRi8zc05z?=
 =?utf-8?B?YUZXM2pBRi9RUFQ5a3pNbGlGbjExdFlSRUpwcU0wNk1Ta0lRUStYKzk4ejNZ?=
 =?utf-8?B?dVBKS3NsR0RrVlZzL1JSaDdVU0ZQaGdIYnN6SndrTFc2bFMrZWx2dUE3MUNj?=
 =?utf-8?B?My9Yc3FrMjAvQVlmMDd0MFpCU21PTDFIQk9zU01HMDBNbjloZWRwR1ZGc2JT?=
 =?utf-8?B?VFJYTTcvMUc3R3JKUTYxaGRDRUVEeGgzbHA4bm0zRmlWY0o4cmQxZkVQYVI5?=
 =?utf-8?B?NVRoWFJrN2xVUk9xbENJUkNISit5RWF6WnpMYUd4QmZaVHNrekh5bGR2a3c2?=
 =?utf-8?Q?d73uYY23CP9uqY7zT/Vn0aSis?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b567cb7-c8d7-4602-a5b0-08db240cd784
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 21:49:37.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cufYPxZNCM2b624SbrYHrsICJMQnUF4Dg9BhGShjD4iR9quAt1E/t43AvuBSHFmAZOhGWBnmWXkuuZVCOiPEgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 10:55 AM, Krzysztof Kozlowski wrote:
> On 13/03/2023 18:05, Dipen Patel wrote:
>> On 3/12/23 8:47 AM, Krzysztof Kozlowski wrote:
>>> On 10/03/2023 20:06, Dipen Patel wrote:
>>>> Added timestamp provider support for the Tegra234 in devicetree
>>>> bindings. In addition, it addresses review comments from the
>>>> previous review round as follows:
>>>> - Removes nvidia,slices property. This was not necessary as it
>>>> is a constant value and can be hardcoded inside the driver code.
>>>> - Adds nvidia,gpio-controller property. This simplifies how GTE driver
>>>> retrieves GPIO controller instance, see below explanation.
>>>>
>>>> Without this property code would look like:
>>>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>>>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>>> 				   tegra_get_gpiochip_from_name);
>>>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>>>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>>>> 				   tegra_get_gpiochip_from_name);
>>>> else
>>>> 	return -ENODEV;
>>>>
>>>> This means for every future addition of the compatible string, if else
>>>> condition statements have to be expanded.
>>>>
>>>> With the property:
>>>> gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
>>>> ....
>>>> hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);
>>>>
>>>> We haven't technically started making use of these bindings, so
>>>> backwards-compatibility shouldn't be an issue yet.
>>>
>>> Unfortunately, I don't understand this statement. The
>>> nvidia,tegra194-gte-aon with removed property is in a released kernel
>>> v6.2. What does it mean "technically"? It's a released kernel thus it is
>>> a released ABI.
>>
>> There is no active user of that driver, so even if it breaks 6.2, it is fine
>> as there is no one to complain about it.
> 
> How do you know? It's a released kernel, thus how can you ask millions
> of people if they use it or not?

Please help me understand, if I am targeting these set of changes for the kernel
6.4, wouldn't all the patches land on v6.4 at the same time no matter the tree it
will go from? Also, if user is at v6.2, how this will break as at that version, it
will have the old bindings and old driver, right?

> 
> Best regards,
> Krzysztof
> 

