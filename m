Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF9693837
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBLPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBLPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:49:26 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA19EC7C;
        Sun, 12 Feb 2023 07:49:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2WGSJwEgLoVWWGg+EoCy9+7l8XiI05ffAYSf56uErxVCzRjf6WsD5aveDjXNc8YM/RKKxmB3KdtSu7vcohkcnVvq8FtfccyMawtGSigZxT5uzoX+yvQyClWOkjpk1CoMGfhCB/yQUJUzI3MS7LhLFN+9MG0zXZIojov96BmU4pur2VP9YKxvqwvMccYCmz+RiA9zhRsP/MyFXips0acl7gUmthZOHwH2sEn/dQQuol7qpeGWxqQJHqZWjL7bGDUTxh0BMhVwUt7Rl5nxqbihzQSA8khRuCBz+w1ECdAa/nqvRBd9XxNdUsnxKJ5kTavK8lLFXLFuGvrluZ2mer7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq6QLngN/cXmzsl5TMgmiFEfnbIzWG//C0AWQ4NZLaQ=;
 b=Cc77/c03QBcbzFHs3yoB50dShj1+p+dMn9k0I5Cmij3glkiYhXjJdS9aQFwg9Zdn/VHYdW2bVxrYnjZ8Gj7Y2jf+XdStOq8QUT6QVAAKFMYlcMN1/9hakJGGfdqoppP6g4guUM1OABhWmwHsid9xxE/0gbAmRG/jQGi2TZlHB8bUFyIo+FM03V2aQU2Ky8HyCY3/ijWhLldWZ1ep8gasft1WwMMr0VyYFTFeDSypjUmjirHMLOL5uKiLnayWbqA9ioFmwPdpv93//zSwB/4hNgyTC5+XlUo+CjWKo7SNzApoxuk5akPZw4q5+/vMwUgJqLt1tnxZJw+c7XFAOb9GyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq6QLngN/cXmzsl5TMgmiFEfnbIzWG//C0AWQ4NZLaQ=;
 b=yAX6u9e1hkUCFCwj6eZCViYk5eDVjA7YZ2I/QpEyFE0pNSCySJEg06JCxSfd06XI4PIImXoRHBTLK41RJjTkkopLxnMlOwyKuzqEANLbB1WkCsoETnmLKvNUwQdgsTtWDy0zTDGWcF+/zbspmX9DeCqUfDKoeXmt/p8eTi8FZBXLEiqjLpIU/9EkFkzKCtT0DlMcsEgOgb4SEas/mj4ScxN4t4sB5yNbFFuu9LI3Yc/ayOavPBynhkUMohZ56XoMcv1QyhGxRTyx2UDDutvwrp8BQ8QUfh2tsteu9akjJw9VuSce7/gryB5iCu6Rvz674bkkt7Ha/vGGDYcKYAe4vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AS4PR04MB9243.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sun, 12 Feb
 2023 15:49:22 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::cb43:d6bc:dad3:3dd]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::cb43:d6bc:dad3:3dd%7]) with mapi id 15.20.6086.023; Sun, 12 Feb 2023
 15:49:22 +0000
