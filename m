Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6A5FE311
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJMUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJMUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:05:59 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C841DA74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:05:56 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29DK5D9b802665
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 13 Oct 2022 13:05:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29DK5D9b802665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1665691514;
        bh=YqCkWQXDmcvlk06J1T5EwAK+3U0wNkOzu/L8Ng5Da7A=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=CZvj/G9muvf9RB1GfomyE5B9R5wIj03WWOnCLRiG/c/e8PeiURqkuFQokrrxfmIwl
         I36VH2kHTw5tibHjuQDidOD3DUICrOCkp/UoSTRrxGvT8JFxVzy5lNoetnsZawALqA
         +J7S4VQU4jzQJFfuqPd0p3hs6vRiHXVYjBcqMqSiK1oPqIJyKsrVURAGEC4bdWfu64
         Ryd+u2Hfjl96pEUoQ6GIH7yUa99MCmal4vSgnww/sqIbriZ7g9LR++CrRKITqfsI8w
         vxU17QiK9GM+nIInD30Iw/UF62mr2+GdJs4U+lTHZTev87xLe0ijAdsmZ6fQ8npeqC
         VTJnE0e6yuMqg==
Date:   Thu, 13 Oct 2022 13:05:09 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH v2 1/6] x86/cpufeature: add cpu feature bit for LKGS
User-Agent: K-9 Mail for Android
In-Reply-To: <BN6PR1101MB2161F6E79A6B123D9B0B53E9A8259@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221010190159.11920-1-xin3.li@intel.com> <20221010190159.11920-2-xin3.li@intel.com> <cca7e8ec-9fa0-7517-12d2-b0fd115bb9e9@intel.com> <BN6PR1101MB2161F6E79A6B123D9B0B53E9A8259@BN6PR1101MB2161.namprd11.prod.outlook.com>
Message-ID: <69F8F5CF-D939-4AC1-A691-06DD15746F1C@zytor.com>
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

On October 13, 2022 12:35:23 PM PDT, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wro=
te:
>
>> > diff --git a/arch/x86/include/asm/cpufeatures=2Eh
>> > b/arch/x86/include/asm/cpufeatures=2Eh
>> > index ef4775c6db01=2E=2E459fb0c21dd4 100644
>> > --- a/arch/x86/include/asm/cpufeatures=2Eh
>> > +++ b/arch/x86/include/asm/cpufeatures=2Eh
>> > @@ -308,6 +308,7 @@
>> >   /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word=
 12 */
>> >   #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI
>> instructions */
>> >   #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512
>> BFLOAT16 instructions */
>> > +#define X86_FEATURE_LKGS		(12*32+ 18) /* Load "kernel"
>> (userspace) gs */
>>=20
>> The spec says [1]:
>>      "Execution of LKGS causes an invalid-opcode exception (#UD) if CPL=
 >
>>       0=2E"
>>=20
>> Perhaps userspace has no interest in this=2E Then, we can add "" not to=
 show
>> "lkgs" in /proc/cpuinfo:
>>      +#define X86_FEATURE_LKGS		(12*32+ 18) /* "" Load "kernel"
>> (userspace) gs */
>
>Good point!
>
>>=20
>> Thanks,
>> Chang
>>=20
>> [1] https://cdrdv2=2Eintel=2Ecom/v1/dl/getContent/678938
>

It would be useful for reviewers to mention that this is was a policy chan=
ge on the maintainers' part=2E This is totally valid, of course, but making=
 it explicit would perhaps help reduce potential confusion=2E
