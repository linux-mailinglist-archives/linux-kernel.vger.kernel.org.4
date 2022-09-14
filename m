Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149DA5B8297
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiINICr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiINICY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA6A6CF7A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C592615D9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826CC433D7;
        Wed, 14 Sep 2022 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663142524;
        bh=Gb+UiMDJQOrLZOBOFvKO7hc50e8Wfw2fbwZ4a+0Jhhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaIkyci8t2ooMQbr9h9k78gp0yMhS6aqvjyg5Npw9R98sEnih/9jPERR1/8oCy7uO
         XPvw2a7og0Y5TH4ZzVylrrM1iLE6ZtbrjHfJnjMf0abP8PGzQwgpx7IIhmNEOavRUL
         XHRgE6Xb8qG2Vq0vz2nMox4dfJ2ogwy9xDSWMZCI=
Date:   Wed, 14 Sep 2022 10:02:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/2] staging: vt6655: remove unnecessary volatile
 qualifier
Message-ID: <YyGKlVbhFmrZ1lXK@kroah.com>
References: <cover.1662724786.git.namcaov@gmail.com>
 <c3a7d9963b1c38c5f493786d7268c430617412dd.1662724786.git.namcaov@gmail.com>
 <Yxt/3FOysEbwCm9T@kroah.com>
 <CA+sZ8B8Y1ZGou1Y4tQYJC1Wp_2MVdYKO0Bd3SfxMAU1DF+mz_g@mail.gmail.com>
 <Yx2NY0RBWLqH3rDK@kroah.com>
 <CA+sZ8B8-hsNXY-nFffvGMLJXmsAa9L+gnEK1ZdC7PztG1dd03Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sZ8B8-hsNXY-nFffvGMLJXmsAa9L+gnEK1ZdC7PztG1dd03Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 06:52:12PM +0200, Nam Cao wrote:
> On Sun, Sep 11, 2022 at 9:25 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Sep 11, 2022 at 09:12:44AM +0200, Nam Cao wrote:
> > > On Fri, Sep 9, 2022 at 8:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Sep 09, 2022 at 02:17:55PM +0200, Nam Cao wrote:
> > > > > Remove volatile qualifier for the member rd0 of struct vnt_rx_desc,
> > > > > because there is no reason it must be volatile.
> > > > >
> > > > > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > > > > ---
> > > > >  drivers/staging/vt6655/desc.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/staging/vt6655/desc.h b/drivers/staging/vt6655/desc.h
> > > > > index 17a40c53b8ff..3f0f287b1693 100644
> > > > > --- a/drivers/staging/vt6655/desc.h
> > > > > +++ b/drivers/staging/vt6655/desc.h
> > > > > @@ -182,7 +182,7 @@ struct vnt_rdes1 {
> > > > >
> > > > >  /* Rx descriptor*/
> > > > >  struct vnt_rx_desc {
> > > > > -     volatile struct vnt_rdes0 rd0;
> > > > > +     struct vnt_rdes0 rd0;
> > > >
> > > > You can not just remove this without describing _WHY_ it is ok to do so.
> > > >
> > > > Have you properly determined why it is, or is not, ok to use volatile
> > > > here?
> > >
> > > I did not carefully look at the volatile usage here. After looking at it
> > > again, using volatile is actually valid: the structure resides on coherent
> > > memory.
> >
> > Are you sure?  That's a very odd thing for a driver to need.  Looks like
> > they are allocating some dma memory and then pointing structures on top
> > of that memory.  Why would you need to have "volatile" markings on a
> > structure definition for that?
> 
> These structures are the ring buffer descriptors, which are dma-mapped and
> their values may be changed by the hardware. For example, the field "owner" of
> struct vnt_rdes0 is set to OWNED_BY_NIC by CPU, and then set to OWNED_BY_HOST
> by hardware when new data arrives (at least that's why I can guess based on
> the codes). So I think volatile is needed.
> 
> Please let me know if you think I'm wrong, because I have just recently
> educated myself on DMA mapping.

With DMA mapping you shouldn't need "volatile" as it really doesn't do
what people thought it did.  Other drivers don't use volatile for
accessing memory this way, the device should have notified the driver
that it is now safe to read from that memory through the DMA api.

So try looking a bit closer and also look at the compiler output before
and after your change to see if it actually did anything or not.

thanks,

greg k-h
