Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791F56EEB49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbjDZALh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjDZALg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:11:36 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81810E9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:11:34 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 33Q0Ahlv3867755
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 25 Apr 2023 17:10:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 33Q0Ahlv3867755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023040901; t=1682467844;
        bh=zlADXuLQzQL6rHF9UUciVfpOcO8xxJBWdPf+jRMOtOY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=jQNul7h3BL6TjIB5IeiXakFXyVmFOZYvsiqT5Y9CCEe2lL0yHHCEnrzPwoJ3iynxH
         zyOSN4jPN8whhWJcgEvNZ3Cwn5ue4eVAHjUWRFD8WdYSuvdKxyGy3cqHZwfmvr/BzL
         fgbOwCxq8xyJ7UOh4ped5n6brZ+vBBrBchNZMOnIFWmkUKxOniqjjfvWZtDTjJwycE
         Z4NQxO8T70KqwH/kQQcVRsDkkQfm2uyVxwEEi10dOPAAVHNDWsMEtrViMZKzbAz1VT
         UXUpjy1cX9iDEBChgHLfsjobulqrE9R7lOpC6tuWuUxKCeJtoY7MJNlXvA23vd7Joz
         cPHTCf2EPjBug==
Date:   Tue, 25 Apr 2023 17:10:42 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
User-Agent: K-9 Mail for Android
In-Reply-To: <ecdea7a8-a748-6ecb-5fc1-93d7eda3c54d@intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com> <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx> <ecdea7a8-a748-6ecb-5fc1-93d7eda3c54d@intel.com>
Message-ID: <D9668AEC-9650-4840-A03D-553994B414DD@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 25, 2023 3:29:49 PM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> w=
rote:
>On 4/25/23 14:05, Thomas Gleixner wrote:
>> The only consequence of looking at bit 0 of some random other leaf is
>> that all CPUs which run stop_this_cpu() issue WBINVD in parallel, which
>> is slow but should not be a fatal issue=2E
>>=20
>> Tony observed this is a 50% chance to hang, which means this is a timin=
g
>> issue=2E
>
>I _think_ the system in question is a dual-socket Westmere=2E  I don't se=
e
>any obvious errata that we could pin this on:
>
>> https://www=2Eintel=2Ecom/content/dam/www/public/us/en/documents/specif=
ication-updates/xeon-5600-specification-update=2Epdf
>
>Andi Kleen had an interesting theory=2E  WBINVD is a pretty expensive
>operation=2E  It's possible that it has some degenerative behavior when
>it's called on a *bunch* of CPUs all at once (which this path can do)=2E
>If the instruction takes too long, it could trigger one of the CPU's
>internal lockup detectors and trigger a machine check=2E  At that point,
>all hell breaks loose=2E
>
>I don't know the cache coherency protocol well enough to say for sure,
>but I wonder if there's a storm of cache coherency traffic as all those
>lines get written back=2E  One of the CPUs gets starved from making enoug=
h
>forward progress and trips a CPU-internal watchdog=2E
>
>Andi also says that it _should_ log something in the machine check banks
>when this happens so there should be at least some kind of breadcrumb=2E
>
>Either way, I'm hoping this hand waving satiates tglx's morbid curiosity
>about hardware that came out from before I even worked at Intel=2E ;)

"Pretty expensive" doesn't really cover it=2E It is by far the longest tim=
e an x86 CPU can block out all outside events=2E
