Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6973673E05C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjFZNRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFZNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84339139
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF1F960DEF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1061BC433C0;
        Mon, 26 Jun 2023 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687785421;
        bh=s9k+AYqgePpeMVIbOwnHOPJNWdEtQMP7MRlarPpl/SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxpMk344RbkBco6lAhRjhfZSdjHK+F0rXhq4r0mHKjP5qC9mkEEtnk0P7JDMgsxV9
         px+GwSerrEXQuF3KiZyME/abRD/PStDlqgkn2HP87G8m6Z4WpvYeQyGIxQv0x2PaQH
         UtGTAZJHzH4CRHdnooI6HegYKvJGVeml5UlW/d+Fkf0QNqFfmKlxlISq9WKimtGmEx
         5hmUeqA5ozE13cXa19HyFgk/O/0+91E0ieIIOVDJyZwNoZ1vD6IRwLwTH35HjZdhO6
         OACXaeNCstOPTK7dEKQXe/JaYLMyMPtDWxCcHB3HIWY4DSUs+9SVo7HTa9KykkM6lS
         z3BRjLwJvflkg==
Date:   Mon, 26 Jun 2023 06:16:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     =?utf-8?B?5L2V5LqR6JW+KFl1bmxlaSBoZSk=?= <heyunlei@oppo.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev][PATCH] f2fs: not allowed to set file both cold and hot
Message-ID: <ZJmPy8YQbcnS9Zkr@google.com>
References: <20230613085250.3648491-1-heyunlei@oppo.com>
 <b8523d41-246b-b11e-f6e3-423e32cc597a@kernel.org>
 <6c527e97-c4a6-dc58-13fb-516f77e5e068@oppo.com>
 <f7a44e66-6fde-a178-d29e-7684bcbc454e@kernel.org>
 <ZJXtcfoR+BFx5CXn@google.com>
 <b638931a-ab81-a6ef-be5b-57848f27aba7@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b638931a-ab81-a6ef-be5b-57848f27aba7@oppo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25, 何云蕾(Yunlei he) wrote:
> 
> On 2023/6/24 3:07, Jaegeuk Kim wrote:
> > On 06/20, Chao Yu wrote:
> > > On 2023/6/20 10:42, 何云蕾(Yunlei he) wrote:
> > > > On 2023/6/20 8:33, Chao Yu wrote:
> > > > > On 2023/6/13 16:52, Yunlei He wrote:
> > > > > > File set both cold and hot advise bit is confusion, so
> > > > > > return EINVAL to avoid this case.
> > > > > > 
> > > > > > Signed-off-by: Yunlei He<heyunlei@oppo.com>
> > > > > > ---
> > > > > >    fs/f2fs/xattr.c | 3 +++
> > > > > >    1 file changed, 3 insertions(+)
> > > > > > 
> > > > > > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > > > > > index 213805d3592c..917f3ac9f1a1 100644
> > > > > > --- a/fs/f2fs/xattr.c
> > > > > > +++ b/fs/f2fs/xattr.c
> > > > > > @@ -127,6 +127,9 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
> > > > > >                   return -EINVAL;
> > > > > > 
> > > > > >           new_advise = new_advise & FADVISE_MODIFIABLE_BITS;
> > > > > > +       if ((new_advise & FADVISE_COLD_BIT) && (new_advise & FADVISE_HOT_BIT))
> > > > > > +               return -EINVAL;
> > Why not this to allow setting one bit only?
> > 
> > @@ -123,7 +123,8 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
> >                  return -EINVAL;
> > 
> >          new_advise = *(char *)value;
> > -       if (new_advise & ~FADVISE_MODIFIABLE_BITS)
> > +       if (new_advise & ~FADVISE_MODIFIABLE_BITS ||
> > +           new_advise == FADVISE_MODIFIABLE_BITS)
> >                  return -EINVAL;
> 
> Hi,Jaegeuk,
> 
>     If new modifiable advise bit is added in the future, maybe multi-bits
> is allowed?
> 

Looks like making a single bit assumption would be better in general at this
moment.

> Thanks
> 
> > 
> > > > > Yunlei,
> > > > > 
> > > > > What about the below case:
> > > > > 
> > > > > 1. f2fs_xattr_advise_set(FADVISE_COLD_BIT)
> > > > > 2. f2fs_xattr_advise_set(FADVISE_HOT_BIT)
> > > > Hi,  Chao,
> > > > 
> > > >       I test this case work well with this patch,  case below will return -EINVAL:
> > > > 
> > > >       f2fs_xattr_advise_set(FADVISE_COLD_BIT | FADVISE_HOT_BIT)
> > > Correct, I missed to check below statement.
> > > 
> > > new_advise |= old_advise & ~FADVISE_MODIFIABLE_BITS;
> > > 
> > > Anyway, the patch looks good to me.
> > > 
> > > Reviewed-by: Chao Yu<chao@kernel.org>
> > > 
> > > Thanks,
