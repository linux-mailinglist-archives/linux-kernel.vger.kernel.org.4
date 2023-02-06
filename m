Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC12E68C710
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBFTvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:50:59 -0500
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5F125972;
        Mon,  6 Feb 2023 11:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=jS8Lr/pwA5OrRN4brjkNs2jw0MJnveqWb1qydiq7450=; b=PzcVPmntEcaP6qZgyrdEZDCu1o
        BesahfN7b/ewF+hA/2B1ezrn+0NTYW7pfNYbLpBxCW/0Er+37lr5bd+5+g/88KxDqsW9aMqls3eMp
        1peItIsu5okHg3iFOQqp91YyZ7dZhUZm8jSoqMmW3yqFGEa1ikQ6CYnxl+0Prk0pjA+PUBQomT9xb
        4SA2JMEoek3+9ajzTDbqxpWj37qvrxhOXqhkKDNjHNI4GKMau5mGLg1x83ckJcCBbwN7UVwaWG+Kp
        KHlE3lBqjfexOCOhZp+w3CNB/K+h2JY0gxlq427EoOaH1KPqt1tsf5oVCnN5EV9r7SNfuGKnWBwWL
        K3fEGq9A==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1pP7Vi-00530d-MK; Mon, 06 Feb 2023 19:50:42 +0000
Date:   Mon, 6 Feb 2023 19:50:42 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] jfs: Use unsigned variable for length calculations
Message-ID: <Y+FaEp2blurmgVlH@gallifrey>
References: <20230204183355.never.877-kees@kernel.org>
 <Y96/SUlPUl7xH1NO@gallifrey>
 <63e1486a.050a0220.7001.ca15@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <63e1486a.050a0220.7001.ca15@mx.google.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 19:49:48 up 332 days,  6:15,  1 user,  load average: 0.05, 0.04,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kees Cook (keescook@chromium.org) wrote:
> On Sat, Feb 04, 2023 at 08:25:45PM +0000, Dr. David Alan Gilbert wrote:
> > * Kees Cook (keescook@chromium.org) wrote:
> > > To avoid confusing the compiler about possible negative sizes, switch
> > > "ssize" which can never be negative from int to u32.  Seen with GCC 13:
> > > 
> > > ../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [-2147483648, -1]
> > > [-Warray-bounds=]
> > >    57 | #define __underlying_memcpy     __builtin_memcpy
> > >       |                                 ^
> > > ...
> > > ../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
> > >   950 |                 memcpy(ip->i_link, name, ssize);
> > >       |                 ^~~~~~
> > > 
> > > Cc: Dave Kleikamp <shaggy@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Dave Chinner <dchinner@redhat.com>
> > > Cc: jfs-discussion@lists.sourceforge.net
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  fs/jfs/namei.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> > > index b29d68b5eec5..494b9f4043cf 100644
> > > --- a/fs/jfs/namei.c
> > > +++ b/fs/jfs/namei.c
> > > @@ -876,7 +876,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
> > >  	tid_t tid;
> > >  	ino_t ino = 0;
> > >  	struct component_name dname;
> > > -	int ssize;		/* source pathname size */
> > > +	u32 ssize;		/* source pathname size */
> > 
> > Had you considered using size_t - this is set from a strlen and used by a memcpy
> > that both talk size_t.
> 
> I considered that, but I've had other maintainers upset about doubling
> the variable size.

I bet at least on some platforms it's cheaper as the 64 bit.

> I opted to keep the variable 32-bit here, so the
> machine code would only change to lose signed-ness.

Fair enough.

Dave

> -Kees
> 
> -- 
> Kees Cook
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
