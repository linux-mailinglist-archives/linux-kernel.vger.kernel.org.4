Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237DF6D87E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjDEUMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjDEUM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:12:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A65E4C21
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avswBLlyfYee7YMYYuwJHKnyzzNHak3NJgK78YFFl6oz8eDX/i129+SKBtOKXisSVPEpFjNGD/Xu3/jCNhmf/H/88aHMcU5woEZIJuRJYLjZ03GVWAaH6pJ/8W0Gn/rU5+AegM9oJsFEji1mq5X8f//jgm2WiCEv19b4wdzQ9zQ1yF/YHQMgdUz6YumKlnAUgwc9w4Jxn+hoUFmloMO01i1DXJog1tlmm1fJxI3JT0w48jMCQvu4s0AU7exIt7kyA1b8jrBK9PaXtUmeNlxlzh7h3IQIkqdMu2ArDAfD0rmhKrE/Z1+ttsZ1AUDGBPFyWkCvdFyh9PRxy3lhCDtNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RZGhzGxQxGQYdieMN9ospg8uGetY5CArRn8z812+RE=;
 b=oAjNWf0mm8FHhY8bZzXa32VfWyJyQOe/7GXblsRd+F0ZJrPpScranf0MD/CYAfT00y+UQ2vnEOK26lC9jaJF1d7esPXqe2G7pfhkgJqkuqpuiWLDda1o555xOcj7IIkFvBIKagLxo1XS3LP8WL4jzqWVjE3gzH8HL3rzxozJswrokjDXpT4f069N/1VypMaei4cZxxuaMHhyJoNVq2EEynLScrsMKqjNooRRnatKGbIWGf0kofqD/wHeSLrC6XFTjEUcwqFor//Acg7vPkVWYEZ5iZcr0odiST5eBB98KmQolh0dr/XI6Jl3MCM/6kKuNfjmuPAyR9HiNKFhA6kN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RZGhzGxQxGQYdieMN9ospg8uGetY5CArRn8z812+RE=;
 b=4FMvLYPn+rqtyz3tFiF4kTG+U+U6rdSzh/ZJh4vmg5iSD+4IysL3d1dGjvSYNo3KD81JLK1Ojn/ghE/ERug9UR9grM+ZEQ915fAtW+v2w52gKjRegjD1g4/dxFngfKYCn07bViSOjNgnOtRlwVy33v5YZcj+KXX7s/wAqNJzILI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 20:11:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 20:11:20 +0000
