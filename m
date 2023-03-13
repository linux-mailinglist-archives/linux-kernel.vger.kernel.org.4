Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D036B7EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCMRHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCMRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:06:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B294E7F01A;
        Mon, 13 Mar 2023 10:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN5wXIbFM6x5HWYhTsQvHYXXS8SovJYrPHQanrSbsQU9ZxD2mGshU/KOkWaPRjFd03vHVRWxUrMQDC/Bn8m9HoME7hWoz1PItp/699JPcHPTAdcenhrvpSsEpAhfRDGYnkYpcMiYmiK0U9fmOuLhbXJBP0Z2oY1XQtRADNhz9GLqSDKiSPfAwF+/RgJcVz4XFqISCemIEpDJCTAZnBElYcWq2nCWqDiTYfuKNUGJDs9MidTlSF4emHIybUMP3e467ggrcTnV1V/p6wH+lmP07Xy9hwPMk36nx5Fzx6J1OwEe+XzjUwHOLAFipXG8vO0xSIw0zMZaDFa3FudYthnEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJMpQLZMvM1qm/nlujeu/tVThhzJ597E6Jx64bIor3s=;
 b=Efxj42r38KZ6jtfttmv49HUdl9asp8Pzgg006IVX1+a++cVeKCn1ZRB9P6ENFhhmecc4PMFlbOBYWTdoEhjqMQqUBwg5AOCUW2yiqWRE5HZgJvTqnc1PautoasKjRDLpODeI4v397jxNvFYF2SZpzIGUWih1m80g1V5acdYJ1H9EgSHSbA6Knio47VAyhnNKqxupRlwxT9k0WTKCTBMsZL4BPmydnuRR/zqlx+7s73ygef7Sq0YfQwJEbr4B8acGIiA7wUZo+DzKFFnc6oHeRT0Hh3wouE8RI34FVB+SkOXOJoJgDhdHiZWlenXGq68GzESQGc7YMruN+tWrisYCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJMpQLZMvM1qm/nlujeu/tVThhzJ597E6Jx64bIor3s=;
 b=EarHIT6LKfZ5jF1mgz7OdvXJEIhV2lwyIW7FV61l3u/PgSfsshxfOTM0jyOrdZpdmXe09rhuEbdvFrRyiTEaXlotWovrNMJigDwb63fSMeoHdEmDFfveryhk31npC1iJ1kEv/HUtzSoeIsg163VJtENLbD66ecWwi7SBkn15QKb6MQ+sKsbLpJR9t1yraAY3vvF4/5pGa2kzmVLK2WyMVs3gfDacGgX3VFVvM9IJ7wUAXmGkbbt2cZsC680PmtRKycfYjeWOTeDNh7kkAVtDRqOf3yi6yPGOojljaaJJKrZSBDQgb2Sy+THrIY8bxMzL0yAhffseop7VqsVsz47Ljg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 17:05:29 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 17:05:28 +0000
