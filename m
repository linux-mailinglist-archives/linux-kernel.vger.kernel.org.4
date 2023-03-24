Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1FE6C7CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCXKb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCXKbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:31:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5632201F;
        Fri, 24 Mar 2023 03:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZKi8I1SaBdSQUXrTQUdrgMAE1cb6JurH6QdoCFUzIPoHlXk7p1tmuof3d9gZBp3y9V21MNNS2sRS+dQeMIhHTb9w5IXtFvE3G+H7nBCqWwUeo5p5+AHIFzIOfElyWL9ZxmFid2eBMF5/F0vcjimedXkq95ocyDEJpZXB3Q9gEItfIopI+hHpUW2HM4PB69hrb+T1t6KUIMJaxdLVbsZi8PcmlZZUKVEDs1XAdnAF8msGxwIdPP4EnsgmzKGd8grPIme4k+xA2o8zIqQV8tIic4Wbkbu7fWqx7Kc0JSen6e4tCeqrFDN9lBW0+2Yba0B4y0BnInjmy6f3EGXXHFSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFymgbccdaZwuPCHu5Zjk5QY08rFEEor/S+LouvDxJw=;
 b=HXFFfvDdZroTSwI86ENLASQFNNkEnND3eqqxQ++Rp8G6FHvzbekjGOZQRf+A+CTz3ussNwP4JYjXBDhpwRMgJnWTdz849nlfL3y25mzQwG5eAIzGEmx1RNM23B7BToLV2+7E7sgDyLOxG0pTQ+Py8s6yJy8abOc6QMwTB5FQkDZ3JSekCptoLmc09HUoMX341bOhJwxE8xkzVnwKW3mKTfKX1WJKV5g7UhV0SfTwyKYZI/UGxMo2OXVlumjSw2yc/uwZwZ9Fop9HnyTCYs9z8QZpNohlUpMSbUj0pdr1Ae6Nf8j9mKJ6/+HEsq/uX9QnphfIQWzSbgjDpiY8vANEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFymgbccdaZwuPCHu5Zjk5QY08rFEEor/S+LouvDxJw=;
 b=rYwTs82ojR2FhdSXFh6UimnRc1DE8HI8cBJuq4L031TlY+X3aFcKXt6xOKpZPuJ2qD6dvf6pJOK46XmeLLlgOz7xF7TAdsYD5l5GcAezjKo94gRZEJRDcwWntK/GmvPjvhxd1t8IjnBTB8F9rkbgRiFnA9H4Lmk7Jslcq5oiS3ExXExsNRmTHA7Gvba4t3p0bYGqjRRlEvfG934gFoh4jUJR5gV6vQU8dgzKMwmZgYdrQj151TyEquSekNzuutE+CU6j2MkxebVvZ+GTlK2/PdWTnMUH663l9MDofkhIHWpr7mqFuiV28NK4e06+EuLHgJBZ83zRbi5uDMaSG9FNMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DBBPR04MB7562.eurprd04.prod.outlook.com
 (2603:10a6:10:1f6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 10:30:49 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::34da:496c:c4b1:9929]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::34da:496c:c4b1:9929%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 10:30:48 +0000
