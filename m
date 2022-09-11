Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4185B4C83
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 09:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIKHZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 03:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIKHZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 03:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF2255A4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 00:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1115B60E9A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F1FC433D6;
        Sun, 11 Sep 2022 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662881101;
        bh=OrAu6mHIVqYRRW/CQFimPqBKISrkvqtpRN9Epl3Dyxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slDYJmis3ItMPuBIHoHNT3dHscIivy08miuXqCAL0AjgKn5uM6Pr1LdrkTOmXpsEi
         1J5/JHa5KHtCSKx8oyEtVUDwl3iUfGAH4pTzL8YswRreXy+A7Fdw1DDgRq+DQ0dLeS
         zRxd7J0HjaSiY3GEANn6RPX8rEBCTjQlPISulNHY=
Date:   Sun, 11 Sep 2022 09:25:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/2] staging: vt6655: remove unnecessary volatile
 qualifier
Message-ID: <Yx2NY0RBWLqH3rDK@kroah.com>
References: <cover.1662724786.git.namcaov@gmail.com>
 <c3a7d9963b1c38c5f493786d7268c430617412dd.1662724786.git.namcaov@gmail.com>
 <Yxt/3FOysEbwCm9T@kroah.com>
 <CA+sZ8B8Y1ZGou1Y4tQYJC1Wp_2MVdYKO0Bd3SfxMAU1DF+mz_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sZ8B8Y1ZGou1Y4tQYJC1Wp_2MVdYKO0Bd3SfxMAU1DF+mz_g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 09:12:44AM +0200, Nam Cao wrote:
> On Fri, Sep 9, 2022 at 8:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 09, 2022 at 02:17:55PM +0200, Nam Cao wrote:
> > > Remove volatile qualifier for the member rd0 of struct vnt_rx_desc,
> > > because there is no reason it must be volatile.
> > >
> > > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > > ---
> > >  drivers/staging/vt6655/desc.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/vt6655/desc.h b/drivers/staging/vt6655/desc.h
> > > index 17a40c53b8ff..3f0f287b1693 100644
> > > --- a/drivers/staging/vt6655/desc.h
> > > +++ b/drivers/staging/vt6655/desc.h
> > > @@ -182,7 +182,7 @@ struct vnt_rdes1 {
> > >
> > >  /* Rx descriptor*/
> > >  struct vnt_rx_desc {
> > > -     volatile struct vnt_rdes0 rd0;
> > > +     struct vnt_rdes0 rd0;
> >
> > You can not just remove this without describing _WHY_ it is ok to do so.
> >
> > Have you properly determined why it is, or is not, ok to use volatile
> > here?
> 
> I did not carefully look at the volatile usage here. After looking at it
> again, using volatile is actually valid: the structure resides on coherent
> memory.

Are you sure?  That's a very odd thing for a driver to need.  Looks like
they are allocating some dma memory and then pointing structures on top
of that memory.  Why would you need to have "volatile" markings on a
structure definition for that?

Dig into this some more please, I don't think this is correct.

thanks,

greg k-h
