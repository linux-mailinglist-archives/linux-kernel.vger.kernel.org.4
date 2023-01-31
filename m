Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D76835A7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjAaSuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjAaSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:50:09 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FDC5957F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMyVsJih6PgTExgg23NK5peHY9qNm8IomGBMiXzmODUr6yA9+lfOPSF9DehucTnA+65+xV04f+S29twEmJ8gYWenAS6tTd99qat5ukP0zCqMEiyMU+DVMVPNYcQV/lv+gd41K1y/abv8zfZLUVS0f02oJoxLfIEvkBE2aYrUGrfhs8nnikc+qCL4TCnhz4suWM+SCTKjTCAWQWgEVe2T5o8TGzRAc+rLqC/FwEhhzDdC541aUAiRLhh3EhU8gsUBPLY4zS35L2C+ezXmJnzIYLM6YAdpReooiKP6kPljCtQBfr+L4RtLt5W+ngQPXHYLUyqAnXpaqgj7qmR3HndyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xDy7rYf6hdvXUDXA5sBnAtUdZHSSRiDjCTSV8V7nwM=;
 b=NMLjFrAoFFWIgTLTA6yJyYpdaeOayfatSzm6JPEW/ey7WIqHbDwIL+uLWup2BL+DICwQMZa6X2FFNQJqD4TS8mIKlklZeKPwCxsXkClUPKQXEhuIoNU4hWYrRo4mw88PAJkQIUYJfGVYxKCUM8qagDyh9v7SAhMwteMe6u/10611HI/xUd+jwBEmAs18VicMjs+KiKGWSc/Ajs2Xuikq2EsWxmKPZCrGFNx98p/itz0Ln1NLtQHS4cxmxYz07PfxGGXqWYfU0I/0zpSnaqa2+b1nlFPMeLtpQtZ40hF554z5PMhzkDWOrqHf5v3WJMR2u2z2XxxaienWFr/VlIqOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xDy7rYf6hdvXUDXA5sBnAtUdZHSSRiDjCTSV8V7nwM=;
 b=jSjfmxY4bUGi8bbs7iadAavX7EV/bTQBlW3x9fcDPdoVHMLcTxjyxcO62SQj6iO2nbHYCi9L4+yZtrEFCk5ky35LWbQ5uddeFG4GZwziwpvmou5Gent5bpPllZPOQhgyHEx06gInIg4IPDOOpaw6y7lwKxHMNEWV3rNXDoU1+yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 18:49:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 18:49:56 +0000