Message-ID: <7dd9297f-b065-2ace-1c77-22dd0126c526@amd.com>
Date:   Wed, 5 Apr 2023 15:11:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
 <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
 <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name>
 <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
 <e46777d3-adea-90a2-afc4-35f9d7cef50c@intel.com>
 <CAMj1kXEDYa5YcRj7t9JJmQ21+ierue2q6ADOXUOMjoOGndGRug@mail.gmail.com>
 <969a3d2a-52e7-e60e-5de6-c550c548730d@intel.com>
 <20230405190636.4mrq2daz6a23yhvr@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230405190636.4mrq2daz6a23yhvr@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:208:236::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 33424f40-32a9-4864-3789-08db3611ec09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJpVNf9CVKo14hKGqBEZrcIJskhJNhkBurxvm5GDUIB0I2kyNUrEg5jfPfVn1zl2ZuPcpaS0OWA7fusLWXqWGrwnntjT1eUphQxng2q0dAEt3L4YgD1aGOMLm/N+80mINriiBW5v53d47rUJJNw58g8dkGX5RUfl6x/DCfcL/fqdF4W6rSGQoq2AdWgX2G3rrev/Y4/sWqJIqlHMqSenchrECcQmr8eo+27TaffZXcfZNuRh720HvkKGFuxb6SIpB4cpaIZz/SNUfQUUZi5TF8tlz+1B8RZVxxzJzU5NlxGc4O40hMvgDFVlNWBLj+9iZ8bG4JVmVPrI9U3w2VisPEOLbu95JofqS4X/NbxOzro7jjrsHEPinG+p3BI5lMlhr1j3mNZEX9tl0l6jjshQb3HXviEvLeeO2wB+yukD3CtwbULJyC/Nai5XZ2NiOEn+VfMOVRjP/w6doK6pg9HjXY19t1u0BzXZo2P+ek2IVxB2FRgVIkg8nLnaHH87VOTu245229d4Yea3UeCMlnR3scmBwsAxtXRDYqYgAsS6A1X85mAMb1I8ccggBmShvbt+F92QChtyOPsXHjdvhrt3QNNke85HsIg1RzVHCmgY09d1Z1k06wxpdzKjilnIG1JlFtPpJuZpcaVPvtFpprYEwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(31686004)(66899021)(7416002)(36756003)(5660300002)(38100700002)(66476007)(66556008)(66946007)(8676002)(31696002)(8936002)(86362001)(41300700001)(4326008)(83380400001)(110136005)(2616005)(6486002)(54906003)(6506007)(6512007)(53546011)(26005)(6666004)(186003)(2906002)(316002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3hVeEg0dXRpeTFaWkk0TTFGdTJoU00zV0VxVGhNTnVETUJxcnRScXMzeVhj?=
 =?utf-8?B?aU15bDhFWCs0VnE2Z3pROEdBbm5pZXJRU1FJclF5bTVnL1RpSzNmcUl5dVNa?=
 =?utf-8?B?ZEtJempuUm84N1RCUVN5UDdrcHpSWkI1RmRuYTczN0NHdXRqYXR2MjhidXNr?=
 =?utf-8?B?cmVCSTAzVEVNdDArL0c4M0ZqcHJ6eVJjaGkySU1CWmhZa2JxNzA5OHY0SXZM?=
 =?utf-8?B?U1luVFJYamFLTWpzWExmRjkzc3V5VWN0NWpZak5tRUUwSm9xOGxDUFhueUJY?=
 =?utf-8?B?Q1lGTEFjbW45eVhNVkpSSmlvUDR6ZVBpVWNYNEN3aWxoUmpoNkJzMWFqNXNL?=
 =?utf-8?B?NWp3VE1TSE10RFhZVXhlNzVUR0ZHK3lYYkFPYlc1NXQ4eTVYUTBYejRGeGpv?=
 =?utf-8?B?UXhWRUV1ZXVXbDV0MnVwTXcwTHk0K2pwVlRMVENDSE9yekZ5TVZNcUJ1dnkx?=
 =?utf-8?B?dk12S254dXZxNFpYL2Uya0lNTWQ4Vjdkc1FHWGdUS0liMGx6dFdzL3kzVmhO?=
 =?utf-8?B?dlFqcnBadVI2d2lybFZQNmF2QnpSMVNEekc5aitjN3BrTlVGUWlHS0d3MFpv?=
 =?utf-8?B?cERJMWdXNU0vNkdLVkhQUXhydEs3QjJ6V0h2eVVTZng3YmhTWWhuWEpQcHZH?=
 =?utf-8?B?WjNEek5ZZlVKYkF4YUY3ZXBRNVFDOG1DemhzRmwzQW1WK3Y0cmlwZWJVMEs2?=
 =?utf-8?B?T3ZhZXV3YU8zRjRObWlRbW5WSVdTcEVrZEc3S1RmVGdIcVFEaTIxMmI2MGJP?=
 =?utf-8?B?K3lJYlJVZVhNTEtFOCtRTWxBcERib0xzZzhYUFZRK1J6Y2FsdlZDYU9jUUxy?=
 =?utf-8?B?V3JFOUxMdUpwaEphbnZmRWJuM21TRDZCeWw4cGtKMlk0QjkzODBjU0t2UU9V?=
 =?utf-8?B?UXBLNUMxR01iRVZwazIvNlptZk53TUg5S3laN0xUYkt4MDladDdoNE0rMFlF?=
 =?utf-8?B?eTNRd0xva3VxVFhQSTlyWUpmSXVMTW55OWliaGltQnd3QlFHNzMwWXlpVTRE?=
 =?utf-8?B?eThnMHZaSXlrcitiSnpyMCtueHN5ZDhvSjBzYjhEMWZxdmpwc3hZRzA4K2tJ?=
 =?utf-8?B?NUgvS2VFUFlyMmVKZzN0U3hQMTJ1bHhnQ1Q5Um5ONUw3VDVWSTkyOUNFY2ta?=
 =?utf-8?B?UktXeXRVUTN5eW9QR2JwTzcrSzZIQ25lRStUWmhLL3lGMEptSVlFQXJqVkV3?=
 =?utf-8?B?bGpIRTkrUWJtTzZuczkxT1NTdXFScHJ3WVd6RnhGWGUvczhLQ2hzN2QrSito?=
 =?utf-8?B?U0V6MnZoMExaV3FseW4wTGdveWc3eXVud2pxMEdZVHJZenR0R2tBMVhXTnlm?=
 =?utf-8?B?a0Q4azlhZXlGQUtyQWFNZWdmc3FkLzB2K05CdnN6S0I3Q0toOVFmZ2V1eVJT?=
 =?utf-8?B?RGdKK29rQ0UrZCttR2RkZGhJN1luTVpVOEtxQVlXV1hMbGUvL2tMZVhVbjVX?=
 =?utf-8?B?YWFITUhmSkg2Z1NDU0Jpd2NDKzlVZ3lsV2Y2b3BSYS9KN1NtNTFmWmszUGtX?=
 =?utf-8?B?ZUd1OWh1VVpDdGUvditlUVU0UUxLL1hFaDJsRytzVlRZSnJHYkFNclJFVG51?=
 =?utf-8?B?UVFOTzZySVd6T2JISDdYTkdDQnFqTDRreGdMQTNWaDBPZG5ZUHl6Z2JLeGlJ?=
 =?utf-8?B?bTQxSDZyc3dXMVZQb0t5R1p2STkrNzNRL1RwSTN3ZnRtdjFrNktwZHF5cTFh?=
 =?utf-8?B?cHZLdXVqQjJXZWhYbEhDQlJhaWl4RThCdFBVSVVGV0hjVklJMjd2RitNRXh6?=
 =?utf-8?B?bjY3dkpnQjUwVGF2OHhQMnIxcUQ5akVZWXlqc0FCaHdtTVRUTC9tNGJpT0RT?=
 =?utf-8?B?dlVERjJNOFh1SzZXejJXSEk4Lzl0S3I5SDVESVlyQTJNR3ZRbDlaWEpCVE5O?=
 =?utf-8?B?TGtDWURPeUpQdUxBZUZFcVdmOTBRM1MvSDRiTm9DSEF4eHpnaktYYlJSV3NO?=
 =?utf-8?B?S28waUNIWUY0YXFEMU1RdzcyUEtoYjI0OUxzVFFjSzI0OWJLenBxZlN0bW1I?=
 =?utf-8?B?cktsN2hDblRKUVg5am00Y1BSaDBMNm42cUVUSHRFdyt3RjJwR3M1WFNuTVRm?=
 =?utf-8?B?dEsrSzcrL3lHRmVZUW1CSUhqbXF2c2xVTnlsb3VlNEQ0ZG5Id2c2ZlFMTEZJ?=
 =?utf-8?Q?wJSRwUEMV9WfzWT1RG9YeUvtz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33424f40-32a9-4864-3789-08db3611ec09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 20:11:20.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlqD26wn2TCnIl0tqHIuF78g5Pt4XTWAiIs6eAvI6nl8y9DhqdnlEPZv8KRkzWxvcPMUXOM0RSamdbHUFNzSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 14:06, Kirill A. Shutemov wrote:
> On Wed, Apr 05, 2023 at 09:15:15AM -0700, Dave Hansen wrote:
>> On 4/5/23 06:44, Ard Biesheuvel wrote:
>>> Given that the intent here is to retain compatibility with
>>> unenlightened workloads (i.e., which do not upgrade their kernels), I
>>> think it is perfectly reasonable to drop this from mainline at some
>>> point.
>>
>> OK, so there are three firmware types that matter:
>>
>> 1. Today's SEV-SNP deployed firmware.

SNP support is originally available as part of the edk2-stable202202 release.

>> 2. Near future SEV-SNP firmware that exposes the new ExitBootServices()
>>     protocol that allows guests that speak the protocol to boot faster
>>     by participating in the unaccepted memory dance.

This is already out and available as part of the edk2-stable202302 release.

But it did come out after general SNP support, so the near future 
terminology works.

>> 3. Far future firmware that doesn't have the ExitBootServices() protocol
>>
>> There are also three kernel types:
>> 1. Old kernels with zero unaccepted memory support: no
>>     ExitBootServices() protocol support and no hypercalls to accept pages
>> 2. Kernels that can accept pages and twiddle the ExitBootServices() flag
>> 3. Future kernels that can accept pages, but have had ExitBootServices()
>>     support removed.
>>
>> That leads to nine possible mix-and-match firmware/kernel combos.  I'm
>> personally assuming that folks are going to *try* to run with all of
>> these combos and will send us kernel folks bug reports if they see
>> regressions.  Let's just enumerate all of them and their implications
>> before we go consult our crystal balls about what folks will actually do
>> in the future.
>>
>> So, here we go:
>>
>>                |                   Kernel                   |
>>                |                                            |
>>                | Unenlightened | Enlightened | Dropped UEFI |
>> Firmware      |     ~5.19??   |    ~6.4??   | protocol     |
>>                |---------------+-------------+--------------|
>> Deployed      |   Slow boot   |  Slow boot  |  Slow boot   |
>> Near future   |   Slow boot   |  Fast boot  |  Slow boot   |
>> Far future    |   Crashes??   |  Fast Boot  |  Fast boot   |
>>
>> I hope I got that all right.

Looks correct to me (with Kirill's description below in place of the 
"Crashes??").

>>
>> The thing that worries me is the "Near future firmware" where someone
>> runs a ~6.4 kernel and has a fast boot experience.  They upgrade to a
>> newer, "dropped protocol" kernel and their boot gets slower.

Right, so that is what begs the question of when to actually drop the 
call. Or does it really need to be dropped? It's a small patch to execute 
a boot services call, I guess I don't see the big deal of it being there.
If the firmware still has the protocol, the call is made, if it doesn't, 
its not. In the overall support for unaccepted memory, this seems to be a 
very minor piece.

>>
>> I'm also a little fuzzy about what an ancient enlightened kernel would
>> do on a "far future" firmware that requires unaccepted memory support.
>> I _think_ those kernels would hit some unaccepted memory, and
>> #VC/#VE/#whatever and die.  Is that right, or is there some fallback there?
> 
> The far future firmware in this scheme would expose unaccepted memory in
> EFI memory map without need of kernel to declare unaccepted memory
> support. The unenlightened kernel in this case will not be able to use the
> memory and consider it reserved. Only memory accepted by firmware will be
> accessible. Depending on how much memory firmware would pre-accept it can
> be OOM, but more likely it will boot fine with the fraction of memory
> usable.

Right, since a typical Qemu VM has a 2GB hole for PCI/MMIO, the guest is 
likely to only see 2GB of memory available to it.

Thanks,
Tom

> 
