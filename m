Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B766CF005
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC2Q6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjC2Q6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:58:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5034EC1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:58:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w9so66062096edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680109092; x=1682701092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuabhBI/cJhvDusEUPo+YOaR3W7tGSIZ44NN+9mu0w0=;
        b=KRhDpCBHo+cC0CIvD6/8H+FJ3/p+pTrSukNlFpUKGEdpR591210jADy121UAEsDwGn
         idKke0XPRuXg/9Lif4V/yLyLqD1pL1hq0OgixllpUUeWcGUpFWSPlZIs8yIXGnAWMhbB
         AM92B5FWQVleFV/F5J+7lVrl6QXDczDdVs/7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680109092; x=1682701092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuabhBI/cJhvDusEUPo+YOaR3W7tGSIZ44NN+9mu0w0=;
        b=2rsM63zVaHfVY/T0cQtgXfNgujj7oObVM23hPNqWanwuypmOP5njgIdwKVi4e7mdLt
         u39PO1BbI7Mv0iczfuSUNAkrDF0eSIRs84HZADzEzqhL/qu7H+Ad8VwaEAaWWFdsl/Ke
         fyWUgllZ384BfbGYNcKHxHD03E1H5kTIo91Q6wicr3dDaMXhb+F3xM2fAfae66RMUR1H
         7/UQeEEEf1BjE5CM2i5Iii/mHrOr4saCUuHOQKtBUpjqbhV8yCHgd4340hs9BpLcKtR5
         JAwvI1tYH3lEq9gtLpC/wXx+NsKgsHRs5EOGiRy/HsnrxGScgo/Cf5/ZedmhYN/Cjyqp
         Qjdw==
X-Gm-Message-State: AAQBX9dlfNOYoFxcpUxLe/QeucCFkXbbFjl1lsmXME8aGMY+nhq2Uo6o
        g0g7vo7k9o8v5NM1Knyks/YRoeBa2C3fsPeLxczO467D
X-Google-Smtp-Source: AKy350b9bJzgpqED7e7EjlMaimtfFWB6JWmvllvDVvR0ZaLmepS5UfnDwhanXQ7UAK7myrkNHrzVpg==
X-Received: by 2002:a05:6402:14c4:b0:501:d3a0:30d9 with SMTP id f4-20020a05640214c400b00501d3a030d9mr3207567edx.7.1680109092688;
        Wed, 29 Mar 2023 09:58:12 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906309600b0092f289b6fdbsm16630005ejv.181.2023.03.29.09.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 09:58:12 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id l37so9362334wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:58:12 -0700 (PDT)
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr9808123ejb.15.1680108655974; Wed, 29
 Mar 2023 09:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230329053149.3976378-1-mcgrof@kernel.org> <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net> <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230329091935.GP4253@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 09:50:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
Message-ID: <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        song@kernel.org, rppt@kernel.org, willy@infradead.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 2:19=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Arguably DEFINE_SEMAPHORE() should have the argument, as binary
> semaphores are a special case, but then we gotta go and fix up all
> users.

Using semaphores for just pure mutual exclusion used to be *the* most
common use of it, which is why we didn't have an argument.

Then we got the mutexes, and now semaphores are almost entirely a legacy th=
ing.

I think we should just make DEFINE_SEMAPHORE() take the number, and
people who want a mutex should either put in the "1", or they should
just use a mutex.

> /me git-greps a little.. Hmm, not too bad.
>
> How's this?

I'd actually prefer to not have that DEFINE_BINARY_SEMAPHORE() at all.
It really shouldn't exist in this day and age.

It's not even less typing, ie

    static DEFINE_SEMAPHORE(efivars_lock, 1);

is actually shorter than

    static DEFINE_BINARY_SEMAPHORE(efivars_lock);

And what you actually *want* is

    static DEFINE_MUTEX(efivars_lock);

and converting the up/down to mutex_unlock/mutex_lock.

So let's just make it clear that the only reason to use semaphores
these days is for counting semaphores, and just make
DEFINE_SEMAPHORE() take the number.

Strangely, sema_init() already does that, but I guess that's because
some people really *do* use semaphores for concurrency control (ie I
see things like

        sema_init(&dc->in_flight, 64);

which is clearly using a semaphore in that very traditional way).

So ack on your patch, but don't bother with DEFINE_BINARY_SEMAPHORE().

               Linus
