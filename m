Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD2C611E09
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ1XTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ1XTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:19:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C7DED0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:19:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so8672221pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8si2vf2VR/0A71CmzV1b/E7teUHcCtPVdR2pRp+lY8=;
        b=clKJ+Eg6+E0kRwaPzQAVWxthIdxES0GjL1p448fD6NVR6gLbX1eczAu4jxN0gWLWhv
         TSjMCeFG++GL6H7sUQggoD5XRg/tQZvUecnWNMQ4jnwFlmG076w+t58t0sCmUF1V1FdQ
         HV/3iQFh7fG7WgFOYH4I+amvHPuWEL2JD8UlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8si2vf2VR/0A71CmzV1b/E7teUHcCtPVdR2pRp+lY8=;
        b=csDKCcJTCKqy7KJ1dv4NMFmoZ2gIrDkLa8WNNEjJWzf4ORicRZxaeuU2uWBVfpD2Vs
         kUeg+IEPQDw7CbHDNoNhhHt6q0HLD35Mr/PO0pHaNkIyrldUZ7eauwvaau9vd+JsIzjj
         dnF81Tsae0h1ZCXAGHoGwOLAP5Lt0E4tKyO1lAFsxcZ/S2u+ey8hIvJ87WNUYZvTyAcj
         gGz9OeOFNr0hO5Jjyfn1viZM33F+SBw6pWNxoDGS26ID2ewcKFMRX86PDW29j08u11xj
         BqX/dSRqWWK2WedMPTQrn9ZGuGKDv3Fhy9Gv0uAiy/GwWk1vM9trmJ/3fBrJTJYH2hGs
         mE8w==
X-Gm-Message-State: ACrzQf1+BwCTBAJ/3WvRdkpAiXE6TIZAZKJDVxBSbYydFEQhoGZ4T0Zk
        yOOSCyoqE2miZrbgqT/p7mEm6A==
X-Google-Smtp-Source: AMsMyM7NKSQxTDDDJ5e8zb24NoUJVrOTK3QcTM+sRWtNVFQsC4i6r85bfjefRevEt5AviWBG66gedw==
X-Received: by 2002:a17:902:aa02:b0:186:9395:4e82 with SMTP id be2-20020a170902aa0200b0018693954e82mr1488384plb.5.1666999178970;
        Fri, 28 Oct 2022 16:19:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f22-20020a63e316000000b0046ece12f042sm8119pgh.15.2022.10.28.16.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:19:38 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:19:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stanislav Fomichev <sdf@google.com>
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
Message-ID: <202210281617.F35925A52@keescook>
References: <20221018090550.never.834-kees@kernel.org>
 <Y07raim32wOBRGPi@google.com>
 <202210181110.CD92A00@keescook>
 <CAKH8qBvwKfhMYjHV=rizA0ZinArHKmBP6U_N63HTcZTmM=QQ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBvwKfhMYjHV=rizA0ZinArHKmBP6U_N63HTcZTmM=QQ+g@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:07:45PM -0700, Stanislav Fomichev wrote:
> On Tue, Oct 18, 2022 at 11:19 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Oct 18, 2022 at 11:07:38AM -0700, sdf@google.com wrote:
> > > On 10/18, Kees Cook wrote:
> > > > Round up allocations with kmalloc_size_roundup() so that the verifier's
> > > > use of ksize() is always accurate and no special handling of the memory
> > > > is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE. Pass the new size
> > > > information back up to callers so they can use the space immediately,
> > > > so array resizing to happen less frequently as well. Explicitly zero
> > > > any trailing bytes in new allocations.
> > >
> > > > Additionally fix a memory allocation leak: if krealloc() fails, "arr"
> > > > wasn't freed, but NULL was return to the caller of realloc_array() would
> > > > be writing NULL to the lvalue, losing the reference to the original
> > > > memory.
> [...]
> > > > -   arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> > > > -   if (!arr)
> > > > +   alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
> > > > +   arr = krealloc(old_arr, alloc_size, GFP_KERNEL);
> > > > +   if (!arr) {
> > > > +           kfree(old_arr);
> > > >             return NULL;
> > > > +   }
> > >
> > > Any reason not do hide this complexity behind krealloc_array? Why can't
> > > it take care of those roundup details?
> >
> > It might be possible to do this with a macro, yes, but then callers
> > aren't in a position to take advantage of the new size. Maybe we need
> > something like:
> >
> >         arr = krealloc_up(old_arr, alloc_size, &new_size, GFP_KERNEL);
> 
> Maybe even krealloc_array_up(arr, &new_n, size, flags) or similar
> where we return a new size?
> Though I don't know if there are any other places in the kernel to
> reuse it and warrant a new function..

Yeah, and it explicitly can't be a function, since GCC has broken
attribute handling[1] for inlines. :(

Regardless, I'll respin this with a macro and see how it looks.

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503

-- 
Kees Cook
