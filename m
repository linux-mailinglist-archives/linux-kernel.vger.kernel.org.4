Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F925E90FE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 06:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIYEyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 00:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIYEyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 00:54:51 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B57913CEB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 21:54:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 3so3807939pga.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 21:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=P2wvlg/sKupDOfwRxPOvn4eTw/F7swZQ2U9FkS+2NIo=;
        b=BXsf6zUmdcaZUebvDnxObiUlxuwhyNm3xlesVZ8csmewxZiY7KAiGa4wLWoUwSC+/h
         5njwxu6yOrSiy6rw60Puxg5JBDuJ5N1RFd1Frvf2aS46SGFjZj2lK9qAE90+1Kg/omz0
         UKEdorzCrL1rFiUzFe4qUwC4lKQ+5ZUQwTJ1jkFdVzcFJaIvlKMLA9zAPKKj8q+2+Yp+
         M+wG8loz6+YzMmH0SxANXdoHlshJ1r8nWD1AwwXm10AXDGZxeAaV4UxKovV8lkVBJFVe
         3iNCLau7UC19kqePwMivdZvyyCOv2mFisfz4WuNebp3siQEiD3l5f2sdDRQuQgf/xeGX
         gI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=P2wvlg/sKupDOfwRxPOvn4eTw/F7swZQ2U9FkS+2NIo=;
        b=dKj/IbAadvua2wCTxkZoNWGAiCWar9OblLp1Zra0xfaKfzySzLPpofAwgekfiz9VZw
         Q20F7JclK+AvP9Wr4DQKyKbVoiICMPdWaobpjSnWFrQEp6NdU8MgxBmw7vtSiR5sg8X0
         +h1Pl7HEWI5CQFNgNR69RNBoDnR77Mlk0E345p+aiP+hJNsTGlq7a2Ig+5N13HDzvLM2
         9oHoBMztY4mmLWwKxi9dX+3ZXVSJhx2FzPvFliY6UslHRcIxTebMG+BbqWRI60O1rO7J
         FX8kmTUgg4Fp7/54xrYqzZxZROw2H0zFoXJMYDsTS/s9NHGKdrzIXlbKatSnRCGiTImf
         TaNw==
X-Gm-Message-State: ACrzQf0A53WTBej3vtGk+fLfPUoMfurTT2gY8GMNMFd0ULEF4mm+mXnl
        Ow/20iRQqV5Jz6eX+IGBF9o=
X-Google-Smtp-Source: AMsMyM5lswvmUzKskZZeIrOUiIw2gZ5mbNkKLRHv9Fewfb/cT0WLpfYNTW2+vyKRuO7/fL9UYc2sXQ==
X-Received: by 2002:a65:6cce:0:b0:439:49b5:48b8 with SMTP id g14-20020a656cce000000b0043949b548b8mr14476183pgw.514.1664081687424;
        Sat, 24 Sep 2022 21:54:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:37c:3916:9a45:14cc])
        by smtp.gmail.com with ESMTPSA id lw4-20020a17090b180400b001df264610c4sm17189987pjb.0.2022.09.24.21.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 21:54:46 -0700 (PDT)
Date:   Sat, 24 Sep 2022 21:54:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] pcmcia: at91_cf: switch to using gpiod API
Message-ID: <Yy/fE9lUmWTpsyTL@google.com>
References: <Yy6d7TjqzUwGQnQa@penguin>
 <68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com>
 <Yy7tLRcMaKeet9An@mail.local>
 <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 04:17:20PM +0200, Dominik Brodowski wrote:
> Am Sat, Sep 24, 2022 at 01:42:37PM +0200 schrieb Alexandre Belloni:
> > On 24/09/2022 10:33:29+0200, Arnd Bergmann wrote:
> > > On Sat, Sep 24, 2022, at 8:04 AM, Dmitry Torokhov wrote:
> > > > This patch switches the driver to use newer gpiod API instead of legacy
> > > > gpio API. This moves us closer to the goal of stopping exporting
> > > > OF-specific APIs of gpiolib.
> > > >
> > > > While at it, stop using module-global for regmap.
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > 
> > > This looks good to me overall. Three comments:
> > > 
> > > > @@ -63,7 +62,7 @@ struct at91_cf_socket {
> > > > 
> > > >  static inline int at91_cf_present(struct at91_cf_socket *cf)
> > > >  {
> > > > -	return !gpio_get_value(cf->board->det_pin);
> > > > +	return gpiod_get_value(cf->board->det_pin);
> > > >  }
> > > 
> > > a) The change in polarity looks wrong here, I can't really tell
> > > from the patch. If this is intentional, maybe explain it in
> > > the changelog. With that addressed (either way)

Oh, yes, you are right. I at first thought that card detect pin might be
active low, was not able to confirm it, but forgot to restore polarity.

Anyway, I think this does not matter given Dominik's patch below.

> > > 
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > 
> > > b) In case you are doing more patches like this one at the moment,
> > > note that I'm in the process of removing all unused board files
> > > for arch/arm/, which will in turn make a lot of drivers unused.
> > > I should be able to provide a branch soon, which can be used to
> > > identify drivers that don't have DT support any more and don't
> > > have any board files. Rather than converting them to gpio
> > > descriptors, we can probably just remove those drivers.
> > > 
> > > c) I'm not sure about the state of the at91_cf driver. Apparently
> > > we used to have three drivers for the same hardware (pcmcia,
> > > pata and ide), and only the pcmcia driver remained in the tree
> > > after drivers/ide/ was removed and pata_at91 did not get converted
> > > to DT. I think in the long run we will remove the pcmcia layer,
> > > so if you are actually trying to use this hardware, we may want to
> > > revive the pata variant and drop this one instead.

Nope, I am interested in dropping legacy gpio API, that is all.

> > > There is no dts file in tree that actually declares either of them,
> > > so chances are that nobody is actually using the CF slot on at91
> > > any more.
> > > 
> > 
> > I'm pretty sure it is broken since eaa9a21dd14b ("pcmcia: at91_cf: Use
> > syscon to configure the MC/smc") as this change has never been tested.
> 
> Well, that's a pretty strong reason to remove this driver. May I get ACKs on
> this patch, please?

Not sure if this is worth anything, but

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
