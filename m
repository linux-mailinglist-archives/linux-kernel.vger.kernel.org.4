Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61D766A8A7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 03:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjANCW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 21:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjANCW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 21:22:56 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730F8BAAC;
        Fri, 13 Jan 2023 18:22:54 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30E2MVvU2813069
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 13 Jan 2023 18:22:32 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30E2MVvU2813069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1673662954;
        bh=KJ0MZzQf9nWc/obRK9dCTOC8sETJ1kHQc75kDMqlTBA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cRRm4dYbxsq/napYdd6xvhdJPhYBBTgvvGCl5dMR0yZHP5i923R/3VDa+DROd60Jt
         pVdcGhluvg+8P7sH/bF9whe9UCT5l0zNTB1svMwvwctHkCDGgMr/ndhtxAAk92rvaD
         G9GhkoIQTyPVFzUkYEgo0vtLSVLzIls/uVdViCo2c/nKpIWb9C5PCl3YrJX9Vfslx5
         gCwZYm8Fo3zLXhMubFRjo/81xWNF+4Xchk1LJ5ydDGD/DuWr1olJzJLK6eG/60VJFx
         FigTINyjp94lsHXR86iImeQ7YvB9Dp9EUqT0h0ddAujw4FNWc2B/HOvZ9S9l90Afyi
         JNAbqQk+IUiNA==
Message-ID: <585ddb35-adc5-f5cf-4db3-27571f394108@zytor.com>
Date:   Fri, 13 Jan 2023 18:22:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 0/4] random: a simple vDSO mechanism for reseeding
 userspace CSPRNGs
Content-Language: en-US
To:     Yann Droneaud <ydroneaud@opteya.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
References: <CAHmME9oXB8=jUz98tv6k1xS+ELaRmgartoT6go_1axhH1L-HJg@mail.gmail.com>
 <cover.1673539719.git.ydroneaud@opteya.com>
 <ae35afa5b824dc76c5ded98efcabc117e6dd3d70@opteya.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <ae35afa5b824dc76c5ded98efcabc117e6dd3d70@opteya.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 11:55, Yann Droneaud wrote:
> Hi
> 
> 12 janvier 2023 à 18:07 "Jason A. Donenfeld" <Jason@zx2c4.com> a écrit:
>   
>> Sorry Yann, but I'm not interested in this approach, and I don't think
>> reviewing the details of it are a good allocation of time. I don't
>> want to lock the kernel into having specific reseeding semantics that
>> are a contract with userspace, which is what this approach does.
> 
> This patch adds a mean for the kernel to tell userspace: between the
> last time you call us with getrandom(timestamp,, GRND_TIMESTAMP),
> something happened that trigger an update to the opaque cookie given
> to getrandom(timestamp, GRND_TIMESTAMP). When such update happen,
> userspace is advised to discard buffered random data and retry.
> 
> The meaning of the timestamp cookie is up to the kernel, and can be
> changed anytime. Userspace is not expected to read the content of this
> blob. Userspace only acts on the length returned by getrandom(,, GRND_TIMESTAMP):
>   -1 : not supported
>    0 : cookie not updated, no need to discard buffered data
>   >0 : cookie updated, userspace should discard buffered data
> 
> For the cookie, I've used a single u64, but two u64 could be a better start,
> providing room for implementing improved behavior in future kernel versions.
> 
>> Please just let me iterate on my original patchset for a little bit,
>> without adding more junk to the already overly large conversation.
> 
> I like the simplicity of my so called "junk". It's streamlined, doesn't
> require a new syscall, doesn't require a new copy of ChaCha20 code.
> 
> I'm sorry it doesn't fit your expectations.
> 

Why would anything more than a 64-bit counter be ever necessary? It only 
needs to be incremented.

Let user space manage keeping track of the cookie matching its own 
buffers. You do NOT want this to be stateful, because that's just 
begging for multiple libraries to step on each other.

Export the cookie from the vdso and volià, a very cheap check around any 
user space randomness buffer will work:

	static clone_cookie_t last_cookie;
	clone_cookie_t this_cookie;

	this_cookie = get_clone_cookie();
	do {
		while (this_cookie != last_cookie) {
			last_cookie = this_cookie;
			reinit_randomness();
			this_cookie = get_clone_cookie();
		}

		extract_randomness_from_buffer();
		this_cookie = get_clone_cookie();
	} while (this_cookie != last_cookie);

	last_cookie = this_cookie;

	-hpa
