Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722B060004F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJPPDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJPPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:03:13 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D74150C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1665932561; bh=Wg6GtD2ZzWSQ6Z/hu/RF4EtKjefFvDhYKsRPqn3anp8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=owbrKLFcrfJU1G2j85Nua7FP6V3CtoEzK7eF1zqSaJJYW/5am+6bfbO2b9x9tiXsu
         5MMHc0NmzHGZm8PwiDcTCaYUAMYaXi29SxuwflrlniN24E8Lx98s469JSWmqJmZK4X
         9qSjCB5IOHQH8FMpoKO5GgFkb6dj7DtdNRJLFeVE=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Sun, 16 Oct 2022 17:02:41 +0200 (CEST)
X-EA-Auth: rqDcTQj11g/+I1KNqnWV0ELN5Jcrvy5Et74Xab4CYIiKU78hFJPEs2s2evli4I6kFMQfPGQEIwwtuOW6X69I1t0TYIa33UtB
Date:   Sun, 16 Oct 2022 20:32:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
Message-ID: <Y0wdDTUBrUT/cr9w@lion2204>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
 <alpine.DEB.2.22.394.2210161649400.2876@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210161649400.2876@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 04:51:09PM +0200, Julia Lawall wrote:
>
>
> On Sun, 16 Oct 2022, Deepak R Varma wrote:
>
> > Include multiple statements of macro definition inside do-while{0} loop
> > to avoid possible partial program execution. Issue reported by
> > checkpatch script:
> >
> > ERROR: Macros with multiple statements should be enclosed in a do - while loop
>
> I don't think this change will compile.  See if you can figure out why
> not.

It did compile. I built the greybus driver and loaded it as well with the
modinfo tool. Can you please tell why you think it won't compile?

./drv

>
> julia
>
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/greybus/loopback.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> > index 1a61fce98056..37214cb43937 100644
> > --- a/drivers/staging/greybus/loopback.c
> > +++ b/drivers/staging/greybus/loopback.c
> > @@ -163,9 +163,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
> >  static DEVICE_ATTR_RO(name##_avg)
> >
> >  #define gb_loopback_stats_attrs(field)				\
> > +do {								\
> >  	gb_loopback_ro_stats_attr(field, min, u);		\
> >  	gb_loopback_ro_stats_attr(field, max, u);		\
> > -	gb_loopback_ro_avg_attr(field)
> > +	gb_loopback_ro_avg_attr(field);				\
> > +} while (0)
> >
> >  #define gb_loopback_attr(field, type)					\
> >  static ssize_t field##_show(struct device *dev,				\
> > --
> > 2.30.2
> >
> >
> >
> >
> >


