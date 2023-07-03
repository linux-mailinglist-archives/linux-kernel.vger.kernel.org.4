Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262A745D13
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGCNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGCNYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:24:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BFFE3;
        Mon,  3 Jul 2023 06:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXvnQZgtUxlupMElr1Vll3Cp9X73W6QInDriWtR/EwQeRzicbfX48kP5coaut/ldtC/UuZ8cAeziUnoIXq/R+EX3i0Jfnk67BD9wGnpDMDydMocIGbI6pdV8hGfw3vmYshqlqcMe3mhYmYfvZiWtSPBUyjdn1+vgwlqooZAmZRskdOPUCO/4+hrVsnphvsG4GEUlVa0Y74h/PEgkTPKEKyl+x3kpTNbPXoO3pjhA/uUiLP7rGyUhfUgMLOyf6SPioqn4F9giyZPZOFlCU3ArElpO/NCG7jTAcfNeBT3X1czBqomLlHqYGtbQ/Tc+rIbEHyxo+SgK6XTlEMlH5b/9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quLszEF9TS4Ida720q9qPl2yVT7JJ7Ab7VoLWQATDIA=;
 b=ECFALEHGLmBw/YU3X+xkaICaovqYYCcpHWxs3UIoTiI4byzsfhNxeM4eFX4rcmDTz2CFgcBP6JUdoyAH2Rb/PcZJiiy9JAn4jjuc/qQV+mkhxn/jld001wtgF7M0sdKbXj2emX2c+FJwgLKMltVUqSWc2hcR6G88dtXTZP7aEjb9kVs6TLlYsRHmo+66jqeQKBIOVYWorYjTDwzH4nv02+OWexSnQgptv+BfnZbgWuksyJuc+NKQaN5OYPZenmwp3B4U6AL+a3wJI4GykVP5J75vVfptFceCJwVMqk62R6wFezA6J8+I7rvzcGRAhBkEA/61m6js/sVGqtaszcmNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quLszEF9TS4Ida720q9qPl2yVT7JJ7Ab7VoLWQATDIA=;
 b=XR+QxPNjWL7wWHgF7xYnSCFiI++DBr3GPK+PHAjBLmhQD4CquZ2XH1v1gQBvFEUdThKoVFYfhcS/VvjTb2gNaLgCUv3l5I6FpaPpj3v8eVQxF6QX9c9GktcHNGhjvOh69qLYtR19eWCi3yH00+c+0sebA/pCgn3aNj2gXYqEs3biQtzOZEoO3Ddrkz7NPAGXoq+qEA7LJvJtLL7lgxgAKzuT1plvrSvjtcOTEkYDo6l3JkYBmBHsEDzebP8TXmWyQ7JDftUIrCyTw4QyixXl8jUhSYtfxuUZBTQUJFealyJV3jlTK47FBEU7MvHHQg20qWT+gRAF24Y6e1ZLCT5f1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5049.apcprd06.prod.outlook.com (2603:1096:400:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:24:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:24:40 +0000
Message-ID: <930003c4-c90d-0008-a6cf-9298240e7d93@vivo.com>
Date:   Mon, 3 Jul 2023 21:24:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/5] genirq/devres: Add
 devm_request_threaded_irq_emsg()
