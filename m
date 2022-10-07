Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7F5F7D87
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJGSuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJGSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:50:20 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1687ABD60
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 11:50:19 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 297InvYN3880193
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 7 Oct 2022 11:49:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 297InvYN3880193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1665168598;
        bh=ebbXAFUQTJ5N3J/tbr1SoNx5sHiGAoFoQG3WsBx76IY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=M3kjoZp0i0uCERjjUEzlsByOKuCR0blDY3/kObrsY1y1+QiyogKmaF48oiGuoPMMM
         N5M1ppY9YackhvRvtXhgx/bT5h80YLUeq90w/V58QnIs+j/UEknc0NP++3dqlaTO+Q
         s6/cs8FSwxU17aFb8zHmSK5RFfbhFOtCwrKc5s2ZeORtDQW68cgazXv6NOH639fudm
         w3hzJ24nETePB2Hbc1plqCN5vU/bW5dALCkFyzXJAD/H0DkDAjQ7cIkyFgpCVjxIW/
         vEtdJUa6//w/0iW6RhqzYJfhY/i34qFPd6GGXWJVxGz3FU1oY2nVLRVVWKlFUyyCyB
         7eSAjxPIUC3RQ==
Date:   Fri, 07 Oct 2022 11:49:54 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_6/6=5D_x86/gsseg=3A_use_the_LKGS_in?= =?US-ASCII?Q?struction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <BN6PR1101MB216170B28962901E72C539BDA85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-7-xin3.li@intel.com> <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net> <5E3D5429-33BC-4924-B82C-C731507C0F06@zytor.com> <BN6PR1101MB216170B28962901E72C539BDA85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
Message-ID: <3F0DCCD0-2179-47E2-BC57-A948C0C91098@zytor.com>
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

On October 7, 2022 11:07:34 AM PDT, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wrot=
e:
>> >> +	alternative_io("1: call asm_load_gs_index\n"
>> >> +		       "=2Epushsection \"=2Efixup\",\"ax\"\n"
>> >> +		       "2:	xorl %k[sel], %k[sel]\n"
>> >> +		       "	jmp 1b\n"
>> >> +		       "=2Epopsection\n"
>> >> +		       _ASM_EXTABLE(1b, 2b),
>> >> +		       _ASM_BYTES(0x3e) LKGS_DI,
>> >> +		       X86_FEATURE_LKGS,
>> >> +		       ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
>> >> +		       ASM_NO_INPUT_CLOBBER(_ASM_AX));
>> >>  }
>> >
>> >I'm very sure none of this was tested=2E=2E=2E the =2Efixup section ha=
sn't
>> >existed for almost a year now=2E
>> >
>> >  e5eefda5aa51 ("x86: Remove =2Efixup section")
>>=20
>> Xin, what did you use as the forward-porting baseline?
>
>6=2E0 release, and my kernel dump shows me a fixup section is there, and =
a fixup section is created anyway if we do "pushsection "\=2Efixup\""=2E
>
>
>

Yeah=2E =2Efixup is really Just Another Text Section =E2=84=A2, so it is p=
robably not surprising if it has crept back in=2E
