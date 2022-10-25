Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6949D60CA41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiJYKow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiJYKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:44:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8232A3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A5A8CE1B47
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A5CC433D6;
        Tue, 25 Oct 2022 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666694679;
        bh=y0fhIZHdL2tj9M5OvvCMMhfCMRAwQjchg5BOYDbVnyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfdJ4DrKUOgvvLHp3xP8Jc01uDkPq+dcyYwKxaI2yIgY6tJW1xLSi4ac36KRBdD+A
         NYpzikXouwA+kgtbPVgSdIziLhyGg1x9xqmFZA59tVqWqOD8chCgRitnwEMP3CVeoE
         X97/zlqMdlf1moAf2nGdn70XCUcHDgmV5/AxW9Js=
Date:   Tue, 25 Oct 2022 12:45:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8192e: use explicitly signed char
Message-ID: <Y1e+SmS3O2ZaPVoe@kroah.com>
References: <20221024163005.536097-1-Jason@zx2c4.com>
 <Y1eADgj7fLKegXDH@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1eADgj7fLKegXDH@kadam>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 09:19:58AM +0300, Dan Carpenter wrote:
> On Mon, Oct 24, 2022 at 06:30:05PM +0200, Jason A. Donenfeld wrote:
> > With char becoming unsigned by default, and with `char` alone being
> > ambiguous and based on architecture, signed chars need to be marked
> > explicitly as such. In this case, passing `char *extra` is part of the
> > iw API, and that extra is mostly intended to be somewhat opaque. So just
> > cast to `s8 *` for the sign test. This fixes warnings like:
> > 
> > drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-staging@lists.linux.dev
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > index f9589c5b62ba..4563e3b5bd47 100644
> > --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> > @@ -456,7 +456,7 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
> >  	}
> >  
> >  	for (i = 0; i < len; i++) {
> > -		if (extra[i] < 0) {
> > +		if (((s8 *)extra)[i] < 0) {
> 
> I agree with Linus that this if statement is nonsense and should just be
> deleted.

Yeah, I agree as well, let's just delete this invalid check.  No other
wifi driver cares about ssid characters like this.

thanks,

greg k-h
