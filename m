Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD3065C55C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbjACRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjACRs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:48:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEAB6455;
        Tue,  3 Jan 2023 09:48:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EDECB81061;
        Tue,  3 Jan 2023 17:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDECEC433D2;
        Tue,  3 Jan 2023 17:48:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="leAFh2n/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672768132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/6ONPv/8ephkMq7zwBAh7OAe26uxzx/1Tr6U98cNiqc=;
        b=leAFh2n/S6ByGM51V5rqmcx/jLUT5Jy4736plh1dcEO0bvK7LJ33xLQjeyWBC8P0RCBCSm
        AdPKhjMYjlQVGYU8k4Od0MSfQ/hFKTEsZJnVh2VjsuGQ2iTI23oAZGgFn+c0EjrJbLCzFb
        BK6lMpItP3slRDNTBa8ToWjIAbKSv3U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3c32a9bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Jan 2023 17:48:52 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-4a263c4ddbaso108672117b3.0;
        Tue, 03 Jan 2023 09:48:52 -0800 (PST)
X-Gm-Message-State: AFqh2kpHKQ4aSu7bftINKPsBRB2zVa2NmRg6RIVQmHFhtvUpPRvvR431
        p4IWN8uE9mCO80gU7m+OD2YImdVkK1TjlKKJyy0=
X-Google-Smtp-Source: AMrXdXsnCvGNGSvWf4qxRn3p2eP0HxA+9QaISXAMcI8boGLvm0+AlVZKcc20Pf3AWhNIcG/AzAzGuni/cyFbL9vXu5I=
X-Received: by 2002:a81:1147:0:b0:3f8:5b0b:bbb8 with SMTP id
 68-20020a811147000000b003f85b0bbbb8mr5484046ywr.79.1672768130997; Tue, 03 Jan
 2023 09:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-2-Jason@zx2c4.com>
 <Y7QELo9etPM8Tpx5@gmail.com> <Y7RA3bmko0AjO8hQ@zx2c4.com> <Y7RfPnyK/25pxpKs@gmail.com>
 <Y7RmDVI/ScoeBO2a@zn.tnic> <CAHmME9ohJ3JZNjkxuA0KjFW0LLQksgQP5f8bfrogd3+GmLrpKw@mail.gmail.com>
 <Y7RqQNH0OuiYCDeE@gmail.com>
In-Reply-To: <Y7RqQNH0OuiYCDeE@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 3 Jan 2023 18:48:40 +0100
X-Gmail-Original-Message-ID: <CAHmME9o8MDfZJ5puHh-FeCJApRMuZ6E6W04e3FVYd7RFf6TYew@mail.gmail.com>
Message-ID: <CAHmME9o8MDfZJ5puHh-FeCJApRMuZ6E6W04e3FVYd7RFf6TYew@mail.gmail.com>
Subject: Re: [PATCH v14 1/7] x86: lib: Separate instruction decoder MMIO type
 from MMIO trace
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
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

On Tue, Jan 3, 2023 at 6:47 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> > On Tue, Jan 3, 2023 at 6:29 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Tue, Jan 03, 2023 at 06:00:46PM +0100, Ingo Molnar wrote:
> > > > > I guess you missed the conversation with Borislav yesterday about that.
> > > > > He mentioned that I'd just take it through random.git when this whole
> > > > > series goes in.
> > > >
> > > > Please base your tree off on tip:x86/asm then (or pull it in) - it only
> > >
> > > My idea was a lot simpler: avoid the tree inter-dependency by us acking this
> > > patch so that it can go through the random.git tree.
> >
> > Indeed I would prefer this.
> >
> > Or... just put this in 6.2 because it's trivial anyway? Heck, even mark
> > it as stable@ so make future backporting easier. Then it'll meet tip's
> > urgent criteria.
>
> Yeah - that's sensible too, it does fix a header namespace bug - I've put
> it into tip:x86/urgent.

Excellent, thanks. I'll rebase on that when it hits Linus' tree.
