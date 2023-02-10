Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F31692964
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjBJVhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjBJVhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:37:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE38160E46
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:37:50 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B5F873F329
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 21:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676065067;
        bh=eC2XZoUBnGDmxKSPMrW/XXx7BIGT4mv6vf3OxAuOY0I=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=QrFzEzJEjwGHPGp/sdSsT3hLX86gjysktCvs1/TvQJvNVJnEzXYhXTG7K9bUXKP73
         wpeCQF0MjRhP3XODhkhPeLJJ5GtxAU67U2PJXPhq44kzktlQcNbC8RQXuoU9+4q0ry
         +e94CR2uHKJdvLqMO1zCicjsZTLgzxREo6mkecym1P7nqlEATO9cwJDCgdALNeGz1m
         S1iPs8FbxfAus00rPr5Qf31zHfLBPBzMFPXt2GIXH7Y/hfuANHSEwJ1sRpMs3uThF3
         L7vER17iZwEef1dAKC+VvEYMnzbx96MRxnK1BM6J5eDtAhZap7oUnIGePU/LlTHn5h
         53H6MvsfUUDvA==
Received: by mail-ej1-f72.google.com with SMTP id i11-20020a1709061ccb00b008aadd9cb12fso4291336ejh.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC2XZoUBnGDmxKSPMrW/XXx7BIGT4mv6vf3OxAuOY0I=;
        b=TcUJi9FddYdgEUIINzNfo9VDiTMHo1TPJRM36zYdKhDVEL6ktzS1ynRm97pGc0S3hy
         uFjFkmzYvBNVNO3AoOJJDXMIx6ziCfaBbrocH0Jwc51TYbZSZKsegBAzvBFx6bURYbrq
         H8upWVKISqVPmcZNJxA4qs8YC6LrD14KCfyH/cQDADd/gQ2k3kjPAUhynoKlWCEsyNs9
         2CMkEG3bNqnRLVhCy6AYl6RdUqgMuJ58LLljYl+PHxOa4WU2lUHsIYDTl12tVs5AL7bA
         wndcOgY1n2IelwAlX7ZEIRDSbg4I+zrrWGIEz9SW0Nur2IHmEgfQoHn9pYE0SbUFz/iQ
         Evcg==
X-Gm-Message-State: AO0yUKWBki8fXVcKETTRvMZEhjtaQEmZp3JR/EzqR03zutE9o7WCcV/F
        uDdBe8gj/D0Csgj6PajRndcFwN4ICf8PGVZunyAvFl7F+DxZ7B4C76ZhPUbyD151/hxIFnqTHB1
        Z5E8T98/6Yp7IH60LaiHWeLvcVJoan+ntMjtaGapfRA==
X-Received: by 2002:a17:906:d54f:b0:8aa:875d:9d9a with SMTP id cr15-20020a170906d54f00b008aa875d9d9amr19218542ejc.50.1676065067214;
        Fri, 10 Feb 2023 13:37:47 -0800 (PST)
X-Google-Smtp-Source: AK7set9tQPWSKYHZI8inu8XKqYP5n9wE+26d1aWDJPmcuaYvCIZs5H3m4k+oT+RGH2S9Xw5DEwqt5w==
X-Received: by 2002:a17:906:d54f:b0:8aa:875d:9d9a with SMTP id cr15-20020a170906d54f00b008aa875d9d9amr19218529ejc.50.1676065067021;
        Fri, 10 Feb 2023 13:37:47 -0800 (PST)
Received: from localhost (host-87-7-128-191.retail.telecomitalia.it. [87.7.128.191])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b0084d35ffbc20sm2906112ejo.68.2023.02.10.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 13:37:46 -0800 (PST)
Date:   Fri, 10 Feb 2023 22:37:45 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: allow to use INIT_STACK_ALL_ZERO
Message-ID: <Y+a5KQjQopSXwVPJ@righiandr-XPS-13-7390>
References: <20230210172203.101331-1-andrea.righi@canonical.com>
 <Y+aBT8AD9RXde24X@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+aBT8AD9RXde24X@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:39:27AM -0700, Nathan Chancellor wrote:
> On Fri, Feb 10, 2023 at 06:22:03PM +0100, Andrea Righi wrote:
> > With CONFIG_INIT_STACK_ALL_ZERO enabled, bindgen is passing
> > -ftrivial-auto-var-init=zero to clang, that triggers the following:
> > 
> >   error: '-ftrivial-auto-var-init=zero' hasn't been enabled; enable it at your own peril for benchmarking purpose only with '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang'
> > 
> > This flag should be dropped in clang-17, but at the moment it seems more
> > reasonable to add it to the bindgen CFLAGS to prevent the error above.
> > 
> > In this way we can enable CONFIG_INIT_STACK_ALL_ZERO with CONFIG_RUST
> > without triggering any build error.
> > 
> > Link: https://reviews.llvm.org/D125142
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> 
> If this went via the kbuild tree, would we be able to use
> $(CC_AUTO_VAR_INIT_ZERO_ENABLER)?
> 
> https://git.kernel.org/masahiroy/linux-kbuild/c/4e3feaad6ff8a7a57e3bf3308a93c93e3a2e17a6
> 
> Although, I suppose this could be a problem if the version of clang
> being used to build the kernel does not support this flag while the
> version of libclang in bindgen requires it?

I didn't have much success with CC_AUTO_VAR_INIT_ZERO_ENABLER, but maybe
a better way is to check if the version of libclang used by bindgen is
less than 17, considering that is extra clang option is supposed to be
dropped in clang-17:

https://github.com/llvm/llvm-project/issues/44842

I'll send a v2, unless we find a better way to support this auto var
zero-init feature.

-Andrea
