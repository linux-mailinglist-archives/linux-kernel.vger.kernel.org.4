Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890B0696EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBNUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBNUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:43:51 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E619A25B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:43:49 -0800 (PST)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 31EKhDM42600658
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 14 Feb 2023 12:43:14 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 31EKhDM42600658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023020601; t=1676407396;
        bh=hVmBufXnwHZqmpGPMVZRmOlUV+rvMCBzlaAQbBzh/W4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=KVOuWecM+ZrwPwg7go1NtbaDW+hEFQOtacdLe4I9VCUMGOoDBbMeLJ3ITJqNGEvXV
         idbNJzO2C0itzIkUgMrERtqGH3aWd9u5a7hv7XnHTH84JHSwVhpFt9o5M0FsDxwhMC
         9QSstqgE5WOQiyaT1+4IIh2YdLGn1fw/5h/CoUwoeONWrIMnxEkVke6RTr3rRtCk1y
         kiGwhnflvSLiQGboUtGmHr70BBdVonVrCksNd4jzCb1kJaY6YA5w8C9m7s0ukRb6IL
         z5R89F31Ci+k+GRR3zGVi31igvGdBqO//VZw2gJwqMttSf/NMbX0VwKRtwtomrvrbH
         v1YYdYSkE4UMA==
Date:   Tue, 14 Feb 2023 12:43:10 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPING=5D=5BPATCH_v3=5D_x86=3A_Use_=60get=5Frandom?= =?US-ASCII?Q?=5Fu8=27_for_kernel_stack_offset_randomization?=
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.2302140447190.6368@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk> <alpine.DEB.2.21.2302122311470.46819@angie.orcam.me.uk> <877cwltmno.ffs@tglx> <alpine.DEB.2.21.2302140447190.6368@angie.orcam.me.uk>
Message-ID: <DDFBF35E-D837-4CDC-8EF8-2CBF75C77901@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2023 8:54:53 PM PST, "Maciej W=2E Rozycki" <macro@orcam=2Em=
e=2Euk> wrote:
>On Mon, 13 Feb 2023, Thomas Gleixner wrote:
>
>> >> For x86 kernel stack offset randomization uses the RDTSC instruction=
,=20
>> >> which according to H=2E Peter Anvin is not a secure source of entrop=
y:
>> >>=20
>> >> "RDTSC isn't a super fast instruction either, but what is *way* more
>> >> significant is that this use of RDTSC is NOT safe: in certain power =
states
>> >> it may very well be that stone number of lower bits of TSC contain n=
o
>> >> entropy at all=2E"
>> >
>> >  Ping for:
>> > <https://lore=2Ekernel=2Eorg/all/alpine=2EDEB=2E2=2E21=2E230130201115=
0=2E55843@angie=2Eorcam=2Eme=2Euk/>=2E
>>=20
>> I'm waiting for you to address Peter Anvins feedback=2E
>
> Do you mean this part:
>
>On Tue, 31 Jan 2023, H=2E Peter Anvin wrote:
>
>> Well, what I said was that masking out the low bits of TSC is not a val=
id use to
>> extract a random(-ish) number this way, because the lower bits may be a=
ffected
>> by quantization=2E Something like a circular multiply using a large pri=
me with a
>> good 0:1 balance can be used to mitigate that=2E
>>=20
>> However, the second part is that subsequent RDTSCs will be highly corre=
lated,
>> and so a CSPRNG is needed if you are actually trying to get reasonable =
security
>> this way =E2=80=93 and, well, we already have one of those=2E
>
>?  Well, I inferred, perhaps incorrectly, from the second paragraph that=
=20
>Peter agrees with my approach (with the CSPRNG being what `get_random_u8'=
=20
>and friends get at)=2E
>
>> You also cite him
>> w/o providing a link to the conversation, so any context is missing=2E
>
> Sorry about that=2E  I put the change heading for the previous iteration=
s=20
>in the change log, but I agree actual web links would've been better:
><https://lore=2Ekernel=2Eorg/all/alpine=2EDEB=2E2=2E21=2E2301081919550=2E=
65308@angie=2Eorcam=2Eme=2Euk/>,
><https://lore=2Ekernel=2Eorg/all/alpine=2EDEB=2E2=2E21=2E2301082113350=2E=
65308@angie=2Eorcam=2Eme=2Euk/>=2E
>
> Please let me know if you need anything else=2E  Thank you for your revi=
ew=2E
>
>  Maciej

No, I do indeed agree=2E We're talking something that is a part of an oper=
ation that is already fairly expensive=2E Now, if RDRAND is available on th=
e hardware then that could be used if someone really wants it to go faster=
=2E=2E=2E but get_random_*() seems saner than doing ad hoc hacks=2E
