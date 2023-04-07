Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1A6DB3E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDGTHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDGTHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:07:08 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09207114
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:07:06 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 866CE3F238
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680894423;
        bh=NxU5wo4yJIlxfUu7luiA0zDVsYB5pwNg6QbXIvPeaIU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=dhLcKKg4QcM2brn0GMCPB/zd6Kyk3b+GPENsh7BDgoPytaf7TtE5bUjtO5p2qvfCJ
         x/PMRVgSNwmSXPEDp0pQdUcbfveTzLtd92SfPp/zq6mPsRN1NSHNTS1wObCBC6omZ3
         cyzv4Xdf7F6gVeVxNzys7JZb3RbS9MbgBN/Ci4qrMpfqr7w/J9kC1o2zLRUxGGbDGy
         ViaPt5rWNmQU9VREmw7xuHOUfKBztMmsDdVpY4N5nYmZMH7u9Oafr0PWesA6G+PbM3
         XNDqufef7znc5yJZrfAzNarnKeteoDN/AK4fCCkKClxA4j9crilpQDKwrGtPgPuCvx
         w9HrC55W6lnZQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-93440b99eb3so136046966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680894422; x=1683486422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxU5wo4yJIlxfUu7luiA0zDVsYB5pwNg6QbXIvPeaIU=;
        b=ReRnplVXgqAVSvq+LB5OFNIxRL3T02LRjJaePiMh/97be17/ORTdYyz2tm7e70Ez/8
         1uSn0LnGUzBoVgin4G/Gbdnm6Lqz/ynZnr+Lqh39/ggK+UFTm79/x31vNHIENdJHz/77
         Njw4rPzg0+8gE9butPc8sxlE1+5BjR+nnNhhwsW3FBPfUUGDk/S3nYZK90aAlTfK31x9
         O7hw+F3jeEskjYnhvnskGl5IUIDZDTpoPcZ1jE4pCvyzuKQGNTZ3CPNKaGQ5JOvumlbA
         5D/usJhl5hS+mE/Ipjn3IEN/qajAwZGVHnCLB+7sx7L1YUZROq/sy3IJhUYu8yeuY9JF
         Gr5g==
X-Gm-Message-State: AAQBX9fyl3iVONlbsWmmJqdrH4l1r40yg2ur3WJzi60RWDYfYzwxCWJw
        2FUZ1gYHy2dfIoMlsrkRp90hROVu4OzbPEFrWlTSyujGeIFBfDnFQY3xGP3Ajurt2Po+EZpNE69
        JvoJjAO4HjAVHysbf236rR+GmgcpPbCF8Sp6TII7z+Q==
X-Received: by 2002:aa7:c6cf:0:b0:504:8738:9758 with SMTP id b15-20020aa7c6cf000000b0050487389758mr639100eds.16.1680894422104;
        Fri, 07 Apr 2023 12:07:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y+tYyDiSKosZ5ldvA/H/HGaVnXTlxmZ8wichKKXSZ50KMbwudz4TFE8q0RJqP9YJxlGWNrJA==
X-Received: by 2002:aa7:c6cf:0:b0:504:8738:9758 with SMTP id b15-20020aa7c6cf000000b0050487389758mr639079eds.16.1680894421788;
        Fri, 07 Apr 2023 12:07:01 -0700 (PDT)
Received: from localhost (host-79-33-132-140.retail.telecomitalia.it. [79.33.132.140])
        by smtp.gmail.com with ESMTPSA id k13-20020a50ce4d000000b00504872a5288sm163126edj.35.2023.04.07.12.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:07:01 -0700 (PDT)
Date:   Fri, 7 Apr 2023 21:07:00 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Eric Curtin <ecurtin@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Neal Gompa <neal@gompa.dev>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: rust: drop is_rust_module.sh
Message-ID: <ZDBp1PaVL7KoqOdD@righiandr-XPS-13-7390>
References: <20230407070517.204676-1-andrea.righi@canonical.com>
 <20230407175318.GA1018455@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407175318.GA1018455@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:53:18AM -0700, Nathan Chancellor wrote:
> On Fri, Apr 07, 2023 at 09:05:17AM +0200, Andrea Righi wrote:
> > Commit c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
> > introduced the constraint "!DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE"
> > to enable RUST.
> > 
> > With this constraint we don't need is_rust_module.sh anymore, because
> > 'pahole --lang_exclude=rust' already has the capability to exclude Rust
> > CUs. If pahole isn't recent enough (< 1.24) to support --lang_exclude,
> > then DEBUG_INFO_BTF can't be enabled with RUST and is_rust_module.sh
> > isn't used as well.
> > 
> > In any case is_rust_module.sh is obsolete and we can just drop it.
> > 
> > Link: https://lore.kernel.org/lkml/Y+p2xKIN6TJnQinK@righiandr-XPS-13-7390/
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> > ---
> >  rust/macros/module.rs     |  2 +-
> >  scripts/Makefile.modfinal |  2 --
> >  scripts/is_rust_module.sh | 16 ----------------
> >  3 files changed, 1 insertion(+), 19 deletions(-)
> >  delete mode 100755 scripts/is_rust_module.sh
> > 
> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> > index a7e363c2b044..608406f33a70 100644
> > --- a/rust/macros/module.rs
> > +++ b/rust/macros/module.rs
> > @@ -179,7 +179,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
> >              /// Used by the printing macros, e.g. [`info!`].
> >              const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
> >  
> > -            /// The \"Rust loadable module\" mark, for `scripts/is_rust_module.sh`.
> > +            /// The \"Rust loadable module\" mark.
> >              //
> >              // This may be best done another way later on, e.g. as a new modinfo
> >              // key or a new section. For the moment, keep it simple.
> 
> It seems like this whole section can be dropped? I only see
> __IS_RUST_MODULE used in scripts/is_rust_module.sh, as the comment
> states.

In the scope of the kernel, yes, only is_rust_module.sh used that, but
outside the kernel "something" may still rely on this section. Keeping
it seems safer for now, to avoid potential user-space breakage.

Thanks,
-Andrea
