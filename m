Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE21A738CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjFURMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjFURMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:12:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3AB3;
        Wed, 21 Jun 2023 10:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eho4tAFb4UX0DE4JyB69vWCuPwudKtjHbtXzKAep9jozwF75YKuV8NiwLu996CwKyP9t2dkaAI3Vy3vSsvt6NjCqFfrHVgXztzHUJKw6Kz5/0OMBJcf1unN5SbremBZDhNBKajzsTvoHI4dZG3Mkz1eRPEO8Z7XQqQW78bLaqoMJe4NLUqOw+JmeAt28YvUSf0nmFKG/C39hMvV+OD503XFlZ65iomWDQSDfYjEcUiUU7eRROPb62w9kU9Cq0DtHa9o7DEo6gDVS8ppJblwNlHeKZhM6VB35jIAlOm5NDgVJ7aTUkysegCJMECU7m3Ab4E1TOFl8L+MiOVrK+wQJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A9DVQgzS9DWRv6ZiGnJmNF/wMnib+H4UxmcsW8hGUM=;
 b=lR6GnOd4nkZQvukrObBttWK1qtgyxPKThTyIuZl4Xu4px1foN1aJMlpmxEyXq3SOsaUm6WrdYoIp6yl5jySdisCoV0ZK4CGzwEt+QV9QwNlo+E1cG3QkfW8+WkFXoeuiVlD+qMJOncGxLtgxbLYVeoIGwo2CzEdE8u6nKzgcL4yehRko4q0gWiyUZ9nXoiM/m1/CpN1K31z77q7MVABRhWY8lwGp/5wQPNjkP3A3KMz+hhmQ+tH/scQX88ObEaj8o1fLfSWC/MHpMGH3+6/FqDWZPFaFZFqsjeXJYUNVcamOoFwiNunEotuR49KpA4DA+AdwjEMWS3czChKDLzbqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A9DVQgzS9DWRv6ZiGnJmNF/wMnib+H4UxmcsW8hGUM=;
 b=Fteqe1Fx1sx+auPqpnkXIxooCe+wDGJPMC6KmKFI6gQ6wVBlnprRrdPjvC3wc+/CF316VvH4zXAiCSfsrJ2JmbYkamneoke7m5MJA5Sxywt7jwi/bmVsTExbXVSbbYrLIL2eADucN6/nT3jeQMtBY3iUpBZfnjQwdbjiHPbmasc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 17:12:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 17:12:30 +0000