Message-ID: <194d8448-dde2-3452-7ccf-4e88fddbff75@amd.com>
Date:   Tue, 31 Jan 2023 12:49:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 3/8] x86/psp: Register PSP platform device when ASP
 table is present
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-4-jpiotrowski@linux.microsoft.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230123152250.26413-4-jpiotrowski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::16) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4ef536-dbb5-4ad9-7db7-08db03bbf28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4emxBHHWH2+G88G224Dk9tDie5IE5ipM3aRzY7hV6+Y2p3HrCzAzyAU/V9CuprWgcoZSO2tvCHV9hB2I4s7GeDwy72X3N4QnnCU3gIigmtiqQCXoobH24rS7186uqXnV9eh65c3gByUIqUsKwMBTUb/j5Xc4+IA/dREDabXyBeVQSiWwFiqyWfcG40VM6Sm6QXWhTt16JZEskRKz+OLTO4YgeFWfF3H7mI8K70WhRdS7n0fVjnxpLlT2ixyREinETh98uiBFiVXTDpoVWxZSLojmixwKvg1/vXcsD6jb53roDp0C5a3CfEZZGY+IOgtsdPIjEE6ixr380KAw0esnNIdd02WWbcD41WHIYN0f+dCBBad6zzgmwXpG436mfvzBk5c92mHGWtCCivNwAR5ippAiZG/z8n6VFgg1orcinvPde6cFKzSNirzSt87R9J5pCWeiIEqfYnx06O+8DEuU/hyP3JcjLnkh9i+GbhqKhiuQpxoXVhhBPoMDHAI5ulUqawF50XG8JJZEPwYvJoq7HdFEuj4pLX+XsuzL/qjISsPV8ActRSLqAqQdhUitcaIbc46zKLOG4sdV1BRP0mVP8YqEOzJqo8lPSK/tPlBXg4wpnlyJaEo3Um83vy6mPqBzIx8xroQi1DgBM1Gi+FEA+6qLq8Tj1iUQOblFxSQ0zScu9TGgqnoW8peOG8pQDrBrb6HcYa6s0yQUqrLzFN/Cp//ORaw77PqIoasvO1bniAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199018)(41300700001)(4326008)(31686004)(83380400001)(66946007)(66556008)(66476007)(8676002)(316002)(8936002)(36756003)(186003)(6512007)(26005)(2906002)(5660300002)(54906003)(478600001)(6506007)(53546011)(31696002)(86362001)(38100700002)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJYc0ZDZjdFeGU3R0RIM3Z6cVJ0UXRMdHVFMXNtM1llZ01UTzVGbmxlMFFH?=
 =?utf-8?B?MUpIZG9tSkpZNXVwaXh0R0t4U1U4bkNsVjVEVVdVV0wwOTJoSi8xaXZvVWcw?=
 =?utf-8?B?Q0pSTVZQR1gxcy9zcHA4OTY0S3lqTUdNY3VObG5iVUJ2QjNOaXJBWU83Q29X?=
 =?utf-8?B?SUR1V1dUczF1MzhTWWkvUng1aHhpWWVEd0RFZUkvR2Z0NWlkazBYUzAybVlh?=
 =?utf-8?B?b05LRFZQdDZqVVBjRkJ1c0M4TVA2Y1lDOURscmlaVlJSQ0FoYlVzSS9iUE5D?=
 =?utf-8?B?Umdqc01EUUp6bzRCbmlJOUZzMStqR3gxS3FyWXg4R3BSNnl4Q1VZYk1PZ2Jj?=
 =?utf-8?B?Yk8rVHduZzdoQXZXVG1GdWo1ZkhtdGthRTVEYWp0R2FrN2R3RERET244aWg2?=
 =?utf-8?B?SXVoNEh1U05sZUZsU2ZkcG9VMjF4b0tlQ000dEJHb3lQZHZKQ2lrODkybmw0?=
 =?utf-8?B?OHNJSWY4R2xpR2tXeUxIb0RGUEI0aDVIRXMxL0oxeEg2bklCRW5LeEZtcHFX?=
 =?utf-8?B?TGhEdlJUNTdzRitUaHc5dWw3dDE3U3VuNG5pQnUzRVYrUHY1eWdxUWpna2VC?=
 =?utf-8?B?NVpwZ29yQUE3ZEdITStoYXY0Rm05YWNxbFVWV1o3ZlErTmJtaFdZbDVTNGZ5?=
 =?utf-8?B?YklpU3ZUYWF6cFRUZU41eUwvblAyM2NlNFU3OFNtOVJsYzJyZkpNSjgyMjJB?=
 =?utf-8?B?RUR3ZFJ6Z3FvRUgzbVRDdThQampvTUpUMEczL0VCbGZta1QwSFN2ZUp3cHFI?=
 =?utf-8?B?U3VDdG9Ma3VHQVRZUG1yYlZHa1BNcEN4VjEzbDg1bmhjeGhvTjFTSUMwSS9U?=
 =?utf-8?B?T0U0TnpyYkJjSjBZWnM1djVzRUVxTktKd2ovSE5DUmpUMzdoZFpKU1NEd2xl?=
 =?utf-8?B?ODUyMXRzRURYTU1RL2lXQytkQ1Z3M0ZHdE9wdEcvK0QyYnhkb3k5TkNSUXhO?=
 =?utf-8?B?V1FuYnh0cTNlMXVHV3M4aU5lb2tyUnUzZEZCOCs4VzRPaCtnZ2lTMUgydGNM?=
 =?utf-8?B?YXNGRUlVRlZCS0Vpa0d3V2hsaWZFZi90aW9mc2Y2Z1dwYnpvM0lUOHpFMXRT?=
 =?utf-8?B?cTRoTEQ2SlNRZXVaa2NFUmNaVlN4aEZ6VE96bk45bkVZY29XczhqVzBTWFBU?=
 =?utf-8?B?QWFQaGJRTWhOZGhTNnV3NG5ySVUxTWx0Smd1RUdlbkZSQ2NjN3V1bFRia0VG?=
 =?utf-8?B?dEIxdlRVMjl0VVpJVVpnMitMUWN1ZFVMZmdGSnlDeTc2bGwraWdmUjYzU2RQ?=
 =?utf-8?B?NlgrSisydkh4cjlrVFhBSzVRQ3B0Z0c5bEx3WTJCcS9OMGNGMnpHNkdhTW5a?=
 =?utf-8?B?YmxLeEdWVDJWL1JvWEdBY2YrL29uZnJqV01XWjNMN2RRM2U3SFVuQUN4TFlV?=
 =?utf-8?B?UE5ob2NacGRyTDJPaEhFM0xKSjZrZUZwTzRQY3AyQWhha3lqSWg4d1RmYjB2?=
 =?utf-8?B?amk3aVhtTkI4S2JwOU1uZjZWSTVKWE94bS95UmxKbUh1QUdyRHRhK3lYOUc0?=
 =?utf-8?B?TVhpNUUzcm9Hc2FiczVRYWQ1aTVVejhiNlM2UGVKRHlmM282YjV2YzhVc2RJ?=
 =?utf-8?B?QUhSUFlGWXRpaW4zYkdBVGZBMDhieGpDV0pBMjJEOG9rUDZlRzJydmIzMWNZ?=
 =?utf-8?B?MitFUFhMVk43R0NHbGNIdzlXYXBpQ3JzcUV1RFVJOWVKVHMzNURDRFJtVkhm?=
 =?utf-8?B?NVVhYURyUndtVCtONTR4VS9odUdhd3NVdDZwYmh0OThXR0I4bVBQVENYK1Fl?=
 =?utf-8?B?eHVhbWNQVm8rOUpydGhwTlI4ekh2dlRQbThrTHVsUW54ZUVZRS9aYUVQNzI1?=
 =?utf-8?B?YkVTQ2s2Tlhtcmt5TDI1cjhkUzNHbElTMjhQelNYcFl4T3dUaklPRlhmOWpN?=
 =?utf-8?B?YWowZStlRmlXeGNxNUdrSTM1UzhEcTY5RmlpNWdkVUowQlBsYStrdWhLOUg1?=
 =?utf-8?B?UFZWL2xvRm5jN1lmWVl6aVFYcDdnLzliU1RoUmUyTkg2NXVNUmNOMWhTNWJG?=
 =?utf-8?B?ODhweWwwU0xTNE9sckRmVjRhUFVjSzBKQUh4dmNtMU4zci8zK0pWdlVIOGYw?=
 =?utf-8?B?QTVNMEttWXhwZ2hmUzBRYVFJMnlHbEduaGI5a1YxYzRMeDMzMllUMDZtN09N?=
 =?utf-8?Q?xuZKfwiqV3T84x5rchECINx/6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4ef536-dbb5-4ad9-7db7-08db03bbf28f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:49:56.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGpTaWmZM77Sw0Q0wQoJQpjIgAUSZzovDazYBS7xKQyRZdkx09Jz7dwq2MVf3FgvmHgS1jzy47R30Poekep2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 09:22, Jeremi Piotrowski wrote:
