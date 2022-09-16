Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8C5BAF9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIPOvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A98A572E;
        Fri, 16 Sep 2022 07:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2EEF62C52;
        Fri, 16 Sep 2022 14:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58EBC43470;
        Fri, 16 Sep 2022 14:51:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KlnuYh1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663339856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQYiQoE1MzbspExjoxRIxp8659JqC9N66qASNbjnQqI=;
        b=KlnuYh1sIGr8iLDnyM+oR6yvdq24Mjt7ZamBZ0JSxxSGkgc4FRdQprP+5+Bjt3yAL6YIB7
        yqOyyKBd6P9kvimEiqKEMUDql0NS6+PZNFNjavhEaVHVq5YER6w0tDUwuDpWXJ4FBwbo79
        gRldpBdze8LjSuUu0ZMBXHkrXyE0qYE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1f8ea2d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 16 Sep 2022 14:50:55 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3450990b0aeso262117667b3.12;
        Fri, 16 Sep 2022 07:50:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf2BAoZuRL2Uk/12ojcGA6HEUcIrGFUp9jQ8SO8ca83DtEhAguDa
        nFtlgTj1fy5rIS354EphiTazMUKmOvfuxKMQoKc=
X-Google-Smtp-Source: AMsMyM51XqKQyk4s+gVt6jlmvoxBMaNxeULYyZNPUl7oFIcgBDfSa9yp9k6H0qwzA8LOD3vyzz1NfXzFWJtdMAVT2qo=
X-Received: by 2002:a81:d97:0:b0:348:f982:e2f7 with SMTP id
 145-20020a810d97000000b00348f982e2f7mr4722516ywn.414.1663339853668; Fri, 16
 Sep 2022 07:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
In-Reply-To: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 16 Sep 2022 15:50:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9rhunb05DEnc=UfGr8k9_LBi1NW2Hi0OsRbGwcCN2NzjQ@mail.gmail.com>
Message-ID: <CAHmME9rhunb05DEnc=UfGr8k9_LBi1NW2Hi0OsRbGwcCN2NzjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] random: move add_hwgenerator_randomness()'s wait
 outside function
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Olivia Mackall <olivia@selenic.com>,
        Alex Levin <levinale@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Rajat Jain <rajatja@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Thu, Sep 15, 2022 at 1:22 AM Sven van Ashbrook <svenva@chromium.org> wrote:
> -       if (!kthread_should_stop() && crng_ready())
> -               schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
> +       return crng_ready() ? CRNG_RESEED_INTERVAL : 0;

I was thinking the other day that under certain circumstances, it
would be nice if random.c could ask hwrng for more bytes NOW, rather
than waiting. With the code as it is currently, this could be
accomplished by having a completion event or something similar to
that. With your proposed change, now it's left up to the hwrng
interface to handle.

That's not the end of the world, but it does mean we'd have to come up
with a patch down the line that exports a hwrng function saying, "stop
the delays and schedule the worker NOW". Now impossible, just more
complex, as now the state flow is split across two places. Wondering
if you have any thoughts about this.

The other thing that occurred to me when reading this patch in context
of the other one is that this sleep you're removing here is not the
only sleep in the call chain. Each hwrng driver can also sleep, and
many do, sometimes for a long time, blocking until there's data
available, which might happen after minutes in some cases. So maybe
that's something to think about in context of this patchset -- that
just moving this to a delayed worker might not actually fix the issue
you're having with sleeps.

Jason
