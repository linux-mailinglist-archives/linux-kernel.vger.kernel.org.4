Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B46D8912
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjDEUuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjDEUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:50:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6A10E7;
        Wed,  5 Apr 2023 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IKKsnS3MuUIvRxMy4gZqz2HRi+ZqkC38lFixxuuqyM0=; b=fE14ROxcsZyXXmo/B5pJ4W4N7Y
        BL9RtcBObIBQP/0sd7V5jWKBJCz8XJSFdaseUG5oekzFKVgjuSYzxKu6Uc9dXu+SJ3JppkqmcWjbH
        hM93rlw1sXbzoSMyDOYJYy5VyseTmP/h5f2BpVl8IzNhm5WEZ+ANtK4lggPZUFCc01Jy3CI7Lcr7o
        qSaC+u81xVk2+VP9FezUkzI1pt7zLW1h4TDhaZT6+ZubXunWdEUx20wDNw4+AjEdMeezAwbnbkjAx
        RVTo6TX23eHJWeBE948QSCg+cxyVX0aRK5iS3YHn0htgslwFijmbwaYqCAhDwkocw+qmqJbZBuvwC
        /B3+rYJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkA4d-00Gkcy-NU; Wed, 05 Apr 2023 20:49:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CE1C30036C;
        Wed,  5 Apr 2023 22:49:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E98FA26A19DBF; Wed,  5 Apr 2023 22:49:42 +0200 (CEST)
Date:   Wed, 5 Apr 2023 22:49:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
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
Message-ID: <20230405204942.GH365912@hirez.programming.kicks-ass.net>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
 <20230405175111.5974-3-wedsonaf@gmail.com>
 <2023040554-promoter-chevron-10b2@gregkh>
 <2023040509-tamer-clinic-c14c@gregkh>
 <20230405191826.GA365912@hirez.programming.kicks-ass.net>
 <ZC3YWLmIick4jSSv@wedsonaf-dev>
 <20230405202932.GG365912@hirez.programming.kicks-ass.net>
 <ZC3cxzpnrnXf/osU@wedsonaf-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC3cxzpnrnXf/osU@wedsonaf-dev>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 05:40:39PM -0300, Wedson Almeida Filho wrote:
> On Wed, Apr 05, 2023 at 10:29:32PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 05, 2023 at 05:21:44PM -0300, Wedson Almeida Filho wrote:
> > > On Wed, Apr 05, 2023 at 09:18:26PM +0200, Peter Zijlstra wrote:
> > > > On Wed, Apr 05, 2023 at 08:04:22PM +0200, Greg KH wrote:
> > > > > On Wed, Apr 05, 2023 at 08:03:11PM +0200, Greg KH wrote:
> > > > > > On Wed, Apr 05, 2023 at 02:51:01PM -0300, Wedson Almeida Filho wrote:
> > > > > > > +void rust_helper_mutex_lock(struct mutex *lock)
> > > > > > > +{
> > > > > > > +	mutex_lock(lock);
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
> > > > > > > +
> > > > > > 
> > > > > > No need to ever unlock a mutex?
> > > > > 
> > > > > Oh nevermind, mutex_lock() is a macro, mutex_unlock() is not...
> > > > 
> > > > Yeah, so I despise all these stupid helpers... but I suppose it's the
> > > > best they could come up with to interface the languages :/
> > > > 
> > > > The only hope is that the thing can do cross-language LTO or something
> > > > to re-inline stuff.
> > > 
> > > One thing we could to do improve the situation is to convert some of the
> > > existing macros into inline functions on the header files.
> > > 
> > > We can't do it for all cases (e.g., cases like mutex_init that declare a new
> > > static variable when lockdep is enabled) but mutex_lock is just a function
> > > when lockdep is disabled, and just calls mutex_lock_nested() when it is enabled.
> > > 
> > > How do you feel about this?
> > > 
> > > -#define mutex_lock(lock) mutex_lock_nested(lock, 0)
> > > +static inline void mutex_lock(struct mutex *lock)
> > > +{
> > > +       mutex_lock_nested(lock, 0);
> > > +}
> > 
> > Can rust actually parse C headers and inline C functions ? I thought the
> > whole problem was that it can only call C ABI symbols (which inline
> > functions are not).
> 
> Rust can't. We use a tool called bindgen to read C header files and generate
> equivalent Rust (extern "C") declarations for functions. The tool has been
> enhanced recently (https://github.com/rust-lang/rust-bindgen/pull/2335) to
> handle static inline functions by automatically generating helpers like the one
> above (in addition to the Rust decls).

Oh man, that's sad, I was hoping it would write the equivalent inline
function in rust.

> So the situation is improved in that we don't need to manually write (and
> commit) the helpers. It may improve further in the future if we get better
> integration of the languages.

But yeah, feel free to convert macros to inline functions where the
difference is moot. There is indeed no real reason for mutex_lock() to
not be an inline function in that case.
