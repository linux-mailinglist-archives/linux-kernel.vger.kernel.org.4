Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C32648DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLJJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiLJJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:12:30 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B1AD114A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:07:46 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BA97SMM021793;
        Sat, 10 Dec 2022 10:07:28 +0100
Date:   Sat, 10 Dec 2022 10:07:28 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nolibc: add support for s390
Message-ID: <20221210090728.GB21743@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-3-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209141939.3634586-3-svens@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:19:36PM +0100, Sven Schnelle wrote:
> Use arch-x86_64 as a template. Not really different, but
> we have our own mmap syscall which takes a structure instead
> of discrete arguments.

I'm fine with placing the mmap syscall inside the arch-s390 file, though
it differs from what's done for other syscalls. But I admit that mmap is
one of these syscalls that differ between various archs and that it's not
shocking to leave it per-arch.

However you're having an issue here:

> diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
> new file mode 100644
> index 000000000000..34b744e2f7d6
> --- /dev/null
> +++ b/tools/include/nolibc/arch-s390.h
                             ^^^^^^^^^
vs:

> diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
> index 4c6992321b0d..fcded65b98d7 100644
> --- a/tools/include/nolibc/arch.h
> +++ b/tools/include/nolibc/arch.h
> @@ -27,6 +27,8 @@
>  #include "arch-mips.h"
>  #elif defined(__riscv)
>  #include "arch-riscv.h"
> +#elif defined(__s390x__)
> +#include "arch-s390x.h"
             ^^^^^^^^^^

As you see the file is not the same so if you build by including nolibc.h
directly it will not work. The difference between s390 and s390x has never
been very clear to me, so I can't easily suggest which name is the most
suitable, but you'll definitely have to choose one :-)  If it's just a
matter of dropping that trailing 'x' there, I think we can fix your patch
here without re-submitting, let us know.

Once this one is fixed, I'm fine with this:

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
