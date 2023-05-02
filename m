Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70606F3DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjEBGrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjEBGrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:47:22 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90B19B0
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:47:18 -0700 (PDT)
Date:   Tue, 2 May 2023 08:47:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1683010036; bh=QX2OOLcfGpNlKl3zjd9j0gHhX42jLgoW5/8PmXR8oJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyNxJX1Ry6ZDFUXmFpepZhEBvARAxDoPFJateKZF4N6qbwdS3cQDQzOPT7gGsRMCD
         9xSvQan76KW1IWHJFhriHEy46Jh4PFHNjHS/j47y/rjvevkfreNClie2UY/Tv469U1
         dlJuEkiSi8vrYSa2kM3sKMoG3d6qIhiszKSeogzY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: remove LINUX_REBOOT_ constants
Message-ID: <c967837e-39c7-48e4-9ee7-65892f13d126@t-8ch.de>
References: <20230428-nolibc-reboot-v1-1-0bca02d20ba6@weissschuh.net>
 <ZFCubzgPxBSDiTwq@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFCubzgPxBSDiTwq@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-02 08:32:15+0200, Willy Tarreau wrote:
> On Fri, Apr 28, 2023 at 05:52:11PM +0200, Thomas Weißschuh wrote:
> > The same constants and some more have been exposed to userspace via
> > linux/reboot.h for a long time.
> > 
> > To avoid conflicts and trim down nolibc a bit drop the custom
> > definitions.
> 
> For me it breaks the build when including nolibc directly, so most
> likely we need to include certain files:

Indeed, sorry no idea how I missed that.

>   In file included from /g/public/linux/master/tools/include/nolibc/nolibc.h:99,
>                    from <command-line>:
>   /g/public/linux/master/tools/include/nolibc/sys.h: In function 'reboot':
>   /g/public/linux/master/tools/include/nolibc/sys.h:972:30: error: 'LINUX_REBOOT_MAGIC1' undeclared (first use in this function)
>     972 |         int ret = sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0);
>         |                              ^~~~~~~~~~~~~~~~~~~
>   /g/public/linux/master/tools/include/nolibc/sys.h:972:30: note: each undeclared identifier is reported only once for each function it appears in
> 
> I suspect it might be like the S_* macros for stat() that we had to
> guard against. What build conflict did you meet ? I would like as well
> to redefine the least possible and if we can make sure to fix the
> conflict efficiently without breaking code, that would be better.

The conflict looks like this:

    In file included from nolibc-test.c:18:
    sysroot/x86/include/linux/reboot.h:10: warning: "LINUX_REBOOT_MAGIC2" redefined
       10 | #define LINUX_REBOOT_MAGIC2     672274793
          | 
    In file included from sysroot/x86/include/nolibc.h:98,
                     from sysroot/x86/include/errno.h:26,
                     from sysroot/x86/include/stdio.h:14,
                     from nolibc-test.c:15:
    ... and all the other ones.



The following trivial fix on top of my patch would fix the problem:

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5d624dc63a42..9d27131c224e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -21,6 +21,7 @@
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> // for O_* and AT_*
 #include <linux/stat.h>  // for statx()
+#include <linux/reboot.h> // for LINUX_REBOOT_*
 
 #include "arch.h"
 #include "errno.h"


Want me to send a v2 or will you fix it up on your side?
