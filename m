Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80E065DDB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbjADUaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbjADUaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:30:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076DE18384;
        Wed,  4 Jan 2023 12:30:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BA1BB818D8;
        Wed,  4 Jan 2023 20:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C80C433EF;
        Wed,  4 Jan 2023 20:30:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XBIXrtxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672864206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sa99aiRE7scIwfvML/yhzFWYXLOzBtNC5r3KfyUVDy4=;
        b=XBIXrtxjyxM17F4LGCu3fLy0l12mdSSGD5Bm/7S/ewL3U7DkzEfoILDO3caI9a+cxq0mnH
        d6JkaiqGvGg5nHS69g7paR51Fh3h3KeWP5BxdFYVFbfRaFw0Ypsb1jcXcGpevT38Jfy8OY
        j6OL/0LFLGkmcNR5q8/5dVVjw9B6pp8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 44c9cd83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Jan 2023 20:30:05 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-4a2f8ad29d5so151104427b3.8;
        Wed, 04 Jan 2023 12:30:05 -0800 (PST)
X-Gm-Message-State: AFqh2kouei6B1NTBCBlvK1V40m6O4p65YypaBaarwjrXpxKlZKmwEQgt
        vihV9PF3CHDU3eHuk6/IFrAqCfjVrrodLubli8U=
X-Google-Smtp-Source: AMrXdXtnlAdEjqXnGADVmxcmaw0N9w1q4mvc2FZ8ZEIAmo/GMankbc+DPDnEMO2SqEh4Lmm3cojhsNUj9E/km0ZrpC4=
X-Received: by 2002:a0d:ea43:0:b0:47d:af22:b7ec with SMTP id
 t64-20020a0dea43000000b0047daf22b7ecmr2656959ywe.259.1672864202973; Wed, 04
 Jan 2023 12:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-2-Jason@zx2c4.com>
 <Y7QELo9etPM8Tpx5@gmail.com> <Y7RA3bmko0AjO8hQ@zx2c4.com> <Y7RfPnyK/25pxpKs@gmail.com>
 <Y7RmDVI/ScoeBO2a@zn.tnic> <CAHmME9ohJ3JZNjkxuA0KjFW0LLQksgQP5f8bfrogd3+GmLrpKw@mail.gmail.com>
 <Y7RqQNH0OuiYCDeE@gmail.com> <Y7Xg19H39FqTwyEL@gmail.com>
In-Reply-To: <Y7Xg19H39FqTwyEL@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 4 Jan 2023 21:29:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9p6zwGU33hq1D1Zt9ek8T5ExBp7jLxgn1DVhO4bvOODog@mail.gmail.com>
Message-ID: <CAHmME9p6zwGU33hq1D1Zt9ek8T5ExBp7jLxgn1DVhO4bvOODog@mail.gmail.com>
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

On Wed, Jan 4, 2023 at 9:26 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> >
> > * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > > On Tue, Jan 3, 2023 at 6:29 PM Borislav Petkov <bp@alien8.de> wrote:
> > > >
> > > > On Tue, Jan 03, 2023 at 06:00:46PM +0100, Ingo Molnar wrote:
> > > > > > I guess you missed the conversation with Borislav yesterday about that.
> > > > > > He mentioned that I'd just take it through random.git when this whole
> > > > > > series goes in.
> > > > >
> > > > > Please base your tree off on tip:x86/asm then (or pull it in) - it only
> > > >
> > > > My idea was a lot simpler: avoid the tree inter-dependency by us acking this
> > > > patch so that it can go through the random.git tree.
> > >
> > > Indeed I would prefer this.
> > >
> > > Or... just put this in 6.2 because it's trivial anyway? Heck, even mark
> > > it as stable@ so make future backporting easier. Then it'll meet tip's
> > > urgent criteria.
> >
> > Yeah - that's sensible too, it does fix a header namespace bug - I've put
> > it into tip:x86/urgent.
>
> This namespace clash fix is now upstream as of 512dee0c00ad & later kernels.

Thanks. I've rebased my vdso branch on that now. I guess at this point
it probably doesn't matter that much since everyone hates my use of
the instruction decoder anyway, so I'll see what else I can do for
v15, but still, it'll at least make it easier to experiment.

Jason
