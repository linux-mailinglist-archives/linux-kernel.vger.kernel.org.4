Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2592474D4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjGJLaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJLa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:30:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D189B;
        Mon, 10 Jul 2023 04:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGgnAUSfKL3gXMl9DylD6OrZfSbzrVHtElGVV3mIkembb9AOU64a/z01Cs216yvVxKZmpLHpAhnb1is9tBK/C96NF91gGEL4SHIExn5v/BTq2nGcsgNr8Ws0+VbzWStd3xL/9CrvuCrg6PgzICgb/zFNKBTr9W9Zx0iFL5JsRxyKSb92IPa1wtzUb8ZhcW96/s5Xx2Rb9EVMeKTEVa2X1xArm7G0eeCmtNsgzLk2LAwJ9Cu5JUfja9Gwp0RYdCA39EJQXn3j8zJpYo9GqwThwArJrTJS9qIWC52vanZnnLylzf57Jv4JnIl0vCzuRlEb3OhYdLh1BuWi5Wzn34U/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb773PQz5ok/pfsjykFWWssWfFMIXAwm0FzjGuStIOU=;
 b=Icc0PvuygtkDrTw8ScneRRgszYGtochk1MsYSqg1u98CRGy7CLQvql4SgH3N+Ov3nvko7aIEhCBshzOjG1KQ4KQ9lM95JDbNo/hMbX91N1HtNISpsOnp66MFQ5ol4NlFxSkWtnIqOUD7uItMZCWzYUTWEmntS88YriW1H5yUy9tq6Oqag1aJu6K4t3myVbqueIu+mDQrqLCH6wO8Tzrf5iARAhspGcz16pBeer6OHuvE8Wsrm66WB4qfe01ymC4XKP+BThLAWkGzZQL85hBStHye8febkmD65oslgT1rRKN4YsPblIBEA6ZvFcHgE4PCZMf54kmZRhu9m/5HP7+4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb773PQz5ok/pfsjykFWWssWfFMIXAwm0FzjGuStIOU=;
 b=mj5rcplaivdelHfaJig0au6YkBVWCcK12TFH/U56iF4fLlmoZUowdXG/jyFFpD/CrY3uI717vLZaG2lbQE8sn2cNNJt1dIpdkDYH/W7TVnnXcdNk6jkeU0yh/z66F+9ZgYVEJI+aTbEvMPND+JyWZNtAbck6S/FIOYm0dbKOAvClReFjJIkuBanBw9bJS0HcFg+E/+ry33I0BcJ85XUqDAcNkZGLytWUzR4LIniy4C+3XdezgR7wOWGgSqx6tVTHkN1++AwSteO8gPPU/8jwNhc1HYBnW7EVwacj/FFoLC7ZrefK4EULASGee3kpLoOcnf1pwuSAeYAHK9Fd0ZVRxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6242.apcprd06.prod.outlook.com (2603:1096:400:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 11:30:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 11:30:20 +0000
Message-ID: <57b97b0a-6570-5085-dbac-a08089791876@vivo.com>
Date:   Mon, 10 Jul 2023 19:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 06/21] thermal/drivers/db8500: convert to use
 devm_request*_irq_probe()
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230710095926.15614-1-frank.li@vivo.com>
 <20230710095926.15614-6-frank.li@vivo.com>
 <c628dff0-bb0c-f78d-7302-599c5329c977@linaro.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <c628dff0-bb0c-f78d-7302-599c5329c977@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 964fed59-f7bb-426d-13df-08db81390b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIiZBHSg6sd/0PymZLpD+havDLogYYMMwkd1gRSsqclfC7HbqWVK/aDErC6QVEmvJxH0F8xq2BC/btQE5BjVDINwGrzHrJ2M0hpwa3VK1rSKW0YS2J2Xi8ITUfACPMwx2xXO1zlp4JsWo9NHDn6JrDzpxSyLjepp8tteCTMdTnh0tQlFIui1jepUYd6oC1qzawBzQtMQzTVa6O5hDsLgw01YNs7zXxr9FmK0PWalmhxaD5MLIm6ASP0q9NRK14oGF3b7eJF0Wm3Jdgm+V7JfFleEDJgMljyLwYZhFqPLIVM510XLpB6cuL3yg4khW2G3T8qLgKKEKIIZlj/SZhftnLZqWXfaki3LwQngt7E3R4nwgbPnC5A4fG7Q2h4JCEd4ePMbnB5tVe8KY5cGsoSBYc/QTeb3UjwrNVnb22vMji9Df8ZkI+m4goEwxbet884B08mremXKUOhlW8qhSg8+VYsteP/mIFyX6z2n2TqVftAulYw5gnnjo9L1sjNS4g58UdHDX3V7uxEF3gG/Josp9r/MoG7mI53Rz+jSJkU4rcJ6jrV1nxQKKpJ2srunFzbEpvoMFjsWnhEgvbT56fh1uzwivoziOapKfRAwJ2QydEheygdWAgfR1hWODLAstcUSZZ5J8BRwrhpWdTUqp3tg9V7rzLZGRgxk7WBbrw2ERO18UfteyasSht+FzCmtP59V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(41300700001)(5660300002)(7416002)(31686004)(54906003)(110136005)(316002)(2906002)(8676002)(8936002)(6512007)(6486002)(4326008)(66556008)(66476007)(66946007)(6666004)(52116002)(66574015)(36756003)(478600001)(186003)(86362001)(31696002)(38100700002)(38350700002)(2616005)(83380400001)(53546011)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGtQYjdnUEZ3RVF3MmRuSlJCOFQ4cmZHZHFUT0lHMU5jM2psQXlia3NWek50?=
 =?utf-8?B?L29rTUprTDJqODBHZ2plNm0rS2hzWnlaUC82OGM0YnYwc2M0NW9sT09SRWhT?=
 =?utf-8?B?QjVIOStHTmRVb3ZuVmQyOXc5QkpOa1hwdXovR3VQclVGQ3I1aWVYbUNtTWRq?=
 =?utf-8?B?OXJWMkZBN0VYRXZRaVcveDVLc2lvc3loQlovbnlBQVI4c295MElIRCtpSnBn?=
 =?utf-8?B?OEt5bDVlakF0WkhOODJRR3h2dDJweVh4NFJSd2g1K1ZqT0duWGV6NnlSU0o0?=
 =?utf-8?B?NmdKTUt2OUdtOUVHdDFISTF3MzUxVjB5YVpYbE5oUmZHdDF3V1ZHTFB2Ylda?=
 =?utf-8?B?UWlicTVGZmUzVVlheitUNFFPeGhZdWJqUXE3SE90cVhSd1hsSkFRYjhQWWpy?=
 =?utf-8?B?WXFlUEJpVVlBYy81NURQWHFLNVJQVUlPUGZmUDM3TUV5K0RwREhhdjFZRGU4?=
 =?utf-8?B?UXJNWllrMVhlYVVvWTJSVGxzSk93RzI3RWkxMUNjOUZ3c1FvRnZYSjgzVE1V?=
 =?utf-8?B?dDRLM3Z2c1JZWllUWUxLV25ncSt1Z282WlNLUXNhYkpMOHNXWkxBNUhvYlJO?=
 =?utf-8?B?Q1BKN1RuVVhCby95dUM1eXhEaUVtb0hGV1dMUnhYZjRaZk9pU2RZRlZIa3R2?=
 =?utf-8?B?cm9qTzVETWEvUHF4c25rTDBKWGxmRG1iTUtzOFB6b0k4VlVsOFhNZmlpSnZy?=
 =?utf-8?B?bllna1pEWkYvQjJKVVVxejlSM3NGaEtocjJyZ2p2K3cyekp0c1M4Q3VCeW5o?=
 =?utf-8?B?Q0tXZUF1VWN6RVdjTGwwNXQ0Tk5yTDA4VGpuL0NOZDFESHVrVXU2VGhCY2Nv?=
 =?utf-8?B?aWQrbFgzQ2VuY2szN2IwcWtqby9zUDlPdXV5T09vOVZHQmUyRUNSS2ZEaVln?=
 =?utf-8?B?YmZRUFdTU3BxSEZlMkJueCtROWRabEtFNHJOSFE4VGtocncxVGdDY2tMRmI5?=
 =?utf-8?B?ZjhIVytqTE15cDZ4SGV0bE5Jb3ViUm5obThVU1hGTkU2R0JDaThNZjVyTnEw?=
 =?utf-8?B?aUZGUkVyMFFxcUFCTzc2bGRmc2k1WE5rY0JYQk5KUFpLRnY3TWl4RVRsdHM0?=
 =?utf-8?B?V0tmSUl2UXBiZHhsNktQdm5LSVJUbDZ4bkdsc1ZiN3o2WlMrUjRKZk1xTDh2?=
 =?utf-8?B?UE1uMndpV0pqWEcvb1Q4MEtaVWlMWUhySVN4NFNJMVVEbUNRVkZqTm9CZ2gx?=
 =?utf-8?B?akFqL1QwT2p6OEFQZlNlcTVRejZJK3ZXdXc0VG1PS2xLY0hjWWxaL0hhTno2?=
 =?utf-8?B?VjBqVGFjbmRjWUM1anFRWFUrVEp2OElvSjMwS2VRVzVISEEzc1JDaHo3aXg1?=
 =?utf-8?B?bGcyS3dKaHk5OC9WWEs3VUZVaWdhWGRwWG5XWkRMcUN0dFVqQlcvT08vcjFN?=
 =?utf-8?B?bWozZGxsNFNGYjFkcDIrZUhmeWo5b1g2bHB0THp0cjBFdW9oNlhJYUpxUWh6?=
 =?utf-8?B?bFphNWdoQTRha2NIZ2ZVUUVkQmk3enh2RkNZNEk1S1VvK3R2OHVZME11ZUpH?=
 =?utf-8?B?R2VnY2ZaUklScXRxWGJRem9pMVZYRVhKanRhaW9ZTE5KSDlubHZvbDM0azBm?=
 =?utf-8?B?dDRhRDBPZTA0dXlMU2czb2VUMTczZTUzUGJrYkJMck43Q1U3TGs2eTY4U3Iw?=
 =?utf-8?B?RW8rREs5bG5lV0EwK3RaZllPYW1LcHJVOUIxRnIwc1VRcHYwVjhhK2xmSnU5?=
 =?utf-8?B?M1l3SjZ3SmZ2UXZjTGxYVExKbGFTTXB1S0tOUC9kY0dGdjZrdGdVWGlEMHov?=
 =?utf-8?B?K05YL0RpOU9EWGh0b0JORDhlUjNkeU00SXhxOVVTdTcybVdMWUtoRFhPOHoy?=
 =?utf-8?B?WTRCMWJYdWUyUm9SemZUdythbXRqRmlaK0c1a2EvZXJwMkpOeFRBaGV0cGxW?=
 =?utf-8?B?UG5IUXE5b0pLNnliaFlQS0tIY1UwVXdwaS9qSEVtd2QxZGxJREZZWXV1OEJS?=
 =?utf-8?B?MUl2ZlNhNGlzenNwRmdXbWZsM0lmdmx5eGhwWi9NOElkRU5NeW1rclB0eFhL?=
 =?utf-8?B?a0lTS3FGZDJTTEhFeFVlL1hUVXRrWnJpd3FRUkh1cVhGVW40OXVhaGY1ak9V?=
 =?utf-8?B?Q0FtamhhQjROM3hGR1d1UjJkSGpsNk8xUEZFbUNGZkpvUmFaQlRzdkh1RUtF?=
 =?utf-8?Q?fbE/SdnrUHKLrBpNyo6xWQK+t?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964fed59-f7bb-426d-13df-08db81390b04
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 11:30:20.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH5onKlgvjwuFzsSKde4lFBNDAN/PZ1ry+dDNj/x9soX4XInoSzqNraWnERkH8RcDbZsvtkqz5iSY3RpcJd7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6242
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 2023/7/10 19:25, Dmitry Baryshkov wrote:

