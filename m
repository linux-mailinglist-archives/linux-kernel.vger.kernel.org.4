Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD66F3E03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjEBG7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBG7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:59:31 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF44C95
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:59:29 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3426xR0k027963;
        Tue, 2 May 2023 08:59:27 +0200
Date:   Tue, 2 May 2023 08:59:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: remove LINUX_REBOOT_ constants
Message-ID: <ZFC0z8dh+DmVSYyk@1wt.eu>
References: <20230428-nolibc-reboot-v1-1-0bca02d20ba6@weissschuh.net>
 <ZFCubzgPxBSDiTwq@1wt.eu>
 <c967837e-39c7-48e4-9ee7-65892f13d126@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c967837e-39c7-48e4-9ee7-65892f13d126@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 08:47:15AM +0200, Thomas Weißschuh wrote:
> On 2023-05-02 08:32:15+0200, Willy Tarreau wrote:
> > On Fri, Apr 28, 2023 at 05:52:11PM +0200, Thomas Weißschuh wrote:
> > > The same constants and some more have been exposed to userspace via
> > > linux/reboot.h for a long time.
> > > 
> > > To avoid conflicts and trim down nolibc a bit drop the custom
> > > definitions.
> > 
> > For me it breaks the build when including nolibc directly, so most
> > likely we need to include certain files:
> 
> Indeed, sorry no idea how I missed that.

No worries, it happens to me as well and that's the benefit of
cross-testing ;-)

> The conflict looks like this:
> 
>     In file included from nolibc-test.c:18:
>     sysroot/x86/include/linux/reboot.h:10: warning: "LINUX_REBOOT_MAGIC2" redefined
>        10 | #define LINUX_REBOOT_MAGIC2     672274793
>           | 
>     In file included from sysroot/x86/include/nolibc.h:98,
>                      from sysroot/x86/include/errno.h:26,
>                      from sysroot/x86/include/stdio.h:14,
>                      from nolibc-test.c:15:
>     ... and all the other ones.
> 
> 
> 
> The following trivial fix on top of my patch would fix the problem:
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 5d624dc63a42..9d27131c224e 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -21,6 +21,7 @@
>  #include <linux/auxvec.h>
>  #include <linux/fcntl.h> // for O_* and AT_*
>  #include <linux/stat.h>  // for statx()
> +#include <linux/reboot.h> // for LINUX_REBOOT_*
>  
>  #include "arch.h"
>  #include "errno.h"

Indeed it works for me as well.

> Want me to send a v2 or will you fix it up on your side?

It depends. If for you it's a fix and needed for 6.4 (or maybe older),
then that one is needed with the "//" comment, and it will later
conflict with your previous cleanup patch that's already queued. If
you're fine with having it queued for 6.5 only however, then I'll just
edit your patch and add that above. I tend to think the second solution
is sufficient given that nobody complained till now ;-)

Just let me know,
thanks,
Willy 