Message-ID: <701e7d64-a063-a897-d3c4-53e32a7eef16@suse.com>
Date:   Sun, 12 Feb 2023 16:49:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ACPI: cpufreq: use a platform device to load ACPI PPC and
 PCC drivers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, pmladek@suse.com,
        mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230131130041.629-1-petr.pavlu@suse.com>
 <CAJZ5v0gptfbwPzXCosXKb3H3Hqu0p_PiPORA_RhGcJvteVBnYw@mail.gmail.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CAJZ5v0gptfbwPzXCosXKb3H3Hqu0p_PiPORA_RhGcJvteVBnYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: c249fe31-5ccb-46ed-4f4a-08db0d10b595
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+oOfF5IeHkpuE4FKNu9ocnovaWnUUSJB3sKTp1auOU3goz9ENEFZf6xnvkYQBEkuy5/JUmwx76hnok+t8PkRsZkwtSSxQT8j28wtPiNZQCmCxyOcKDgoN6eogVOWJtHdq65Qkv7zZoiZsD7/63ibV3yEvuNVatmYzndr+I7Bgeb+h0fPVY+IoAc6+WZpIzXczaMcx7Y0aR7jr0wurWLOD5eIP4Smk3YRCd5U/YXIBthHEW/SAHWJgyzfsrxHKev3HemAVkt+OxJbi5PjNBJcGzfjxUXcDUynP4i121MZuWJWztlYdJ9hBWYBLkUlgmwZ57hQAmPx9nTezh5liuCd2PnzSFPj8eOceq0cYVglDLhs2+44slWPogQ94Z6MYofhIloFcEOSQafwFYn9BpSInr1OyhqfWVpExy6ihVtGKrllr+C9GRcu/euO7Bvvvp2LY7I3+UTwqjthoUY+3IWfhWbpp6tgJbCiA6mz0wHMcAy2IQftWSQfwzRfU7pP1RJQpzbm39WDZNPAK8rVJCvXhwCESVGlrrvkORTTKuZb7NTwW8CsIuGXnime3MMT/gqrZWppOPzfncb5Uu60TvXSAsaiUoWCcIYNhTeDk3tZSIwVmN45nlUREXSU8NVv5P4nxgHVX8dKpwzDYlr9w+nkuq/Mky0lWKOHf0/iMOu0mK5y5UxJpERv+gCYE091R0JRmQBOdn5jvtp++GNGByvqyN7Wkg0nHVXlqa8VWoqDiQNKuAnGK/xzQie92xn6Kka70RoV52uMLZA+JP3emngWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(316002)(41300700001)(38100700002)(44832011)(36756003)(2906002)(8936002)(83380400001)(5660300002)(66946007)(66556008)(66476007)(8676002)(4326008)(6916009)(31696002)(6486002)(2616005)(478600001)(966005)(86362001)(26005)(6512007)(186003)(6506007)(55236004)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S05iQTNMc0tFRWZ5Ump0NHRacGdORFJWWVNsS2tjRy94eDFJV0ppSVoxR3hE?=
 =?utf-8?B?Mno2WGtDUXhndm9xK09aKy9aUXJqNWtRYTBZSm5KU1kzMDV5WWwrUFZDYTJP?=
 =?utf-8?B?SkgwOU5DV3ExT3d3QVVGZkM4U0xsQlF6WjE1UC9QVUNMVWljREdVN0tpMGpN?=
 =?utf-8?B?UWZYUHVaZTFHeHJZc25sS0lGTm9ySTIrTlhOMS8vTnFVb1BzajBCblZrSmY1?=
 =?utf-8?B?Q2RrdG9MWWEyVWhuaHFNOHA0NEF4WkY4SkpVVTJaMVdCYkJNMGc1SVBuVGFN?=
 =?utf-8?B?eEZPRFJLdlNRZmxRL016bC8rYUpmVXdmVVFOdEZzTnhBVlFjWWV3OVVtSmFw?=
 =?utf-8?B?eEpwdW1QQzluczREOWlweFV0d0wySGF2YXVkTlRoWEx6ZDF2bTJxc2UzME9U?=
 =?utf-8?B?VnVPL3VvVGhnQ3hLbXFySWUwaTJad0dTK2hiQ1JjUlQ4K2FjYWxGVDdXTi9t?=
 =?utf-8?B?MlRYZEt1QWpQaVprWUR4M0piY2llWmEyMERBN1BaRG5McnU3eXpkVFFYQUpa?=
 =?utf-8?B?SmxGQmNZTkxjZW8rT2VWbEt5L2dueThQSlM0WEhVY29VdE9IU2lDYmM1eWJ1?=
 =?utf-8?B?OXdCNWJrblJ0TGVKazQ1WE00dEVlcDlEZVlJNjh2anRhZUtOMjYzamZkRGgz?=
 =?utf-8?B?THZud1J2ajdZQTVaaytsVnhzelZndkhmS0VnRHBlOEZsdm5SbjNmK3djdkt2?=
 =?utf-8?B?UldsSnlvbjVBNEMzSzNQK3c1bEZ6T1haQis2aS92WWZoZ1ppV2xscCtxcG81?=
 =?utf-8?B?WVVSdnVsdmJpWDA4N0RFWE5xaHZERTZtRnBSWnRNcStaK2RzRm5LUDNkbW96?=
 =?utf-8?B?KzUzd2FBbVExS1lkc0JoWm03c2lOcStranlTZkk2THpUMTRoSzR5cjZNdGF5?=
 =?utf-8?B?QVVtVFQ1T2dEOXBjMnBUaG94dDA3bWVlVVpyaFJuT3QxT2xVa3dqTXZ2K0RX?=
 =?utf-8?B?QWl5bXgvbnJDdHplRURXZGcrK3FzRURWU3ZWdzRuVlEzeWd3SldWemx5c0tF?=
 =?utf-8?B?a20ydm8vb04xR3F3ZFQ1RUZSMld3eXhKdDZFdHNMVUlZc05uUkRhUjRaaVpV?=
 =?utf-8?B?RE5yUHZIR2l1WHNuRUIxZ2ZYUHlTOXBSZFZlY01ObVFDYnV0azNrKzZlQlVW?=
 =?utf-8?B?TlhHdnEyNXRpbU1KVEVka1BtTklmaEVjeDRPUEtIdko4SnBoU09Vdkh0WmdU?=
 =?utf-8?B?T09EM1hMSTFLaFRxWEE2ZUlGb3FvOWt6NzNwaitqNE0vc3R1UnExb1Nxanlm?=
 =?utf-8?B?OHNTMk1nVjVzamN6cjc2dFlKMWJoY0VOUFRQL1RoVVFjQno3UFBlY3NCR25I?=
 =?utf-8?B?MGJJODRNZ2dkSTdTY0M4M3ZSYU9zNUdCeGZjMVRFdldzbENrYytyc1cwdzBq?=
 =?utf-8?B?K1dncGZPdXIrL1ArMUQzdlJHUlJqRSszRVB2dHFTS0xoYVB3Y3FqczlIVk8z?=
 =?utf-8?B?a052OUJqa0wxcEVMNVMrbTEwK0VqNjJka2lZaERoYVRnMVl6aEUzdEdRZ1ND?=
 =?utf-8?B?WDR1S3V1T3FHODh4UVdCTmtqdE9NNTRLYm5PN3BXNnR4MTArVElCWlV6aG1N?=
 =?utf-8?B?bmZBcGFzUzdocnNmZCtQNVhpcmxSMkkrcjVFSXNybXduVUFHK1ppRzRabmhS?=
 =?utf-8?B?RXFueFU1czZzRWRvQVIxWmxpQ1V3eEM1VW1NYWo2dmRUQzRQaHB1bm5WdDhG?=
 =?utf-8?B?S2lKRFlsZEtHNmRXa0NPbDdlbWVCUGtqK0JiOHA5T3dZbXFXL0VsY2g5bWlI?=
 =?utf-8?B?dWl4T0MvSC9xNU9mYkNaYWJVaER0aWVKWFdiR0NBdm5CMHl3T0xWK0F3anc0?=
 =?utf-8?B?M1ltck5GQi9KU0FnUk1vZnNqRXJIWENpTzRXZld6bWVCeTdOaTNnQWpubXYx?=
 =?utf-8?B?ZHRsQlBqbWRvZ1M4eGE4S3NOa1dYTzZySm11RUdNSHBiSjZpT2FSRjlPZ0w3?=
 =?utf-8?B?MXZHWlg4L3pFbHFvTlFkODNuWlNYOHlEbUFzcURJaGtGVGk3KzVLVUtjb0Uw?=
 =?utf-8?B?SG50NkYzYjVBUGd0S01GcTROZ2ExS1J5MFFYWXYra2lRSWtLZnN2SnVyU0Nn?=
 =?utf-8?B?cHdnYkdhUDR4VlljZkwyUjVFU1NNRDZsMCs3K3JMczdadkE3bEV4Zzl2QUt1?=
 =?utf-8?Q?/MHqWIVzNtY5AbmC2MKTBeb3/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c249fe31-5ccb-46ed-4f4a-08db0d10b595
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 15:49:22.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gdz9NM2AEtTQQ4579HSZisWVbPoeLd7HukkPqY4ht16UPit3lAFXz4jg72DBsrcRpLI3jjIkFST3I9FpymFhVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 18:20, Rafael J. Wysocki wrote:
> On Tue, Jan 31, 2023 at 2:01 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> The acpi-cpufreq and pcc-cpufreq drivers are loaded through per-CPU
>> module aliases. This can result in many unnecessary load requests during
>> boot if another frequency module, such as intel_pstate, is already
>> active. For instance, on a typical Intel system, one can observe that
>> udev makes 2x#CPUs attempts to insert acpi_cpufreq and 1x#CPUs attempts
>> for pcc_cpufreq. All these tries then fail if another frequency module
>> is already registered.
> 
> Right, which is unnecessary overhead.
> 
>> Both acpi-cpufreq and pcc-cpufreq drivers have their platform firmware
>> interface defined by ACPI. Allowed performance states and parameters
>> must be same for each CPU.
> 
> This is an assumption made by the code in those drivers, the
> specification doesn't actually require this IIRC.

