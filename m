Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEACB6D881C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjDEUV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDEUVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:21:55 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7B2195;
        Wed,  5 Apr 2023 13:21:52 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id f14so14003828oiw.10;
        Wed, 05 Apr 2023 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680726112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnADMbw67GFOIAu/QMHFrxWtG2e8CKg/IkYrnPOwmus=;
        b=Hat/L9omZemr/+kN3CwaZL4zGAcj2qQmnPXrv1Q0zbE3adcTSzjk4nlZShdr7amtz7
         cHlM6cFRVI39kHV+XBQft4BjPoOOLnH68uYHYWfReBqQzor5czLyqMuhX6mf5CSWt9Qz
         MArQoezzMzv5LLUKzw9r/xJ6T86SpKNg064+aUuzuUdSQg/d/bjj7rb+ue3zQ6I94lcs
         3sfAxpdWXnwMRNQFBBTDTZZYyffE/nyGPgYAVXmqvSnFqwO59AvS/YJML/xNfPClMIS0
         Wqyzu69s16omrv2bgBtQxMvChTesuQ8nd1ZH0PKi+ESWWkyF842o/+q4vHw+eOzGYYvn
         bh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680726112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnADMbw67GFOIAu/QMHFrxWtG2e8CKg/IkYrnPOwmus=;
        b=CM1SBZWjMmwbecQdFXFezG+rD19P5f6RQFcnyGcNlsPMLrFqikO+YXLX7qtZ4bC9C0
         U935PDJ0B/bq3/XsDsCQo4YKkJfAH6zCSSZRyhLoSL2upyocZ2QjbXNANRzihPzeKwJW
         qSa4qU2VYm04FSxcdDWLgXtqx7F099OCHoBxmCRAD9JQowRYqGI3fVuKxTq+zvBZ9ZsG
         c4daWBBqFZKNN++BljT9y6Zz3IDWpPpLZPST/ys06LhOXt3EXqvg/KDDd1zSTzKQYTHZ
         eLUBe5fKDfNhDx7RHidLNyO/a0EZSqXgOkdrR69EQec4d3FqCSrKsZQxRPwbY9CP7FME
         eP4w==
X-Gm-Message-State: AAQBX9faCDHn3bm1woBb19W4u7d3t1KGi+fm/V53gxpW7xV05vldE2vJ
        plCrcDpIPDPcQ/r3mpgHkwY=
X-Google-Smtp-Source: AKy350aDT8+G8AmvxEe3zYFaAVMcIYPOQWuEBkL2b70IE+POBcy++j0fHXAtNio+G7hop06C6529Kw==
X-Received: by 2002:a05:6808:6345:b0:384:1c58:53a with SMTP id eb5-20020a056808634500b003841c58053amr3324117oib.40.1680726111967;
        Wed, 05 Apr 2023 13:21:51 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id i2-20020a4aab02000000b005251e3f92ecsm6997239oon.47.2023.04.05.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:21:51 -0700 (PDT)
Date:   Wed, 5 Apr 2023 17:21:44 -0300
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
Message-ID: <ZC3YWLmIick4jSSv@wedsonaf-dev>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
 <20230405175111.5974-3-wedsonaf@gmail.com>
 <2023040554-promoter-chevron-10b2@gregkh>
 <2023040509-tamer-clinic-c14c@gregkh>
 <20230405191826.GA365912@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405191826.GA365912@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 09:18:26PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 08:04:22PM +0200, Greg KH wrote:
> > On Wed, Apr 05, 2023 at 08:03:11PM +0200, Greg KH wrote:
> > > On Wed, Apr 05, 2023 at 02:51:01PM -0300, Wedson Almeida Filho wrote:
> > > > +void rust_helper_mutex_lock(struct mutex *lock)
> > > > +{
> > > > +	mutex_lock(lock);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
> > > > +
> > > 
> > > No need to ever unlock a mutex?
> > 
> > Oh nevermind, mutex_lock() is a macro, mutex_unlock() is not...
> 
> Yeah, so I despise all these stupid helpers... but I suppose it's the
> best they could come up with to interface the languages :/
> 
> The only hope is that the thing can do cross-language LTO or something
> to re-inline stuff.

One thing we could to do improve the situation is to convert some of the
existing macros into inline functions on the header files.

We can't do it for all cases (e.g., cases like mutex_init that declare a new
static variable when lockdep is enabled) but mutex_lock is just a function
when lockdep is disabled, and just calls mutex_lock_nested() when it is enabled.

How do you feel about this?

-#define mutex_lock(lock) mutex_lock_nested(lock, 0)
+static inline void mutex_lock(struct mutex *lock)
+{
+       mutex_lock_nested(lock, 0);
+}
+