Message-ID: <6c572cce-f596-1e95-f834-efb6b49b2ea6@amd.com>
Date:   Wed, 21 Jun 2023 12:12:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [patch 13/17] init, x86: Move mem_encrypt_init() into
 arch_cpu_finalize_init()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.670360645@linutronix.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230613224545.670360645@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::34) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 24402f93-bede-4422-8375-08db727aafcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5aJ9csGD0kvQEmNMbSQFlus/1FpIRNC3pRqIwojT4vrjbYqYoXfi7ny2Af/y/6b25ECvUoW0LV1phFIphuwG1Nb/ls6iWAh/cCVyqiusEDOT1UAi36aMPLNo3ZZPhQdqg7Y2kXXHvoOYyq95BvkOg6utlH2WxLaG86Q7Iuku3VZM0lO4FrZoeYGnY2aickD/yroxR2Q6q8/ihr+ZLy9Gy6J32Olkircl02r+vBv9XRE5Z+p0HnOEVWpeD9zgscjncAoVyeuwA5LozzyrChEmFrVPePmnxpwhM/NTNQabslXfW+GbsoHsjkhFvYt0FNmdgtsAVow5zTwMMyMb0VPNZMa9vFAGP9edm4VWw5G5IkZfizdegGbFd5mFcEpur3OoZc8OAyI9bQO9Tf+Zbl/oKqIE03xZqnI+saeS9evaSsf5K1q0zwwgHVRWaHZt0bc9OdFtbMl1Q1oxCBYNSBrIrQdEyMn0AAwoy8Dc/rTSLoX6Uirih7AMXhJv82tztZKljDYqPx1FM0NLdjzL2k8XBWQy67DiuDxtIVKZ6tSuqQCvrnIo5Vc7D4PcgzAkHQD2Hzmw4NT7cKbx0CgKtuTDb10DTpPTtXrQFrVZfR75D9m+Hjo4x6xzpVt4TG2GtSonnJQAaN9gvNp083Gpk7sgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(31686004)(478600001)(66946007)(66556008)(66476007)(36756003)(6666004)(316002)(54906003)(86362001)(110136005)(31696002)(6512007)(83380400001)(6506007)(26005)(186003)(2616005)(6486002)(38100700002)(53546011)(8936002)(8676002)(41300700001)(4744005)(5660300002)(2906002)(4326008)(7416002)(7406005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2cwVWRxY2UwaWdjRE9vNERDUHJOM25UTWYrZGpualFEUkJlUkdsUXZyZzhs?=
 =?utf-8?B?WXBoWHE5MHZPUHJ4dWFaTThRQkRoUkR2YVV1b2VmVUlaN1A3MVdLVS9xZXM2?=
 =?utf-8?B?OUVuNVpOWS9Oa3B3TWpCUkllcWpxdzlUWDd1dVZOSU5PRGpGTlVGNUhUcE5u?=
 =?utf-8?B?UnlEaExEaUNLNzdKQ08wZDNQdzFHYWdSK25BOHVNMXRNS01vTEQzMXRZeHVF?=
 =?utf-8?B?OXNYeVNHTEFla0FxVzJHclk2UUI4QXlWUjNKZ3ptdm9nZGJYdHllSGdKR2Jt?=
 =?utf-8?B?VXFacTQwdFQ2bm5IREpROUFCTnpoQmtxS2lwR1pvRkVxU1lKUlkyM2MvNkRp?=
 =?utf-8?B?bWRybUpLaVFNNmJ4MVlBYkluWmhOS2JucWF6aDBHd1c4c0lwemlraDRxYXBt?=
 =?utf-8?B?ZThITWVMOFNyRDlTc1NaaGc1cVlZeFcrc0dSS0NvVzZqS1FUY0ErZVdRN2Jq?=
 =?utf-8?B?Q3EySnB0UEI5QSt3OUV4TzVVSDhKYjJPN1NCNlFLcmtSQU16SkcrWlBkSDdJ?=
 =?utf-8?B?NnpuMDJid0hac1h4T2dYTkl2ZnZsM2FGbGRxQ1JTc1UwVzBjZHFLeHNkdGZL?=
 =?utf-8?B?VElHMHFNVDM0ekx4cVIzUlRnR2hTdlJWazR5STQ4b2N3TjJyNU9tM0Y3QVhh?=
 =?utf-8?B?M21pZDd4TVBZdzR2Rzd5K0ZoUnF0Y3hoQTBWL2grb0FDYmZvY3pVVU9FdkRq?=
 =?utf-8?B?VU1ub0I2NVFLNHBRSXpCcFFVWnBUR25KcmxzK3NuUkVuZ3FIMEdXODgzeW42?=
 =?utf-8?B?UzVlK1MyMGZiRmdHb0FJRzM3REdqcGNVVnRVRG44M053M1ZjYW1VY3VManVn?=
 =?utf-8?B?MDRlaWRUcUtQRzdKZlI3d1F5Sktidy9iNS9ONTczREFkVFBOTHA4V2EwN3d0?=
 =?utf-8?B?TW5DZ3czZ0ZoRVVJNStLbWwxOUVFNU9SSzI2eXdwc2l1VlhCaysyeCtwQWVN?=
 =?utf-8?B?VHdpU1ZuUWhWemlCTU50eVVkTkltZFdlQmUzR1krNEVCbktyNzNsM0pvY1Jr?=
 =?utf-8?B?WEFLcmRrZXJRd0NsTDlmQ08zY3NRcEV0RVMwaWl1NXJsQ2dPMEVtaVVraTVX?=
 =?utf-8?B?MWcwb01hOXNZbmdEM1BqaXV6KzVjMDJTV0VMYXNTVDIwZk5Wa29RbFhibzBJ?=
 =?utf-8?B?c1JDaGJhblFHYngxaC82K1V0YmdJSGhYS3p4cFAyRFJ4MlJ6VmN5QzFFMERk?=
 =?utf-8?B?ckwrdFdaSklXM2ZaR3k3MmdnNGgra0JrbFBoajZDVkIwSXJHK0QvTEhINERh?=
 =?utf-8?B?Ui84b082WGhLM3kyQ0gwbnI5N0JqeXNMTG5kOC96TTJWYW1sSm1iVzhQck9u?=
 =?utf-8?B?V05hMWRSc0Q4N0lSQVZjaTh3RGt6cjFqZTZCRkJhRHM3cnZTRVVoeGk0RWpW?=
 =?utf-8?B?SVd5VnhuUERTZWNhbVcyRnFONFBrR1BBaHFTRjhMRGR1Z1BmQnJVVllxRXdM?=
 =?utf-8?B?VHlDcndnZXR2THBRbG82c2tOelF6NFZ5ZHlJZytPVkEraERneFgwU3I2eXFQ?=
 =?utf-8?B?dm43QWFMa1J6MlJWU2tIY2RHV0ZJKzJ2eFZpUTRrYXFyVGNmWk41eExWRVdp?=
 =?utf-8?B?UE92aUJVRHkwZmNrVzNFeGFuWlp1Q0NHZUhvV2lpSU1sV2VicDgzem9IQ0M5?=
 =?utf-8?B?TkMrdXlZWmlMcWEyWTVQRlR3bE9YSE9BYUtWNngwcDBSQTd4NkFlUyt5OHNG?=
 =?utf-8?B?UWNDdHZGeStlUjBMK08yZ0JZOU5vdWxhWklxR3V5Vm5CQ3hMa0pLUThXSno3?=
 =?utf-8?B?MjFBc21oQWdEMU9pWm5wdWpKK0FQL0RTejJSTmk0bE5pcHVuNFBLL3FhYnU2?=
 =?utf-8?B?UW11azF2R2N2VkdGRVQ4SWx6YmZXdk9USlRKYWpKdXM0RnFqWDJNK3VrcXhI?=
 =?utf-8?B?Vld3aHVwNys2OGw4TUZvdU13OVZFMC9ITDJKZ2I2M21qT3VWbjhNVW9ja3FE?=
 =?utf-8?B?ai9BSEV3QjlxRzdOSXR3bEFYQ0VxamprY0lsOU10S2Y1VUw5ZzA3QzZpR1dl?=
 =?utf-8?B?ZkRyYmJrZ2swcllaK3Bqd2JINCt5RmlubVExQWJIRkUzNkZZSGd6WXJwSlpL?=
 =?utf-8?B?NHY1UGExL090SDNyc1JPT0pZeStDWk9jdXdDcmJyV29OdnlRZVFLK1FaWjVp?=
 =?utf-8?Q?M9/01UBEybqWEphqZo7GApvPD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24402f93-bede-4422-8375-08db727aafcd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:12:30.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnyXSgu0SNegjMGQqQhBFywene8hE3DCzXzvACM17ckySPa0s4eHBRHV2rguFDYFsJr4E57od4RvjdfVMm+ZAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 18:39, Thomas Gleixner wrote:
> Invoke the X86ism mem_encrypt_init() from X86 arch_cpu_finalize_init() and
> remove the weak fallback from the core code.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/include/asm/mem_encrypt.h |    7 ++++---
>   arch/x86/kernel/cpu/common.c       |   11 +++++++++++
>   init/main.c                        |   13 -------------
>   3 files changed, 15 insertions(+), 16 deletions(-)
> 
