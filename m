Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8E6E2917
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjDNRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjDNRP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:15:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A559ED;
        Fri, 14 Apr 2023 10:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaSSIT8SD4sUvOzy7/vRGb/hOdQmph97JPbYhrw7Jv9l++tFJolHA7SXFw3xzhxIiveh/0lfB2nfYQWH9Rr0q+UtQWrXUnoZK7We7+TvAz0NcvOc/5bb5XvrkGzOJ2HZ3I83pqbnYDIAYhSKoiKf8xQVGVbIhQO2fSj0fNSl5pw1zSf/ZR5wVCIHXDgrj+2DOf8BY5r4vJ/392SmjbluJNPlHuNO7SAChB12/kPn3dUWHBwgxScYi2I7AMYIJxLpFKw8fGnAHTeJ4/mL7qlCCOdv4XtSV0RjI8immvqoSEehkH1tMoUhycfp/uSlLkHfCmrdX3Pahr239iLNtIEIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwqxn5I8jvKC30w0+A12yn0J67UwM1pTSs6MT7yzDhM=;
 b=dx7SDmEdGpac/guxOtN1h7lKXozgrP1voYHuYqrAsNK6naKURLkiRvqZ7wfSVessTHKoIVIa53wxj1oCEbDLuOLXajr7O796tC7asMTyxMsAwJ7CmEMn0BrTEm066oQ39anIVW241FcV2cfQeke7e0I5rhDEfzhv6O7WJw1N30xko20jM4CmCRqzxK0lCQQ6x18qS8k/kU60SWP43e5EC8gxHIWcgHhjxJVtDoQB7A0cfE8NG3cJ3GYjFERXlElBiUNsDjG8B3ZcWxp4ohAgkXDYdMfzBTjnR0LoGqppsSQtOdGX+FrrQIB6Q8OXjNK2UDTJj5V7lF5JP73RzBpO2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwqxn5I8jvKC30w0+A12yn0J67UwM1pTSs6MT7yzDhM=;
 b=NjVTcaGQHY+Mvw0GcVEITq0lltEdIxOADASkd6r4ho+A2hs/tTEMIyPyh/0GJe6MT/1izpn5Po60iHpFvbp4x7CAMqyDEqbv3vIqDn+2WhJ+3cuvYMsheVr+JxV9lYKp78g69VvS6mxcWcMjogBk3+Wt13nr66g2OwvCu9kFlBePHTQDt1m9Vfl/j7wrBZ+xFdGpRcXmwnqZX9H9eqjeQmv0kyHMUGSp2fosed9Htfg8IxVIoezFN5dxcV0Rf1lgUB0VdhBc6Fx7MqbRfHb3OsQHyAdJVCPNRO2HZj0Pp7q2WtPueziLh6gYRUYwINOx7nUejcZKM0XNaiAnfBxiUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 17:15:52 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%5]) with mapi id 15.20.6277.047; Fri, 14 Apr 2023
 17:15:52 +0000
