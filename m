Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F8746763
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGDCVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGDCVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:21:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E2E59;
        Mon,  3 Jul 2023 19:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXFPdcgCP/H0yertXt08NxQKhyfQfMEZiS4PXzu5CBmu6rCrjKeuzjNIwNP7GP7S/UK0/puUNITXZ21/l01QBUE8zg6o3UjrHSb88ozftwFNlzINnoQddgZKiKA2CMvFHTzhaSd5AkMT0EONA5NgNHHgx8OuLcjcQNqjpJwRJ3bI/YZtHlb+mNWFUjvyKPMEYDKr8GH3Gv7lKKdjm8bqbe0MaMGktLjfmrGRq3CVHZ71E/AHSkFI70/k0rGudQqCb7Eih9m6sqCpZVQU7VN9iX9miTol5wEV8cA5/Su4Qtau55ofpC1YPK4B8Hukls9GX8uic9xfo3xp0GhN7OY7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTzXajv6NkdlGJahEkyxO7sJ2tUdORVWX1htD7GtWpo=;
 b=epG5RdcEdp61sPMP5PXwyZaSih5lXATAfP0qKqfyJTcEx8QR0ysozW1g3WA9UOVjmtwcra9b1meQbgvELqDdIfeI3pT9D7W3EF3uBGHLt4c9u7gbpEk26DPih0W3UfMFHjAdSvJ8z3hckFxS4aoqpAcn2d37PBRFsCRTPflVl5J9cJ5LfKvWD31sGGo14FDlQ8/enTnfo/XBhPV+X1FXq3q69Jfhy+oNRForP9U1OTKCL37fS+ZjdA11uINzM02rj2XA2cTgkZRpK3fNBYWiJkgLzw7ydiy3QarXICboVCfwHGg6768KWpki0ujd4Q6nhJRzIEcBhftO7ogWQhVUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTzXajv6NkdlGJahEkyxO7sJ2tUdORVWX1htD7GtWpo=;
 b=G0/6gwoZy8jgf32R3xDjRmiP/CWo57wcLcvDrj045hayUgO4WWbxkMTWn9twNH+L5xT9TjTEOeZGi+WLpx9Z+QjrbS7Y79NNjvR16JDuUeBiQVZ5UEGZ3qFwIziLhFUP2NnOEWRLym9ikgsBUxlnnmk/V8sILDyXv4R1sQALhuhTFA6u8r2g/cfMt09lkOhXxqikRlLL6kWYSYIA1vdY9FZvsLU3pbbmY8MJBNR8/EoNlMGWUW+ABOP+h/5zqKZPHmy8C/fck/ONPgYoAFj06wC9pFg9+yJM9kY7Jt7iwuNymwhtlxRGztKewDA8pWEhhhoSmteaHFQJmCO2vcw/gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB7757.apcprd03.prod.outlook.com (2603:1096:101:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:20:57 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:20:57 +0000
Message-ID: <37fe4ab3-323d-f025-5168-352b054faf8b@amlogic.com>
Date:   Tue, 4 Jul 2023 10:20:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] soc: c3: Add support for power domains controller
Content-Language: en-US
To:     neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
 <20230703093142.2028500-3-xianwei.zhao@amlogic.com>
 <e85f6dee-d62c-9f2f-b1de-8c38bb5aeb14@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <e85f6dee-d62c-9f2f-b1de-8c38bb5aeb14@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e92b1a3-9c73-4bcd-0716-08db7c354d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDO7DWjmRgayUAmlcgdBB5F806vqkuc+op7ELnhqLOqMYucswIztk6B1dpkm0r9OPPKu0p0j4NX19BpW+ee83mmjxkNUV0K8KZhmd54hBrE6jHSms6eaDC26JVFy6QUlkFs4RfFBG8yvdess3XA/zv6cO9wh5hcLIiC8j/gExbpo7qyxRWe6xNfQxZYHZ8H/7R5Ulg0djJMRUy+Pb9Cu/YJjv1PN5obAmELE9grXSdeV4bfC7DiB1CrGWjt64wVGx/8xY6BR0CGCuOlaMRJB2PbqSBOwAW8dXQQHXXSUSWdx2VuqYS5wyJgUwD4VzW2eH/tZLuXid9lyZQXCVYXcF/1/AyWqmSR2k9HpLdSjbe1VfiLu+poMzVGH+HN4zeuaW6ZO2Mt2MdwQo8a6dnTDsTulI9Txs8Ek4j8ALkhvhiZ5r7niGxam2hNpYECV1YX/DT4JQ2ShFh4lkUdK7dKBj7tuFpPOYD23Pa5yT1cLNAfIY9WEjExsMYVraoKJnKyf8wc0eMXGkSHHVp9VlvqfBxWyjuMC5YlXLQ89B3fHIh580iYjqazjiO765QncpAGJq0UvI9VYlc/kZvhe3qvP0VLp2IKq4KsbjV6pHyVGzAVijtDQYblb19Jzs4vuO1dD2xX/tbvnT9tQlZf2Vc2mLCb1eEFYx40N6HJIWjp2OYDGi127DGoxHk70dVsGpUDtd9KvOeMaRh2SMkNIHuS7OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(396003)(376002)(136003)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(36756003)(86362001)(31696002)(186003)(2616005)(478600001)(26005)(6512007)(6506007)(6666004)(31686004)(53546011)(6486002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNFZ2tpNHkzYkx5V2IvMS9Edk52SGRRVXJzUUhndGVDbThhVlNKdDBiMkF0?=
 =?utf-8?B?ZDJyNDdJSjRadXlyLzh3eG10RkdQNkh6aTIyMmV6QUxYQUFZWldYT0VEMHEx?=
 =?utf-8?B?a2JLdU05RmRDa25McUtkVUxjRy9YdmZuMEJLS1QrMTlwUjBBdmNRWC81cURM?=
 =?utf-8?B?TFdIWUNZTXhWMWVIODZhelVsUnFaQ0Y5UmdYVEc1QnBnWEwzTjJpam9HM1NR?=
 =?utf-8?B?dFdBS29DT3BEMzFTYm9rQzhvdEJXWTF3SDBCSncrbXh2bVdET2VOV0theElm?=
 =?utf-8?B?MldWRUFPZ1VUSmt1cWtSY3h3d1ZVblVLdkhwUFBTTUxvT0tCK3BVNHhMOXBj?=
 =?utf-8?B?Vys3a3FtOHRveEZJTjNvMStSbURxYVVEMG0wRXFnTTRPRVZMQ0RteWVvSnhl?=
 =?utf-8?B?aWRIWVFid2g1eFhrMHZIOFMzNE04Y2pqOUJ3L2h2M2x6YWpqQ20weVQxN1JT?=
 =?utf-8?B?UXlXaklwc3BrM0ZjK096c3VnQTJFbTUrZDNGaXBVb1pndURFd3JDU1pjUFYy?=
 =?utf-8?B?MTEycWFoWWV6YUwzMWNFeEtPanFWS2hnUUlhRGtkNXJzL3FLZnE1NU5aU3ds?=
 =?utf-8?B?bzhCUVVSdW9EM3U1TDEzQzBWd3kwWXJzc2FoV3d1T0NIblN3YkdJbHlXVUxD?=
 =?utf-8?B?S0tROGZ4S0hLcC9oMHBKbjNsSG9uNVVGSm1lQjl3d3lpakV4MnlTM3p4U010?=
 =?utf-8?B?QkdIUnFwT0ZvQTBGV0pjbWtGSHkwODZrVnJUVzEyL1pOUjJJZXlSQ1JEcy9v?=
 =?utf-8?B?UmlkTnlmRnl1YjBGR0I4MDhSZld1akxVaUxJZWNhQ3A1ODkzay9tRlRQNGNi?=
 =?utf-8?B?UTRRUDh0WFY5NUNZdHNqUCtYOS8rRnlzSzlyemNvc3NIZDRrUkx1OXgwRW9L?=
 =?utf-8?B?T0tCNERlaU1zQVNvM25ZditjdmZjY3ZEc1JKZUVTby92dEk1OExSOEl1THRL?=
 =?utf-8?B?UDZVZVJuSm53ZFRRRGJDYlREMDQ5V3VMc2kxMG9VU0xrVXBkRzk4S1JyZ3BD?=
 =?utf-8?B?M1BVcUloN3E1VjlQQUFGRDBERW5SdDVNZkd1dlNGZzdVYS9rVVVORVM2cXE4?=
 =?utf-8?B?Snc3b2F1ODB2bmU4Q1h5Y3ZOODkzRnRSYVg2UDgyemJyMk0vZUc3TDV6WFhF?=
 =?utf-8?B?Z3k4N2MxZ0pqZkdieHpGelBCejNLWlRLK2txZjExVUVEeEFQV09iQ1dwbnpK?=
 =?utf-8?B?SkJlbm0rQ2JlQ2NrZzBQL3NqQ1Zrb2RvUUZqSjZiYTYzd21qSVU4NHVqYTlS?=
 =?utf-8?B?b1ViNFRPSnlGV1paOTcraWt0Q0pCYWEvS1dTYml6dVhUVWxzZWh3eDdJNnNt?=
 =?utf-8?B?NFNHT01JZ2FtQnZjREgweHIvbEhPMlRaQWFiY2t6QTBPbEllRm9IM1RLNEh3?=
 =?utf-8?B?UWFMZ3FxRkJycDhtRDUzcmErRld6SGJtOGpoeHJUNm1CK3k4dmR5VUJ1eHNB?=
 =?utf-8?B?cjE3MmxpUGFhOHJ3eC9oRjVXNEdtY1lBK05QNThrdUxhVG8xQzdSOFBJZm53?=
 =?utf-8?B?cm5WZEpwS0JncThDb29KT3pMZzRLZjdPYkl1RThINlEzZDBuMlNSVGJnSXpl?=
 =?utf-8?B?dGYyVG5uQ1IrNGhkSFhrZjk1U1lyc01KWUpBU2VBUGRqcmtDYm1IbGowZ21V?=
 =?utf-8?B?dU1qdFRFVzFiUmhrSU9zZWxVOTN3RnlHc0dYMmhPMElHaERSRzJpdmF2S1lU?=
 =?utf-8?B?MXliejVXQ2R3UjFIbE5zZWhUN1VzanhLQXNML1c4d0x1THZuYVJuTm1FWFRQ?=
 =?utf-8?B?ZHZiRWpSbXk2NDIwYndSMExwRmM3bjJUa0JuWWVJa0dTTjkzZUoyYzZXTGIy?=
 =?utf-8?B?eG84Mit2dTNGRWRGcXV0bFRPNkJSajg1OFJOYmlxSE5HYWVyM1lOckdvODBU?=
 =?utf-8?B?eW84NHBDdTZLZHd1TUU5azYwUU1BamtZc0Jla2k0S2wwM3hKSkladFFnUmNx?=
 =?utf-8?B?ZFlwQkZwSVhiYWtHd0VVanM3dzFxV2p1UFBYMzNodXVSRFRrRWJwZTAyTjRJ?=
 =?utf-8?B?MVZQYmxibDA1OUgyeVI5c2dYRGZ3b00xcVhXYXFXUmNVYXV5Um1OMWd3QjBl?=
 =?utf-8?B?YTFUK3c5R1VuZDh1cXlkQUxvV3J6bUhOZms2cnYyL2R5bldFNFhrME5xSlIv?=
 =?utf-8?B?aEtMNTN3d3pVMUlLM2FWZ1ZLZHVmVjBMYUQxOUFwRGVxNWE1QnlqLzZzZW5C?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e92b1a3-9c73-4bcd-0716-08db7c354d26
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:20:57.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5+bUkyL0W2JwPjqJ95A/txQ9qdxlFPB8wPdwIMyMr745sc+U6oiw33Xze/gCE40Gh0Av0gbyUO5TKQv0ntupNtHLJJD/PxfnmujHM7bPMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7757
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
     Thanks for your reply.

On 2023/7/3 21:29, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 03/07/2023 11:31, =Xianwei Zhao wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add support for C3 Power controller. C3 power control
>> registers are in secure domain, and should be accessed by SMC.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/soc/amlogic/meson-secure-pwrc.c | 28 ++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c 
>> b/drivers/soc/amlogic/meson-secure-pwrc.c
>> index 25b4b71df9b8..39ccc8f2e630 100644
>> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
>> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/pm_domain.h>
>>   #include <dt-bindings/power/meson-a1-power.h>
>>   #include <dt-bindings/power/meson-s4-power.h>
>> +#include <dt-bindings/power/amlogic-c3-power.h>
>>   #include <linux/arm-smccc.h>
>>   #include <linux/firmware/meson/meson_sm.h>
>>   #include <linux/module.h>
>> @@ -132,6 +133,22 @@ static struct meson_secure_pwrc_domain_desc 
>> s4_pwrc_domains[] = {
>>       SEC_PD(S4_AUDIO,        0),
>>   };
>>
>> +static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>> +     SEC_PD(C3_NNA,  0),
>> +     SEC_PD(C3_AUDIO,        GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_SDIOA,        GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_EMMC, GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_USB_COMB, GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_SDCARD,       GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_ETH,  GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_GE2D, GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_CVE,  GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_GDC_WRAP,     GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_ISP_TOP,              GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_MIPI_ISP_WRAP, GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_VCODEC,       0),
>> +};
> 
> Please move this struct before _s4_
> 
Will do.
>> +
>>   static int meson_secure_pwrc_probe(struct platform_device *pdev)
>>   {
>>       int i;
>> @@ -179,7 +196,7 @@ static int meson_secure_pwrc_probe(struct 
>> platform_device *pdev)
>>       for (i = 0 ; i < match->count ; ++i) {
>>               struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
>>
>> -             if (!match->domains[i].index)
>> +             if (!match->domains[i].name)
> 
> Is this change necessary ? If yes please move it to another patch
> and explain it's purpose. If it fixes something, add a Fixes tag so
> it can be backported.
> 
This variable for C3 could be equal to zero. I will move it to another 
patch.
> Thanks,
> Neil
> 
>>                       continue;
>>
>>               dom->pwrc = pwrc;
>> @@ -207,6 +224,11 @@ static struct meson_secure_pwrc_domain_data 
>> meson_secure_s4_pwrc_data = {
>>       .count = ARRAY_SIZE(s4_pwrc_domains),
>>   };
>>
>> +static struct meson_secure_pwrc_domain_data 
>> amlogic_secure_c3_pwrc_data = {
>> +     .domains = c3_pwrc_domains,
>> +     .count = ARRAY_SIZE(c3_pwrc_domains),
>> +};
> 
> Please move this struct before _s4_
> 
>> +
>>   static const struct of_device_id meson_secure_pwrc_match_table[] = {
>>       {
>>               .compatible = "amlogic,meson-a1-pwrc",
>> @@ -216,6 +238,10 @@ static const struct of_device_id 
>> meson_secure_pwrc_match_table[] = {
>>               .compatible = "amlogic,meson-s4-pwrc",
>>               .data = &meson_secure_s4_pwrc_data,
>>       },
>> +     {
>> +             .compatible = "amlogic,c3-pwrc",
>> +             .data = &amlogic_secure_c3_pwrc_data,
>> +     },
> 
> Please move this entry before _s4_Will do.
> 
>>       { /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_secure_pwrc_match_table);
> 
> Thanks,
> Neil
> 