Message-ID: <b4195142-6cfe-df3c-6edf-0c40b64ad02a@nvidia.com>
Date:   Mon, 13 Mar 2023 10:05:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
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
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <f6d9c84a-1c75-d9b4-59ed-39d6c5b310a9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CH0PR12MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa50d1f-c379-4f43-41ce-08db23e5252a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1HvS+tIiOSum4EM5Fm+7CfLXf/v5rvw1PgCODIymuQ6yFRlHgMB3PV/iQ71EhyH8vKU7D9r0HedPGnQfohZkvli/vWDxJjKVh/Ot4CMcIm6ThxbHhUovsdcArqaUPSOzfnswzbBASj8+0fvW07WvID4xAU5c8fv1V7CYB7YgpTvPSowjj+ZwDxifB1O0vdSV9xik4vo4EkMuLLgArxUZksqwOLxjPoEoV4AxdSfRNiB4u7V/nEGxWgf4bEMHVaokveEkKUuv7sItgCYPeYRaIZIVT6a/viFVQbblwWGa1f2uYe+mCmpYZQNf71EQk0F980Cj816xslRNI4E1qh/VfEvwfeqk2P98hdJvC2yJiSnABeXam8WxaIgLQotq/iubjd/v1qKkMUaQa5tRDGwZnVgMJFxSmObcBC8fzhS670XNW1hZ671ZsOEtHbtRB3SK2msbsseIDQD/oR932aoBGxuHNUwAdx9LFGJpBA7DYVy1T1Rbs38cQcX2nb3p/BC3iXic/qOu+fEzrljQHP2M20W+yxRuNLC6b+gRLqGBufCCipvff0CNYCF20gCQVXSdRIg8Zd5+EiaGdIpfjWRKcAj9WE51IIxh2InSPAhQkyA4t6bTSyGPEM3afY+hJU1MB5fsW5KDhT5o0gfRP0VfIooiSSnOQWQK7JZ0gkqWQArv9o9iwL9y3UPZy0BPTMeVHo8HgMdGnuJ9XI4WG9+xi6tMKhHHLpxhoicOPJuxFiKowoAWI3TO526dfjsdYpz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199018)(921005)(38100700002)(31696002)(86362001)(36756003)(2906002)(7416002)(5660300002)(66946007)(66556008)(66476007)(8676002)(41300700001)(8936002)(2616005)(53546011)(186003)(478600001)(316002)(6666004)(6512007)(6506007)(26005)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFuY3dJQjBoUnB4Q0dwS0IyMnBzbHFTd0p1MTdFckxKZWxrWG1XVm9SQzRK?=
 =?utf-8?B?TWZsOVB6T0pjRXg1aS9XOWhnbWpGYjhsOUxGWG0ybXFpVmg1ZmhLTkQ4RWZQ?=
 =?utf-8?B?RHRSKzZBakdlcm9LM25WTmVkaVFxanVHWEdPeXF0ZElJRW5VV1ZUVU9nRFJs?=
 =?utf-8?B?dDdsYTNVNWdwb0M4RkJRamw4Z2ZmeG55VEFHS1hyWkdYenR2Z0cxYWhNMlV3?=
 =?utf-8?B?R09rUDNUcmJVWStDQkllbTM1R1VBNCtHL2U0cmhnbU9WblZJSHd2ZTJOR1J4?=
 =?utf-8?B?eXh1Z1NJeERubGNuWGk3N29QSG5sSWptYjkyQnJQblpRaGR4Q2QrQW9FbWw4?=
 =?utf-8?B?dVFhWVpxWStjOS9ldlZ3eE9rSlVEMityNHdCTnNDOGdJQUVwMmo0ZVYzSmhs?=
 =?utf-8?B?bjZhdFRZNGpDbWFVUDYrbzdteEFzRy91MFZEWmIzd0R0UzNTSkJ6bkkxaTlP?=
 =?utf-8?B?YkVSbTlPcGRJVEl4N04zMGVxWHNCZVlyV0RGTy9GajBGTU1UQnVOSXpzVDdn?=
 =?utf-8?B?eE1MNU90SmxoYlk3a0pidWZGN3V2WGlWMnFPN3o4R2ZwNStkTHBRY2t1b2g0?=
 =?utf-8?B?ZVVTRC9jL3lHYnBkQVQ4QnpGbjROYlA3dEFJME4xeUplK1gyUlFnZCszeVdL?=
 =?utf-8?B?cjVnbWtaYnlSZktkYWluVmpUZWx5ZDNscUFSczVQMlpwUmdVejN3a3RDWUpO?=
 =?utf-8?B?NnJYZFJEbWxCM2VrT2s2MlNWZHVwSm9pZGxFbUpvbmlsaWVHWmFrQm1idit2?=
 =?utf-8?B?UFNJQ1M4RzNaNDhUY01DaHlXSDVwWk5hTXNRWjNJemtCeWlrNTZZL1MycHlo?=
 =?utf-8?B?RFpnUTJKa2hISXlvM080bmVjVklvSDcraWtEWUdMTjVxL3dpT25neWVKQUs1?=
 =?utf-8?B?bnhhY2g3d3hMSFJyYUU1eDAwVUlLc1VMblFGODVNWlUydEdGZU5yYkN4bXhi?=
 =?utf-8?B?UThzUlpVMzgrN0N1ZHUydWJVZngzN0FvSmlkMUJpZjdUQkw4YWJPc20wczI0?=
 =?utf-8?B?dGpPS2hCSXlrWHhkSkVXU09ENjF4T0hmSHRtM0pheTRnZlo4bmg2RlBEd1JN?=
 =?utf-8?B?YlFZTi9FQmpGaGJQWDV4UmFhNjk4N1JzWVJqYlhkZHpCYnlVRUJHUkFMV2pQ?=
 =?utf-8?B?RE1yaEtyajhuck1CRDBZTjNJVlJQYnpNL0p5R05nbVFCM2tSOWhxZHVpOSsv?=
 =?utf-8?B?WW1wS3Mzb09TWDlabXZvbzRpTUthT0ZYb1BEUmtmTUk4REh1MmRFalFsQk1F?=
 =?utf-8?B?ZzEvMWtxak9oN01xOGw5NWpBUkZQSXBRZGFoeDBXejBscFZLVloxbTJWOGFk?=
 =?utf-8?B?ci8rSmRyVHFrcmFDK2ZBVnZQcjRNRUt5ZmR0OTdwQ0lwT0kyTUhXV256NjM0?=
 =?utf-8?B?bnN3Q0J5ZXZiRVZIU0xBZGNZZHp4dWlvOXFjcHRHTXhxZG4xdFkxaHFKazJ4?=
 =?utf-8?B?U2VqSVh5UDA3WXZwSC9KRCtpaENHTi8yTzJiUi9SYy9CNDQwcjB3Rk9VWWRU?=
 =?utf-8?B?OXZJSU95eGR5eGthRDVZdWxNdE1xWExYa0wvVE16K2V2dW9zTVhGTkxMTjkx?=
 =?utf-8?B?dTQ1Z1BDWkk4VWlxYW5Td1RWMGFVaUpLNXpodFE5bWhpc1YvNmpIcWoyVE9X?=
 =?utf-8?B?VjRaVElsRDNZR2NJd0NpMGtLTi9DNHR3ZU8waWFoSWcrSFNnRGtsVFhWT2Ux?=
 =?utf-8?B?QkhkQTN1anNWcE5vaEZLS0xmUGdSaTVMbmtKeWswWXRZYmlBUEhsSmh5dkJS?=
 =?utf-8?B?am9BUjN4YVRkOXlFRC9INEF1dzNpby9QMnFUY0JPYjZtMlpXWGhtcE5Wa1hP?=
 =?utf-8?B?R3ptTU9WTjdMM05EOVJldW5lYmJreHZwcitpM3Rldk5UMXBNeTdvOHk0Z2VM?=
 =?utf-8?B?TDZaaXErMFU5YXZ3TFJyZTJxbU13UjZ6aE5VZzRRRlhtMnozVGU4NEVyUnNv?=
 =?utf-8?B?Uzd3RWFDNGhKak03V2dHcUtDbGlJLy84aUhWc1ViSFVxamdRWnk3aWVackM1?=
 =?utf-8?B?ZEJLWlNEM2c4Z1FGS0pFV09kZkVwNGxKWlVnY1psOGdCZmJLR09XdHQ4em1t?=
 =?utf-8?B?N0ZiaFNoeUZIMmMrNmFSNWN1dU9ibllDRzBlKzlETTlrcW9UbWR2QnQ3U0Js?=
 =?utf-8?Q?dNGMMq2yPGewn7yJ9n7ORc0HK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa50d1f-c379-4f43-41ce-08db23e5252a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 17:05:28.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNrYlmEYr3HTvEJYGWZBLoppaajuGgCM8ye85ctOglPhjc2USpSqBm+iao30ZWMdWAbeI6dlgivi0TG92uaQyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 8:47 AM, Krzysztof Kozlowski wrote:
