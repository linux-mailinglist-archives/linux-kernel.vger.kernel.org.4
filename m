Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2A8662893
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjAIOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjAIObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:31:19 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A44A51CFF3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:31:09 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 309EUxDW029407;
        Mon, 9 Jan 2023 15:30:59 +0100
Date:   Mon, 9 Jan 2023 15:30:59 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <20230109143059.GB25476@1wt.eu>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
 <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz>
 <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz>
 <Y7tjnhs77o4TL5ey@mit.edu>
 <CAMuHMdXP8ycxE_Sny0q+SAzLTwnaA3hks=ErW-ZfiMBw7ZMSgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXP8ycxE_Sny0q+SAzLTwnaA3hks=ErW-ZfiMBw7ZMSgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Jan 09, 2023 at 10:28:09AM +0100, Geert Uytterhoeven wrote:
> Hi Ted,
> 
> On Mon, Jan 9, 2023 at 1:45 AM Theodore Ts'o <tytso@mit.edu> wrote:
> > On Sun, Jan 08, 2023 at 07:47:07PM +0100, Pavel Machek wrote:
> > > > However, as this is not Linux-specific, how hard can it be to convince
> > > > your distro to include https://github.com/qris/dhrystone-deb.git?
> > > > Usually, when I have a full userspace available, I just clone the above,
> > > > and debuild it myself.
> > >
> > > Dunno. I'd not solve it if package was in Debian, but it is not.
> >
> > I would suspect the better long-term solution would be to get the
> > package into Debian, since that will be easier for people to use.  I
> > suspect the reason why most distros don't include it is because it
> > really is a **terrible** benchmark for most use cases.
> 
> My use case is verifying the CPU core clock rate when working on
> the clock driver and/or cpufreq.  I can easily measure e.g. SPI or
> UART clock rates
> externally, but not CPU core clock rates.

Then maybe you'd rather use this:

   https://github.com/wtarreau/mhz

E.g.:

  $ ./mhz 10
  count=1666675 us50=20089 us250=100748 diff=80659 cpu_MHz=4132.645 tsc50=42427696 tsc250=212780620 diff=102 rdtsc_MHz=2112.014
  count=1666675 us50=20271 us250=101282 diff=81011 cpu_MHz=4114.688 tsc50=42813060 tsc250=213905908 diff=102 rdtsc_MHz=2111.970
  count=1666675 us50=20405 us250=100344 diff=79939 cpu_MHz=4169.867 tsc50=43094116 tsc250=211927426 diff=101 rdtsc_MHz=2112.027
  count=1666675 us50=20239 us250=100249 diff=80010 cpu_MHz=4166.167 tsc50=42744302 tsc250=211727114 diff=101 rdtsc_MHz=2112.021
  count=1666675 us50=20182 us250=100482 diff=80300 cpu_MHz=4151.121 tsc50=42624768 tsc250=212217884 diff=101 rdtsc_MHz=2111.994
  count=1666675 us50=20153 us250=100151 diff=79998 cpu_MHz=4166.792 tsc50=42562818 tsc250=211519326 diff=101 rdtsc_MHz=2112.009
  count=1666675 us50=20281 us250=99803 diff=79522 cpu_MHz=4191.733 tsc50=42832298 tsc250=210784252 diff=100 rdtsc_MHz=2112.019
  count=1666675 us50=20104 us250=99841 diff=79737 cpu_MHz=4180.431 tsc50=42461284 tsc250=210862414 diff=101 rdtsc_MHz=2111.957
  count=1666675 us50=20088 us250=100287 diff=80199 cpu_MHz=4156.349 tsc50=42423974 tsc250=211807066 diff=101 rdtsc_MHz=2112.035
  count=1666675 us50=20178 us250=99913 diff=79735 cpu_MHz=4180.536 tsc50=42614718 tsc250=211016124 diff=101 rdtsc_MHz=2112.014

It's also what's used by sbc-bench to verify that CPU vendors are not
cheating in the embedded world. It's very simple, and not arch-dependent
nor compiler-dependent (at least as long as you don't build at -O0 :-)).

Just my two cents,
Willy