> On 10/07/2023 12:59, Yangtao Li wrote:
>> There are more than 700 calls to devm_request_threaded_irq method and
>> more than 1000 calls to devm_request_irq method. Most drivers only
>> request one interrupt resource, and these error messages are basically
>> the same. If error messages are printed everywhere, more than 2000 lines
>> of code can be saved by removing the msg in the driver.
>>
>> And tglx point out that:
>>
>>    If we actually look at the call sites of
>>    devm_request_threaded_irq() then the vast majority of them print 
>> more or
>>    less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>>
>>       519 messages total (there are probably more)
>>
>>       352 unique messages
>>
>>       323 unique messages after lower casing
>>
>>           Those 323 are mostly just variants of the same patterns with
>>           slight modifications in formatting and information provided.
>>
>>       186 of these messages do not deliver any useful information,
>>           e.g. "no irq", "
>>
>>       The most useful one of all is: "could request wakeup irq: %d"
>>
>>    So there is certainly an argument to be made that this particular
>>    function should print a well formatted and informative error message.
>>
>>    It's not a general allocator like kmalloc(). It's specialized and 
>> in the
>>    vast majority of cases failing to request the interrupt causes the
>>    device probe to fail. So having proper and consistent information why
>>    the device cannot be used _is_ useful.
>>
>> So convert to use devm_request*_irq_probe() API, which ensure that all
>> error handling branches print error information.
>>
>> In this way, when this function fails, the upper-layer functions can
>> directly return an error code without missing debugging information.
>> Otherwise, the error message will be printed redundantly or missing.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
>> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   drivers/thermal/db8500_thermal.c | 16 ++++++----------
>>   drivers/thermal/qcom/lmh.c       |  7 +++----
>
> Please split LMH to a separate driver.


