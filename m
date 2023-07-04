Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003317467A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGDCoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGDCoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:44:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA96B6;
        Mon,  3 Jul 2023 19:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz15JxpBRH3jqhKlpTCHWxttEiuaAi1oFeE8qmt8bMg431/Dz9UdXon/xIUaAQ9IMKAmECDfOq3MXC/juCQzUQr2ETB4Lfk7y/fxjX1MyifWVVXVcv/gcCyode27tbFSzr54ly7iv6O+jxOxRY7Ba7L6DR0zoMv5uwFYcnuMZ8TiH2Wye8VbuKcIceMsfoWz3TzRaDpl44+mDpwbACdkPyd4eNXDGJFHsLQs+uPusqWHbUBdXeu4qtGvy6a5LuhC3BH9Vy+HPOtH7q3CWQ0UOqO77c/hCimvx6oWM2rsnKfGjolGKfnAdAou2Q43NuwjsYbXIeTYkYJIiYnofKz0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dwq//OI2qptA/SLfIKB+4nBglGsoufKoXiGVFZ5U6XQ=;
 b=JDdVaCUp+L6yKsX8lGaN3PqVCWC+xQsv2T9hMU+odsvlT6Z0/csCZUCRWbEhybh+2rcnWe0HoPD7/ao4SveddR7KnkmsFA6riBBP1NuGUq+Td6Q7eKMOopSU2xUl3tsVDXS5qHyg7vn/FTtqdQcx94hEag8+cPLUpOCW0Ut8j9EGAHE2NjAtmY7MQRls2DsAnNkfMt4schE3nv01NjRrTzqcKPYZXtugC4f8469LM/8Q6GXIYJFP00ElHgZw4MC9Ilgn/rOY7oUJuKso/8L9Pqew7BhABwUEp2I+nr2uKXEisH+5Lvdxceee1X+lH6HU6rA+y3XQLNUmMk2DJFo16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwq//OI2qptA/SLfIKB+4nBglGsoufKoXiGVFZ5U6XQ=;
 b=gbZbRDV9JSjYS2MllF21TN3r1KT/YSTFdk2INLxLGZkBNq0P1tBzxcI3/KDBQ0f+c/ZzjgK6s3msPWC2AJ3zG+Xqdls6HWhovJkq7KM2PmIErH2hwvftmswWXAor1hZsVJ9dAfIe/ydPUlL63Efi3oOpf6YXe35oHKof97VZUBSieN3zOoZVxdyVehgxoxyfp3d/alVvgW6gqwxg9mNLL/KpmTofWkTmDsXYMyHRVkIKt76fYO9bKl/3M7tUB+0uMewqCkKGwhBTxo4+D9al2K42rJ2ZMQ5QXwCe3f0e1sB09xXthO7lnbYr8kHqg7fYz0n0yBAAQ96oiTRnyidSyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI2PR03MB6711.apcprd03.prod.outlook.com (2603:1096:4:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:43:11 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:43:11 +0000
Message-ID: <81682c16-916f-c80d-5ffb-b80b4685b673@amlogic.com>
Date:   Tue, 4 Jul 2023 10:43:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] soc: c3: Add support for power domains controller
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
 <20230703093142.2028500-3-xianwei.zhao@amlogic.com>
 <e85f6dee-d62c-9f2f-b1de-8c38bb5aeb14@linaro.org>
 <20230703193736.7teaaovalia3g3ml@CAB-WSD-L081021>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20230703193736.7teaaovalia3g3ml@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI2PR03MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b8e4a2-ef96-45db-5e0a-08db7c3867c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXn+wUVudmeeLP4g1LcdHIIJSHM26Dn3E0hu65Vp9+k7vF7+URHWKyKKv+aUNiEtFAwKiYvf4lyhZICWX2NWpC080ZH9WBI0g3RGCxEXRKBmVYB25RsJ+7Zp7hULOBfMTbbDYAnN2cWM5hJ47m+1iQsE0EEw2rYDWEGpTbr3A6jYnKeqflddMPiPKOVvuiwF9D8xWFf3dm/mQ2xO/9mO8+LBJjRvau0ME4jJPUe3rkzB7I84gATUImrY8F8ZquoOGKC0PTgRUQq9pnaLeVBw/7I5EftcXFgcoSfrbVDP/+jpnIlkv4iuM6NXF0gqK9hnuTOStMztEDtydMRi/rzrU1XTCyRFN0xGzgITaU/XntCNtqLxKfXhfwxug0irxFt7Hv3g03EzmzNmeWtKhkotbbYaDkwDDCiYTo5eO8Fc6Ao0l/8oOIf2rnfnL9IEcdFLIxvlDxjitvZiVWS/C3wu7tkHbuiatiwv/1NNOkJX8l8IKx5BlB8byfDVv6XwJYG8ipu8PdkYVcbkuKSIs+HQde3vWiDhQoAZ02yGbMskXAgLxdqmnariLItQ0UdIaR6uuzoTzuu7ojn+YdZf4zoSuNkyCrKN/z4Z4sbnK1xC7weLzRcWnz7H93nZR9qPOff2B2dQMnIwsyXtD6WFnLioDu6yM30wJVRpQMTbdynFLufzBQNHcfR9uAmT31bhF7ZnUZGW3reQAIDr0zSqBvPqyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39850400004)(346002)(451199021)(6506007)(53546011)(6512007)(316002)(38100700002)(66556008)(4326008)(66476007)(66946007)(2616005)(83380400001)(186003)(26005)(478600001)(54906003)(110136005)(2906002)(31686004)(8676002)(8936002)(44832011)(36756003)(31696002)(5660300002)(7416002)(86362001)(6486002)(41300700001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHk5QjFralgwUVFsRzNta3lveVRobG0vdVVXWU1NaStNUitsVUlwVm1rSHl3?=
 =?utf-8?B?eGx5MWRobnZ4cnpNTHZHQzRkQ0VwVWZmTzdTUldldlZLQ3VkRTdnYkhyM0hG?=
 =?utf-8?B?dmNIUmozRmpJRFZHTFlYQjB5L3Q5dE1HUkFzby9QT0RBamlROUFwSW96Nk00?=
 =?utf-8?B?Q0lpKy9XcFZvQ2dqS21zeGg4TlRxRUpQaTRRVzlRYlBxbm52V01jalVPRUI0?=
 =?utf-8?B?WDVxbGtQcmFXN2hCUFJ5OGkvdlpMVGJZSUdNUWhzTE5oSFdxL2lvT1krcWxJ?=
 =?utf-8?B?RWFhbzF5bWg1clVFTzlsNjMzUzB6V3BkM28xQU9lSzNtZk9JcS9CSDhmenJO?=
 =?utf-8?B?cmVQSi8rL0xMQk1uaUtHTjNBeThYTjRqa25OWXJac0dWS29mem53LzJHVmN1?=
 =?utf-8?B?YVRVOGU5akljV3ErVElOVlhkeFpud2UxN3liU0R3cDZ4WG1aVytHeU5YQkRO?=
 =?utf-8?B?VmY5OWE1UENJVGJPLzhQN3dtRUtYdFZTTW9xNnRLUERNanB5ZWRDcGFBNDJh?=
 =?utf-8?B?NC9JVW1Sak1JN210TTBoblJUUHNSM2NtQTV4bHk5L3hsblZwL3hTL0VqMEZs?=
 =?utf-8?B?cnhyN2ZoWHVJdit2eWdLaXlzTEMzVTFkY1dLOVQ1NXJveEJvaXljNUhDcWtI?=
 =?utf-8?B?b0VIa3R4a015REo3TGZ4cnRlanhSa2pLMlQxNmdLNkhOQndwZ2RNd3dCTExQ?=
 =?utf-8?B?R2sxV1dMZWpsVHJXeTRheWpGbm53STQ2dThUMEZnNXB1aXJtTDRzNm5hZlk0?=
 =?utf-8?B?eWhEK2tidWxSaE4vcHNUbUtOZVErNTJpOXErVEplZlNVVTgxajFidjQ2L0NQ?=
 =?utf-8?B?NGozVm5Hb1FuaE14elBOcW5ieGIwS1RwVjlGNGs5S2NtOEdSdFcxNGdQQVNR?=
 =?utf-8?B?VWlSalBneHlIYzdvWTFOamZwQlgwd3I1NTBFWkFFQzhlc0liQnZaMFFGVmc0?=
 =?utf-8?B?eGFLK1VrcllpS3V1RmtiNkNNbzA3TDVIaFpHSm5RcXQ3TmxFNmR3WDBFd2VB?=
 =?utf-8?B?bldzNEdzeUNWa0pPejZwMVNmR0U0TW13OUUwb1dIOUNTTm42eGxUR3NGZWNJ?=
 =?utf-8?B?b2dzaS82N3BnUG9vMnhiL3VOWEEyUGJhQ1lHMm5ZQVJUNFZDS0cvQ29UMVF2?=
 =?utf-8?B?cUFsdE5ra0xXWk1wWmNTTWFXY3RwZ0lUR2dhems4akszV1pFb2EyK29iR0lT?=
 =?utf-8?B?Q0ZGRUlmMnZHalVrUU03VG8xbGxxc24wMGF6OW9PNFlkc254WkljemxvdVVJ?=
 =?utf-8?B?YytidE9adkZ5WEFEVHpHMCtzb0lET29heHQwVm54YjBwOHJLTHNJdEtPZUNY?=
 =?utf-8?B?UGpTS1JFVTBmYStqUEprd0ZHdmppd1Rzdy9GelhkU2hvYjR5NHlncGIwTm50?=
 =?utf-8?B?aDRzc21tMUpRZCtmNlMwSHpuWWRodVpnSmZIR1hBTFB1L1ZSZngyOXREK1Vx?=
 =?utf-8?B?NXVIZURkd0hnV0hQOStiQU5LYlFjbU02U25YRHBqd24zYmxwUnY1bW1lMzRI?=
 =?utf-8?B?T2NjT3NLUWJhZm5sdUdOVDg2dmhEZnNRY0x4MXg0dTBCQXowejYvdFRLbExG?=
 =?utf-8?B?R1BaN3FFM1dtdHNSdktmN0t1NG4xYVdWTHlTbEF0YldJOG0vY0gwUzRWQ2JJ?=
 =?utf-8?B?cjBZSkN5S1pGZndtMXlsZndidzMyTHRESmM2SXV3c3pkWnMrdEVmWnRCUmxO?=
 =?utf-8?B?SnBDeGFHMTdxdHRhbmlsYndkOHYyUTJmSU5oYzBjRWI4OTVlQkRRMmtNQ2lB?=
 =?utf-8?B?NERiQjhUOW9IcUxNT1FyK2RHNnp3MElEeDBONStKWWZMYmFhNDFYV3dFTFhJ?=
 =?utf-8?B?VHZhZWJvVGl2bXQ3bXNIaTFoSk5vMGM5Szd3NzBEMDQwKzRhaC9iS0ZLcHVC?=
 =?utf-8?B?TXlWNStVY1p4M0Q1bCtsbW5KczNodDhsWHBPNTdNWHhpQmxPeEUvdWRCdW9Q?=
 =?utf-8?B?OW1FdVFMQ2d3N0c3VysvUHJOdXZNdzc0KzdSNmFwU09GN3l0alcveHM1aXdS?=
 =?utf-8?B?cFl4cjlVZ0c1SmZnZTdod1hUWHVJMERkMFJZNVpuVVJqdWZyT1o1UXJPV3Nl?=
 =?utf-8?B?ZGl2ODl1SzBwTzVyZnBvaGlRMko5MzhvUFNacmYrejdOaVlWenQzVnA1M25L?=
 =?utf-8?B?aXdGeDlFbTh2SlB4L0poV1kyZGJucFJwR2pBYlNRTDNLdVhFd2kwNllQRVZx?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b8e4a2-ef96-45db-5e0a-08db7c3867c9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:43:10.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nU4RA2nFKjhsy7XsWQpTshvDG3iHE7tJEPsF0bJGh3hYH8VeGcJDqGt7tj52LUOWFt+tkifGhZix+YLgX/uvJr0HVqjdKGECCnuj/S4qpjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6711
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,
    Thanks for your advise.

On 2023/7/4 03:37, Dmitry Rokosov wrote:
> [ EXTERNAL EMAIL ]
> 
> On Mon, Jul 03, 2023 at 03:29:31PM +0200, Neil Armstrong wrote:
>> Hi,
>>
>> On 03/07/2023 11:31, =Xianwei Zhao wrote:
>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>
>>> Add support for C3 Power controller. C3 power control
>>> registers are in secure domain, and should be accessed by SMC.
>>>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>>    drivers/soc/amlogic/meson-secure-pwrc.c | 28 ++++++++++++++++++++++++-
>>>    1 file changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
>>> index 25b4b71df9b8..39ccc8f2e630 100644
>>> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
>>> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
>>> @@ -12,6 +12,7 @@
>>>    #include <linux/pm_domain.h>
>>>    #include <dt-bindings/power/meson-a1-power.h>
>>>    #include <dt-bindings/power/meson-s4-power.h>
>>> +#include <dt-bindings/power/amlogic-c3-power.h>
>>>    #include <linux/arm-smccc.h>
>>>    #include <linux/firmware/meson/meson_sm.h>
>>>    #include <linux/module.h>
>>> @@ -132,6 +133,22 @@ static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
>>>      SEC_PD(S4_AUDIO,        0),
>>>    };
>>> +static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>>> +   SEC_PD(C3_NNA,  0),
>>> +   SEC_PD(C3_AUDIO,        GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_SDIOA,        GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_EMMC, GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_USB_COMB, GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_SDCARD,       GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_ETH,  GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_GE2D, GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_CVE,  GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_GDC_WRAP,     GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_ISP_TOP,              GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_MIPI_ISP_WRAP, GENPD_FLAG_ALWAYS_ON),
>>> +   SEC_PD(C3_VCODEC,       0),
>>> +};
>>
>> Please move this struct before _s4_
>>
>>> +
>>>    static int meson_secure_pwrc_probe(struct platform_device *pdev)
>>>    {
>>>      int i;
>>> @@ -179,7 +196,7 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
>>>      for (i = 0 ; i < match->count ; ++i) {
>>>              struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
>>> -           if (!match->domains[i].index)
>>> +           if (!match->domains[i].name)
>>
>> Is this change necessary ? If yes please move it to another patch
>> and explain it's purpose. If it fixes something, add a Fixes tag so
>> it can be backported.
>>
>> Thanks,
>> Neil
>>
> 
> I suppose, this change fixes the situation with SEC_PD(C3_NNA, 0)
> domain, because it has index == 0.
That's true.
> May be it's better to introduce the separate struct member for that? For
> example, 'present' (true or false).
> I think code would be more readable and clean.
> > [...]
> 
> --
> Thank you,
> Dmitry
