Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7251665C514
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbjACRb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbjACRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:31:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA75DFD9;
        Tue,  3 Jan 2023 09:31:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A447B80E12;
        Tue,  3 Jan 2023 17:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F48C4339E;
        Tue,  3 Jan 2023 17:31:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jZKK1U17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672767065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jmz3B4N06geTRMh8pYrWdrgJ1hJ5+fSjFeBSA/9U4Cw=;
        b=jZKK1U173hU+Tm1B4VZIY2iKtnBryPgXtg7J+l/epGoKVwpvFCdtA/VuZREza/hKERPpLs
        7+ZrzFpexuA8LaynH1QEBXbw5XAYjvLgBQp5vg26C7fIrG48s1k7JTxe5ge3gE4UqL03m8
        yJD5GFLUSa+tY9m+OhndnwDWEDXQI40=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f1a3a7f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Jan 2023 17:31:04 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 83so33013270yba.11;
        Tue, 03 Jan 2023 09:31:03 -0800 (PST)
X-Gm-Message-State: AFqh2kpaxpAvds0ObSZVcoVqGxl8hIfrEBsTSFy3E7sLTGR2ODa0uM6h
        Cfh+kTqA0dFGu/jtT2FMtq4OSb12mBir1F3HaD8=
X-Google-Smtp-Source: AMrXdXsqzKdjs796F972R+nah6TEAsws7b/uf6K5iQTSv3+zK+tre1qXfQnNtsot0TU1C0wZtvv2rmeH8iPAEAY4pxE=
X-Received: by 2002:a25:c89:0:b0:703:8a9c:fd with SMTP id 131-20020a250c89000000b007038a9c00fdmr4700323ybm.231.1672767063101;
 Tue, 03 Jan 2023 09:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-2-Jason@zx2c4.com>
 <Y7QELo9etPM8Tpx5@gmail.com> <Y7RA3bmko0AjO8hQ@zx2c4.com> <Y7RfPnyK/25pxpKs@gmail.com>
 <Y7RmDVI/ScoeBO2a@zn.tnic>
In-Reply-To: <Y7RmDVI/ScoeBO2a@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 3 Jan 2023 18:30:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9ohJ3JZNjkxuA0KjFW0LLQksgQP5f8bfrogd3+GmLrpKw@mail.gmail.com>
Message-ID: <CAHmME9ohJ3JZNjkxuA0KjFW0LLQksgQP5f8bfrogd3+GmLrpKw@mail.gmail.com>
Subject: Re: [PATCH v14 1/7] x86: lib: Separate instruction decoder MMIO type
 from MMIO trace
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
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

On Tue, Jan 3, 2023 at 6:29 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jan 03, 2023 at 06:00:46PM +0100, Ingo Molnar wrote:
> > > I guess you missed the conversation with Borislav yesterday about that.
> > > He mentioned that I'd just take it through random.git when this whole
> > > series goes in.
> >
> > Please base your tree off on tip:x86/asm then (or pull it in) - it only
>
> My idea was a lot simpler: avoid the tree inter-dependency by us acking this
> patch so that it can go through the random.git tree.

Indeed I would prefer this.

Or... just put this in 6.2 because it's trivial anyway? Heck, even
mark it as stable@ so make future backporting easier. Then it'll meet
tip's urgent criteria.

Jason
