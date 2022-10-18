Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4065560317F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJRRUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJRRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:20:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8688E7B284
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:20:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so14598636pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzA7KFscGcTYw/jlVpmUrWtxk0VQxSITq1/A7jVwNp4=;
        b=gkN5uN6j+2Rasgo1mpJY6UDA47g4OVbtLOnT9MEBTvwmeKLZ3JnFVmCgsSwTbawI60
         fTOjmwq2NjPvM1vsxSrcCZw/2A1hxn4gexKx6LLDGHUakBh7+WUhrYI46/zWlh0B8lox
         /ay89kGbOPwWfGnkb7sFZ0MKJlMKigYi2g7Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzA7KFscGcTYw/jlVpmUrWtxk0VQxSITq1/A7jVwNp4=;
        b=dyUVrpz/VNW+4SftqJxdfoUS/7NUoi17G3bHWP/UChvbMRYXrDxTo+QW4uQzRKxy+w
         OhiHCrhft2cze5xcn6DPbrws370QDgQr0dGWiam8+5M6mchHLyCer0hnupB9HD4Lo7Jd
         t0pOTpu1ukiY8vaIWmo8+Ll9ZQgY2Viz4CUsepGu7iJTr4mUPyoP5uJ4UdF3gzwAqjqD
         DW7OGcey+kh03DblsR/UQI9QaQ83rL7lNG7rxtKnby3632swjb7pTCxePzxDM67MI/Pd
         MUb5N+AOUsyz3qlJcamzcqp6hKhDLTNIxMfE6tlAnCgSwrAJ0KkVYG1KiugtoqF6C0Z1
         CuDw==
X-Gm-Message-State: ACrzQf2i9ADpKugG45GLvhyIeuIzD/90FINYAFngpxL4wGdhzNSrcAL6
        zlIT+ETXUAnzg9xk5fq8EGsimQ==
X-Google-Smtp-Source: AMsMyM4oPkrEyoYhrUGb9NOJMPFawGNM3cLeYe84+ieZqFzUSBTgtuJ7INnr+OaEdHAdQV5E9Fp6nA==
X-Received: by 2002:a17:903:1c6:b0:185:47ce:f4f0 with SMTP id e6-20020a17090301c600b0018547cef4f0mr4109622plh.132.1666113614694;
        Tue, 18 Oct 2022 10:20:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 75-20020a62154e000000b00562a8150c08sm9395682pfv.168.2022.10.18.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:20:13 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:20:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     David Laight <David.Laight@aculab.com>,
        'Peter Zijlstra' <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210181013.923F8809@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <9bb036e48580454b81e6de7224c5f006@AcuMS.aculab.com>
 <3edb387ea335085dcb6dd49f1d9c9ce6@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3edb387ea335085dcb6dd49f1d9c9ce6@overdrivepizza.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 08:58:24AM -0700, Joao Moreira wrote:
> > Does the hash value for kCFI only depend on the function type?
> > Or is there something like a attribute that can also be included?
> 
> Hi David -- does this sound like what you are asking about?
> 
> https://github.com/ClangBuiltLinux/linux/issues/1736
> 
> If yes, then it is something in our todo list :) I think Sami is handling
> it.

I was hoping someone with prior experience with Call Graph Detaching to
solve Transitive Clustering Relaxation[1] could assist? ;)

-Kees

[1] https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel.pdf

-- 
Kees Cook
