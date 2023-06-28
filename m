Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214D741054
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjF1Lr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjF1LrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB42D58
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24CB4612B7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E91C433C9;
        Wed, 28 Jun 2023 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687952843;
        bh=PVaFDEbBF2Au7UWFczdEngsK/YR0zBZrsGSHokTjBKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRmjrlR7h5CB3Y/kvjrssKwZyep7A3kG7lSpSjfzPxtyv/uqd2+lrFXpuVolNswD2
         E71w9o3rmH49rzMpZGlnpep5JTF2LsHaANnH3erZYpOaOri5mYNLBMU2laa0sQM9zZ
         WzTLiOMZ/n/23LjYFHGwmOXMa/F0RShpkFAYUxRI=
Date:   Wed, 28 Jun 2023 13:47:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Alexander Graf <graf@amazon.de>,
        Babis Chalios <bchalios@amazon.es>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        mzxreary@0pointer.de, xmarcalx@amazon.co.uk,
        Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 0/1] User space notifications about VM cloning
Message-ID: <2023062827-hatchet-await-50dd@gregkh>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
 <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de>
 <2023062834-lark-frostbite-9710@gregkh>
 <CAHmME9pd7AV6a2Ot_zHspwisH06nKhSaQHu0BiDjEw8T=hQhAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9pd7AV6a2Ot_zHspwisH06nKhSaQHu0BiDjEw8T=hQhAw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 01:36:51PM +0200, Jason A. Donenfeld wrote:
> On Wed, Jun 28, 2023 at 1:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 28, 2023 at 01:13:40PM +0200, Alexander Graf wrote:
> > > Hi folks,
> > >
> > > On 16.06.23 17:07, Babis Chalios wrote:
> > > > Hello all,
> > > >
> > > > Some time has passed since I sent this. Any comments/thoughts?
> > >
> > >
> > > Can we please get this merged somehow? Greg, any advise?
> > >
> > > This is purely a device notification event to user space, similar to network
> > > link change events and the likes and has nothing to do with Jason's
> > > envisioned random reseed event exposure. We can happily send RFC patches for
> > > the latter after this is merged too.
> >
> > Sure, I can take it, but it's the middle of the merge window and it's
> > too late for anything new right now, sorry.
> >
> > I'll pick it up after 6.5-rc1 is out.
> 
> Please do *NOT* do that. I'm still unconvinced that this isn't just a
> subset of the vmclone work that needs to be done in conjunction with
> the RNG, and I'd like to get those recent virtio patches merged first
> before we move onto this, so we can see where this fits in
> holistically. I would not be happy if this got merged prematurely.

Ok, will hold off on this until you all work it out.  The changelog text
discusses entropy, so it makes sense that this looks like it is related
to this topic.

thanks,

greg k-h
