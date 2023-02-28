Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF696A5645
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjB1KFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjB1KFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:05:17 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C92BF2A;
        Tue, 28 Feb 2023 02:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8p/7ke4O4/t/i6nxL3O9S6bOMYZaBeaK0c3gtRyo5fmZeemAUMStZrve5pMxOkpRkV8WpECgOlNYEXTk8NlpJGi9UZaXU3Tb/vWClEqPAwnlKY9WQ7dfU7okEQ+4U+rYqMVinoFyCVqEFkzq2J37KibWp2FDKaFHgn/zZCpW8jn3wZKDeUURin34mtjmne9i4LIlWRs/wVaw4FvwDMcl4XcT8jTmeApPL+XpHVx3brvULlVPfBHC8kb80TI8tLKPDiCjvyfez8QsPe7EBte7/wV72wUi6hR9Z2WyINBVQQF3jDnOGVStKmPp8jLOAf1xHNWfzNYWtoygLIaB6hhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw4bSNQ5NDS9KLa/ealM++5IRRAJsLPDG2uxDCwScMQ=;
 b=drdg8q1lOSn7thh1Sfb1xmqkDk745RceIbHNnz0SAmempHuCcDqcMsKvZTKlKp9hHz9cHIdesyVfbUEbl03CYIm2v3mSWP46vmi0/ObUxSyeiXPObXK8zFCVYVj+6waz4OMXW/pxI/TrfpWzZrLzkF6WedzGU5gQ+haMhso1uyFMFIW/N1AQ5ooVL9wKmh19E6r4jfCTJ4ZADlW9xwrLvqNg7t5yAgq9fBDBGixOd2haYFDHi0HPn7AlTFhm1Z9d+ZdnsrLGn13B+f2C4mxJeOSUQPwRTfMHYfYiMTiCCAMesyIRuuYSLM44ebnf4N/YdNanSmsUVAErFagpA4O5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw4bSNQ5NDS9KLa/ealM++5IRRAJsLPDG2uxDCwScMQ=;
 b=ERVVTEjN7JC1brgtl/biiyxQ374B36957zq3xhCSo1bhgi0E1ZoYADw7cviHbn7OSKNOtpnqupvJs1mFPrhnD642Twqw4MT65317mH4oUQ4wTt+KYQzwOJfGsemLCCT1EyED/G6CeheOVGXmKbuv9WhghCoav7CYOn8nwi0TexPQgAnWTXFsJUX47qpty20hbRjcPZ0FAOeCiKqWIxq+HS4usi8KEKBVMHdn119sRtkJYRhrFvuIIm+UOP39Qb6Yey4qOsTpzemY9kMrCghMBvPbxkcyW/4SW2a85re/h1d0AifkpSJccb2iA2bs/hBfRFsLY+U6EmPEkJdtdCh8wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AM7PR04MB6918.eurprd04.prod.outlook.com
 (2603:10a6:20b:10c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 10:05:01 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::cb43:d6bc:dad3:3dd]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::cb43:d6bc:dad3:3dd%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 10:05:01 +0000