To:     Krzysztof Kozlowski <krzk@kernel.org>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230703090455.62101-1-frank.li@vivo.com>
 <20230703090455.62101-2-frank.li@vivo.com>
 <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 90993049-0250-442a-855b-08db7bc8dac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2zFJdIVlXFN1QVK51lEj470zJpjz4w7/kI9zYW02ic2Combjolh8hC5/EIqWXzROfGakXfWXY/ZBcCTsc40vXaGsNkUW9bBim7QBRT6oeZB/R+tA1riaCknDO2+AxxhG/UP5CGYOzOyNpOdQRwL6e2EpTt7wGikwCjbUoeTFcquQaPHHrofdMhRUX+DR1jd6SkXB7b3acIF8ntq4rnxz8qkcKMiWUoeEDcAYy0rYwNXY5AUH2w4Fnl+4M3/J0fB3a2brzhQ7JXT6aahgLpOtVaxk2dM4MP0Y15ieN5bHTkNFSmvWRt/KdmdddzdsK++xxPAR/sXkLGlneAnKdQwzIj4+UeoEB2R1eaComrhxDw0jyI8BqZDLixmaldL0e4zcJgHstjSG33V9vYKolUPY7h3piBvNJafPFpe9afg1ly1cfUTzbPKBuKJ87wZwqSpFdZVO+RMOAds3cTN3zxi/BRZaj43uaMVxuAR6kYvjTOnrDGNqF4RqZ0j0vFRvp4lYmv8VIUTulNtcXg2Gi1a3Lq9JMxMkuEZuzOEFbjgZQxIlqxsHDciEufsMdE8wKimem38Qgu7sllh40/SzBNuBAPb6n+EKgkKjeu1lI68v/S+XQgaYsL9ItNVsLHlUZkjzpPCTky7SLvCBUcbuWTD8vYsWlGWJfobjChwto0tjuCEUpAhXbuQf61zFrX8TdAHJK1Lwu5AceGI6y1AAgGeFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39850400004)(366004)(346002)(376002)(451199021)(7416002)(31686004)(4326008)(66476007)(66946007)(66556008)(316002)(2906002)(478600001)(36756003)(8936002)(8676002)(5660300002)(41300700001)(31696002)(966005)(6512007)(86362001)(38350700002)(6666004)(52116002)(6486002)(38100700002)(53546011)(6506007)(26005)(186003)(2616005)(83380400001)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVBCNHUzYUNiT0tLT092bVRvUkJBb0RLRm11UkpqanZWSEZYaWFzcUNtUDBu?=
 =?utf-8?B?c3BHQkt0M2lRN3NnVWZYWkxDeHppZUxvUDczOU0zZ1MxMzNOU1V1TTcwSWZK?=
 =?utf-8?B?a2o0MTRBS053NmVpamZhYUN5SC82Tm5iSmtET2lyazFEVktvWERQckVkblow?=
 =?utf-8?B?WWtOdlEySnUwQ0xPd3RrOC9yVnVCVHhyNWd4RHQxem5mWlhFcHJXN3JHeXJr?=
 =?utf-8?B?MmYrd3gvV25ndjEvZnkwcHVxSHY1RHFaaXJhTzFzbTJnWjYxbGdaYjZjZC9R?=
 =?utf-8?B?T0JLT251c0QzM09WV1RCdjRzUUFBVkx0L2pVRzI4eXVtK2V0elJGSTU3eFdY?=
 =?utf-8?B?enEwV00wVEU1V2hIMzAwbXM4NTZFZ2U3aW9xVWo1aGpaMXJqdG92ZzJOTWhx?=
 =?utf-8?B?NTM4U2N3VjcxL0xycXc4OHBzWWJYbktBaVpWNUR4dXE2Nm5zSTJaTnU0YlNX?=
 =?utf-8?B?cDVZSVQ5NEdBUHNoVkdCbHlNS3FIajYwaHl3Z0l4VjIwVGxFdU84UWVHYXNW?=
 =?utf-8?B?RkVVMUlXY2RoSEI4MkdvMlBzaHRBc09IalUyY1Fmb1A1aFh3b1E5ODhPc3R5?=
 =?utf-8?B?U0s2VklTc2pBQjExZmczSUpGVjZndEFKRWZ0d2R0dW5LUmFoUUhRQkNRN21B?=
 =?utf-8?B?a1NsTjk3UnBXZUVPM2YzTWhxbC9iUTRvcTZseHhrdml1VkgyV2R1RHBETkg4?=
 =?utf-8?B?V1lucE1qT1RPbTJRcmZTZWY3MzhSNm5hNGViMlJzOC9FNloyaTc0RmVYQ29Y?=
 =?utf-8?B?Mmh0VDV4bVArdUl2U2xhQS9FemNYZkRKeTAyODFJc2tGQzBoOTV4a2o3VS9P?=
 =?utf-8?B?UW40Sm9oTFpLRytNRUVweFlGZkZqTzZ1M0lmN1VlTk1QenFOUXJFeVVKNzlo?=
 =?utf-8?B?ckVkQjdVRk1CQ2tZVjVvWWgxN3lnRDVDcU1lbFdxQWh4VW02L05TbGQ1WVJB?=
 =?utf-8?B?b0ZBOXBIYW1NL0pUVXgwalR4OVJ5MVdZOUNBd0FaMWhHUzlqRXZJeitGY2Y5?=
 =?utf-8?B?QUxuWThYNlFIVTFiN3JuZzFLQ1Rsd0ZtOGRNVHNhd2h0d3BhbHZ0bjhLT2U0?=
 =?utf-8?B?bFR2K1AvaVFyeGI1KzdSbVRvd1o5SXU2RmJtVEtXOWFCSzFDb0RXSldvMG02?=
 =?utf-8?B?bXVqQ0lNZ0xqcHJKOThoeVk2NG5sYy9DWmRjWmtoVS9YT0xYSkdYZmhORDhz?=
 =?utf-8?B?eEtrRnB0SU9xRVh0aUplaFo5bjJlOTRqZ2pWQTNoY3NaL0kzU2NteUlEUHlo?=
 =?utf-8?B?UnJZUTBaNTgwcnlhTjJWTTBsZmRWUm1DdjkxZWtaeGtGSGRYS3p4cXA0R2dm?=
 =?utf-8?B?d0FrTjJpVnpKeG8xbmkyYWFhYlZOZm0vRGFsZzR6VlhDN0wxVFdiZytYd1Z2?=
 =?utf-8?B?WFN4TzhOYVdndmN4WDRsMzVRZndVLzRvVVB2cldSZFNqay85MzNpWDFoblhO?=
 =?utf-8?B?RVFVYlNWRyt0bXRyT040NXpHV3Uvd1IzYU9BUUduNW9iLzlBYUlGZXc4elFn?=
 =?utf-8?B?RVhSTndSYVkxVDBLMjdsY0xEQXV2em5QdDVlM1AvbEtkeTV5bEkzOE1OVVpE?=
 =?utf-8?B?TGpUSVYwZERqYktXZElMZ3FGQSs4b3lBWWpGbHlRN25mN2RZaEl1MWdFYmJp?=
 =?utf-8?B?b3JBVHV0NmpLakRxWHY3MmlFNnJxTDlmV3pqNEx6Q29uNTYxZDM2eW5WZkd6?=
 =?utf-8?B?ZzNaK1VnS1RSMnEwZUh2WTkwckhvc2FmK3YydkpEYk9aRjJHN2xZMWt3UGw0?=
 =?utf-8?B?aElLblZqTmduT2NSN2czRUtqVXpXSXdoTW5Zby9NWXU5L2tYNGlCRGpLYnVl?=
 =?utf-8?B?UzU5OUFOMmFabVA1eTh3TktXTGpmM1lpQlNGY1FTNkJuODdIWDFiWldNaThG?=
 =?utf-8?B?SUFXWVdaWS9DY211b0swU3RrVno4OGpycjBVbnJ2K3pSYjA4cUVWY1IwNXg4?=
 =?utf-8?B?cTg4SS9CaFp1c2kxZFBPWVVmZWo0dEtUYllndlhvRCtocUgxNEQ0SXV5SktI?=
 =?utf-8?B?WWxBNHZ5OVljR1ZNajRCSENpbitjK3Y1WnNMRHRGSVVXRjVJSVl0eWIyYzcx?=
 =?utf-8?B?eXNZNkErR25lYUNrTGI4UWUxdzkybjZRSGlHRXlia3FVdnRyUW54OXkzVnVw?=
 =?utf-8?Q?HlIj8qTl5qbuTBVEzqZ6X6UPp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90993049-0250-442a-855b-08db7bc8dac7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:24:39.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwxUmhC4uE2W/vVanb2pPp2XUjykbGzgGLzANuVZHmvb5Fjg0INT2+3MyUF6RGMVvZOT2g92ROfmOx0PDvOMVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5049
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/3 20:31, Krzysztof Kozlowski wrote:
> [你通常不会收到来自 krzk@kernel.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>
> On 03/07/2023 11:04, Yangtao Li wrote:
>> There are more than 700 calls to the devm_request_threaded_irq method.
>> Most drivers only request one interrupt resource, and these error
>> messages are basically the same. If error messages are printed
>> everywhere, more than 1000 lines of code can be saved by removing the
>> msg in the driver.
>
> ...
>
>> +int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
>> +                                irq_handler_t handler, irq_handler_t thread_fn,
>> +                                unsigned long irqflags, const char *devname,
>> +                                void *dev_id, const char *emsg)
>> +{
>> +     int rc;
>> +
>> +     rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
>> +                                    devname, dev_id);
>> +     if (rc && rc != -EPROBE_DEFER) {
>> +             dev_err(dev, "Failed to request %sinterrupt %u %s %s: %pe\n",
>> +                     thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
>> +                     emsg ? : "", ERR_PTR(rc));
> It is open-coding dev_err_probe(). Just use dev_err_probe instead.


How about the following? If possible, I would like to start modifying 
more drivers in the next version.


int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
                                    irq_handler_t handler, irq_handler_t 
thread_fn,
                                    unsigned long irqflags, const char 
*devname,
                                    void *dev_id, const char *emsg)
{
         int rc;

         rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
                                        devname, dev_id);
         if (rc) {
                 dev_err_probe(dev, rc, "Failed to request %sinterrupt 
%u %s %s\n",
                               thread_fn ? "threaded " : "", irq, 
devname ? : dev_name(dev),
                               emsg ? : "");
         }
         return rc;
}
EXPORT_SYMBOL(devm_request_threaded_irq_emsg);


Thx,

Yangtao


>
> Best regards,
> Krzysztof
>