> On 10/03/2023 20:06, Dipen Patel wrote:
>> Added timestamp provider support for the Tegra234 in devicetree
>> bindings. In addition, it addresses review comments from the
>> previous review round as follows:
>> - Removes nvidia,slices property. This was not necessary as it
>> is a constant value and can be hardcoded inside the driver code.
>> - Adds nvidia,gpio-controller property. This simplifies how GTE driver
>> retrieves GPIO controller instance, see below explanation.
>>
>> Without this property code would look like:
>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>> 				   tegra_get_gpiochip_from_name);
>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>> 				   tegra_get_gpiochip_from_name);
>> else
>> 	return -ENODEV;
>>
>> This means for every future addition of the compatible string, if else
>> condition statements have to be expanded.
>>
>> With the property:
>> gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
>> ....
>> hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);
>>
>> We haven't technically started making use of these bindings, so
>> backwards-compatibility shouldn't be an issue yet.
> 
> Unfortunately, I don't understand this statement. The
> nvidia,tegra194-gte-aon with removed property is in a released kernel
> v6.2. What does it mean "technically"? It's a released kernel thus it is
> a released ABI.

There is no active user of that driver, so even if it breaks 6.2, it is fine
as there is no one to complain about it.

> 
> And since DTS always go to separate branch, your patch #4 breaks
> existing DTS (return -ENODEV;) - it is not bisectable.
> 
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
> 
> 
> Best regards,
> Krzysztof
> 

