Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B475F6CF7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjC2X74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjC2X7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:59:52 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A3E59DA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:59:49 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 32TNxJBe752942
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 29 Mar 2023 16:59:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 32TNxJBe752942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023030901; t=1680134360;
        bh=fEfLr9fjoInNQF0tD7n4faJFzEJ6O81l0Wno1CwnONg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=A1ZhCiCSzsdVt4HCt50aMOTheBBXgJ9wGP5mlFhFo1qNFMg+M0mK9M+Ka/BvSYswX
         r6Iy3XZxzaNbPfkIag8c2z6pDKHWChVXpNl5rKvRFFhhS8Rx8JYCTjeO8NFGt936T5
         fHFITmToQgD7B7iOs/u23fHH1zyblJ3lTPx89F0i0CkxtzWhDxBecfJAmcV7UBOp4k
         QBHbWjnM2ue96FQr4qkwyiX+48TfS3x1G4kUKC18B7cSoeHOz+Hi8fevZ0oyQA+arN
         /Is2HJr5mhaHE2ctFmSqiyBkkT41xv5ZkqzK57Cd9OEGmVuxwJWbgPpP14Mvg6dhEn
         sjPq87kkpl89A==
Date:   Wed, 29 Mar 2023 16:59:16 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "Kang, Shan" <shan.kang@intel.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_1/1=5D_x86/vdso=3A_use_the_right_GDT=5FENT?= =?US-ASCII?Q?RY=5FCPUNODE_for_32-bit_getcpu=28=29_on_64-bit_kernel?=
User-Agent: K-9 Mail for Android
In-Reply-To: <SA1PR11MB673439BB3F5C1BE2CDEF91A1A8899@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230311084824.2340-1-xin3.li@intel.com> <5e84fd48-459d-8850-d26f-860c6d34a9ad@intel.com> <SA1PR11MB6734CF1607F263CB8389F5F2A8B99@SA1PR11MB6734.namprd11.prod.outlook.com> <SA1PR11MB6734735DD3637E302DC155FFA8899@SA1PR11MB6734.namprd11.prod.outlook.com> <SA1PR11MB673439BB3F5C1BE2CDEF91A1A8899@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <149866DF-508B-426D-9D76-90B3257C1756@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 29, 2023 4:11:09 PM PDT, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wrote:
>> > > > +#ifndef BUILD_VDSO32_64
>> > > >  #define GDT_ENTRY_CPUNODE		28
>> > > > +#else
>> > > > +#define GDT_ENTRY_CPUNODE		15
>> > > > +#endif
>> > >
>> > > Isn't this kinda a hack?
>> > >
>> > > First, it means that we'll now have two duplicate versions of this:
>> > >
>> > > 	#define GDT_ENTRY_CPUNODE		15
>> > >
>> > > in the same file=2E
>> > >
>> > > Second, if any other users of fake_32bit_build=2Eh for the VDSO sho=
w
>> > > up, they'll need a similar #ifdef=2E
>> > >
>> > > I think I'd much rather if we define all of the GDT_ENTRY_* macros
>> > > in
>> > > *one* place, then make that *one* place depend on BUILD_VDSO32_64=
=2E
>> >
>> > Sounds a better way, let me try=2E
>> >
>> > > Also, about the *silent* failure=2E=2E=2E  Do we not have a selftes=
t for this somewhere?
>> >
>> > When lsl is used, we should check ZF which indicates whether the
>> > segment limit is loaded successfully=2E  Seems we need to refactor
>> vdso_read_cpunode() a bit=2E
>>=20
>> Hi Dave,
>>=20
>> How about the following patch to address the silent failure?
>>=20
>> diff --git a/arch/x86/include/asm/segment=2Eh b/arch/x86/include/asm/se=
gment=2Eh
>> index 794f69625780=2E=2Ed75ce4afff5b 100644
>> --- a/arch/x86/include/asm/segment=2Eh
>> +++ b/arch/x86/include/asm/segment=2Eh
>> @@ -254,7 +254,10 @@ static inline void vdso_read_cpunode(unsigned *cpu=
,
>> unsigned *node)
>>          *
>>          * If RDPID is available, use it=2E
>>          */
>> -       alternative_io ("lsl %[seg],%[p]",
>> +       alternative_io ("lsl %[seg],%[p]\n"
>> +                       "jz 1f\n"
>> +                       "mov $-1,%[p]\n"
>> +                       "1:",
>>                         "=2Ebyte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/ra=
x */
>>                         X86_FEATURE_RDPID,
>>                         [p] "=3Da" (p), [seg] "r" (__CPUNODE_SEG));
>>=20
>>=20
>> And the test then reports CPU id 4095 (not a big enough #), which can b=
e used to
>> indicate a failure of the lsl instruction:
>
>Having to say, it's a *bad* idea to use a special # to indicate an error=
=2E
>But there is also no reasonable errno for getcpu() to return to its calle=
r,
>saying "we had a problem in the syscall's kernel implementation"=2E
>
>>=20
>> ~/selftests$ sudo =2E/run_kselftest=2Esh -t x86:test_vsyscall_32 TAP ve=
rsion 13
>> 1=2E=2E1
>> # selftests: x86: test_vsyscall_32
>> # [RUN] test gettimeofday()
>> #       vDSO time offsets: 0=2E000028 0=2E000000
>> # [OK]  vDSO gettimeofday()'s timeval was okay # [RUN] test time() # [O=
K]  vDSO
>> time() is okay # [RUN] getcpu() on CPU 0
>> # [FAIL]        vDSO reported CPU 4095 but should be 0
>> # [FAIL]        vDSO reported node 65535 but should be 0
>> # [RUN] getcpu() on CPU 1
>> # [FAIL]        vDSO reported CPU 4095 but should be 1
>> # [FAIL]        vDSO reported node 65535 but should be 0
>> not ok 1 selftests: x86: test_vsyscall_32 # exit=3D1
>>=20
>> Thanks!
>>   Xin
>

I don't think we should put a test in the vdso implementation=2E We need a=
 self test, to be sure, and we should check that LSL works standalone (beca=
use of Oracle et al), but putting an assert like this in the vdso is like o=
f odd at best=2E

If we *do* put in a test, it should trap to the kernel, not return an errn=
o, because it is the equivalent of putting a BUG() in the kernel=2E In this=
 case we can even do better, because we can execute the getcpu system call =
at that point=2E

But=2E=2E=2E why? We generally trust the kernel implementation=2E