> The ASP table contains the memory location of the register window for
> communication with the Platform Security Processor. The device is not
> exposed as an acpi node, so it is necessary to probe for the table and
> register a platform_device to represent it in the kernel.
> 
> At least conceptually, the same PSP may be exposed on the PCIe bus as
> well, in which case it would be necessary to choose whether to use a PCI
> BAR or the register window defined in ASPT for communication. There is
> no advantage to using the ACPI and there are no known bare-metal systems
> that expose the ASP table, so device registration is restricted to the
> only systems known to provide an ASPT: Hyper-V VMs. Hyper-V VMs also do
> not expose the PSP over PCIe.
> 
> This is a skeleton device at this point, as the ccp driver is not yet
> prepared to correctly probe it. Interrupt configuration will come later
> on as well.
> 
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>   arch/x86/kernel/Makefile |  2 +-
>   arch/x86/kernel/psp.c    | 39 +++++++++++++++++++++++++++++++++++++++

Based on comments about other SEV related items, this should probably be 
moved into the arch/x86/coco/sev/ directory.

Thanks,
Tom

>   2 files changed, 40 insertions(+), 1 deletion(-)
>   create mode 100644 arch/x86/kernel/psp.c
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index f901658d9f7c..e2e19f2d08a7 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -139,7 +139,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
>   obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
>   obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>   
> -obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
> +obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= psp.o sev.o
>   
>   obj-$(CONFIG_CFI_CLANG)			+= cfi.o
>   
> diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
> new file mode 100644
> index 000000000000..d404df47cc04
> --- /dev/null
> +++ b/arch/x86/kernel/psp.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/platform_data/psp.h>
> +#include <linux/platform_device.h>
> +#include <asm/hypervisor.h>
> +
> +static struct platform_device psp_device = {
> +	.name           = "psp",
> +	.id             = PLATFORM_DEVID_NONE,
> +};
> +
> +static int __init psp_init_platform_device(void)
> +{
> +	struct psp_platform_data pdata = {};
> +	struct resource res[1];
> +	int err;
> +
> +	/*
> +	 * The ACPI PSP interface is mutually exclusive with the PCIe interface,
> +	 * but there is no reason to use the ACPI interface over the PCIe one.
> +	 * Restrict probing ACPI PSP to platforms known to only expose the ACPI
> +	 * interface, which at this time is SNP-host capable Hyper-V VMs.
> +	 */
> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> +		return -ENODEV;
> +
> +	err = acpi_parse_aspt(res, &pdata);
> +	if (err)
> +		return err;
> +	err = platform_device_add_resources(&psp_device, res, 1);
> +	if (err)
> +		return err;
> +
> +	err = platform_device_register(&psp_device);
> +	if (err)
> +		return err;
> +	return 0;
> +}
> +device_initcall(psp_init_platform_device);
