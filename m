Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89452663337
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbjAIVi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbjAIVih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:38:37 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C8DE3C71C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:36:48 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 309LadgB031856;
        Mon, 9 Jan 2023 22:36:39 +0100
Date:   Mon, 9 Jan 2023 22:36:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <20230109213639.GA31782@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX-xpu-+8kAun90ZdYLe6kMzW3CEoD_hQtpwTPSJ8Tp1A@mail.gmail.com>
 <CAMuHMdWm8Z-xkDUTjppbPT_uxFqfdOZPrPYxgBNgFRL6E=sN3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,FAKE_REPLY_C,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Jan 09, 2023 at 08:36:39PM +0100, Geert Uytterhoeven wrote:
> Seeing the rdtsc stuff, I was a bit skeptical, but it seems to work
> fine on arm32 and rv64.

Yes, I'm using it on arm32/64, mips, i386/x86_64, ppc64. It always
works fine. The rdtsc stuff you saw is not there to perform the
measurements, it's the opposite, the tool is measuring the TSC's
frequency when there is one :-)

> Unfortunately you forgot to add a LICENSE file ;-)

I really don't care. It can be public domain or MIT (since in many
places you can't drop your own rights and put something into public
domain). If you need anything from it, feel free to steal code from
it, I'm fine with this.

> Alternatively, I can use the C version of BogoMIPS.  Which has its
> own merits and reputation.

Yes, it's just that you have to apply your own ratios depending on
the build options and arch if you want to find the frequency.

> The nice thing about Dhrystones is that people still publish numbers
> for comparison, also DMIPS/MHz and DMIPS/mW.

Yes that's true, but the numbers can differ by orders of magnitude on
the same hardware depending on build options, it's hard to compare
anything using it these days.

> Gcc 4.1.2 (still the userspace compiler on a few of my old systems)
> doesn't like the aligned() attribute on functions.

Good to know, thank you. We could enclose it between ifdefs if needed.

> In glibc 2.3, LLONG_MAX is defined conditionally on __USE_ISOC99.

Yes or the usual (~0ULL)/2 should work and be equally portable.

> Apart from that, the result is fairly accurate. Nice job!

Actually it's not the tool that's accurate, it's gettimeofday() ;-)

Cheers,
Willy
