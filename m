Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A9F60BE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJXXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiJXXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:14:16 -0400
X-Greylist: delayed 3580 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 14:35:24 PDT
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125C1DF23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=RF5v6sbc/BgP4DAy64XP5vEHKb5eLyVOJZSiY2mcVFQ=; b=q2vKX0iVl6xstCbWD8tFqDVTaY
        7Wu08EpPd0dhYq2LDGPkm3Xxk3hfzOBoQjY8XJYq4waPjgz/NzlVGrrIl+oieZUgrlNUU/KhfYnDq
        Ggk46jc5GbAaOIRpagZZ4I29/kRcjn8uVBYbqX89CSh+v46QCDKASN8gsAe4bZ4dFKEoSnavM358x
        IKAkS7OlzbkEYoi0IqBujvSbMKbGsFTNejtNJxC4anlU1etzLVOt9kfgF67X8Dml0kk4VwyCrIhG4
        dh7bv/HeYouaQpsvL72fs9T/RmFQldMPSWiKo72eGoTsGPMAiBlKoTMJ124iA7ne72cELr9ImhPvQ
        6vXgVjAA==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1on2Vh-007RkM-Tl; Mon, 24 Oct 2022 19:49:17 +0100
Date:   Mon, 24 Oct 2022 19:49:17 +0100
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: Fix fortify moan in symlink
Message-ID: <Y1beLWto/J2W1Stu@gallifrey>
References: <20221022203913.264855-1-linux@treblig.org>
 <202210241021.6E9E1EF65@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <202210241021.6E9E1EF65@keescook>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 19:47:20 up 227 days,  5:13,  1 user,  load average: 0.07, 0.04,
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
> On Sat, Oct 22, 2022 at 09:39:14PM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > JFS has in jfs_incore.h:
> > 
> >       /* _inline may overflow into _inline_ea when needed */
> >       /* _inline_ea may overlay the last part of
> >        * file._xtroot if maxentry = XTROOTINITSLOT
> >        */
> >       union {
> >         struct {
> >           /* 128: inline symlink */
> >           unchar _inline[128];
> >           /* 128: inline extended attr */
> >           unchar _inline_ea[128];
> >         };
> >         unchar _inline_all[256];
> > 
> > and currently the symlink code copies into _inline;
> > if this is larger than 128 bytes it triggers a fortify warning of the
> > form:
> > 
> >   memcpy: detected field-spanning write (size 132) of single field
> >      "ip->i_link" at fs/jfs/namei.c:950 (size 18446744073709551615)
> 
> Which compiler are you using for this build?

I think that report was the same on gcc on Fedora 37 and whatever
syzkaller was running.

> This size report (SIZE_MAX)
> should be impossible to reach. But also, the size is just wrong --
> i_inline is 128 bytes, not SIZE_MAX. So, the detection is working
> (132 > 128), but the report is broken, and I can't see how...

Yeh, and led me down a blind alley for a while thinking something had
really managed to screwup the strlen somehow.

> 
> > 
> > when it's actually OK.
> > 
> > Copy it into _inline_all instead.
> > 
> > Reported-by: syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  fs/jfs/namei.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> > index 9db4f5789c0ec..4fbbf88435e69 100644
> > --- a/fs/jfs/namei.c
> > +++ b/fs/jfs/namei.c
> > @@ -946,7 +946,7 @@ static int jfs_symlink(struct user_namespace *mnt_userns, struct inode *dip,
> >  	if (ssize <= IDATASIZE) {
> >  		ip->i_op = &jfs_fast_symlink_inode_operations;
> >  
> > -		ip->i_link = JFS_IP(ip)->i_inline;
> > +		ip->i_link = JFS_IP(ip)->i_inline_all;
> >  		memcpy(ip->i_link, name, ssize);
> >  		ip->i_size = ssize - 1;
> >  
> 
> Regardless, the fix looks correct to me!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

Dave

> -- 
> Kees Cook
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
