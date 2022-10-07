Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3825F7E73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJGUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJGUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:03:44 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8A118767
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:03:43 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 297K3FPb3889477
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 7 Oct 2022 13:03:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 297K3FPb3889477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1665172996;
        bh=X2g9nKEpXhztLuafwCQwISYVdwjCkNSLi2LIVlrXkBQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=B+9IMzlf7Mb0dTAyg2GjuX8HmF2d8HbqaccH3xO/Uxn1RF4+q1AlXz3/kUfWk8k0u
         okvllDiCAgELcyzrVjvWt8qsBt7BB3Ts3PN28ajSItkdPbgWjKuHYwqD2cGJIee4RP
         ob1DCMsBhK9/ZaE1OLwG0x27NmJQBIswNMnVXeau8ImBWmvD1SNV2Fx0Tl2NWBVK0m
         ymDqApWQH4ZQouZSVlC/lKlUEzgjusW4FhEgUQQnnWJwQwxsEVOnOduvh/UhpW7auw
         6wODmt/2cRSzm9Frr0zp6gzqY54BDDX6rYvXPTsBRaRshLhUv72+k9mLdMcuCaQjgH
         fP8cX2POxOo5g==
Date:   Fri, 07 Oct 2022 13:03:12 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Xin3" <xin3.li@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6/6=5D_x86/gsseg=3A_use_the_LKGS_in?= =?US-ASCII?Q?struction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-7-xin3.li@intel.com> <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net> <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com> <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net>
Message-ID: <80AC2E90-D842-4EA2-A413-3CC5CFF088BC@zytor.com>
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

On October 7, 2022 12:24:13 PM PDT, Peter Zijlstra <peterz@infradead=2Eorg>=
 wrote:
>On Fri, Oct 07, 2022 at 06:01:06PM +0000, Li, Xin3 wrote:
>> > > +	alternative_io("1: call asm_load_gs_index\n"
>> > > +		       "=2Epushsection \"=2Efixup\",\"ax\"\n"
>> > > +		       "2:	xorl %k[sel], %k[sel]\n"
>> > > +		       "	jmp 1b\n"
>> > > +		       "=2Epopsection\n"
>> > > +		       _ASM_EXTABLE(1b, 2b),
>> > > +		       _ASM_BYTES(0x3e) LKGS_DI,
>> > > +		       X86_FEATURE_LKGS,
>> > > +		       ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
>> > > +		       ASM_NO_INPUT_CLOBBER(_ASM_AX));
>> > >  }
>> >=20
>> > I'm very sure none of this was tested=2E=2E=2E the =2Efixup section h=
asn't existed for
>> > almost a year now=2E
>>=20
>> Weird, did you ever check a kernel dump?
>
>$ readelf -WS defconfig-build/vmlinux | grep fixup
>[ 5] =2Epci_fixup        PROGBITS        ffffffff826a5350 18a5350 003570 =
00   A  0   0 16
>[ 6] =2Erela=2Epci_fixup   RELA            0000000000000000 360c388 00502=
8 18   I 60   5  8
>
>In fact, when I add one I get:
>
>ld: warning: orphan section `=2Efixup' from `arch/x86/kernel/traps=2Eo' b=
eing placed in section `=2Efixup'

Perhaps the two of you need to compare confugurations?