Message-ID: <a75a9e85-5682-1527-2e74-e1f7cf69132e@suse.com>
Date:   Tue, 28 Feb 2023 11:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, pmladek@suse.com,
        mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230220143143.3492-1-petr.pavlu@suse.com>
 <CAJZ5v0jng3PDPnTKAov0m2KTYKaQuwOdi+jCVwc5BM5duct2Pg@mail.gmail.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CAJZ5v0jng3PDPnTKAov0m2KTYKaQuwOdi+jCVwc5BM5duct2Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AM7PR04MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: c3840a74-30f5-4d3a-4bc8-08db19734176
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmV7Sgry38HFS3zIwqTizuOqkAWurwbi3NvsndGl/XiM4T6sI7A8feymZTbDx90cQa+TAIuDXxSu9Y+uC1HZO9yzRxSf4qtgzEuFLx48JxAnyW1seTJy838CjFDyUMYRcQ16hvQsf8Zl0vG+DZFhuQrvLbgOjSnXdBSWtaQ3MSQJmKiFY/KL3MV9sLBQt6wGIhCWAeD5xo0cdfbn06sPetGQlIrV4hwgbiFdcwBbpWdNMwYPuOoDeAD5A67/nJQ+25qfzygr4p/BJ+H7y8YppCJW7Z/jkEQ04Vy6k/QhQ0UC10O7bdVi9k/CdpGYc8orE/kJ6/mhwjYNd/rddiIN3AXp68iadJ/4GAZPqkBs/fLEDLSoNk7SBFpKjc0wi6QoFVwj76dBGMmA/dSjzCqRzlJW0HksTFvYhT7Shr/uDftqou5YJpTrThBR2Qy0xwJBuncTBt2UBWCFq4ItFuvmUQF1r+rxF43146xuRAt/R4bpzUTCMRlf/vggol4EabPpNGtvoDGlFmGgqj4CxS5sjEUZMEx21BCKA/3cCgGIWamPNqBk/GC+UqbzbGlTLlXvfK1QEoK6aOfb0yzPgGNFYjUPflXHkdBm3TjeNRCiXkOPULm86BlP5w9SdaK5JrZIuNsJZtAYTorCXvwMLi5RmXNvzWuq2KsIm8bPQhXUcHFw2ZSJpbYKKYehLLH6WbL3rA6fT8y1IWIpfV+OmBhg3yBOLW9svxE6WClUhwCAs9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(38100700002)(4326008)(31696002)(86362001)(36756003)(44832011)(66556008)(41300700001)(66476007)(8676002)(5660300002)(6916009)(8936002)(66946007)(2906002)(55236004)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(53546011)(478600001)(316002)(966005)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJWaVdkZnRHTTBzVERlOE0wemxKaG1KTVdrWHRaTktMM3c0NlpacGRWK0Zs?=
 =?utf-8?B?cVdkMU5YNUJ0VWZuUjhQZ0kvQlRwMUEybEh2T2lNT2o0NzNTM2hReHd6bGdX?=
 =?utf-8?B?ckNKeDNGL1k5NEhZZzJzMmEybytpeENTU0NUeVZEYjJraFB3QXFpRWhGd1cv?=
 =?utf-8?B?ZXJsQkVvTjY5ZmFUNnNMZzJBTkdLQytQNXhsT2JMVURBT3dTc3Y4UmVsRWxh?=
 =?utf-8?B?THlKQmE4UCt4UnlGSkpsRXVEbWt1MVlIOXhKWDZPYWk4RGVBN0FnLzNDTnVs?=
 =?utf-8?B?a2RVK3g1VkpBcFFBYk9QSU5VOGg4S2gxSlFOSWNwbmlDeUJXd0xiQldSdW9Q?=
 =?utf-8?B?aDlhOW8wS09idVZnZjY0OU9FYjh1VmNPcEFPWVNPSENkbENNRTMxSmYvd3lp?=
 =?utf-8?B?MXh1TytQNFA3ZjAzV1BNV2p4YTk1SVZZaGFjeDRzcFV3ZmNjSUlyRzJGVlpO?=
 =?utf-8?B?RDBKT0ZDZXVReWdZdngwOU9lbm9KNlV1a0IyaW9DZWZLTC9scnlJVWZ4SEdh?=
 =?utf-8?B?dVFqelM1TzRnV1BPTTlZOG1kYy92Z3dSdXpTcUtoQzR3K3N0aXhUdHpxcnpU?=
 =?utf-8?B?RDFGMllSMEpnNUZSTzF6TVZZMnJod2M3L0hGU3lOUmdrZDZlOHl3cjZFWmsx?=
 =?utf-8?B?ZGoxU1FoV1ZodWpWS09FTDBhdTEzeGlDeTNSRHBuRDFuRDdjcnV4Tjg0d1RG?=
 =?utf-8?B?MCtoMEExUVJuYTd4VFdOM0ZWNDMyekdqQ3dISE8vTkJabmdTZ1lMYkFNcTN3?=
 =?utf-8?B?VnJWbklURS9SbG44cEIrQlM5OVRDR0xvV0VSSHNqUGZ0bzE3R0x0eWFIU1pL?=
 =?utf-8?B?VjRHT0ZpRHJUbEZhanFEelRGejk2alVwZmUxSDlrU1ZXQno0UXFrUUJuSWRV?=
 =?utf-8?B?b3hxdzZkWjM0TnJSN0lWMlVENDF4VDQ0Vk5ZOVkxZ3BreEo5MVMrTjQ4bW8r?=
 =?utf-8?B?eWpydVF2NUhJVFROWXVqc1V6TENPai9FNlVBYlFaLzNNdzJqR0MwRGlhRURI?=
 =?utf-8?B?RDc1NkRndFc0OUFUNFJqOUtCTHY4c2RTczIvK0VyMm5pd0JHclI4V1VNWWp0?=
 =?utf-8?B?NDNJYW5NakluNytZaHdGRnZ2b2pweEoyd2VaYkRjK3FNZkZLNklvKytxZHJO?=
 =?utf-8?B?RVQzRURoMlN5cmEwWHZmR0JwcHJuU2ZaRXY2MnNOVlJxcjltQlV2eXZvemIv?=
 =?utf-8?B?cGV4bW5WOW0wRjhzWTU4c3V5ZnlrV1hia2dGTFFFcEpGbjFobGVHclRncmZ0?=
 =?utf-8?B?V1FUMTdtRExPYjRRa0EyM1ZCRlEvbmVlU0xSbVBMMWFTUllMZW1USUkrazNW?=
 =?utf-8?B?cjBCMUJTVHhVRnVmREEvQ1BwRGJGNTlEcWhiVEwwZVQybnNRWFdMTkpHeFFn?=
 =?utf-8?B?UG5VMGtxaVVZODFnUGVLaWNHekJhYkpXTlQ0bHpZaVk3ZVBWOEt2VFl1OGts?=
 =?utf-8?B?dFZxMFlLeGhwV2EwVy9BdWNjS0NFeXVCOSszVUsvSkx5aktYT0xMazFaV0tv?=
 =?utf-8?B?ZHJCQStXL3owZGRMTzIyalRJSHpSbXpSeEJaVnpVT0JGeFpuR1VZL3BkN09C?=
 =?utf-8?B?RFg3NEVzbCtaRUFGUGp3UHNZWDNydEcyQ0J4RGttSm9obG4zTzhzZWwxNlBM?=
 =?utf-8?B?TkJ4TzBXMVhKVkhKWnk0Sjl0R2ROYThadDF2VUR6R1piL3k4L3RQMXR3dVVM?=
 =?utf-8?B?UUlkaGFPK2prU3QwSjAyRldHemVqeStnTlNtT3NCZlB1ay92cjNvdmdRdTJh?=
 =?utf-8?B?YldjM3FQRmVUZWdObVlWVnQ3ZWVWUXRHcVp6TjJBWnIvcUhhZWIyYURxekJS?=
 =?utf-8?B?N0FpZW8xWElXMWgrZzVwM2FyVnkyWjI3NVZqK2VtcHNZellqVTU1V3J1VDh5?=
 =?utf-8?B?dU9STmlRaUpDVm9oZ0plZWpqcm1OaWdLU3ZhN0tUaVltM0gxU3BNdjBxVW91?=
 =?utf-8?B?dmg0UEhpRmtBMDRwY0FITm5mVXNBQnI3aVRTYisxblpxZDIxeUxDRytQYjYr?=
 =?utf-8?B?dWY5M0g5VUh2S09YaEkzOXhkNkdlb3duZEgvc2RiaFdpRVNZMkZHRVdhMnBn?=
 =?utf-8?B?NDZ4ZVVad2UvRzl3Tm1vc25uYU5YVmsxY1hldjQweVI1QkhmV0V3TFVNeHlu?=
 =?utf-8?Q?/NC4vBz/n0tjD7OR7MFV4ftQj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3840a74-30f5-4d3a-4bc8-08db19734176
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 10:05:01.4668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VckzqQuCZR0ZPZP+5hg7fqoyZncDc7yFlhbC6Le06rtltf8/8S3GN0VYSZZnNscpYp3v+o9lKmiYXOgAVqpQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6918
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 16:04, Rafael J. Wysocki wrote:
> On Mon, Feb 20, 2023 at 3:32 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>> Both acpi-cpufreq and pcc-cpufreq drivers have their platform firmware
>> interface defined by ACPI. Allowed performance states and parameters
>> must be same for each CPU.
> 
> This is not a requirement set by the ACPI specification, though, but
> the assumption made by the drivers in question AFAICS.  It would be
> good to clarify this here.