Sorry for mixing these two patches together,

can I add your Reviewed-by tag when the patch is resubmitted for the 
next version?


Thx,

Yangtao

>
>>   2 files changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/thermal/db8500_thermal.c 
>> b/drivers/thermal/db8500_thermal.c
>> index fca5c2c93bf9..0ef8fc2eb4a1 100644
>> --- a/drivers/thermal/db8500_thermal.c
>> +++ b/drivers/thermal/db8500_thermal.c
>> @@ -164,25 +164,21 @@ static int db8500_thermal_probe(struct 
>> platform_device *pdev)
>>       if (low_irq < 0)
>>           return low_irq;
>>   -    ret = devm_request_threaded_irq(dev, low_irq, NULL,
>> +    ret = devm_request_threaded_irq_probe(dev, low_irq, NULL,
>>           prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
>> -        "dbx500_temp_low", th);
>> -    if (ret < 0) {
>> -        dev_err(dev, "failed to allocate temp low irq\n");
>> +        "dbx500_temp_low", th, "temp low");
>> +    if (ret < 0)
>>           return ret;
>> -    }
>>         high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
>>       if (high_irq < 0)
>>           return high_irq;
>>   -    ret = devm_request_threaded_irq(dev, high_irq, NULL,
>> +    ret = devm_request_threaded_irq_probe(dev, high_irq, NULL,
>>           prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
>> -        "dbx500_temp_high", th);
>> -    if (ret < 0) {
>> -        dev_err(dev, "failed to allocate temp high irq\n");
>> +        "dbx500_temp_high", th, "temp high");
>> +    if (ret < 0)
>>           return ret;
>> -    }
>>         /* register of thermal sensor and get info from DT */
>>       th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
>> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
>> index f6edb12ec004..48a14d7e8bf5 100644
>> --- a/drivers/thermal/qcom/lmh.c
>> +++ b/drivers/thermal/qcom/lmh.c
>> @@ -207,11 +207,10 @@ static int lmh_probe(struct platform_device *pdev)
>>         /* Disable the irq and let cpufreq enable it when ready to 
>> handle the interrupt */
>>       irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
>> -    ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
>> -                   IRQF_ONESHOT | IRQF_NO_SUSPEND,
>> -                   "lmh-irq", lmh_data);
>> +    ret = devm_request_irq_probe(dev, lmh_data->irq, lmh_handle_irq,
>> +                     IRQF_ONESHOT | IRQF_NO_SUSPEND,
>> +                     "lmh-irq", lmh_data, NULL);
>>       if (ret) {
>> -        dev_err(dev, "Error %d registering irq %x\n", ret, 
>> lmh_data->irq);
>>           irq_domain_remove(lmh_data->domain);
>>           return ret;
>>       }
>
