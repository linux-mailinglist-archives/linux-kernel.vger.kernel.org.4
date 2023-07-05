Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E17747E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjGEHny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGEHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:43:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0EE6E;
        Wed,  5 Jul 2023 00:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO0bvbeP5Nlc6+B6ljnl8e1GYz2Msqa3v4H420MANoCNANyBXKdGHwmIYAou9cySnbDQOVX+hbw51vf4JEUrKEJKIOXxFH+2ehERd4tmk18+4pp4bJ4WNYEpTp8DGf1k67xtVqv67dzZKpsJUSpCHahGxRyJFULsTGaK1ZDLrcAxpLOpsXIDEfmJJcovo8TnLtnJ2SToVdZMqUTmZAROoqii9MfDRPu21Y3X1qnG3t2lIqWhnLGrUERcvVkSydJIxsmZJRgJKSqcmOG+Kv5/tPLgo4S60fKQLLbATUJjVUcT0Bt/3otFvykseq1N1nv+EDwLmnikJ0QGv1ryG+OBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ1epOdV2kxfOulcivlQZvyTElSzqgl6odlLvLq504M=;
 b=NEE9RxlAtcQPjZSK8uZf1hcNh3Q81Xr9Q6EWYontVP40YwPUMbsBIwcXrJuqD9eQw06rpGxtRlMMKeAoXy72ViUXCqB8kFEnnPJln0zEhn+nJHR0LTSI9TAKcsVNtITRmSn8XvGjo/8hEY4/nVqLymr4BjfvQyFewtpG//4x/A6+b1BSOAI+vS2QHM2vxZ89IIWYwDnlc/JGYezF6jAl73LjYyi8G3KWUa7482UY5EAqzWFh2nqIOmECN72ZO83r1TJq7/iOT5n/y/eWXhz/fFZLx0q7sD5581ZkF7Ed2ZxHffTijAIPTiPV5xvh+SSd1Hf0fZH8i3Lntx4eDuJs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ1epOdV2kxfOulcivlQZvyTElSzqgl6odlLvLq504M=;
 b=htqcg1lHYwkW45vvUBeHyPG+ZGt4ybwRNYqQJCEDtXc7qovnirhrDpCQ4Y5uBm64IEc/HfCZ+fri6giv3CwzZIuOWxeLU7pogVLh5S/ijPUoMPaKtoLP/V4q9BRgLgJc/sU9cR8sibA5aRxlCKLD2XzJ9Im95su9al3TGgFgyY4jGXf9lPowc5Pxum5IMhHKXi5LwUgFAz+0hZjwFrDfgL75Tjd1G+ZtQgEYNQOaBUZBkipaTvvQzvT24Y30/Y3bnlqMTit8cg/uPjS4kz1g5PR7YIX7de/8UeNxLQNdQEY7RI0XSCn6zPucRQpXUf3aTss2T99SxRZwPrrtH9VFEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6663.apcprd06.prod.outlook.com (2603:1096:101:175::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:43:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:43:44 +0000
Message-ID: <c092b860-33d5-77c0-456c-367d545e8b7f@vivo.com>
Date:   Wed, 5 Jul 2023 15:43:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/5] genirq/devres: Add
 devm_request_threaded_irq_emsg()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230703090455.62101-1-frank.li@vivo.com>
 <20230703090455.62101-2-frank.li@vivo.com>
 <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
 <20230703174347.4m6hcmify4jwsozv@pengutronix.de>
 <11052797-b006-11bb-e4eb-987ddd568b24@kernel.org>
 <20805fef-d6aa-91d8-999e-04b1d6b7a37a@vivo.com>
 <20230704141954.fcmol2yswkpbnpaw@pengutronix.de>
 <20230705101537.000059d2@Huawei.com>
 <20230705073000.oxlb7e7sdkdxurps@pengutronix.de>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20230705073000.oxlb7e7sdkdxurps@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c4dbd7-c1c9-43d1-926b-08db7d2b8f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/AkHRYrYvRW31pRqnKCfzcyfxeeqc0IOiMOwuSxC+EepThrNTJKrIX8Ws4cbBsTk0+2/lw3MmtnNRN2+NfdTvKSP3ZXzQWPfdbhvVva2W7zieBAtmzqbbzS7nDmvaoFkUJaCMm8LB0hsTPb6xfH/i5pQbXjUMg39rGuKDMlRfimiUPJujL981uXXW2jklMj7n5qzNsZ1DUrVKOrmGhH/bGRT8YhHohGbGk9nShapiupj4Ne6TSDVPBu01jINIpHLhhmuhqT7WDitSECry7sP0bbwCI0OLED5HlxIJm6CLAsbLcAqkcu6a6vorhZa64u2DhczEyYhgF21RiSXVRbeeVPTv44dCPpaaammsgAKnWzh+yakU4j2IbkuCBDBfIV6A5ak87AZ8Xvc2sYTPJ0Le7j6WgtERkw10h5v3bgfaQezOYfzk06wR2962/c17lO2F9LQyTPx4OAXI26IKUcJoCQnn3oKE1qQ1FaFCkkQq9MJvIOHi1hZfVb6QAJrjxDHj0iHXM5YfNEm00WYQg82XwBARn2FLzFqXk561ZNHrEl4urPhoGZDZRmlQ81Rrl7RRbT2/RIy9GTnFKLQqu3wY0nG9+TKNV+zY1g3ap7Ockr+Zf0FgNtRu7kzTbOKFvBEIVJuBDRuIBXGXqa49WticRXfPFCHftN28S2smuTQCliuZMjJ0rFp0Tvk8ylkE7s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(7416002)(31686004)(66556008)(478600001)(36756003)(66476007)(66946007)(8936002)(4326008)(8676002)(2906002)(5660300002)(316002)(66574015)(41300700001)(110136005)(966005)(6512007)(31696002)(86362001)(52116002)(38350700002)(38100700002)(6666004)(6486002)(53546011)(26005)(186003)(6506007)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M241clFGcDlHcUZsWWUxbzdFdUdBZVVTTUoydlU4NnNkVmVURWZDTEFYWEpG?=
 =?utf-8?B?WDJFcWI0QmZhSUZTcXJTNEVJTHZVM2tmYnAvWExZQ3dHUmxGR0pnT24ycFZ1?=
 =?utf-8?B?SFFQZ1JEQmlhMEltbjlBaGpKVHBENVAyenZjT1ZDS0NJZVhSUCs3aTdsbUtJ?=
 =?utf-8?B?SDl1dDR2QkhZTkpvcHlsSFRaVkdmWXU5bGxrT1RJcmd4TGRpNnR0Q0hGbllF?=
 =?utf-8?B?aXRiQlhlclJXSWpjS3Jzd3RVR1F6WmM2aGhlL1RRVUtXTHNZOHFLUUdkSVlo?=
 =?utf-8?B?eVlhU2JWSTIvWDU1QklaQXZ3RkloQmFiSHp2aWdXVDg3dGNiYVFjT2hNTDN4?=
 =?utf-8?B?cHlMN2djSSsreVIvUjVjSHhOa2oxWVBUYVRGTFlHdXdGTk5kbG1PRVZOaGt1?=
 =?utf-8?B?RmhabmZvcm9BSE1jRGEzY0daUWhkM08rYzFnUGg2SjRlbUFnclFLUTNOM0tD?=
 =?utf-8?B?cjBtb2MwRU9vc2NRRjlMdjE1dWlBUlFzQS9FUG9sa1JBNXl6UWJ1TzBjRzVX?=
 =?utf-8?B?bC96aTM4dWo3MldJc2EraThVdGhhU2VEYWJ5Q3ZpNXRvb3RwRWpWTk5vblpE?=
 =?utf-8?B?VzM4R1hxUkQ0aU1xd1pMeFdvOVFQcnlZdGExSmpiM3hzSmpseWNJc3p5Q2gx?=
 =?utf-8?B?R1B4VHhzd3hzTk1FaVlBa0FDeXN2NGZXTkJNVGRpb1lCT3FRRDBva3JtNm8r?=
 =?utf-8?B?bW55Z3JjeGtTSnAzUWg0Q1pqcGpDc2J3bE5FSzVoUytGVDZiTldKNGlzZ21l?=
 =?utf-8?B?SWhOY1pSajVQZkN2NTJEMHpSN2g2YkxoSFp4by9FUHNMM0JNa2V2Qk1pN0hj?=
 =?utf-8?B?NVMxZXNSdEt0UTlBTmVybTdmeFpWdXJhNlZIMEF2Z0k1Nmdxa1c5dXJGMERU?=
 =?utf-8?B?Rnh2UEtEL3A3QlppYkErdFdsc282akNwMU1Oa0hVY1JDR2UrRERjMElsL1M5?=
 =?utf-8?B?T1U3MlJaOFB6bGlyUU5YZ0JxM0JNTzNacnN4aWNlSHZjZDluSzRjYml2dm9D?=
 =?utf-8?B?RlZiNGNXVXFBOVNmUnhEUlVWL1ZhcVNSRmJibWZUR0hDWU0wQWROQ2pERkVq?=
 =?utf-8?B?MGFFKzQ0dStGWXNWMVY4NlNsSi9BTlB2ZDh5Tm9qWkFucWVpWHdZaFNRaElj?=
 =?utf-8?B?dmQ5Vk15ZmdScWlFaTk3ZTFCejdISVNhcG1MazYzWVo4N3BFWWdYSXpZQmFu?=
 =?utf-8?B?dWk2L0p6NFNuQWpmb3lKbkpYS3FYbGhNcEhDblZReCtlbU9waytWOUgxVm9m?=
 =?utf-8?B?cmt5eEVIelUrVHZ3RVNpUDIyblFYMkdMSVRkRllsY2NhZUcyNXlqeWNoWXlG?=
 =?utf-8?B?SnZGS0RzYUtYT1hMSzNiQVdxZDROMS9sdVJDUG44aG1BWm9yNGlheVdQbGcr?=
 =?utf-8?B?akZCMVB3dE53eGpiSVhFbWRld1N5OHBzamJudERkOEhyU2MzMkVqU1dEVGlt?=
 =?utf-8?B?TXhWTWVLNnd5U2dOQktqbnk0WWw5emlGS295djJxMlcvek5TZTlIbzJ3cTZF?=
 =?utf-8?B?c2FicTNad2NzVVcxS0hENHBXcjlpd1NNeUdJQU54RjQ4UlhVOVh5ZVoxL25L?=
 =?utf-8?B?SUJIVVN2a1g4SkxwVVhVWms4QURGUEYrcFRpUkZjbFNIaWxBakphUUc0THd0?=
 =?utf-8?B?Nk9MVHlmcitkei9MS0JaaHNUVGFOTzh2QlUwbVEvNGl0c0VTTThtOFNUWHhQ?=
 =?utf-8?B?Vmt5Z3FsN3NKLy9uamN1dkRITlVKTGlWQ0RaZTZNWkNLQjE1aFN5TXFDUVBk?=
 =?utf-8?B?bHU4WU82NWgybjJ6Nm82Wmc3aVB3VGJER3pBRHFOcVVHd21CcFMwTGpsNW5k?=
 =?utf-8?B?WEVUamY1bTNLOWx0UU84ekdGSDlieDZrRkVXMW8zL0NzQ0FEc250dEd1cjlu?=
 =?utf-8?B?R2tqV1dLUjJQVXFpL0d5OFB5T1l6d3VkVUpTZFUzVnIrM2FnbElnY0xJZDVZ?=
 =?utf-8?B?dTUxcEl3RkMvenJTeGdXckE4a0w4QXZOVnJJd1V0QXpPdnBnRmo4ZWxHamlY?=
 =?utf-8?B?Q3NvNnhwQXVHcExNV3VXU0UzZ1RIZFBZZGhZU0Z2NVUyb2VMb3N3OFYxYm5P?=
 =?utf-8?B?c2hDeHJJQWtzMUEwaDBHNUNWUEYzOXVXeHd4ZUVrQnBDUXV2VXBpdlNyTnJY?=
 =?utf-8?Q?tw6fyB43rXV9MmQt/GfnC3vvq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c4dbd7-c1c9-43d1-926b-08db7d2b8f3d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:43:44.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObvD4hhMqjVw97ZQlWKDqG60dLDWUo3FcL0ABuwDQ82xs3iPJoLzx5qqfUivUJdfWXQbYH8MOVOm+tGpwa5uHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6663
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/5 15:30, Uwe Kleine-König wrote:

> Hello,
>
> On Wed, Jul 05, 2023 at 10:15:37AM +0800, Jonathan Cameron wrote:
>> On Tue, 4 Jul 2023 16:19:54 +0200
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>>
>>> Hello,
>>>
>>> On Tue, Jul 04, 2023 at 05:06:12PM +0800, Yangtao Li wrote:
>>>> On 2023/7/4 16:48, Krzysztof Kozlowski wrote:
>>>>    
>>>>> [你通常不会收到来自 krzk@kernel.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>>>>
>>>>> On 03/07/2023 19:43, Uwe Kleine-König wrote:
>>>>>> Hello Krzysztof,
>>>>>>
>>>>>> On Mon, Jul 03, 2023 at 02:31:59PM +0200, Krzysztof Kozlowski wrote:
>>>>>>> On 03/07/2023 11:04, Yangtao Li wrote:
>>>>>>>> There are more than 700 calls to the devm_request_threaded_irq method.
>>>>>>>> Most drivers only request one interrupt resource, and these error
>>>>>>>> messages are basically the same. If error messages are printed
>>>>>>>> everywhere, more than 1000 lines of code can be saved by removing the
>>>>>>>> msg in the driver.
>>>>>>> ...
>>>>>>>    
>>>>>>>> +int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
>>>>>>>> +                              irq_handler_t handler, irq_handler_t thread_fn,
>>>>>>>> +                              unsigned long irqflags, const char *devname,
>>>>>>>> +                              void *dev_id, const char *emsg)
>>>>>>>> +{
>>>>>>>> +   int rc;
>>>>>>>> +
>>>>>>>> +   rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
>>>>>>>> +                                  devname, dev_id);
>>>>>>>> +   if (rc && rc != -EPROBE_DEFER) {
>>>>>>>> +           dev_err(dev, "Failed to request %sinterrupt %u %s %s: %pe\n",
>>>>>>>> +                   thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
>>>>>>>> +                   emsg ? : "", ERR_PTR(rc));
>>>>>>> It is open-coding dev_err_probe(). Just use dev_err_probe instead.
>>>>>> dev_err_probe is supposed to be only called in probe functions, while
>>>>>> devm_request_threaded_irq might be called in other contexts (e.g. when a
>>>>>> device is opened). That's why I asked to not use dev_err_probe() in v2
>>>>> True, but then all the callers of this function will forget to set
>>>>> deferred probe reason.
>>> That's another reason for letting the driver issue the error message and
>>> not the request_irq function.
>>>   
>>>> So let's use dev_err_probe?
>>>>
>>>> BTW, any suggestions for names here, keep using
>>>> devm_request_threaded_irq_emsg or change to a new name?
>>> I would have called it devm_request_threaded_irq_verbose() which I
>>> consider easier to understand. But maybe  is just my (green)
>>> bikeshed.
>> If going to use dev_err_probe() internally maybe can just use
>> devm_request_threaded_irq_probe() thus reflecting that and making
>> it different to the devm_request_threaded_irq()?
> I like devm_request_threaded_irq_probe(), thanks for that suggestion
> (even though it's red :-)


devm_request_threaded_irq_probe() also sounds good to me, :-) If there 
is no objection, I think it's time to start working on switching the api.

int devm_request_threaded_irq_probe(struct device *dev, unsigned int 
irq, irq_handler_t handler, irq_handler_t thread_fn, unsigned long 
irqflags, const char *devname, void *dev_id, const char *info) { int rc; 
rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, 
devname, dev_id); if (rc) return dev_err_probe(dev, rc, "Failed to 
request %sinterrupt %u %s %s\n", thread_fn ? "threaded " : "", irq, 
devname ? : dev_name(dev), info ? : ""); return 0; } 
EXPORT_SYMBOL(devm_request_threaded_irq_probe); MBR, Yangtao


>
> Best regards
> Uwe
>
