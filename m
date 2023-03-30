Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E56D088F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjC3OoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjC3OoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:44:08 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED4176B3;
        Thu, 30 Mar 2023 07:44:03 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17997ccf711so19987897fac.0;
        Thu, 30 Mar 2023 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680187442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M59Zhlyue+8YucUN9CbNq8WgSVKkMeAwGI1kFlClvWI=;
        b=S+j8LaCm6UEQDjtGt+RxgfCmBk1JE4gXT3XjF7e/k4NfYX+GRLTSLYO3lEh4EohhgX
         xSSqV7kHVsbGoGaTYeDiSaLW8geOql4v/YU00Am7SSdiYYT34GJpyIytHoH7InX5K1Z7
         O3X3MKlPTnunSmv4Xa4mfGRG93ADd0z2n4xPgRmWNzM3H+hGSZa1xFjW9WUVUxgxbTzA
         YI/WQxjzR0yAw+/ow5/DgbigPA0UNXOpP/VwGdpSfhhPJxXVDkK3WPo9jwt44YduG7Q+
         N+5po5P1bvyFbjo8aEj4wG8gm2akSqChvVflczd2fJJ34WoYS7Csu4KDtseZgkNeC50r
         wzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M59Zhlyue+8YucUN9CbNq8WgSVKkMeAwGI1kFlClvWI=;
        b=30EujOZY0MdfW/fql0Vb9xFMaEcr99UTonYVtuFIXlz2MWNpK2wlPNAFYex8W5je5P
         I2II0USmnoxONZ1PVh8J5NzdGmBGdvRhlnHjAbTfGC8tZfduAF1BrhR8MqNv+iRrBEWZ
         YOvGKJzIPNdqIXhO9180x+H/FKe/lgR83Ak8FTusyRRx0mIpV8Fr1UK4KwTVSQoPHkvw
         YTLkLr1BL3S5XkZFjUm9OBl02a19OZK//IkVLl427MnGjIF+4E/34zf74gR+JCkPkbsi
         OCgS86N6CFf2kJgTSwlxytwOcMr3CQBaRW5FcNnkhNoqW7DtpklfgasHQyYeZYKHIoDi
         HFIA==
X-Gm-Message-State: AAQBX9dO59xiMa7Tcbfx0cXz2xIZNEf6l2MDTMbAtTBjjjwU57d4YF92
        W/TJa3br7AgZilNd1YQIc0k=
X-Google-Smtp-Source: AKy350bTycHczbqfayfmBmcZYXTDdV1/OLKONTgYIIWZFgTJ7BMWHyyd5uD3Wj/6om/OKXEjay/jiA==
X-Received: by 2002:a05:6870:3118:b0:177:b77c:3430 with SMTP id v24-20020a056870311800b00177b77c3430mr13765538oaa.35.1680187442173;
        Thu, 30 Mar 2023 07:44:02 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id xg8-20020a056870cf8800b00177ba198612sm12883872oab.53.2023.03.30.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:44:01 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:43:54 -0300
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 12/13] rust: sync: introduce `CondVar`
Message-ID: <ZCWgKnuRpUfWs2wT@wedsonaf-dev>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-12-wedsonaf@gmail.com>
 <20230330125223.GC124812@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330125223.GC124812@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 02:52:23PM +0200, Peter Zijlstra wrote:
> On Thu, Mar 30, 2023 at 01:39:53AM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > This is the traditional condition variable or monitor synchronisation
> > primitive. It is implemented with C's `wait_queue_head_t`.
> > 
> > It allows users to release a lock and go to sleep while guaranteeing
> > that notifications won't be missed. This is achieved by enqueuing a wait
> > entry before releasing the lock.
> > 
> 
> > +/// A conditional variable.
> > +///
> > +/// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
> > +/// atomically release the given lock and go to sleep. It reacquires the lock when it wakes up. And
> > +/// it wakes up when notified by another thread (via [`CondVar::notify_one`] or
> > +/// [`CondVar::notify_all`]) or because the thread received a signal. It may also wake up
> > +/// spuriously.
> 
> Urgh so wide :-/

Thanks for reviewing :)

> But no, threads can *always* and for any reason, have spurious wakeups.

I don't believe I said otherwise. Is there anything in the text above you'd like to see changed?

> Also, is this hard tied to mutex? If so, you should probably use swait
> instead of wait.

This is not tied to mutex, it works with any lock.

Cheers,
-Wedson
