Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A260454B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiJSMaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiJSMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:30:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569215CB3E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OqNRc2QzK30r4Y1uzmTIGLZT0+0EEZ1eq+jMiyZwVl0=; b=TrvgM40E+jfFoZv0NxzChvCn7m
        TkYQjkjPYXG9L2gYc1KcXKigFjDW3orVQ2KVNPHQ/+SGg1mt4kEZ0uZLV+OwA0RsSd/7cXGaWSJXz
        Yi2tZfrhw3ahBgAD4CQp1Luv2EBOqYHyymKttIwx/ottlzgpWaCdCuuDJm+JwUpz1ZX5KNcdP+ixe
        RV1f6fGpQNtbDf2l3GXZ8d1kNaFR2+f+HPlGv5qQyzouqX+iQou6BgiSKEbBnWnUc4a/ditsRB1OR
        zYQm2avaHW9d9PmBq0zfUwmM4DIlGjPw4ye7wSdPFHzzo/04NxM74O/ANpob10a1Eyo5ErmRVZPEi
        +MnNp7FQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ol7ni-00BWWX-Jp; Wed, 19 Oct 2022 12:03:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1028F30049E;
        Wed, 19 Oct 2022 14:03:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C22682C1EF55F; Wed, 19 Oct 2022 14:03:51 +0200 (CEST)
Date:   Wed, 19 Oct 2022 14:03:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y0/npwZ3UO9+ZSS4@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08FhjK3fKsfRAaw@hirez.programming.kicks-ass.net>
 <202210182200.50680AE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210182200.50680AE@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:05:26PM -0700, Kees Cook wrote:

> > +static int cfi_rand_preamble(s32 *start, s32 *end)
> > +{
> > +	s32 *s;
> > +
> > +	for (s = start; s < end; s++) {
> > +		void *addr = (void *)s + *s;
> > +		u32 hash;
> > +
> > +		hash = decode_preamble_hash(addr);
> > +		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
> > +			 addr, addr, 5, addr))
> > +			return -EINVAL;
> > +
> > +		hash ^= cfi_seed;
> > +		text_poke_early(addr + 1, &hash, 4);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> The one glitch here is that the resulting hash needs to not contain
> an endbr...

Oh right,.. duh. How about something like:

static u32 cfi_rehash(u32 hash)
{
	hash ^= cfi_hash;
	while (unlikely(is_endbr(hash))) {
		bool lsb = hash & 1;
		hash >>= 1;
		if (lsb)
			hash ^= 0x80200003;
	}
	return hash;
}

Which seems properly over-engineered :-)