Message-ID: <b502c381-34b1-21f2-175f-754996778069@suse.com>
Date:   Fri, 24 Mar 2023 11:30:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5] x86: Avoid relocation information in final vmlinux
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        nathan@kernel.org, trix@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Fangrui Song <maskray@google.com>
References: <20230320121006.4863-1-petr.pavlu@suse.com>
 <CAKwvOdkFvMgYypc4w+UChO2O50wSHqXJUct2fkxrd+Qgn2C4Cg@mail.gmail.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CAKwvOdkFvMgYypc4w+UChO2O50wSHqXJUct2fkxrd+Qgn2C4Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DBBPR04MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9398a41e-914e-4aa2-0f32-08db2c52d58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FJnJi0mZUh/NcVkKfO9201Vlhi0JguawNfUsZoiGdJENSmUT0nZwhBz3AA9W41yzxuqS69F48Rv9Fisa+IJqaFBMKyA/SLCjdThH23iNYpF3AuOLq1N7LEIEZgNSnVNc9gKLXBhbcQ4niNseOjf20E7WZSved78J377IjihRAUtGhQ9VTOYYmffTLIk6ladapIHHNXtuQBD3mgUDvpzt11XrSVdiAqUupVddhoQkTp5Cc9dEVh/2w2b6THk6ix0AxQSPv36W8HU8E4ixdvO9nmgfSTEaKxu5NUV4aG9xEctue1cLWXDRq7/1vps4DnWrF6xFTflT+pp0Vb9WC8+vfU5lBxxOPkYFvVktUhRHuTu4f+8C7Dyf4k5Q+1SDDbRxoqZzdDWepaRdDmlEHVElAMqy/nsRDGc/OjB67Qm9hVsz5BhVR5dOmfL/7wJa/SLasFwlG2x9lBdJuQOZikSXI/qbQr0VivT8hLsfKnk/d+EXP2wboW40scv0i9Av2jFQKskjY4+0gK/ydtoZtQzw0sdv3z2ngy11o+5EpgQyextj8ti8Ui2KotUVVOneOXE5XYrRhfTdqq3ApmYAScMiQnbttRUh0hD2gp0N008fCUfKIPpSLbfxvvSIkEbrC1zggwl8xBBNy16hfymNFrK9PCzGH1moNcyskILZe1nRsMOqrsUfDmoXxM+Jl4NcVOMfsP0pIJTpF2ozLq1XsgfXRRciHLt3TRDc1q6KRa6JUOYYvKTAVzrpbzIQFqwR1yP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(86362001)(31696002)(36756003)(186003)(7416002)(478600001)(44832011)(66476007)(66556008)(6916009)(8676002)(4326008)(5660300002)(54906003)(8936002)(66946007)(41300700001)(316002)(2906002)(53546011)(6512007)(26005)(38100700002)(6506007)(6486002)(55236004)(966005)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlmYjdKOWxYa09FbHU3dDkwbHEvaUJWVUh2a2lNeFprcFhQS1dzeGZhVFNx?=
 =?utf-8?B?WmxyTkUxK2FiaGhZWUVTQitZRUxJcmFqcWZpS3RQQi9rcWQ2eUlPZEhRSW50?=
 =?utf-8?B?RGZTS1ZnakNHMU5ySWJXOW1hME1IaC96eS9XOEwxWUFXakR1WEI1OVh0Qi9H?=
 =?utf-8?B?bWZya0UyMEI0Qm9uQmNPdnRZWmVqQ0h6aEhPWUtzcUx1bDV5VWFTVXZSYWxa?=
 =?utf-8?B?TTNHdEpLZEdzRldNZkl3UVdXOUw3T1p0aTZrOE9RcHM1a3BYZGFzN3VUaEk5?=
 =?utf-8?B?d1cxYVdvU29icUYvZzc4cUkySUhFckhsdFBqUWtrZGZHOEJFVG8yOGViVXc5?=
 =?utf-8?B?cGl5L2pjZ0FjVjBubVJCQTRHUW9nb3JWaGlzWUR0MEREYjhEeXdpMldNdEtJ?=
 =?utf-8?B?SVBkQ0VwMEdkUDlQeUZsZm85eldCTSsrS2F0SWVXaEMza2lLRVNVKzM2MlB0?=
 =?utf-8?B?SFpaTFQxQjZydUlTRmZ3Vy85YnJoMDhvYXd6ZHJqMUwwQzR0aFVOMFl0MUNK?=
 =?utf-8?B?MjE3c0JNKzA1RGY4cFVPSlYxdkNnTzZtUzZ2RjRkWjBDbmJ0d050TkU5djdG?=
 =?utf-8?B?V0ZPeldGZmNXcnBzVUc3MzV0SUJwbFlPeG13WkFSNmZZWEZMTXh0Y201YTZ5?=
 =?utf-8?B?MUMwZzVRTU8rTiswbHU2dCs2VWYwelAwQ0hLZnEyNnBoOWNFQWttZGc4c0Ex?=
 =?utf-8?B?MWJYOUE5bU11SzNqeE1PdTR1YTZXcEFRM0dxeDhCbHZyQmNnTGpiNnFlbENa?=
 =?utf-8?B?SWE4Tm5yMEhrUVZ2Y3RiaUo4VGFYM3h1OE4wdC83YWE0TVBtMWc2c2cvYVd4?=
 =?utf-8?B?SHRWcFk3UUpFWFlIY1R1WTB6dGN4a1UrcGo5WENSVVRNOC91OTFLZE0wcGp5?=
 =?utf-8?B?RXpQZHlwK2U0TDd3bVpRUkJVbWRhN1lNczRqQ1BqblNhbXRoV3ViemY0T2p5?=
 =?utf-8?B?UGdDRmpFbUdpNlBLRWM1dVBtdWtNL3V0WVZhb0Z0aDJCUFlBMFBTbWgzVzZs?=
 =?utf-8?B?TERhL1l5dTAzM2tEY0N0aytPTnpSWmJJdW5xOFZNVU5DTkxXYkh0Ykg3aVVF?=
 =?utf-8?B?blc0WkJyL3gvNm5BR0F2NjIxR0JrQUlGTThydHhYbE5PdDh1TitHNEE2Qjcz?=
 =?utf-8?B?dE9VWFFoZXl5c0xVN0dXaU5mT1Y2RFVoVkg4My9aRDRHazlqTWthZkVWRzdj?=
 =?utf-8?B?UkduMVhQdXFMZmI5T1cyOHI5Y1JLazV3N09wSXBuS2hZNDVrNlBQQi9IRjlt?=
 =?utf-8?B?Z2tSQksrc0h4cDNxVisvZ3JBZkNXMVR3aC93eDZyTkZvTitneWtKRnBtZkFX?=
 =?utf-8?B?ajRDUEpqVG0yeW51Smx4Snd2dWJab2x6NjRzaHhLNmVISUZZT2ZzV2JmOFpC?=
 =?utf-8?B?OG0yUjJjUUMydDBTRDY1ZlB4QUdoblNZNklSbmZPb09jM2lUQkRIK1RKakpV?=
 =?utf-8?B?ZHlBU2Flekk3dU5WTnhVNkwxVmlHZThXVWdmcU1JdFhzd1VnNzFZcEFvMmdu?=
 =?utf-8?B?UVF0MVp4YXR6Zzc5N2puNFpGczdQSHVuT1cvKzZGK2pHZ084L3hkbFNEK1VG?=
 =?utf-8?B?ODZUTTRPRWl3MUpMd0RTNk1pV00rRmxqTWxnSmdYZnpWNkk0M1FJT3VKZFZJ?=
 =?utf-8?B?VTcrL1dnYnRJQjZOTjFxKzl5TU9Wd1o1ZlRUTC9UTTJJUlQvenB6dGhoWmt1?=
 =?utf-8?B?b0Z1bmpyTzUxSnlYd3FlaWFETFZDbS9QZlBHNC9OYS9uOFh4dmwyTHBLZ2Nq?=
 =?utf-8?B?WEV6WWIxVHYwUGpWQ00vK3IrbHkzZTB1c2Y1UmtPK2poY3lhM1MvcG5pcHFO?=
 =?utf-8?B?ZDhIR2FTdlB6ZFR6Qk5vNnBmTzQ5WTZWSUtKSDdVTHY5Z2c0ZEg3NW1BL3Zx?=
 =?utf-8?B?bFBoLzRudW9RM1NzTjFTSmpKOUdIWjdpQnZIYkoyaWJzbmU4dm5jd21FWEsv?=
 =?utf-8?B?dFJySnE4NFpTbTFSdHFZR1hETGFRa3ppcWtCWGtvRzl0VlgyZUxvNDIrdjM0?=
 =?utf-8?B?N0w3UmJtblVDUWhXcm5MdC9IbTVnczFRYldQV3M2dzdCM2hmM2FGQ3pSWllp?=
 =?utf-8?B?b3B4NmpKZkZTMjlSY0tGSDNFdzBMSC9FR09TckF4RzkzUnVoUWNsU0hUWDhq?=
 =?utf-8?Q?T/UJlH/HxHmBFFYCMK0Rv6H5Z?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9398a41e-914e-4aa2-0f32-08db2c52d58f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 10:30:48.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxJLhZd3daLY/v5wfV/ooyxBBeYSbyoNZaiCbt4aGCtL5Rpw1nbPIGln76l+Tbj07fhlaRAp7zeX9aVDFVY37g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7562
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 19:35, Nick Desaulniers wrote:
> On Mon, Mar 20, 2023 at 5:10 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> The Linux build process on x86 roughly consists of compiling all input
>> files, statically linking them into a vmlinux ELF file, and then taking
>> and turning this file into an actual bzImage bootable file.
>>
>> vmlinux has in this process two main purposes:
>> 1) It is an intermediate build target on the way to produce the final
>>    bootable image.
>> 2) It is a file that is expected to be used by debuggers and standard
>>    ELF tooling to work with the built kernel.
>>
>> For the second purpose, a vmlinux file is typically collected by various
>> package build recipes, such as distribution spec files, including the
>> kernel's own tar-pkg target.
>>
>> When building a kernel supporting KASLR with CONFIG_X86_NEED_RELOCS,
>> vmlinux contains also relocation information produced by using the
>> --emit-relocs linker option. This is utilized by subsequent build steps
>> to create vmlinux.relocs and produce a relocatable image. However, the
>> information is not needed by debuggers and other standard ELF tooling.
>>
>> The issue is then that the collected vmlinux file and hence distribution
>> packages end up unnecessarily large because of this extra data. The
>> following is a size comparison of vmlinux v6.0 with and without the
>> relocation information:
>> | Configuration      | With relocs | Stripped relocs |
>> | x86_64_defconfig   |       70 MB |           43 MB |
>> | +CONFIG_DEBUG_INFO |      818 MB |          367 MB |
> 
> Thanks for getting this to work with llvm-objcopy.  It's a pretty big
> win for us, especially for thin-lto builds which produce a ridiculous
> amount of debug info duplication (something I'm petitioning our DWARF
> folks to look into for DWARFv6) some measurements (all LLVM=1):
> 
> Before this patch:
> defconfig:
> 76M vmlinux
> DEBUG_INFO:
> 510M vmlinux
> DEBUG_INFO+LTO_CLANG_THIN:
> 796M vmlinux
> 
> after:
> defconfig:
> 48M vmlinux (-36.8%)
> DEBUG_INFO:
> 270M vmlinux (-47%)
> LTO_CLANG_THIN:
> 400M vmlinux (-49.8%)
> 
> So basically a 50% reduction in vmlinux size, depending on the precise
> configs selected. That's pretty great!
> 
> Android usually keeps around vmlinux artifacts as well as the
> compressed image in case we need to debug the image later, this should
> help us cut our storage costs for those quite a bit.  arm64 is more
> common for Android, but x86_64 is pretty helpful for a virtualized
> target; we do use it alot for first party development.
> 
> I also tested that I could still boot the result in QEMU, attach GDB,
> and still hit breakpoints in the resulting vmlinux.  I also tested
> that there were no more rel/rela sections missed in the resulting
> vmlinux images.
> 
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for testing this change.

