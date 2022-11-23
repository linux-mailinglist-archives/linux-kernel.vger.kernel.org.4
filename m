Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A56D634B76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiKWAHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWAHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:07:46 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EA46405
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:07:44 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2AN07CTf520245
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 22 Nov 2022 16:07:12 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2AN07CTf520245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022110601; t=1669162033;
        bh=gd5qYrdw5dNfYcdoVdpaHxsFvwAZ75iy7fsJ5IPCXzw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=1RrjzVXNw8ceaqMtRMApq/j4tylNyGXcq1RU2nHFzR44i7yb0KAEew+cgDT963W7n
         V4bb8VdNUWkGFD6Oke9IzK7JBljMm7/zuu8IZ/waxA9sV1HdnW587TxH/Di8frkQkE
         wPibCN27m7kuPPt2VS/NHix0elhHiWwW277Ly8s5fZceCPPoPpL3QiGmYYdtnsgUcM
         eKWhhraJZt9oryaHFEtpj6tJeFXo4n7iVZdL5Gp55DaZiuXQ1/b+dYMJOaFfusTi62
         xmVzmpqN/gSt+p/qzNFt0KRQlmGY0IKGEAl4GDfknbRG/20/Xw3ybZU0YlXo/E06FQ
         aAddqoCpXd9fg==
Date:   Tue, 22 Nov 2022 16:07:07 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot=3A_skip_realmode_i?= =?US-ASCII?Q?nit_code_when_running_as_Xen_PV_guest?=
User-Agent: K-9 Mail for Android
In-Reply-To: <99a452d0-18f2-f4ab-522a-dec15d913d3b@suse.com>
References: <20221121162433.28070-1-jgross@suse.com> <Y3vMpbsHA35VoasD@zn.tnic> <99a452d0-18f2-f4ab-522a-dec15d913d3b@suse.com>
Message-ID: <289E9B77-FA56-4655-91F3-7BDE4DF9BB78@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 21, 2022 10:28:21 PM PST, Juergen Gross <jgross@suse=2Ecom> wro=
te:
>On 21=2E11=2E22 20:08, Borislav Petkov wrote:
>> On Mon, Nov 21, 2022 at 05:24:33PM +0100, Juergen Gross wrote:
>>> When running as a Xen PV guest there is no need for setting up the
>>> realmode trampoline, as realmode isn't supported in this environment=
=2E
>>>=20
>>> Trying to setup the trampoline has been proven to be problematic in
>>> some cases, especially when trying to debug early boot problems with
>>> Xen requiring to keep the EFI boot-services memory mapped (some
>>> firmware variants seem to claim basically all memory below 1M for boot
>>> services)=2E
>>>=20
>>> Skip the trampoline setup code for Xen PV guests=2E
>>>=20
>>> Fixes: 084ee1c641a0 ("x86, realmode: Relocator for realmode code")
>>> Signed-off-by: Juergen Gross <jgross@suse=2Ecom>
>>> ---
>>>   arch/x86/include/asm/realmode=2Eh | 4 ++--
>>>   arch/x86/realmode/init=2Ec        | 3 +++
>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>  =20
>>> diff --git a/arch/x86/include/asm/realmode=2Eh b/arch/x86/include/asm/=
realmode=2Eh
>>> index fd6f6e5b755a=2E=2E5bfce58f1bab 100644
>>> --- a/arch/x86/include/asm/realmode=2Eh
>>> +++ b/arch/x86/include/asm/realmode=2Eh
>>> @@ -78,8 +78,8 @@ extern unsigned char secondary_startup_64_no_verify[=
];
>>>     static inline size_t real_mode_size_needed(void)
>>>   {
>>> -	if (real_mode_header)
>>> -		return 0;	/* already allocated=2E */
>>> +	if (real_mode_header || cpu_feature_enabled(X86_FEATURE_XENPV))
>>> +		return 0;	/* already allocated or not needed=2E */
>>>     	return ALIGN(real_mode_blob_end - real_mode_blob, PAGE_SIZE);
>>>   }
>>> diff --git a/arch/x86/realmode/init=2Ec b/arch/x86/realmode/init=2Ec
>>> index 41d7669a97ad=2E=2E1826700b156e 100644
>>> --- a/arch/x86/realmode/init=2Ec
>>> +++ b/arch/x86/realmode/init=2Ec
>>> @@ -202,6 +202,9 @@ static void __init set_real_mode_permissions(void)
>>>     static int __init init_real_mode(void)
>>>   {
>>> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))a
>>=20
>> This reminds me of the notorious if (xen) sprinkling from years ago=2E
>> Please don't do that=2E
>>=20
>
>Okay, what about plan B:
>
>- rework realmode/rm to:
>  + replace header=2ES with main=2Ec making it possible to initialize
>    struct real_mode_header using the struct definition
>  + optional: merge stack=2ES into main=2Ec
>- include realmode/rm addresses needed outside of it in struct
>  real_mode_header
>- setup a dummy struct real_mode_header in Xen PV code removing the
>  need to skip init_real_mode(), but making it basically a nop
>
>Would you be fine with that?
>
>
>Juergen

I'm wondering if init_real_mode should not simply be part of the platform =
ops=2E It's called exactly twice per boot, it is hard to be less performanc=
e critical than that=2E
