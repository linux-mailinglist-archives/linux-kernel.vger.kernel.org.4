Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316205FBE72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJKXdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJKXdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1CA3455;
        Tue, 11 Oct 2022 16:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B0AB6132C;
        Tue, 11 Oct 2022 23:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13626C433C1;
        Tue, 11 Oct 2022 23:33:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TPHgnLGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665531196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J72S7lKbBoFi2f3wnJgojyAB1r4vtVtzcuZbXeqIDP8=;
        b=TPHgnLGDTERFqN5Ro8AW4hhfq70IyfNVQ/2XoloVHNUrqMukWIsr+lZwOs+zEc9Ys657sh
        bQlbUdGwDxCYXZG0saATwHtUsamPzCOMPHt+RVTfjcMI/9//amUSUA6ujwqGYPRaTEL7/A
        CSRS/1anxewUvoEIZB0MAFlDMpKv5/g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7bd43544 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Oct 2022 23:33:15 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id 126so15876777vsi.10;
        Tue, 11 Oct 2022 16:33:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf3QsRTuXE2jq3yJlM6rUKqlf13CvI9c7x/TDmSdvWS5rKbs3k3R
        xD1AGcWUqimFQl+dEU+TM+8a94kLpU2J+4n61j8=
X-Google-Smtp-Source: AMsMyM5JUgwRX+Bm3y9oUVFh1rcsjYinFY8TY3YCHljWiWeTWMUoErS7G+cD75hF4ZdPei4mmItDVE3dcZw+cn0iN7c=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr12251101vsv.70.1665531194490; Tue, 11
 Oct 2022 16:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221007161411.731900ea@canb.auug.org.au> <20221012084611.53852c92@canb.auug.org.au>
In-Reply-To: <20221012084611.53852c92@canb.auug.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Oct 2022 17:33:03 -0600
X-Gmail-Original-Message-ID: <CAHmME9rxkqSSi4xdy62do4i7Wx75fDFAPzRTCf8PLL_AGbs8MQ@mail.gmail.com>
Message-ID: <CAHmME9rxkqSSi4xdy62do4i7Wx75fDFAPzRTCf8PLL_AGbs8MQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bitmap tree with the random tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 5:32 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Fri, 7 Oct 2022 16:14:11 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the bitmap tree got a conflict in:
> >
> >   include/linux/nodemask.h
> >
> > between commit:
> >
> >   82f33a32b4d2 ("treewide: use prandom_u32_max() when possible")
> >
> > from the random tree and commit:
> >
> >   97848c10f9f8 ("lib/bitmap: remove bitmap_ord_to_pos")
> >
> > from the bitmap tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> >
> > diff --cc include/linux/nodemask.h
> > index 66ee9b4b7925,0c45fb066caa..000000000000
> > --- a/include/linux/nodemask.h
> > +++ b/include/linux/nodemask.h
> > @@@ -508,8 -508,7 +508,7 @@@ static inline int node_random(const nod
> >
> >       w = nodes_weight(*maskp);
> >       if (w)
> > -             bit = bitmap_ord_to_pos(maskp->bits,
> > -                     prandom_u32_max(w), MAX_NUMNODES);
> >  -            bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
> > ++            bit = find_nth_bit(maskp->bits, MAX_NUMNODES, prandom_u32_max(w));
> >       return bit;
> >   #else
> >       return 0;
>
> This is now a conflict between the random tree and Linus' tree.

Thanks. I'll sort it out.

Jason
