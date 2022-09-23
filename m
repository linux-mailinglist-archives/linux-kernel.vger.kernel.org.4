Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F305E77B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiIWJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiIWJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:55:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4864CC8DD;
        Fri, 23 Sep 2022 02:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSQGjFKiVWFogI9sg9YMrHpGxpm1rRQnpzPZdN+blLGfkqAtG978DeS/5bnLKFt/xt42CJhNPQE+Uv5EtbzcBj3nliIA8Bj9ef4r54uBHCRpUTF+/j6dj8OvBbfzWHUJddpMvgfa9xkpcXoaU6Jg3HmOUdQMuciwh77aQA5lEtYuULQz1e32XleyHhp4pjzZrBombJLnAtO81eGq2kpz2WxOKYvNljNmyMTXBuEgpLb6NETAGsTcSM7CWy54siFxcMNPLC/Ym86CJO2JieGIvdtE6u8uMZ7z+yfEqDMGBn7xoY2ekDX8t2BO6RK/9+6VTit53lWVbiBdfOGURxny2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+/yEMNaqBeiyVmqhHvUtpWO6NKfplsCbXcRx7ZHQM4=;
 b=Y+cgEOkJ2WgTaMAX/VA4JpMh+Nh6j+IJKR7rD/St6ygyjhuI4DCKOQqNJzgBaa03orbvf1ZoOBaGQW14vGpXdAKy7AFhqoA/3EKqBwHZmQsIlcltJNGxLZ6/ETuj88bBIILwLfuWxEI3OV3wJtwLOkvVGMc3Cnzf7zTA+RnclXbl6JWunDSS6U6CCa4JMGDZgesLVhTlmY79sqsf3ELAJLRl49t/eQZSQA1txBavZ34ytG8TyE1I4kTHvuPnFJAv9WSN1K6SeCzwR/Di2TGE46EksXjoTN3s3W2Mf3iOBY1kGtGpLR4gQTb1KgvjDMCSwcavhsWX6drusO7O0Q+cYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+/yEMNaqBeiyVmqhHvUtpWO6NKfplsCbXcRx7ZHQM4=;
 b=jXoPQZrPrVExfqSLXUY2u672DgWI5MRww0VKahFW2q4dFSrBt+hTTpJ5M44E+oly/cMho0P+vkJJSt27Kp1E2JlpH1j8mgkWFID1QUomhIcLbZEQ4hqrOOG7Drq86sgB0BiikuBboZo6Wka/hSewxQL2y2Blmmdb8lE7PVTLZ7ZJ7RqEV5FaVoSkFUFlFN7jigS1RFn1EVEumh81oV/V9X6LL3ThIhVhuPkK+kiq7QCRGZ/Q3e0k1/KBz5F/mZbbI1QLZFdmZFzvLXHV8dum3wytCp4snfp/Pnl/Ai72uGT5At5DwX1U6Dwu1UbXqGmDlxc0PR9wFGhv96STYBzdzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB9278.eurprd04.prod.outlook.com (2603:10a6:102:2b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 09:55:20 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 09:55:20 +0000
Message-ID: <f72271d7-9f42-45e9-01a4-590bd20250ab@theobroma-systems.com>
Date:   Fri, 23 Sep 2022 11:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/3=5d_arm64=3a_dts=3a_rockchip=3a_add_PX3?=
 =?UTF-8?Q?0-=c2=b5Q7_=28Ringneck=29_SoM_with_Haikou_baseboard?=
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, dmitry.torokhov@gmail.com,
        klaus.goger@theobroma-systems.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-3-foss+kernel@0leil.net>
 <e481af15-7e37-47dc-b272-6d032b5dd7a7@linaro.org>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <e481af15-7e37-47dc-b272-6d032b5dd7a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e38604-6d26-423b-bb54-08da9d49b98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dryiAxRp02V1tc8/+SmbTv4rae8LVdQ7WciyrZDmekzxptfneCgYuD2xhFwmL2Vwf3lvYgjwz4uxOKiP/tE+V/bxplAgGFbfOXKVLsUrFtA4+vbCPsggGdaf6ed2lkzkvk0i+v9Dm6SCZgGfazXDJp35ayEFCfGzRIsOHa2rkxomS8jetPDdmJ+XlTbURGdfqtQkWfLQ1/mhnmx5A9xfZkzfSJ0xZ0q1bcidax0TsSp/hyZ4LYPAAk/qQX7BgqksZFgWGi3tpHkvsRjTtWRk5squ5h4s/AhhTE2WZPQTrHs4HMo6ARSr9/UrrDiYlRHNBuZeAu8u9R5tPfgCQp3vieKxSESGY952Eare1hhdeLzYvOsjCUxEx7uUxqiAcVAqwuA95Rt26HUhqYG5pmqgu3UQhlbMkCaL5hH6WEYX1CxqyXtlZ2vbwvQO0HOvj9rJocWVmY5Jno6QLVk3MGaBL98+M+KV35P5o5job0Zm7q1FICyhgbNGmmI5Yj39hBbzpnFcKd/viUtm4sbyyyQU/KCPJgXa6/44cvysfHp7KbZW3GGCSmGeLWZlWqmfIzGSjt5t5qZc6uY5fh2NStOaJJ+DbBK78v7h+YREbqMVzZQVnaQ6wRmGTGs3jqhqrjsp3+XUhzfPrQk7BdlkKitsmR1rv/262ti2IPcTtDVhCNioVxJaCNYKfRRcwxlH6hxslIWfQ2eUr7Jmt124t78g40mRxfOQ2UAekcG1hmZfSqUNyMJTKgWOcPKZlpImAllKw9JU2H06Kx4/fO8znYF63HwVYwmydYbBUYwJ1XuaVUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39850400004)(136003)(366004)(376002)(451199015)(8936002)(31686004)(36756003)(31696002)(83380400001)(2616005)(186003)(86362001)(26005)(6512007)(2906002)(53546011)(41300700001)(6666004)(6506007)(38100700002)(44832011)(7416002)(478600001)(5660300002)(110136005)(6486002)(66946007)(4326008)(66476007)(66556008)(224303003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJia2N6bzdUeHJaT0Y0Q0dyczVlV2JyQzFzRnI1OFJNcjZ2amRySWFFNEQr?=
 =?utf-8?B?Y1lMRnY4VnBnK1VNZWdNbTNQQXpTcmYyTEMyMkRwU2JCeUdWeGU3dUNyUERI?=
 =?utf-8?B?MDRNL2hCanh4NHMxcTl3V2cxamorSWhWQjlZSnprZXV4V3dIU252VjBzaUtX?=
 =?utf-8?B?aGZzd1dwVXdka0EwRnM4MUR4L24rM2NzWFdtd3JGZ3F0WVgrV2xHRSsxd1pM?=
 =?utf-8?B?TGE3Nkl2QllwMER0MU10SzhCUFJlZkNzWVl2aEZHNUpaTklINUR3NGowOCsv?=
 =?utf-8?B?M01QSmUzbERZaUQwV2gxNUY0UTJXTTJqV2RsY09ONHY1NTlBaE14S3B4eWY0?=
 =?utf-8?B?ditvWDN6dkovTS9vYUpscHFORVgvK2o0emllUEVJemdzdXJLTTJreUt4VFJF?=
 =?utf-8?B?TTc4UlJOd2cxdy90aEpqSjFJNkl3MUZ4TE0wVVJwc2hCam10RHJHV1ZNQkhD?=
 =?utf-8?B?b3JCbXByOWo0ODAySHcrVVZCQ3drQXNjS0Fuc3E2NXZxVjJMbDFCM05IVjN2?=
 =?utf-8?B?T0ROazhsRWtuQk5CbkJPZDVwN2N4bHVDSCtoTDMzaUthVVV6RDY4ZHFkcm1L?=
 =?utf-8?B?N3RxdnZrNjNkT1RzVlF3d1JrNXJjNVF3WW15andQSU1lYk1ZY2J5NEplZ1Vt?=
 =?utf-8?B?TG5YZUNYb2RKcmNjVEFGc0VHVFB4cVF4bEdMVHNYYjZMYmx0TWlReUVFczY4?=
 =?utf-8?B?dVR2cVJ3VENQaUpOME9NVk1CSk5PQm56d3VRcmNrdWE5WXhJaDhjejdxbFg3?=
 =?utf-8?B?d0FFbG5TVkZVT1dqWitlTy9mL2FJeCtpNmFkc2FFSU9VUkI4elg0T1ZKZ2RU?=
 =?utf-8?B?TGJEaDFNRCtKMGdvK2c1cWpIdHZvNjhkSkJZeXdMNjUwYlY4S1o5SVdVbXVk?=
 =?utf-8?B?VEVrSWh5WUQxQkVnSHZreUdNdW4rMSsvYmx4M2JENVgrUGFoSXA4cFpyTXk5?=
 =?utf-8?B?RkROZ3NIbWdLbVN1dnJTSTVhaFNiMGY1bUlBcUpyQklIbVpSZGt5aHFzcENF?=
 =?utf-8?B?bXVybVhDN05IbmFYZFZ5MnFyUy90aDdjUUwyMzJwTHorNVFweCtSaFo3YWFl?=
 =?utf-8?B?bVRzR0ZMZkVXejRPenhTa0V6bnFrSE1MTXA3dXJNZ0ZIRXdPWWZqQVhKR3pY?=
 =?utf-8?B?TE9HZGNrV1dESmNNQWpxcXM1U1VURzlKRUNUUGJZaWYrRW1nR1ZLSlpveWwz?=
 =?utf-8?B?c1pnR3ByMFJtNEFTNjYrYkc0ZnlEd3VxYVZ5SmxFVzVEQjMxam1mYnFLYWho?=
 =?utf-8?B?dlFBZ3pGNkRqeThQTVFlMk0zY0JVbjFkaHZWelZlVy9MOHcxQzl1b1I4S1JD?=
 =?utf-8?B?emc3bHUzL1MyQTBTWTV0S0F2di9GR1RWLzU4WktWTk9BSFJTdGtUS2lsdXht?=
 =?utf-8?B?RkY4cGFYcytsSmVNbjhvbjFLSjFRMU91b1dUZm5JZkR3cEpsNURoc3djNHVE?=
 =?utf-8?B?eUkxQVFDUDd0WHRtdzJzNENRbTVvUnQyVG4wd3gveUxldTFiSEZoVDZ4T3I3?=
 =?utf-8?B?ZDJvSzM1eUxYTG1vUGtmT1B2RE9OeFdaVnp3ZTJJbzhZUEtMREFJZFlVTXhS?=
 =?utf-8?B?NWNYY1I1ZTZQZEFWaEN4WnM4Z1VkTDMrWUNpaGx5eGNTbmZDUW5heFJzRXVZ?=
 =?utf-8?B?bk5OMWl2MkVqNEJUT2hwcjlLUDQrTWljN2JqSStFZlBwL1JOUEc2TTJOSW1s?=
 =?utf-8?B?TVl4Q0JKZU9OWDE5K09XcmdSdE0rcmJXRHhuNnVyK3Z6TDF3K1pRNDRIRDM2?=
 =?utf-8?B?RDZaajUwUXRUazI4bzQyQ1B4VTlPOXpxQmpITFJ5RGRXQ2lPeWxUNXBhVUh5?=
 =?utf-8?B?MzBaWXoxR2hXU2J0RUxkL081Qko2clpFWThQcVBreW5SZnFZelJnZjM3cUlw?=
 =?utf-8?B?dGlVL3ArY3FjRXd6UGxzZXlKMVBhd1lDclJ2ViszSllVU1drMnZIWXJhUjBI?=
 =?utf-8?B?dHZKSVU1RGxadVhNZlV3ajRhUFJ2QlZaTWRQTTVQei9vM2tnQi9jWUlDTzNa?=
 =?utf-8?B?dUxjdUlkeHFUeEV5aFVIb0M0czJnWkJ0aVB4ZEhPU3RjS0JCQjhQUHBkNFBF?=
 =?utf-8?B?NnBWQ2djYmVrTjFaNHhpc0RtdU51eCtGZFVHWEhYOWJmazFld1p4S0tKakF1?=
 =?utf-8?B?TWtudWY1QXF3UGxqZEJFbGZnVzBXREVZZVkwVUlueDZnUFJEeFFQaFE4bjd6?=
 =?utf-8?Q?gFp1ogtf1u+WAfhLGFlVQ4o=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e38604-6d26-423b-bb54-08da9d49b98b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 09:55:20.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d5jnLU5VTtM/YhhXcqzhb4z3+BDbQT82M6mkekJeHNDRt82LA89kgsBECDHCivuGGfj5oyk0OwcD7iVpj65lOJu1OdvU6DuxyY7ILqYA5nTGI/bVX1p0nAcyvTNWgLP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9278
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 9/22/22 14:45, Krzysztof Kozlowski wrote:
> On 22/09/2022 12:12, Quentin Schulz wrote:
[...]
>> diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
>> new file mode 100644
>> index 000000000000..74a7f1182c21
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
>> @@ -0,0 +1,347 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
>> + */
>> +
>> +/dts-v1/;
>> +#include "px30.dtsi"
>> +
>> +/ {
>> +	aliases {
>> +		mmc0 = &emmc;
>> +		mmc1 = &sdio;
>> +		rtc0 = &rtc_twi;
>> +		rtc1 = &rk809;
>> +	};
>> +
>> +	emmc_pwrseq: emmc-pwrseq {
>> +		compatible = "mmc-pwrseq-emmc";
>> +		pinctrl-0 = <&emmc_reset>;
>> +		pinctrl-names = "default";
>> +		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
> 
> This belongs to DTSI.
> 

It is in the DTSI :)

>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&module_led_pin>;
>> +		status = "okay";
> 
> No need.
> 
>> +
>> +		module_led: led-0 {
> 
> Why DTSI - which in logic comes first - starts with 1 and this is 0?\
> 

The first diff in this patch is for the DTS, this is now the DTSI. So it 
does have led-0 in the DTSI and led-1 in the DTS which I think is what 
you're requesting here? Is this a correct assumption?

Ack for all other review comments, thanks!

Cheers,
Quentin
