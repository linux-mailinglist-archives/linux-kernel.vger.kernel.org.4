Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4BC65AE49
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjABIl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjABIlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:41:52 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FC51262C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:41:50 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3028fMEv030128;
        Mon, 2 Jan 2023 09:41:22 +0100
Date:   Mon, 2 Jan 2023 09:41:22 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH 2/5] nolibc: add support for s390
Message-ID: <20230102084122.GB29287@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-3-svens@linux.ibm.com>
 <20221227213530.GA6390@1wt.eu>
 <yt9dilhpjqpr.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dilhpjqpr.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Mon, Jan 02, 2023 at 09:17:04AM +0100, Sven Schnelle wrote:
> > But with this addressed, I'm facing this next error:
> >
> >   $ make nolibc-test LDFLAGS= ARCH=s390 CC=/f/tc/nolibc/gcc-12.2.0-nolibc/s390-linux/bin/s390-linux-gcc
> >     MKDIR   sysroot/s390/include
> >   make[1]: Entering directory '/g/public/linux/master/tools/include/nolibc'
> >   make[2]: Entering directory '/g/public/linux/master'
> >   make[2]: Leaving directory '/g/public/linux/master'
> >   make[2]: Entering directory '/g/public/linux/master'
> >     INSTALL /g/public/linux/master/tools/testing/selftests/nolibc/sysroot/sysroot/include
> >   make[2]: Leaving directory '/g/public/linux/master'
> >   make[1]: Leaving directory '/g/public/linux/master/tools/include/nolibc'
> >     CC      nolibc-test
> >   /tmp/ccCzaBgD.s: Assembler messages:
> >   /tmp/ccCzaBgD.s:9: Error: Unrecognized opcode: `lg'
> >   /tmp/ccCzaBgD.s:12: Error: Unrecognized opcode: `lay'
> >   /tmp/ccCzaBgD.s:15: Error: Unrecognized opcode: `lghi'
> >   make: *** [Makefile:108: nolibc-test] Error 1
> >
> > Thus I'm wondering if specific options are required for the compiler
> > (it's gcc 12.2.0 + binutils 2.39), if I'm not using the proper compiler,
> > or if there's anything wrong in the asm code (e.g. maybe by accident you
> > sent the patch from an earlier development branch), or anything else ?
> 
> Hmm, tried this on my x86 laptop, and it looks like there are two things
> here:
> 
> The cross compiler needs -m64 to compile in 64bit mode. otherwise it
> assumes 31bit mode, where both lg and lghi are not present. The other
> thing is that lay was introduced with later generations of the
> z/Architecture.

Ah, this explains why along my various tests at some point I managed
to remove two of these errors (likely with -m64)!

> The kernel compiles with z10 as minimum architecture, so
> i'm leaning towards enforcing the same arch for nolibc. What do you think?

Sure, as long as this works for most users, that's likely fine.
Alternately, are there equivalent sequences of instructions that achieve
the same on older architectures, and would that be relevant ?

One future improvement I'll need will be to store the envp value into a
global "environ" variable, and run over it to catch the pointer that
follows the NULL and save it into the "_auxv" variable. I've done it for
all other archs here already:

  https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/log/?h=20221227-nolibc-weak-4

I'll give it a try once I'm able to build and test your code, and may
ask you for some help if I don't succeed in doing it. If you want to do
it yourself, please have a look at the last commits adding environ and
auxv to any arch of your choice, such as x86_64.

Thanks!
Willy
