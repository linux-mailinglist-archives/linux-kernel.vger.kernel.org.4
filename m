Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE371F3D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjFAU34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjFAU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:29:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B6E189;
        Thu,  1 Jun 2023 13:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BD6649A0;
        Thu,  1 Jun 2023 20:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1DFC433EF;
        Thu,  1 Jun 2023 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685651390;
        bh=8E8mehVVD5WVRYimo7DhcQTJC6uUV4skk+WhAm6yWjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ij7qIpqLKHHXnNgX0p9QT16EvEEYsSg8g600KUox4OpJ5nwUDTRJZ4zsl63MyAUmB
         MblWfDdxqjV7XM+M2SKqeb3s45e7gqoXQ6KO5LoV/Rph71NJWT4+L6XUC/gHqrUpOn
         ppICkUcPKTu/In/ZKbLjTojvCz9NoJPIXzvh97G6115bS9l8iBabI9mA5aJQ2XAj8G
         2u3nkngcTeRQPjog3KmsdICEz9zutgL65IpwVSz7LKu33fKVCAHb0hz56GeQBBqw3R
         CyYCXhz4rXoTvdlS4a+S72bOHbLWF4j2SIF9iklLvT/lXwn6Q7of6XLX1925ZN00vT
         N1ZpBFoyZnO+w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3236940692; Thu,  1 Jun 2023 17:29:47 -0300 (-03)
Date:   Thu, 1 Jun 2023 17:29:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf script: Increase PID/TID width for output
Message-ID: <ZHj/u9iXSeRfFg1e@kernel.org>
References: <20230531203236.1602054-1-namhyung@kernel.org>
 <dfef9c42-5b84-6720-656f-5d3ac1d8ccf5@intel.com>
 <CAM9d7cjMLMExM_irC+ZXkDi65w95W6OpOihgrbB5X=jJgwyNeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjMLMExM_irC+ZXkDi65w95W6OpOihgrbB5X=jJgwyNeQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 01, 2023 at 09:14:50AM -0700, Namhyung Kim escreveu:
> Hi Adrian,
> 
> On Wed, May 31, 2023 at 9:54 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 31/05/23 23:32, Namhyung Kim wrote:
> > > On large systems, it's common that PID/TID is bigger than 5-digit and it
> > > makes the output unaligned.  Let's increase the width to 7.
> >
> > Might be worth noting that currently the biggest PID_MAX_LIMIT
> > is 2^22 so pids don't get bigger than 7 digits presently.
> 
> Nice, will add that.

No need to resubmit, I'll add that.
 
> >
> > >
> > > Before:
> > >
> > >   $ perf script
> > >   ...
> > >            swapper     0 [006] 1540823.803935:    1369324 cycles:P:  ffffffff9c755588 ktime_get+0x18 ([kernel.kallsyms])
> > >        gvfsd-dnssd 95114 [004] 1540823.804164:    1643871 cycles:P:  ffffffff9cfdca5c __get_user_8+0x1c ([kernel.kallsyms])
> > >          perf-exec 1558582 [000] 1540823.804209:    1018714 cycles:P:  ffffffff9c924ab9 __slab_free+0x9 ([kernel.kallsyms])
> > >              nmcli 1558589 [007] 1540823.804384:    1859212 cycles:P:      7f70537a8ad8 __strchrnul_evex+0x18 (/usr/lib/x86_64-linux-gnu/libc.so.6>
> > >              sleep 1558582 [000] 1540823.804456:     987425 cycles:P:      7fd35bb27b30 _dl_init+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2>
> > >        dbus-daemon  3043 [003] 1540823.804575:    1564465 cycles:P:  ffffffff9cb2bb70 llist_add_batch+0x0 ([kernel.kallsyms])
> > >              gdbus 1558592 [001] 1540823.804766:    1315219 cycles:P:  ffffffff9c797b2e audit_filter_syscall+0x9e ([kernel.kallsyms])
> > >     NetworkManager  3452 [005] 1540823.805301:    1558782 cycles:P:      7fa957737748 g_bit_lock+0x58 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.5>
> > >
> > > After:
> > >
> > >   $ perf script
> > >   ...
> > >            swapper       0 [006] 1540823.803935:    1369324 cycles:P:  ffffffff9c755588 ktime_get+0x18 ([kernel.kallsyms])
> > >        gvfsd-dnssd   95114 [004] 1540823.804164:    1643871 cycles:P:  ffffffff9cfdca5c __get_user_8+0x1c ([kernel.kallsyms])
> > >          perf-exec 1558582 [000] 1540823.804209:    1018714 cycles:P:  ffffffff9c924ab9 __slab_free+0x9 ([kernel.kallsyms])
> > >              nmcli 1558589 [007] 1540823.804384:    1859212 cycles:P:      7f70537a8ad8 __strchrnul_evex+0x18 (/usr/lib/x86_64-linux-gnu/libc.so.6>
> > >              sleep 1558582 [000] 1540823.804456:     987425 cycles:P:      7fd35bb27b30 _dl_init+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2>
> > >        dbus-daemon    3043 [003] 1540823.804575:    1564465 cycles:P:  ffffffff9cb2bb70 llist_add_batch+0x0 ([kernel.kallsyms])
> > >              gdbus 1558592 [001] 1540823.804766:    1315219 cycles:P:  ffffffff9c797b2e audit_filter_syscall+0x9e ([kernel.kallsyms])
> > >     NetworkManager    3452 [005] 1540823.805301:    1558782 cycles:P:      7fa957737748 g_bit_lock+0x58 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.5>
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks for your review!

Indeed, thanks Adrian, Namhyung, applied.

- Arnaldo
