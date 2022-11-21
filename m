Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE163273D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiKUPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiKUPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:03:17 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE24E3D28;
        Mon, 21 Nov 2022 06:52:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwqsWwykpeERZjTrOKPKvPnUGAGfRD5RqV7xPoonMCqh/aamOa+XfTBMprUlBdXwj5EKYBvgzpu9b1JNf6QmiNCHum2Iko0PwYCHjYt1Vf1tWaLc4NGIkA9+Hl+i8JgYcg4WSgi4ynz/0ht6pc9yyzDzIfsyCZQ9pNdXXMwD1arVlD2c8flc5PZl4BSGRP7sAvKHlILiGKk5iMf/ZKAlVyKDxFpqbhLUfjdRY5GAXhuiNcyT+Qbsai7XpSMjVdVl+Xe+Wo8DV7H76CHs9Gf9NdIIxrVKXeMeo1fhmElDRx5/TI41xDsGFjkDu/ECGnPhh385+fHYOCk9xxYR15G7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSZcEztiLzwU5is5DeASIufqgCPwdgIddl565ZM4GGg=;
 b=ej0fz81qnsKeb8ji87w4pptrf2crZPVStg4KrB576jVe6kNqIM2PD2ugvJ/ICEIsscfbeJHbQuAvqEiC7aGYWxWgHnx5AilF5nlfpQnF6Ir3ZtTDSwqciq+uv9OsP+4Y0n4q+37JsPkOnKB8D0dSiR/gkYSVPXJzWSct/g/J3oQZeBzop1IJdUsSJZGa+zsQeeHC/JA4U8g7Rro5RgA4Xd7rP3hsFSUH39qVhqoFjZ6A+KUxjuJDX5kN1/Rmpr0t9PGhFSnEUGWYOkVkGuMmInRprAju+8ASnFVAkoWZDWRVqPljzAYQ7VY8dZWqSYbaeyDOXz3buGET83xRpnN2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSZcEztiLzwU5is5DeASIufqgCPwdgIddl565ZM4GGg=;
 b=Uov2Ha+I+9QYTw88tMO7H6k6bEuLZatlnaN2ikpeIj57kb+6AeyEEnr11GC+PazmR+ZSMnIT7say9RSV2eN0pNM+ebE+3B9IC89Sh1cPs9HkLjM6O6uEjcY7AeNpIQUENiOnnNK+/WZOGByYG6bXz9FTa/iQtisFc+25SW1tm+Vo+Wj3w9y9pPI5X/bbrQAxGjjMBJmgjZR9IEmZfPs1+mL4WLR6JilCtkreUwzzIFSn1B/JnYNaqsx1hS0bO4U046tMUnbrbPKMN4cuL5iC/Gh2f72B12p39a1BtBpTsASkzzYQxNmf/sh4Ndp4Ow75Ewt/7H0bKuC/Q+tskinPDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DU2PR04MB8679.eurprd04.prod.outlook.com (2603:10a6:10:2de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 14:52:00 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 14:52:00 +0000
Message-ID: <53a21308-0948-66c9-86e0-d576ab884567@suse.com>
Date:   Mon, 21 Nov 2022 15:51:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <d1042d77-eb5a-6577-9ec6-e6a7997f15d7@suse.com>
 <Y3uLXq1diou2lHu4@Air-de-Roger>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <Y3uLXq1diou2lHu4@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DU2PR04MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: 504646fb-802b-4079-739c-08dacbcff19c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NYzLrUZ077g3c72UED1CGwDpmviBsy6M0RwXvYah5ycOH+NVX5kQk9UNgcLQerkVWIIwM5LmptlaYVRlBm9War1vn+DuIWIRELhK/M/OQuW7t3oCIfu7plhm2Y+KstAjLebW2EPk04Rkw12GUg0+7JJYlW0YmBfAMMtHlIWIZBGdoEbhd1DLXkOC9cHWTE2B9iCH96xcOIlFOkpDnMeb5i5D8KYLEzR8amV1fXv1z4LSbSzC6Fo889q998bqpq6JUXXOXLP71cgpeaJyd20MC1U2f6/w+WtQMnPHu5AfAlui8xw6amanKqqnhusWx6RQV7ZWlDWHaJUyOgLLiK07TTFDQdpsl8AVoiVGEtPm4j3SX5ZWmKyJbgpRYl5AANsLj3e8801XvOUV0QGe/V5//ASDDIhpaIoHUM1CkY9gfnvHwj1lA2pUQR5wG8R6YTJALTrLmLboZIfjtj6D9TGTB742yZ68xtCE4cNR/boYDiAscWCVeTXtUjsjDv7AozlssmVMaINj7pKThmaYQp/y5EgndcCNt7KYks7Y6lpqgUdYnbIFgPhzrGBcSmCz6mrIAwFXoAlbzy4yASaoZWab4fv2vT11looaqrgETVWDHMfH4z94DVyMWS1A59eX+ATXQFioJWT1Q6ck3f9fjiG8vi2DtiSneJpaaQVGWbRFa1DVfmXDAeijc4OfXKqEcl9L9SLdAiQbIuypz4C7LgjfLi+CRvVelbaNUJH31mKEoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(4326008)(66556008)(5660300002)(36756003)(66476007)(2616005)(8676002)(83380400001)(66946007)(54906003)(316002)(6916009)(7416002)(86362001)(31696002)(8936002)(2906002)(38100700002)(6512007)(6506007)(26005)(478600001)(186003)(41300700001)(31686004)(66899015)(53546011)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkVYMDArUEJXdjcvMXo1Qk1EOUhDQ0Y4WUsrVGx6eEFORkhXeEhlOEJpVnU1?=
 =?utf-8?B?Wm1VV0lPYS9DTGpUc1VQajAwNVR6ejdzSjBsbXV1aitKVTBlTEFKVWdpNGRS?=
 =?utf-8?B?MmZuNThUMkNGbEp2ZlFPQUU0VVA0RkRiZHR0MnZJU2Y2aDFJUEF5TnYxOTFa?=
 =?utf-8?B?T2VaMkRQanQ2ZkNKZFNQcjB5TVlqTkUvSVVoYnpaOEdXOFFmRnFKWFhWbGpj?=
 =?utf-8?B?d2diQ0xvUllSQzJ0MGswS1VzM2hGUjJONTdMb0F3aUFHaUd3dmNGSXZTS1VK?=
 =?utf-8?B?MXhHZUFmYmhXUEM0YTlGbG1VOG9PdWtUUE1hcW9sTEw2eHdYUEh1R0pKNmZT?=
 =?utf-8?B?b2tkamNBYmtOUGdwcGdvcWtRWVVBck4zM3l6aUNUSWZMTW4vMHd0RzdHS0c0?=
 =?utf-8?B?OXNDMlRiNjMvWWc1TXRoWmhyVURDK3lndlNhR0RCbG5iWG9uV3k5eWVReHMx?=
 =?utf-8?B?V0VCVlV3NkdqSHl3cnA1K2FJL3MwTnZyT1F4VDMzQVpkNk1oSy9OalhpQmxW?=
 =?utf-8?B?QlJoQTltMG5xbUFnRllZOG9WWm5MTWpTNUNpelNITmJyeTB4d0F0Tjc1ODQv?=
 =?utf-8?B?QXRXaldpcTUzdWkybEdCOUx2VUUyZnc2Zk9xNGwwekVkamJCZmZsM1RIY2Zl?=
 =?utf-8?B?Z3VFZW1GVFVPZkZPdkVnU0pMa1RWc3ZHZXBKalhkQ0lRZVZMdmovS053RjhS?=
 =?utf-8?B?eG42a0dUSmgya1I1aWR1Q3d4N3NQZHEzc1JVSGtSZzdTK0tqeVA2eExxdHBt?=
 =?utf-8?B?RzZTWEdqVU5hS0Z5SGxSekp0SUE4OE1DUGpDUG1yTmtwOHV3NG9JQ0lsOUZK?=
 =?utf-8?B?VTJ5aURCV0JTd1BmdS9YVWNkZDB3NnlqYUo2V2ovd2pJcm1vZ2IvRkYrQzZz?=
 =?utf-8?B?MjFvUitwVWhHR3ZMcUptZVkyWEdmcFNlbzJnTFYzc3Npb0JYaTVSZFJMdlhn?=
 =?utf-8?B?b3JMSCt0OG9JSFFiMkFtNmRIdlRQYnQ4SHhVWGJseG80dFRyc3l1UFRjR3Nn?=
 =?utf-8?B?WENmZmY5QlpDK0FxeTBzc3JpWmNKWGRZMlVwNllmMzNiWkdjQk0zdFppa09j?=
 =?utf-8?B?V0N3bzNnUk1objl6VzR1bmw1SG5mRkhrYjdTbTVVSHk3VzE3YkRud29UM0pJ?=
 =?utf-8?B?ZGdlT0FSWVBFRHBQOHliYUlEMStvYlVmeUtKSXpNNU9rRE1tQ3RxV2s4Y1gx?=
 =?utf-8?B?R3dqRGdMbnJqMERyTllxaVZkOEFQMEdkOElHNnRaNVo4R0lhRXZZeXlMQlN2?=
 =?utf-8?B?d3JhZlJGZXg1c01oK3Q1eXp1ckFxaDVGMU9xK0ZuZld5SEd2Y251bTBWdXBs?=
 =?utf-8?B?R0llemxPeEVqalJpdUtCd0Y4OVFMQ2ZYRmFzcFlJS3hPMUxUNTRKdlRvcXZQ?=
 =?utf-8?B?WTdwYlRubjhUUjZOZ2JuTVlNdFN6NFE2VlVvQTVrcFpuTnVaZ2JqVnpJTDRQ?=
 =?utf-8?B?WTVSMFEwdlh5MkZXMzUzamU0ZXpyL1lZek5HaFFQU28vOU9kZmo2eWdHWm9t?=
 =?utf-8?B?b3lnbitnTVdtOFdoWmhYTkZoN2lJRUhZZ2xyQTg4RG9paThwV0tER2RON3p5?=
 =?utf-8?B?Q2grUmZRTis0dFkxZktpV0NhS3hJRXlDcGlkZGdPb2xJSkJLRmZSL09YRXNw?=
 =?utf-8?B?TmFEM1BXYkU3bG5EL1U4V29HdjdDaXpIOWszQzZwd1RycG5XWGZQMUx5NzNQ?=
 =?utf-8?B?VjFJcVhob09JdTFwVWpPNjNNajJMTHhyNjVBaytmczNnT2E2a1l1SG04c3dm?=
 =?utf-8?B?OUFyN3gvTm9pb0tCRGJzSVNPZHM5SXZzQ0IwcTQzS05QZWlPOGk3SW02NHEw?=
 =?utf-8?B?S0xLZFFwNFhKeDVnN2pGMm9KUkJmWHlKc0NraVFFbk9ybnpOUWk3L2xhSzda?=
 =?utf-8?B?ZXNsVzZsdU53WVJyZTk5VTdvYW82dERTcHFQRnVDRG1WaFNPaTVpcmhTY3FB?=
 =?utf-8?B?M1R2LzVqc1Z1YkIyUW82MFRjSVpTcFZpdXc3cU42RW5GYlBvMG9mdis3aDhK?=
 =?utf-8?B?RHdnQlJMc1hSS3B6K1Z3M0xYdkxjc2swUi9Zd1Z1RG5STXJQcjJFL0VPanND?=
 =?utf-8?B?VE5tVlFWNVk5dkpLV2t0ODZWRkNlbG0rZzI1d29xdER1dFkwZFg2ek1tVm85?=
 =?utf-8?Q?hBfbHye2Vo5kCgLDNtKv2+hWi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504646fb-802b-4079-739c-08dacbcff19c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 14:51:59.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPhZ8P0hb2xchzpuuJTIOo81cBY4J7yhoiqHcPlrpXvp6Fm2mG2Kq04PA8G+OxO2mn11I2gZhZ2lZ2xZBIS7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8679
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2022 15:29, Roger Pau Monné wrote:
> On Mon, Nov 21, 2022 at 03:02:30PM +0100, Jan Beulich wrote:
>> On 21.11.2022 11:21, Roger Pau Monne wrote:
>>> @@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
>>>  		return false;
>>>  	}
>>>  
>>> +	if (xen_initial_domain())
>>> +		/*
>>> +		 * When running as a Xen dom0 the number of processors Linux
>>> +		 * sees can be different from the real number of processors on
>>> +		 * the system, and we still need to execute _PDC for all of
>>> +		 * them.
>>> +		 */
>>> +		return xen_processor_present(acpi_id);
>>> +
>>>  	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
>>>  	cpuid = acpi_get_cpuid(handle, type, acpi_id);
>>
>> We had to deal with this in our XenoLinux forward ports as well, but at
>> the time it appeared upstream I decided to make use of acpi_get_apicid()
>> (which meanwhile was renamed to acpi_get_phys_id()). Wouldn't than be an
>> option, eliminating the need for a Xen-specific new function?
> 
> While this would work for PV, it won't work on a PVH dom0, since the
> ACPI MADT table is not the native one in that case, and thus the
> Processor UIDs in the MADT don't match the ones in the Processor
> objects/devices.

I wonder whether we can actually get away with this difference long term.
I've gone back and looked at the commit introducing the code to build the
replacement MADT, but there's no mention of either the reason for the
changed numbering or the reason for limiting MADT entries to just the
number of CPUs Dom0 will have. (Clearly we need distinct APIC IDs, at
least until Xen becomes more flexible / correct in this regard. And
clearly we'd need to "invent" ACPI IDs in case Dom0 had more vCPU-s than
there are pCPU-s.)

Jan
