Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F20603233
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJRSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJRSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:19:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A602C109
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:19:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i6so14593352pli.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Hcj3Um0CUqM3wfWQz5cTS0tj5QVHP2N/wI5Mkx+Pk=;
        b=B/8porG5DUyPqOZyeZZaC7zFXXly1SlMrxMLqkMG904nMgBEDxM0eflZgHepbVzHdN
         ceb3mWKvgoTtDUgy+7TisOU0TpEB/+IPMhMYR251axEsQCOZGvZVvAyQKexiyuXcx/w3
         jUa87ZchWUx10cqWweR6P7LBml3kfStIQb8C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+Hcj3Um0CUqM3wfWQz5cTS0tj5QVHP2N/wI5Mkx+Pk=;
        b=CL+NVdHStkz5XpsdLofpwPjzZMwnlHzStD98J8f+C60XTjTemvyKvujSvkU2b6nioj
         qNRi9OWU38YQoeS26vu6E1lDIIYQ1VesNAPc8xboHlVyh0zKJYzjABrr/gB2AY0j/D2/
         0ZseZe2O1NX09WKreo+28Q53iW0/zOTdtbjfcpewBZ0wUBlgxSbnyS5JVT2GrOZiYuWI
         joHTprBIisD5F8MPSEjvr966Xma6dlSMe3Q95MC5D7R+uvXY3q67L8l/RQBwwvhMVEWU
         tWENxRi8cYm+UAX0bHvswcCf622Zg9AmQdQpBuEW4Sr50ONMuo2vlYiO947VbgDh74NJ
         NcOA==
X-Gm-Message-State: ACrzQf1rE39TKzDpqb2sde9p90y/Evz9MorVcrf9jaVbWL6dMoAfzUk9
        dH6S98Nn78He41rj0PAnCrohvA==
X-Google-Smtp-Source: AMsMyM4Jw/vGpw4RglKyguzOz1hwTpv9iVDHvzqdtji8Puw4EeXOYFiSX1x8aes/mXJxhYwr91808Q==
X-Received: by 2002:a17:903:2442:b0:17f:8069:533a with SMTP id l2-20020a170903244200b0017f8069533amr4268946pls.46.1666117182456;
        Tue, 18 Oct 2022 11:19:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v2-20020aa799c2000000b00562a237179esm9576282pfi.131.2022.10.18.11.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:19:41 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:19:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     sdf@google.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bpf: Use kmalloc_size_roundup() to match ksize() usage
Message-ID: <202210181110.CD92A00@keescook>
References: <20221018090550.never.834-kees@kernel.org>
 <Y07raim32wOBRGPi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07raim32wOBRGPi@google.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:07:38AM -0700, sdf@google.com wrote:
> On 10/18, Kees Cook wrote:
> > Round up allocations with kmalloc_size_roundup() so that the verifier's
> > use of ksize() is always accurate and no special handling of the memory
> > is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE. Pass the new size
> > information back up to callers so they can use the space immediately,
> > so array resizing to happen less frequently as well. Explicitly zero
> > any trailing bytes in new allocations.
> 
> > Additionally fix a memory allocation leak: if krealloc() fails, "arr"
> > wasn't freed, but NULL was return to the caller of realloc_array() would
> > be writing NULL to the lvalue, losing the reference to the original
> > memory.
> 
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
> >   1 file changed, 31 insertions(+), 18 deletions(-)
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 014ee0953dbd..8a0b60207d0e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1000,42 +1000,53 @@ static void print_insn_state(struct
> > bpf_verifier_env *env,
> >    */
> >   static void *copy_array(void *dst, const void *src, size_t n, size_t
> > size, gfp_t flags)
> >   {
> > -	size_t bytes;
> > +	size_t src_bytes, dst_bytes;
> 
> >   	if (ZERO_OR_NULL_PTR(src))
> >   		goto out;
> 
> > -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> > +	if (unlikely(check_mul_overflow(n, size, &src_bytes)))
> >   		return NULL;
> 
> > -	if (ksize(dst) < bytes) {
> > +	dst_bytes = kmalloc_size_roundup(src_bytes);
> > +	if (ksize(dst) < dst_bytes) {
> 
> Why not simply do the following here?
> 
> 	if (ksize(dst) < ksize(src)) {
> 
> ?

Yeah, if src always passes through rounding-up allocation path, that
might work. I need to double-check that there isn't a case where "size"
makes this go weird -- e.g. a rounded up "src" may be larger than
"n * size", but I think that's okay because the memcpy/memset does the
right thing.

> It seems like we care about src_bytes/bytes only in this case, so maybe
> move that check_mul_overflow under this branch as well?
> 
> 
> >   		kfree(dst);
> > -		dst = kmalloc_track_caller(bytes, flags);
> > +		dst = kmalloc_track_caller(dst_bytes, flags);
> >   		if (!dst)
> >   			return NULL;
> >   	}
> 
> > -	memcpy(dst, src, bytes);
> > +	memcpy(dst, src, src_bytes);
> > +	memset(dst + src_bytes, 0, dst_bytes - src_bytes);
> >   out:
> >   	return dst ? dst : ZERO_SIZE_PTR;
> >   }
> 
> > -/* resize an array from old_n items to new_n items. the array is
> > reallocated if it's too
> > - * small to hold new_n items. new items are zeroed out if the array
> > grows.
> > +/* Resize an array from old_n items to *new_n items. The array is
> > reallocated if it's too
> > + * small to hold *new_n items. New items are zeroed out if the array
> > grows. Allocation
> > + * is rounded up to next kmalloc bucket size to reduce frequency of
> > resizing. *new_n
> > + * contains the new total number of items that will fit.
> >    *
> > - * Contrary to krealloc_array, does not free arr if new_n is zero.
> > + * Contrary to krealloc, does not free arr if new_n is zero.
> >    */
> > -static void *realloc_array(void *arr, size_t old_n, size_t new_n,
> > size_t size)
> > +static void *realloc_array(void *arr, size_t old_n, size_t *new_n,
> > size_t size)
> >   {
> > -	if (!new_n || old_n == new_n)
> > +	void *old_arr = arr;
> > +	size_t alloc_size;
> > +
> > +	if (!new_n || !*new_n || old_n == *new_n)
> >   		goto out;
> 
> 
> [..]
> 
> > -	arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> > -	if (!arr)
> > +	alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
> > +	arr = krealloc(old_arr, alloc_size, GFP_KERNEL);
> > +	if (!arr) {
> > +		kfree(old_arr);
> >   		return NULL;
> > +	}
> 
> Any reason not do hide this complexity behind krealloc_array? Why can't
> it take care of those roundup details?

It might be possible to do this with a macro, yes, but then callers
aren't in a position to take advantage of the new size. Maybe we need
something like:

	arr = krealloc_up(old_arr, alloc_size, &new_size, GFP_KERNEL);

Thanks for looking this over!

-- 
Kees Cook
