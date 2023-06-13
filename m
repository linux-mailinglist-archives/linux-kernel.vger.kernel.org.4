Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978EA72E25A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbjFML57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjFML55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:57:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2109.outbound.protection.outlook.com [40.107.117.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76E6C5;
        Tue, 13 Jun 2023 04:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvmfr2mf3bPyIOxkxgOKIk530/J9m31E7x9ImA31Y0t40VXqWLVmkC1lOFg7IYhMTJFWQClXWsnJSPCNYIOZ1u9o99BbxALvcCufMQbZRBfkW3/ecEiACheLdxw9DcnA6FwId4fjpAs5i2xvRQhNJKHN/TEM6j3zSvRovFcjAF8uwXUK10Q/N+ulvH/VYPdHnBmlZzn9Vq+yzc3JZayiIAgZZWZ91sJphxIHGAYp0PLxrVvT2JwScQ5+WOLFFvd+rmf+xP4eF83FiyXXU+7jZZDZyIoLhKURt7QdJspdYltZ4MwKo/1Upflbg6IrqJuiURwl37J3e1X4DiP2ehhH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYSFrsSD46dy/ks1gp3MVL0PADZFYMRoXvs5cJizewA=;
 b=KrG+JkDYrwWakAESJlbEP+Cy+Iim1m/i0aeXy7NQGy8aY0lJSX4ATLk9Quh6NMjSk2vDyt5VR+FhaUTOflUtR3WcmSVhtRyaqorZyE1/E2a8zHWya1kMCL8nDbzyZzfJc9qmB8QBT3C8cgqlfmQYSBEGeUbu0FEp6sozkbssxHhoG+4zkn8YF00vjw+4SjvH8/4LJ+SWvSOjX7+6gzLEVxqbg8Nhx2mE2P/Pax5pNLthnIc4YosycQr9In4xHlWpDHtD8ouE6ERBcAPYRl15lNLDvo5t5jU+NNPyfn0LOTYfJL4j6Y9nuBZDuEbYaNDVBV7KDNiYxe5vs0aZHNv/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYSFrsSD46dy/ks1gp3MVL0PADZFYMRoXvs5cJizewA=;
 b=RGT1mfOtGErPAxKVOBX81tlT0NbdSPUYZ2Jm74tGBmx1FoLwOva6BBDP3xTGNgz9TMPlB/fJfx4StzweAnjKA8fU4d8Avn/lka/j0raTs0XNadDUieZ48/eMcPGDL3CzXnJQq/VFYOeoIebP8iQVoJkFe+8LkT4DyyH3jsUjgW+2JHhrvlMKlqUxflObfae4XRBcMJHtdV+rFXPar5TvJLF0kg5JRnZHQU2eSq3nw6QJHBYz2IRj2QeHwMjAv1nH50VQUMqx/s0IjaxsmvooQc/ZUEdpFEd7mdhib1oZ4cHSJ7oYwmJwgEQzEJYkTwe6QOQbE1gFYIEtYZBMNY6HoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6009.apcprd06.prod.outlook.com (2603:1096:101:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 11:57:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:57:50 +0000
Message-ID: <1431a1a9-6ce2-664e-080f-42483aa2b124@vivo.com>
Date:   Tue, 13 Jun 2023 19:57:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RESEND 1/9] thermal/hwmon: Add error information printing for
 devm_thermal_add_hwmon_sysfs()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, glaroque@baylibre.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230613095624.78789-1-frank.li@vivo.com>
 <3ab066e3-97f5-8bd1-eaae-3d790432fb6f@linaro.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <3ab066e3-97f5-8bd1-eaae-3d790432fb6f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: a52f53fc-6599-4b91-d5c5-08db6c05698a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNj6uT98/xwcYnFEBYk34ValRfGY69kbgOcM+M80K6EDhRtOv2qpFjp1FVuuEafG4wHl13IE0SH4hqvzDwXTAW9lctSggztwLHTkNULbDCpORHONlwOTE/xoxw25VOI/i4uUGktoA/3oOF3kuGJF0mRx4sOopeKk25t0RdahWkC3WdCZwTxlEMYJgt62nHl+CNUx0TDe/mscxx2Lfj0AuAHcy1odbfOI0fumeUSG2Iy6zBeumAjIcAr5ACIONsOda9J5DZoni5UE+tWZITymPckvU0Z2nRcajoOmWCytnC0oepO4XA+p9gklDEyTJJnRZ9kWcTBnu/j6cptk3e2KCQ5ZjAG5M0SzKgrwUWRRblYOtf6oUOzVW2Nteel8ZQrgqHYF/WfPNg5L9I5sY81Nfdr5kvlKTPxM8J67l0NkQroblreOok4oQZWvn1tuFFzvLIciufe6v0h1TRLjKvDOdrdx+iylXI9147qipLx1iRTv5RvlIPABIBMlp0fZN1fvhb7UeSTNBiafibptWf+64cGXCsrg7foHSQtwe2rQfGzCtqQcUGXtppb6E3/wT/BhVQNN+770ezuzvGe8SnrH8H4K+0fMAF8TVZnQ/8QOnUi7ayjzut9ZbOhZVi3ekmkufRcVJ5RBWtFvyqbcPE35nss+3ZpoaAlfSfZqUglrD3qU4BNAxkK0gFs+epF2UfdX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(4326008)(66556008)(66946007)(316002)(7406005)(7416002)(66476007)(31686004)(84970400001)(41300700001)(186003)(2906002)(478600001)(8676002)(8936002)(5660300002)(6666004)(966005)(52116002)(6486002)(6512007)(6506007)(53546011)(26005)(921005)(83380400001)(36756003)(86362001)(2616005)(31696002)(38100700002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aCtYRDBUdXBRVy9VZkEzVGNKNm5qeE8rSEVkRGorYjBCQTBGRzEyT2g0Y2tE?=
 =?utf-8?B?dEdKd0M0bTBGL1lpNFJJRllJcjBEaFhsMUgyTlMzNUxFK29QSHpSVG5XZ3Bl?=
 =?utf-8?B?YkVocDFaVGh0b2JYRmZIVHJGajdZTi8zNStKNW5CY1h5NzYzSlZwWmo5VzV1?=
 =?utf-8?B?QmNSeHkxSlg1TFlOMlg4VWdzSHRWRDIvK3YyWWpGWDBmeEFScUdOTnVTakw1?=
 =?utf-8?B?QjZEU1c0QXIyRVJ2TmFKckczdnVSbVhVUXFZOHZqU0pRWUtsMGp4WWZlenNK?=
 =?utf-8?B?MDRvazhrVmNXRXcrdzRiKzM0cGFjV3dtWFpxVkVTV2NGY08wWDY5VzVqd0JY?=
 =?utf-8?B?THArYlpiR3AxWmgzUHVpVFRyWTRkYlhIN2VZVHZaM01UMHBGRGVxS1ZIV2hD?=
 =?utf-8?B?NzFKNnhvRnJCS0UrTTl5SjBaQTR5OU81YjJ4TE5KSEtTUHF0VnV3Q1BlYzAy?=
 =?utf-8?B?WTRBaW0rYXpWaXdQRTJwSHhBZXB4cmxKZDZJSXpHRWZaRm1aY0dMSHZWMG1B?=
 =?utf-8?B?Q2FUSjJqRHh0ZG9rRzlnRDRKVnlNb3RVUGpoanlQRTBEdjl3NkFTbTB4YjNH?=
 =?utf-8?B?R3dSL0JhemROcVhwOW9pM1BXUWJ3eVVrS0ltOWFoY0poT0N5bytKRk5uZDlJ?=
 =?utf-8?B?NkxPU3JLMDE1cGVHZmtsMTRRWENuOURYbXNVNlpET1pqN09Na21qNGtjL2hR?=
 =?utf-8?B?QklTanErb3NOTnlicGwyd3NBUGY4OVZUbUlNalZMTm9MVTV2MTVwcm5hU25G?=
 =?utf-8?B?WDl3c0VqNUNRRzNMZ2h2Yy82dmtidHltb2hBSG10OUxIcEtzSGN2ZTZDNkI5?=
 =?utf-8?B?ejJ3ZXJtRkdNRlJjd3ZVaC93WjN4dXNmeEFvSGRERnhPVWpIZGNQUzIvaEVZ?=
 =?utf-8?B?emhFWThSRnVnZmN2NjVQYjA3czRzWGpJRXI1Z1d3VGdoV1dROTgyTzEzd0tw?=
 =?utf-8?B?VnRYYndocENEVTZqQmJ3alc0YldwWVdtZkJYU3ZGUTNlZUVDZEJhSmFxbU1Q?=
 =?utf-8?B?c3hKRG9xY3RWOWtSdGZ2NDNlZlFaNW9ZNlJESVRDRzF3cngxcXFZSGRUQTFF?=
 =?utf-8?B?VjFnOFA3Z0RuT3NJNUhoQm9iYmtKUHg3anZiQTFEdTJ2d1I3RlAwNlNOVWdE?=
 =?utf-8?B?bDh2NzBSMWNmdTR5TG95NExaQnRWbmhncHJmVlhsa25Ta0NNWC9wWGJ0aFA5?=
 =?utf-8?B?Mk1lZUFNYVBDKy9JRUhobE5CUDRTZWIzWlRxc0h4L01GUlAvRUlWTGs0Mk4r?=
 =?utf-8?B?N1NUSjNscytBWHY1NFJmdFJpTWlqbHFFL1k1UkVPUTk0dEFtbGtrVmo5cDIy?=
 =?utf-8?B?SzN6VnlIcE5OdkkvTHI1NkZ0akU4WTJGTElaQUFYT1BMTG04aUpXb0ZGNGlL?=
 =?utf-8?B?M2ViZ0MxRnZURjFEWG9rYzFVRW1EYjhFZnFhdXVxUUJqUWZGQlpGcXFGaEFo?=
 =?utf-8?B?TDdiREo4ZU9zTDNRNk0rRC9PbnE3bHZENEZISTE4Y05ZdHIva0J5eDRRZGZj?=
 =?utf-8?B?aTlzblZXOGlKZDUwMytXbUp1MUxTRy9Ob2hkZko0VnlrbTFvRlBKZXRzSXF3?=
 =?utf-8?B?SjJyYXhKNG9OdWdPdjk4WVFFWEsxaUY4ZS85Y3hsdVFQYzM4MDFZeVIyV3hT?=
 =?utf-8?B?Wk90NUFvUkViUlNNZUk5VmdTNlV4akNJL3kvQWFPUmVwZ2U3b091RkZ2Z0pO?=
 =?utf-8?B?Z3dRZ1hId1JVRWhiTkRYTmpYaUtHbFJwckk5MGtjZWxjSkZ0bkY1MDk2Z1cz?=
 =?utf-8?B?eWVkaDEzdjhvTzJwUCtMS3ZTdHhVM25Xay82YWtPYzJsc0thMm8yUU5qUnJq?=
 =?utf-8?B?eHR3N1liNzhId21oZkZwaXlKUTB3Tmc1MmtHa256RWZkQXF6bWxnUjBlV21T?=
 =?utf-8?B?VGhEaEs4elVXcVpNdDRzdUsveDJiUE01STNoU0NjSDZBSUJJSkllY0wzZ2RZ?=
 =?utf-8?B?UjdjUTBtWEpPcVZ1Q0xwTGszWlpRdFlZbVNEaUdoTXFINlcyNnNjc1NpVW9z?=
 =?utf-8?B?Zm92MjR2SFFiVm1VYmxrZWRrMTU3NE1weDdZMEZpN2FWMWFSMWQ1cWwwZkdq?=
 =?utf-8?B?Qmo2Y25VR2N0dE4wWm5hdEFHdU9sWThlOWdpTHVyZTFSZWF1R2NiY1FIT3ds?=
 =?utf-8?Q?KKKnUSrJaGGVl0zsVowkUxxS9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52f53fc-6599-4b91-d5c5-08db6c05698a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:57:50.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4l2J6ICqbOOnX6EGrDVjjScwdXOqFLWif6gDxFo3/BRNeEuFJrBPri5/aoS57Bipl0nhkG29Gt1YEBo/D7PLjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6009
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 18:20, Daniel Lezcano wrote:

> On 13/06/2023 11:56, Yangtao Li wrote:
>> Ensure that all error handling branches print error information. In this
>> way, when this function fails, the upper-layer functions can directly
>> return an error code without missing debugging information. Otherwise,
>> the error message will be printed redundantly or missing.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>> Resend patchset so that the changes to thermal/hwmon.c are copied to 
>> everyone.
>>   drivers/thermal/thermal_hwmon.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/thermal_hwmon.c 
>> b/drivers/thermal/thermal_hwmon.c
>> index fbe55509e307..a580add5a2f6 100644
>> --- a/drivers/thermal/thermal_hwmon.c
>> +++ b/drivers/thermal/thermal_hwmon.c
>> @@ -271,11 +271,14 @@ int devm_thermal_add_hwmon_sysfs(struct device 
>> *dev, struct thermal_zone_device
>>         ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
>>                  GFP_KERNEL);
>> -    if (!ptr)
>> +    if (!ptr) {
>> +        dev_err(dev, "Failed to allocate device resource data\n");
>>           return -ENOMEM;
>> +    }
>>         ret = thermal_add_hwmon_sysfs(tz);
>>       if (ret) {
>> +        dev_err(dev, "Failed to add hwmon sysfs attributes\n");
>>           devres_free(ptr);
>>           return ret;
>>       }
>
> Sorry, I commented to quickly this patch. Please discard my last 
> comment. I think it is a good improvement.
>
> Can you replace the dev_err to dev_warn ?

Based on the thermal/tuxsuite branch of daniel.lezcano/linux.git, patch 
v3 was sent.

Included [1] for cleanup thermal-generic-adc.

[1] 
https://patchwork.kernel.org/project/linux-pm/patch/20230613093054.2067340-1-wenst@chromium.org/


Thx,

Yangtao


> Thanks
>
