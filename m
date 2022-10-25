Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2774D60C6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJYIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJYIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:54:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF985139C21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:54:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a13so35275386edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezeNa0KTk2LzeMG5JhgWIVDQRQDMmtK5jUjmS8DSveY=;
        b=aSnigHEoQW6zMZsvzBlSGlaGf/YJDJY/viTwyD/cryQ1AAM2cMo/yR/u2Xvd5aB8/l
         nKMIxOHRqxMp24TxH0yY75kjQVLu6r0ggRki31sGz9OWSsMEw3y1KThHkFxxmYJDQzQR
         7MzDSzXmGdWt54DU/MMi6A7hA+gmLqCamfnHUffOlsaNs7oQ2VzAOOdkDz0IUCkOGGXJ
         YQIHst7yoGMGu1VkeUEthj5tB6M2MyTbLypRMNB5mVFbovKv2+uRrzPZywpUAwzWwELb
         sYVtS1PzLeZ23ZPr9TAaNqHJhAaSqPwgSwG3235pZt3m0dtEnLohZrEqRH2jLBsTvvQG
         +tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezeNa0KTk2LzeMG5JhgWIVDQRQDMmtK5jUjmS8DSveY=;
        b=Z/SHKBrjSZ3lfz2btDCgHEdN/b8Gg+UG8Bfh/qTjqWPWKjK+QKCtI53FiQrBKJGMFT
         oHsQ6nZIMaMPGt7uV7p/StsaZZEckYbjG0+5lO3r5WH8h0Rj796W0DjGChddpo/aai9d
         a7d1VzBygpurcEbjY31dKBC/ynfvRc1TE+ZTuaBJHyi6ddHdAosdDqgNlI6bZu0ORpqR
         Wkefq9dLOsYQufz+SdFPyFb6TywNtqbWaz2xMWadTguybtPQ5fUcFDZdiCOKFymu1sVC
         fUSr1wp84UydXdbUtaoTzmBOuGM/Ky4iyl7lcinND71/iujserzdViL/FsgY4Q5SOXSW
         Xysw==
X-Gm-Message-State: ACrzQf31GlE9dFJG95GH0fkEBksKDnPWhbhRxYkUYZryh2tuk3+9iU9V
        tmMBcgrMg8+000Jcz3Xxxexi2G7sCd0=
X-Google-Smtp-Source: AMsMyM5m9ddl+EduppwZSQwDXO95/iY9B1gwgu7wF1ojRZR2sd6ZZhlB2brLCCKUEO4umWgM8mSEww==
X-Received: by 2002:a05:6402:1d86:b0:457:e84:f0e with SMTP id dk6-20020a0564021d8600b004570e840f0emr34418751edb.241.1666688049383;
        Tue, 25 Oct 2022 01:54:09 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id er5-20020a056402448500b0045cf4f72b04sm1200945edb.94.2022.10.25.01.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 01:54:09 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:54:00 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: rtl8712: check for alloc fail in
 _r8712_init_recv_priv()
Message-ID: <20221025085400.GA246874@nam-dell>
References: <cover.1666645510.git.namcaov@gmail.com>
 <ce12408f17f90b3b368d077a7321a2a252f52b72.1666645510.git.namcaov@gmail.com>
 <Y1eI4kTRSwEG+G6g@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1eI4kTRSwEG+G6g@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 09:57:38AM +0300, Dan Carpenter wrote:
> On Mon, Oct 24, 2022 at 11:24:07PM +0200, Nam Cao wrote:
> > The function _r8712_init_recv_priv() and also r8712_init_recv_priv()
> > just returns silently if they fail to allocate memory. Change their
> > return type to int and add necessary checks and handling if they return
> > -ENOMEM
> > 
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > ---
> >  drivers/staging/rtl8712/os_intfs.c     |  3 ++-
> >  drivers/staging/rtl8712/recv_osdep.h   |  8 ++++----
> >  drivers/staging/rtl8712/rtl8712_recv.c |  7 ++++---
> >  drivers/staging/rtl8712/rtl871x_recv.c | 13 +++++++++----
> >  4 files changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
> > index 003e97205124..47d7d998fa86 100644
> > --- a/drivers/staging/rtl8712/os_intfs.c
> > +++ b/drivers/staging/rtl8712/os_intfs.c
> > @@ -309,7 +309,8 @@ int r8712_init_drv_sw(struct _adapter *padapter)
> >  	if (ret)
> >  		return ret;
> >  	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
> > -	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
> > +	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
> > +		return ret;
> 
> If statement missing.

Probably a rebase mistake, the if statement is there in the last patch.
Will send a v2 nonetheless, thank you for noticing this.

Best regards,
Nam