> 
> Some minor review comments below.
> 
> 
> I do also wonder if linkers have something like --emit-relocs, but the
> option to produce it in an additional file. That would help us avoid
> producing it only to split it out in the first place.

I'm afraid I'm not aware of such an option.

> 
>>
>> Optimize a resulting vmlinux by adding a postlink step that splits the
>> relocation information into vmlinux.relocs and then strips it from the
>> vmlinux binary.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>
>> Changes since v4 [1]:
>> - Update the example target which is mentioned in the patch description
>>   to collect vmlinux from binrpm-pkg to tar-pkg, to reflect fc8c2d8ff206
>>   ("kbuild: Stop including vmlinux.bz2 in the rpm's").
>>
>> Changes since v3 [2]:
>> - Update the Kbuild.include path in arch/x86/Makefile.postlink to work
>>   after 67d7c3023a67 ("kbuild: remove --include-dir MAKEFLAG from top
>>   Makefile").
>>
>> Changes since v2 [3]:
>> - Ignore only the moved vmlinux.relocs, add it to .gitignore and
>>   Documentation/dontdiff.
>> - Clean up the patch description.
>>
>> Changes since v1 [4]:
>> - Fix the command to remove relocations to work with llvm-objcopy too.
>>
>> [1] https://lore.kernel.org/lkml/20230227131829.26824-1-petr.pavlu@suse.com/
>> [2] https://lore.kernel.org/lkml/20221211141227.7622-1-petr.pavlu@suse.com/
>> [3] https://lore.kernel.org/lkml/20220927084632.14531-1-petr.pavlu@suse.com/
>> [4] https://lore.kernel.org/lkml/20220913132911.6850-1-petr.pavlu@suse.com/
>>
>>  .gitignore                          |  1 +
>>  Documentation/dontdiff              |  1 +
>>  arch/x86/Makefile.postlink          | 41 +++++++++++++++++++++++++++++
>>  arch/x86/boot/compressed/.gitignore |  1 -
>>  arch/x86/boot/compressed/Makefile   | 10 +++----
>>  5 files changed, 47 insertions(+), 7 deletions(-)
>>  create mode 100644 arch/x86/Makefile.postlink
>>
>> diff --git a/.gitignore b/.gitignore
>> index 70ec6037fa7a..9bafd3c6bb5f 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -65,6 +65,7 @@ modules.order
>>  /vmlinux
>>  /vmlinux.32
>>  /vmlinux.map
>> +/vmlinux.relocs
> 
> Why do you move this from the arch/x86/boot/compressed/ dir?

The idea was for Makefile.postlink to produce its output at own $(obj) level
which is essentially the top objtree directory. However, I can see the
argument to write vmlinux.relocs in the same directory where other related
output files are present.

> 
>>  /vmlinux.symvers
>>  /vmlinux-gdb.py
>>  /vmlinuz
>> diff --git a/Documentation/dontdiff b/Documentation/dontdiff
>> index 3c399f132e2d..a62ad01e6d11 100644
>> --- a/Documentation/dontdiff
>> +++ b/Documentation/dontdiff
>> @@ -254,6 +254,7 @@ vmlinux.aout
>>  vmlinux.bin.all
>>  vmlinux.lds
>>  vmlinux.map
>> +vmlinux.relocs
>>  vmlinux.symvers
>>  vmlinuz
>>  voffset.h
>> diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
>> new file mode 100644
>> index 000000000000..195af937aa4d
>> --- /dev/null
>> +++ b/arch/x86/Makefile.postlink
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# ===========================================================================
>> +# Post-link x86 pass
>> +# ===========================================================================
>> +#
>> +# 1. Separate relocations from vmlinux into vmlinux.relocs.
>> +# 2. Strip relocations from vmlinux.
>> +
>> +PHONY := __archpost
>> +__archpost:
>> +
>> +-include include/config/auto.conf
>> +include $(srctree)/scripts/Kbuild.include
>> +
>> +CMD_RELOCS = arch/x86/tools/relocs
>> +quiet_cmd_relocs = RELOCS  $@.relocs
>> +      cmd_relocs = $(CMD_RELOCS) $@ > $@.relocs;$(CMD_RELOCS) --abs-relocs $@
>> +
>> +quiet_cmd_strip_relocs = RSTRIP  $@
>> +      cmd_strip_relocs = $(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' --remove-section='.rela.*' --remove-section='.rela__*' $@
> 
> This line is pretty long (146 chars), can you use \ here to wrap it?

Ack, I'll wrap it in a new version.

>> +
>> +# `@true` prevents complaint when there is nothing to be done
>> +
>> +vmlinux: FORCE
>> +       @true
>> +ifeq ($(CONFIG_X86_NEED_RELOCS),y)
>> +       $(call cmd,relocs)
>> +       $(call cmd,strip_relocs)
>> +endif
>> +
>> +%.ko: FORCE
>> +       @true
>> +
>> +clean:
>> +       @rm -f vmlinux.relocs
>> +
>> +PHONY += FORCE clean
>> +
>> +FORCE:
>> +
>> +.PHONY: $(PHONY)
>> diff --git a/arch/x86/boot/compressed/.gitignore b/arch/x86/boot/compressed/.gitignore
>> index 25805199a506..b2968175fc27 100644
>> --- a/arch/x86/boot/compressed/.gitignore
>> +++ b/arch/x86/boot/compressed/.gitignore
>> @@ -1,7 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  relocs
>>  vmlinux.bin.all
>> -vmlinux.relocs
>>  vmlinux.lds
>>  mkpiggy
>>  piggy.S
>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index 6b6cfe607bdb..19d1fb601796 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -121,14 +121,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>>
>>  targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
>>
>> -CMD_RELOCS = arch/x86/tools/relocs
>> -quiet_cmd_relocs = RELOCS  $@
>> -      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
>> -$(obj)/vmlinux.relocs: vmlinux FORCE
>> -       $(call if_changed,relocs)
>> +# vmlinux.relocs is created by the vmlinux postlink step.
>> +vmlinux.relocs: vmlinux
>> +       @true
>>
>>  vmlinux.bin.all-y := $(obj)/vmlinux.bin
>> -vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
>> +vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += vmlinux.relocs
> 
> Why do you remove $(obj) here? I'm guessing that's why you moved
> vmlinux.relocs between .gitignore files?

Yes, it is because this version of Makefile.postlink saves vmlinux.relocs in
the top objtree directory.

Thanks,
Petr