I can simplify this paragraph to:
Both acpi-cpufreq and pcc-cpufreq drivers use platform firmware controls
which are defined by ACPI. It is possible to treat these interfaces as
platform devices.

>> This makes it possible to model these
>> interfaces as platform devices.
>>
>> The patch extends the ACPI parsing logic to check the ACPI namespace if
>> the PPC or PCC interface is present and creates a virtual platform
>> device for each if it is available.
> 
> I'm not sure that this is the best approach.
> 
> The ACPI subsystem already walks the ACPI namespace twice when
> enumerating devices and CPUs.  In particular, acpi_processor_add() is
> invoked for each of them in the first on these walks, so it might as
> well take care of creating the requisite platform device if _PCT is
> present, can't it?

Makes sense, I see that acpi_processor_get_info() has some logic for handling
the first CPU so that looks to me as a good place to hook a check for _PCT.

>> The acpi-cpufreq and pcc-cpufreq
>> drivers are then updated to map to these devices.
>>
>> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
>> boot and only if a given interface is available in the firmware.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>
>> Changes since v1 [1]:
>> - Describe the worst case scenario without the recent fix 0254127ab977e
>>   ("module: Don't wait for GOING modules") and refer to its discussion
>>   in the commit message.
>> - Consider ACPI processor device objects when looking for _PCT, in
>>   addition to processor objects.
>> - Add a few more comments explaining the code.
>>
>> [1] https://lore.kernel.org/lkml/20230131130041.629-1-petr.pavlu@suse.com/
>>
>>  drivers/acpi/Makefile          |  1 +
>>  drivers/acpi/acpi_cpufreq.c    | 77 ++++++++++++++++++++++++++++++++++
>>  drivers/acpi/bus.c             |  1 +
>>  drivers/acpi/internal.h        |  2 +
>>  drivers/cpufreq/acpi-cpufreq.c | 39 +++++++++--------
>>  drivers/cpufreq/pcc-cpufreq.c  | 34 ++++++++++-----
>>  6 files changed, 127 insertions(+), 27 deletions(-)
>>  create mode 100644 drivers/acpi/acpi_cpufreq.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index feb36c0b9446..880db1082c3e 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -57,6 +57,7 @@ acpi-y                                += evged.o
>>  acpi-y                         += sysfs.o
>>  acpi-y                         += property.o
>>  acpi-$(CONFIG_X86)             += acpi_cmos_rtc.o
>> +acpi-$(CONFIG_X86)             += acpi_cpufreq.o
>>  acpi-$(CONFIG_X86)             += x86/apple.o
>>  acpi-$(CONFIG_X86)             += x86/utils.o
>>  acpi-$(CONFIG_X86)             += x86/s2idle.o
>> diff --git a/drivers/acpi/acpi_cpufreq.c b/drivers/acpi/acpi_cpufreq.c
>> new file mode 100644
>> index 000000000000..4e4ceb7cd226
>> --- /dev/null
>> +++ b/drivers/acpi/acpi_cpufreq.c
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Registration of platform devices for ACPI Processor Performance Control and
>> + * Processor Clocking Control.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <acpi/processor.h>
>> +
>> +#include "internal.h"
>> +
>> +static void __init cpufreq_add_device(const char *name)
>> +{
>> +       struct platform_device *pdev;
>> +
>> +       pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL,
>> +                                              0);
>> +       if (IS_ERR(pdev))
>> +               pr_err("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
>> +}
>> +
>> +static acpi_status __init acpi_pct_match(acpi_handle handle, u32 level,
>> +                                        void *context, void **return_value)
>> +{
>> +       bool *pct = context;
>> +       acpi_status status;
>> +       acpi_object_type acpi_type;
>> +       struct acpi_device *acpi_dev;
>> +
>> +       static const struct acpi_device_id processor_device_ids[] = {
>> +               { ACPI_PROCESSOR_OBJECT_HID, 0 },
>> +               { ACPI_PROCESSOR_DEVICE_HID, 0 },
>> +               { "", 0 },
>> +       };
>> +
>> +       /* Skip nodes that cannot be a processor. */
>> +       status = acpi_get_type(handle, &acpi_type);
>> +       if (ACPI_FAILURE(status))
>> +               return status;
>> +       if (acpi_type != ACPI_TYPE_PROCESSOR && acpi_type != ACPI_TYPE_DEVICE)
>> +               return AE_OK;
>> +
>> +       /* Look at the set IDs if it is really a one. */
>> +       acpi_dev = acpi_fetch_acpi_dev(handle);
>> +       if (acpi_dev == NULL ||
>> +           acpi_match_device_ids(acpi_dev, processor_device_ids))
>> +               return AE_OK;
>> +
>> +       /* Check if it has _PCT and stop the walk as all CPUs must be same. */
>> +       *pct = acpi_has_method(handle, "_PCT");
>> +       return AE_CTRL_TERMINATE;
>> +}
>> +
>> +void __init acpi_cpufreq_init(void)
>> +{
>> +       bool pct = false;
>> +       acpi_status status;
>> +       acpi_handle handle;
>> +
>> +       /*
>> +        * Check availability of the PPC by looking at the presence of the _PCT
>> +        * object under the first processor definition.
>> +        */
>> +       acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
>> +                           acpi_pct_match, NULL, &pct, NULL);
>> +       if (pct)
>> +               cpufreq_add_device("acpi-cpufreq");
> 
> It should be possible to combine this with CPU enumeration as stated above.

Ack.

>> +
>> +       /* Check availability of the PCC by searching for \_SB.PCCH. */
>> +       status = acpi_get_handle(NULL, "\\_SB", &handle);
>> +       if (ACPI_FAILURE(status))
>> +               return;
>> +       if (acpi_has_method(handle, "PCCH"))
>> +               cpufreq_add_device("pcc-cpufreq");
> 
> And the remaining part can be called acpi_pcc_cpufreq_init().

Ok. I guess it then makes sense to move both PPC and PCC checks to
acpi_processor.c instead of adding a new file. Function
acpi_pcc_cpufreq_init() can be called from acpi_processor_init().

Thanks,
Petr
