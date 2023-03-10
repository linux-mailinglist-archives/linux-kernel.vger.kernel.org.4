Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547736B3731
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCJHMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJHMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:12:38 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F7E107D4B;
        Thu,  9 Mar 2023 23:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WR3zzuO/akb1X+ZYLp0ihOcvQ+BdNvyw6+jfQymUlY4=; b=XPnLfrzkkkw9K5G4VVZLgLqANR
        fNJe58UXStxoj4nL1qwaua0Rk9lrJJikz/fSFnKG57toJKzSYpM5LsVle6AkXuKeSwxcjr8xuYex6
        gGvUtgLXAazb4INEt1isUNbdcfpVNcSfj4Q6Ne0akJ7L3PCXEISxZY6GkJpz72TADS91acQlLWIJV
        W1lJS3qG0ve5QfsJaOLwdurxjsxnNxpwUaFyyi8RbxaPHtN2cPbknDThjCAcXr4PcBEyzOwH9tJ4d
        ti+xrbmU5bz0sewYbKoeFo5yqKSH9snqM7GjzYd/zIN8sRizv7nX+jR2I6johGqTv058sNQeOPC+U
        je/om36w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paWvX-00FEXQ-0Q;
        Fri, 10 Mar 2023 07:12:31 +0000
Date:   Fri, 10 Mar 2023 07:12:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <20230310071231.GU3390869@ZenIV>
References: <20230310060734.8780-1-frank.li@vivo.com>
 <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310063729.GO3390869@ZenIV>
 <ZArRq/25a5Gt+YMB@sol.localdomain>
 <20230310064612.GQ3390869@ZenIV>
 <ZArULrNVaxl7e42r@sol.localdomain>
 <20230310070527.GS3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310070527.GS3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 07:05:27AM +0000, Al Viro wrote:
> On Thu, Mar 09, 2023 at 10:54:38PM -0800, Eric Biggers wrote:
> > On Fri, Mar 10, 2023 at 06:46:12AM +0000, Al Viro wrote:
> > > On Thu, Mar 09, 2023 at 10:43:55PM -0800, Eric Biggers wrote:
> > > > On Fri, Mar 10, 2023 at 06:37:29AM +0000, Al Viro wrote:
> > > > > On Thu, Mar 09, 2023 at 10:17:16PM -0800, Eric Biggers wrote:
> > > > > > On Fri, Mar 10, 2023 at 02:07:34PM +0800, Yangtao Li wrote:
> > > > > > > Just for better readability, no code logic change.
> > > > > > > 
> > > > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > > > ---
> > > > > > >  fs/ext4/inode.c | 3 +--
> > > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > > > > index d251d705c276..d121cde74522 100644
> > > > > > > --- a/fs/ext4/inode.c
> > > > > > > +++ b/fs/ext4/inode.c
> > > > > > > @@ -2218,8 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
> > > > > > >  {
> > > > > > >  	struct inode *inode = mpd->inode;
> > > > > > >  	int err;
> > > > > > > -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> > > > > > > -							>> inode->i_blkbits;
> > > > > > > +	ext4_lblk_t blocks = DIV_ROUND_UP(i_size_read(inode), i_blocksize(inode));
> > > > > > >  
> > > > > > 
> > > > > > Please don't do this.  This makes the code compile down to a division, which is
> > > > > > far less efficient.  I've verified this by checking the assembly generated.
> > > > > 
> > > > > Which compiler is doing that?
> > > > 
> > > > $ gcc --version
> > > > gcc (GCC) 12.2.1 20230201
> > > > 
> > > > i_blocksize(inode) is not a constant, so this should not be particularly
> > > > surprising.  One might hope that a / (1 << b) would be optimized into a >> b,
> > > > but that doesn't seem to happen.
> > > 
> > > It really ought to be a / (1u << b), though...
> > 
> > Sure, that does better:
> > 
> > uint64_t f(uint64_t a, int b)
> > {
> >         return a / (1U << b);
> > }
> > 
> > gcc:
> > 	0000000000000000 <f>:
> > 	   0:	48 89 f8             	mov    %rdi,%rax
> > 	   3:	89 f1                	mov    %esi,%ecx
> > 	   5:	48 d3 e8             	shr    %cl,%rax
> > 	   8:	c3                   	ret
> > 
> > clang:
> > 	0000000000000000 <f>:
> > 	   0:	89 f1                	mov    %esi,%ecx
> > 	   2:	48 89 f8             	mov    %rdi,%rax
> > 	   5:	48 d3 e8             	shr    %cl,%rax
> > 	   8:	c3                   	ret
> > 
> > But with a signed dividend (which is the case here) it gets messed up:
> > 
> > int64_t f(int64_t a, int b)
> > {
> >         return a / (1U << b);
> > }
> 
> *ow*
> 
> And i_size_read() is long long ;-/  Right.

Out of curiosity (and that's already too brittle for practical use) -
does DIV_ROUND_UP_ULL() do any better on full example?