That statement is based on the ACPI Specification Version 6.5, section 8.4.5.
Processor Performance Control [1]:

"In a multiprocessing environment, all CPUs must support the same number of
performance states and each processor performance state must have identical
performance and power-consumption parameters. Performance objects must be
present under each processor object in the system for OSPM to utilize this
feature."

The same paragraph appears already in ACPI Specification Version 2.0 [2],
section 8.3.3 Processor Performance Control, where PPC was first added.

PCC [3] is simpler and uses a single header to describe properties
(frequencies) for all processors.

>> This makes it possible to model these
>> interfaces as platform devices.
>>
>> The patch extends the ACPI parsing logic to check the ACPI namespace if
>> the PPC or PCC interface is present and creates a virtual platform
>> device for each if it is available. The acpi-cpufreq and pcc-cpufreq
>> drivers are then updated to map to these devices.
>>
>> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
>> boot and only if a given interface is available in the firmware.
> 
> This is clever, but will it always work?

I'm not sure if you have any specific problem in mind, for example, some
systems with broken ACPI tables?

When it comes to testing, I ran the patch on a few older Intel machines with
PPC and one with PCC. The acpi-cpufreq and pcc-cpufreq drivers were tested in
both built-in and loadable module configurations. It was checked that
intel_pstate remains the preferred option and is attempted to be initialized
first.