Message-ID: <4b5e45e9-6aa8-7338-acc4-db06ca1fe025@nvidia.com>
Date:   Fri, 14 Apr 2023 10:15:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [V6 0/9] Add Tegra234 HTE support
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20230414004455.19275-1-dipenp@nvidia.com>
 <373eacb8-be3f-6b95-3e08-f0ff36f79891@linaro.org>
 <CACRpkdY6R9WvwOr3mVgrJcf9dVB4s13eu8juZkBt0Q+=gg2G2w@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CACRpkdY6R9WvwOr3mVgrJcf9dVB4s13eu8juZkBt0Q+=gg2G2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bc863b-fbcd-49f3-4785-08db3d0be678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KV7hoaYm/sxpvpL5rZ2gkpQraF+6Bu4BSCOCsYDJWGhJLpWcKJuCfHSTGjX9MIFgO7xBuslfW0uXoNRP+XSfKpTAzNpY0wdN3mrVS+nKXeLU+/HyyRvBamIlSWEDfOrfbKLF+p2gczXnT5o67VQ2wXsgBA4Uwts6H7Rrml8YJsIGMZX4xxwdufUlRD7l9ul1e8AQCz+LdyDViPyy6a0jOawGWsOEgMVprjtkmebR6r+AKokwR7Ul9g5s0oU5rg+/1CcTUSN9zqc5a+8wJI6YfDT0/kUaTUnjxLFk1MbH4DBkqot3SHvs4jP5YEgBW6XEV3NXWKewlNMhoDKZAwI+4QgIil6RwngdbGcPtHg9bnX6Z0l5oIahVjmNLm5cjURBM8nOKS93I95VTaou9F2QiiwHLYhveKG9js1JMJXI0KGoLH5Hl8fIW7XEsxUC9WEKCTqWVCSRD7kZKY93Z8AXFFeAoisrMObpErDb+zn0YFjONUzhb9KAaf5GYvAvlqp/8oqDPVX0/EMn81csfzYbn9zmFMY3MNZInQ9x6NNXAKXGYasiotiSP8Fy8FeCCgFl4xUN10VQ98lkDw90JU8NZedfieSOTjbyQugLwHDj/e4Rkf+GYyJLjLVny613dyB/RzNHubbSuMC+vzSmVUXdRwTFb6pGwT43gD80t/Q3Nl21WCbZEsDI2LnidV4QePgQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(110136005)(53546011)(26005)(31686004)(6512007)(6506007)(186003)(83380400001)(2616005)(966005)(6486002)(6666004)(5660300002)(41300700001)(316002)(8936002)(8676002)(38100700002)(86362001)(478600001)(31696002)(66946007)(36756003)(4326008)(66556008)(66476007)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWVCTGJ0ZXNWTlpRV3pBa0dBZHRROWExQlBXYS84ZSt1eDZYYy94elMvaHgz?=
 =?utf-8?B?NXZhRUlFT2F5T0NpVXo4amo5VVk2dlBwQVhvc0kxM09oYTd5QVdrK3FFSkth?=
 =?utf-8?B?aUd4SWxvdXJERml3amVGbVQ1ckhxTWtKbDlwczR3WlVoYUdrMFdzU1JYaVho?=
 =?utf-8?B?S2tKOTJTVytiY29yTkQrYUNZOHprbzJtOWpSK1BQWjljcXRzWGlSMUdHMllL?=
 =?utf-8?B?cnZiU1VIUXZPRlVsTHlGYWNiL2ZWU2lJb1VZcWFSbHI0dVdMU3ZRbERPUnl5?=
 =?utf-8?B?dEFyWXN4K1ovV1c1RmduZDVFeUZWTVIrc1dBSkwwcmZYaHh1VTRTWkM5UDcv?=
 =?utf-8?B?aHYwWWxVRTJlb0tmanFnNm8ybGY3ZUNQV2ZRTUhPSlhpYTRCeHRPNkU3cmdY?=
 =?utf-8?B?Q3cyVStYV1NkQTRVaHZnVE1rbnB3emdHM1IvL3h1eFVMSDIvenROUjdwY2xK?=
 =?utf-8?B?S2hMbnE2QkJGTU9VRkVEODlvVUFPbUY1YnVWY1JqMnVBak9aYVhjYVpLcEZJ?=
 =?utf-8?B?aTlhQThHSzR0RzZ5N1FaSnV3Z1pWcGlEaVJrdlJWVWF3a3g4MzZhOXJQbEpL?=
 =?utf-8?B?R0V4V0s3KzI1SU1XQ3hseW45d2psa0hKSy9XQzVSbTQrMHZYU1luK25HV1Qx?=
 =?utf-8?B?VVZxYWdoMzRCVFBCeDd1Wnpmb0w0TTNKc2tZNExaYVJRdlA0b01SVUoyajk0?=
 =?utf-8?B?NS9WRm0yeW9QZWZXeVhtSTdVYS9GOHV5MkgrRndOOTJ5KzVyU3ROc0x4OFBz?=
 =?utf-8?B?NHMrU1Avb0xOMTZPMkljMXk0S29pVXVPSEpiRVFaQTVTd2tIODJ3NlBhREVy?=
 =?utf-8?B?TUttZk1sT0JlTWFHNGlEZ0dRUHBpeEJzNGF4T2FUaDh0T0xtV3lLK2NLcmw2?=
 =?utf-8?B?WXh3TFQxS01DYkxRMGdTbXN4ak1XVmN1b0N5ZkYybVpUY09KbUVOcWptbVAx?=
 =?utf-8?B?NmRpNE1zZ3YvQk5idVZ0MXpQK3Bwc2RQSmFjWEsrRHpCV2twYUNnYkRnclpU?=
 =?utf-8?B?SzQ0V0hrak5ZZ1dPaWFKVUluNk8zOXlHeVI4RTRnZ2cxTlZ5NDQreklmYUx2?=
 =?utf-8?B?UkJtTDBuNG1VTkFMUnYrWDh2Wm9DOEMyUSthVHFTRFZRSDlRdXJ3QWozc3M0?=
 =?utf-8?B?Mzk0TkNXUFNYWHZKSmE3VXNpUmVQa29OZHVtVEJhQ3QyZ1RPeWtTbXhoZllx?=
 =?utf-8?B?QVNqLzZudU5BUkVodGlXYUU0SnRQeDN4U1RGMGRGRit2ekJDNHhzdmxPMnlD?=
 =?utf-8?B?bzZMeW1tdkxZMHM3Y2lMOTRFbkxBQmQ2TllzMkZTb0VJWnhRbVpFTzkvcFJm?=
 =?utf-8?B?SzcwRmJYOGFLYnpOT0p1TmlGQS8rYUtoV1NMMlBrWDU4eVNOSHRUaFFiQnRE?=
 =?utf-8?B?NzNNMVJWbG9yaXRmSVlQMFYweDVZakYrMWJ5V1pYR3F6QmhJT21oM2RCMnhH?=
 =?utf-8?B?dk5XTG4yZ0h1NTF6c0Ywd2VkWVN1MWQ0VHZ4aDdKaExDd21KYmxYMFZMcU5G?=
 =?utf-8?B?ZFZFVlFhS3MyM1JoR3RGZVVkd1hNaXBFbEJzemFFc0NnNFhkTlJ5TWVMWFhu?=
 =?utf-8?B?cUc0QlpZS25IRmdhZ0xkNit3ZEh6M2k5MnIvR1FpT1RxWkVEMGozS3pxS1pj?=
 =?utf-8?B?U2VFTGpCNkJPdm9jR3BJa3ZsS0JYZGVlL3JOVytLdy92bnc3eE9RTlZMZGFq?=
 =?utf-8?B?b2dDR1BRMkJVS2E2b3V5dFRVQ214enNZY0ZLblZBb2FMNjRNWjJZeUh2UUFm?=
 =?utf-8?B?VDE4S0VtblI0M3dGaTZtblFwS3hPWXV5VUhiSjd0b1VjNktLb1E3M2F4LzVt?=
 =?utf-8?B?TG9TVDdESmRjcm43TGs3MWdGR3Ntc1Nvd3ErMDdkNTBuVXY1bW9BczhzQzl0?=
 =?utf-8?B?T3M5N1h5eGtZVlgwK0dsdkxlclFTUDQ5Mk9HM2tFMkhleXhORytZSEtJQSts?=
 =?utf-8?B?Sk5WakhXMjNTcDdWWi9YUWE1bWd3M0NaQXVBaVcrNHdTM0doYVVmS1gvVmh2?=
 =?utf-8?B?VW5QSGZTbk1MZ3RIWDV1UHNwajNBeUcxSkRTd3lFd1o1YXpwcFA3R2lxdXdQ?=
 =?utf-8?B?S2N3RldhYTI0ZHlQSFhzSktWbVN5djZ2TlRzUHpxREdKejZvMThXQUdvUTA5?=
 =?utf-8?Q?3qY5Qf3fCEn7b/Uxgw22iHoc3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bc863b-fbcd-49f3-4785-08db3d0be678
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 17:15:52.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH5Hl/YXivcL0ahpdLFQ1C1/zmJPsuKZWUcrJeLNNtoVRfOLQSxgerEMCsuKdeiSwfXf9QoFz6Oq0We4XrKUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 1:07 AM, Linus Walleij wrote:
> On Fri, Apr 14, 2023 at 9:36 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 14/04/2023 02:44, Dipen Patel wrote:
>>> This patch series mainly adds support for the Tegra234 HTE provider. In
>>> addition, it addresses dt binding comments which prompted code
>>> changes in the existing HTE provider driver without breaking the
>>> Tegra194 provider. The comments raised concern how existing code
>>> retrieves gpio controller node
>>> (the node is used to help namespace conversion between HTE and GPIOLIB).
>>> To help simplify that process, new DT property is suggested which adds
>>> gpio controller node in the HTE provider binding as phandle property. To
>>> conlude this patch series:
>>> - adds Tegra234 HTE provider
>>> - modifies existing provider code to address new dt binding for Tegra234
>>> without breaking it for the Tegra194 chip.
>>>
>>> The V1 patch series:
>>> - Adds tegra Tegra234 HTE(timestamp) provider supports.
>>> - Updates MAINTAINERS file for git tree, mail list fields.
>>> - Updates devicetree and API documentations.
>>> - Enables HTE subsystem, Tegra194 and Tegra234 HTE providers
>>> by default in arm64 defconfig and dts files.
>>
>> All your emails miss PATCH prefix. Use `git format-patch` to generate
>> proper versioned patch. Stripping important part messes up with our
>> filters. We have quite a lot of emails, so proper filtering is important.
> 
> At this point I would even recommend kernel maintainers to get b4
> into the workflow:
> https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1

Thanks for sharing...will have to look into it to avoid such mistakes.
> 
> This tool will also implement other desired behaviours and version
> the patch set for you.
> 
> I am gradually adopting it for my own work, using it all the time when
> applying patches but also getting better at using it for submitting
> them. It has a small overhead (like learning and memorizing the
> subcommands) but once you get used to it, it is really helpful.
> 
> Yours,
> Linus Walleij

