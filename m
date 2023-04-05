Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059D06D88DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjDEUmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjDEUlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:41:46 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235938A6B;
        Wed,  5 Apr 2023 13:40:58 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17ab3a48158so39997974fac.1;
        Wed, 05 Apr 2023 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680727246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AfCjLWvZIUyrgKze4xPpxcziixhKFGAgi7gT/eIT+U8=;
        b=Le7L6+VD0Sv7hAIrRqgQlJc6ChQGeWIYqtkZd2fflXlmHFZnyUlwL6zmbHpm/0mTGs
         nTpqfWAwXZ2LnlsheP7fuSbRETmvyxctIKmMqez8E1GnGyUqEIknJiv8wV34TUNmzTQo
         aa/BZRwkZSFDC6DoUsuhDsRXbA4LENTp7kgPuBAdDAPbnfIBRsifpEi8bL0/lZUy4i1L
         YH6WyPULBzQfWedumPha366T2Px4ttbX6t5mmR4YDK9wbLcEFJXfz0jiLS4gR/C6GSv7
         8AJeVfYLuFE1o4Huk+Zy7aBrtZwceDvjIToR9Je7UMsHXcbpwvDudS5OzMpeVdq9Rei1
         MV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfCjLWvZIUyrgKze4xPpxcziixhKFGAgi7gT/eIT+U8=;
        b=2Vzdfv2jO/YjdBJ7b4DrUtOHq39OWml0kkBfGgV2KIjYHkzAw7K09rHKpS9rXpl/uu
         vkQp5Ab6d9nYCIEQYEcmv60FHGM9m1GpxWjP4U7mBWUw6YpgycALV6RWiyol3/dDObbw
         CmetyosiHhgpTbDOTYX/4ryfxvnKxZBqzPcfzEdsNhzP/APXETntygB94nHUKziTV3Uf
         UrQKPAE9+tpBRBeAudmhsVeb5XVQgvbJ16UkZxAiZXvzD9Jdg25lJouygONIcG1jQ535
         pmmXezb5FqMEVjDXH2ZTEQ2TeVPo0XYOpltP7T57vc9+1iDB50dXpIWZHiajQtOgN1pk
         LnAg==
X-Gm-Message-State: AAQBX9cwmGtEJxrYjRthgctJ0Zhv6Mz4gmL2vIX60eAqtEnTmNB5osln
        slNWq0IRILCTmAO9ingDogo=
X-Google-Smtp-Source: AKy350YHZqITSCSHJLqDyeFxsbBpFfc7dh8uKfXjKnRN7VvLgSzusK6v7T6nW9Fa3P3El6KBOZxelg==
X-Received: by 2002:a05:6870:b68e:b0:17a:c83d:8f9d with SMTP id cy14-20020a056870b68e00b0017ac83d8f9dmr3925311oab.19.1680727246300;
        Wed, 05 Apr 2023 13:40:46 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id uq11-20020a056870df0b00b00176d49bb898sm6273610oab.44.2023.04.05.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:40:46 -0700 (PDT)
Date:   Wed, 5 Apr 2023 17:40:39 -0300
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 03/13] rust: lock: introduce `Mutex`
Message-ID: <ZC3cxzpnrnXf/osU@wedsonaf-dev>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
 <20230405175111.5974-3-wedsonaf@gmail.com>
 <2023040554-promoter-chevron-10b2@gregkh>
 <2023040509-tamer-clinic-c14c@gregkh>
 <20230405191826.GA365912@hirez.programming.kicks-ass.net>
 <ZC3YWLmIick4jSSv@wedsonaf-dev>
 <20230405202932.GG365912@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405202932.GG365912@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 10:29:32PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 05:21:44PM -0300, Wedson Almeida Filho wrote:
> > On Wed, Apr 05, 2023 at 09:18:26PM +0200, Peter Zijlstra wrote:
> > > On Wed, Apr 05, 2023 at 08:04:22PM +0200, Greg KH wrote:
> > > > On Wed, Apr 05, 2023 at 08:03:11PM +0200, Greg KH wrote:
> > > > > On Wed, Apr 05, 2023 at 02:51:01PM -0300, Wedson Almeida Filho wrote:
> > > > > > +void rust_helper_mutex_lock(struct mutex *lock)
> > > > > > +{
> > > > > > +	mutex_lock(lock);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
> > > > > > +
> > > > > 
> > > > > No need to ever unlock a mutex?
> > > > 
> > > > Oh nevermind, mutex_lock() is a macro, mutex_unlock() is not...
> > > 
> > > Yeah, so I despise all these stupid helpers... but I suppose it's the
> > > best they could come up with to interface the languages :/
> > > 
> > > The only hope is that the thing can do cross-language LTO or something
> > > to re-inline stuff.
> > 
> > One thing we could to do improve the situation is to convert some of the
> > existing macros into inline functions on the header files.
> > 
> > We can't do it for all cases (e.g., cases like mutex_init that declare a new
> > static variable when lockdep is enabled) but mutex_lock is just a function
> > when lockdep is disabled, and just calls mutex_lock_nested() when it is enabled.
> > 
> > How do you feel about this?
> > 
> > -#define mutex_lock(lock) mutex_lock_nested(lock, 0)
> > +static inline void mutex_lock(struct mutex *lock)
> > +{
> > +       mutex_lock_nested(lock, 0);
> > +}
> 
> Can rust actually parse C headers and inline C functions ? I thought the
> whole problem was that it can only call C ABI symbols (which inline
> functions are not).

Rust can't. We use a tool called bindgen to read C header files and generate
equivalent Rust (extern "C") declarations for functions. The tool has been
enhanced recently (https://github.com/rust-lang/rust-bindgen/pull/2335) to
handle static inline functions by automatically generating helpers like the one
above (in addition to the Rust decls).

So the situation is improved in that we don't need to manually write (and
commit) the helpers. It may improve further in the future if we get better
integration of the languages.