It looks though I should have also done testing on some newer machine as
I missed the ACPI0007 scenario you point out below.

> 
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>  drivers/acpi/Makefile          |  1 +
>>  drivers/acpi/acpi_cpufreq.c    | 49 ++++++++++++++++++++++++++++++++++
>>  drivers/acpi/bus.c             |  1 +
>>  drivers/acpi/internal.h        |  2 ++
>>  drivers/cpufreq/acpi-cpufreq.c | 39 +++++++++++++++------------
>>  drivers/cpufreq/pcc-cpufreq.c  | 34 ++++++++++++++++-------
>>  6 files changed, 99 insertions(+), 27 deletions(-)
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
>> index 000000000000..7cf243c67475
>> --- /dev/null
>> +++ b/drivers/acpi/acpi_cpufreq.c
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Registration of platform devices for ACPI Processor Performance Control and
>> + * Processor Clocking Control.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/platform_device.h>
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
>> +
>> +       /* Check if the first CPU has _PCT. The data must be same for all. */
>> +       *pct = acpi_has_method(handle, "_PCT");
>> +       return AE_CTRL_TERMINATE;
>> +}
>> +
>> +void __init acpi_cpufreq_init(void)
>> +{
>> +       acpi_status status;
>> +       acpi_handle handle;
>> +       bool pct = false;
>> +
>> +       status = acpi_get_handle(NULL, "\\_SB", &handle);
>> +       if (ACPI_FAILURE(status))
>> +               return;
>> +
>> +       acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
>> +                           ACPI_UINT32_MAX, acpi_pct_match, NULL, &pct, NULL);
> 
> Well, one more full ACPI Namespace walk at init time.

The code tries to do only a partial walk of the ACPI namespace by terminating
at the first found processor node.

> Also, this only covers processor objects and what about processor
> device objects?

I'll extend the scan to cover also ACPI0007 devices.

[1] https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#processor-performance-control
[2] https://uefi.org/sites/default/files/resources/ACPI_2.pdf
[3] https://acpica.org/sites/acpica/files/Processor-Clocking-Control-v1p0.pdf

Thanks,
Petr
