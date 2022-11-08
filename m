Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C84620887
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiKHExn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiKHEwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:52:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43D15808;
        Mon,  7 Nov 2022 20:52:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso16880085pjc.0;
        Mon, 07 Nov 2022 20:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Bj4JndgLNz7gGz6zD6d+gNb6WYRgkFP0L8PlpMLYvY=;
        b=GwVvKDmLAm/sVQueT2Sz2xPPioSUXxQ6vzxfDUFSXUNj+J4298zq4NvzqbG4n8VHVW
         WT/BXdDO18n1/fUaoO99+a1GXy/V1GroI4spqigmYH47Bx76l0V6zMp2M9pikCdLHs9M
         ihQMP/ss8uHosrdwbBQlmTm0WdteexIUF/KWztbrxZuZdHdE1LEFnpYm927VD5LUYRar
         8rPz2G/bDONjuDwz8a37GfzHbwsLGVx4Wi3K1+Vz5O2olnIJrybDXsHdtt7ryDPguqCb
         QXvOxqrHTfRTVi26/ChGa5P+fNxo1FIWVRk3CDJeGuANi0780isBNrihIW4FkrH9VOwQ
         OBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bj4JndgLNz7gGz6zD6d+gNb6WYRgkFP0L8PlpMLYvY=;
        b=Gdw2ML5NSc0dXu9UVKYLXC6Z0mGK68MwnnhlDh4nq61cmMgYtiFgAxwJF3w2IdN6m8
         g4eVyvE3R9xXTVLAJb26EL0+2hHt6DRJ12Q/5O6PjiG0skzD091RunP0bf4J27XfSjJA
         uU/R+JCFNMKeGG8XTqVP9cLIv9jhlNvvhd4BPTSN4ZcD+t1qEmvvr6OTUKoblkwRQdZH
         614qOyN6kJ4rdlvpKh8gFJxmtWGu+RxUYkpQDaH3BA1ZfMNxdBm8Qn1GJ+S9WMRbVyLg
         uvhk5v1I1a4KD2qbMepHF+uGDtqRSCZ/UEzRvO+m56WdXyqHk5nCsKoojQE+2VmNaE+N
         EEGA==
X-Gm-Message-State: ACrzQf0nUh9olE952yMDhk18OduRPjKsef47OAUaGxXwyKJUqEajg+Lu
        +jQLfzrdsjsrzhU3WxO52yfO1vXmHeo=
X-Google-Smtp-Source: AMsMyM7FEB7AjWDl9NYtuDIAxvMEgp97UWpHWQcAcr/MODPg7fOGkE9oGRBc9v3tAacPC6LDGl2qIw==
X-Received: by 2002:a17:90b:11d4:b0:212:ee83:481 with SMTP id gv20-20020a17090b11d400b00212ee830481mr54196696pjb.36.1667883157411;
        Mon, 07 Nov 2022 20:52:37 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb10:b5b0:232e:4afb])
        by smtp.gmail.com with ESMTPSA id j28-20020a63231c000000b0046faefad8a1sm4988911pgj.79.2022.11.07.20.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:52:36 -0800 (PST)
Date:   Mon, 7 Nov 2022 20:52:33 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Get rid of
 devm_fwnode_get_[index_]gpiod_from_child()
Message-ID: <Y2ngkYVAfn24EcfL@google.com>
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
 <YyzYKmsjKflqT1xZ@google.com>
 <Y1aCgJihNIqExUR2@google.com>
 <CAMRc=McvJ7AvhKdP7cv8K1+rzMf8-ptg2SnU+XOAwERhRx1Eyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McvJ7AvhKdP7cv8K1+rzMf8-ptg2SnU+XOAwERhRx1Eyw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 05:48:02PM +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 24, 2022 at 2:18 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Thu, Sep 22, 2022 at 02:48:26PM -0700, Dmitry Torokhov wrote:
> > > Hi Pavel, Marek,
> > >
> > > On Fri, Sep 02, 2022 at 05:55:24PM -0700, Dmitry Torokhov wrote:
> > > > This drops the last uses of devm_fwnode_get_[index_]gpiod_from_child()
> > > > from the tree and drops the stubs implementing this API on top of
> > > > devm_fwnode_gpiod_get_index().
> > > >
> > > > Note that the bulk of users were converted in 2019, the couple of LED
> > > > drivers are all that have remained.
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > >
> > > > ---
> > > > Dmitry Torokhov (3):
> > > >       leds: gpio: switch to using devm_fwnode_gpiod_get()
> > > >       leds: lgm-sso: switch to using devm_fwnode_gpiod_get()
> > > >       gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()
> > > >
> > > >  drivers/leds/blink/leds-lgm-sso.c |  5 ++---
> > > >  drivers/leds/leds-gpio.c          |  5 ++---
> > > >  include/linux/gpio/consumer.h     | 21 ---------------------
> > > >  3 files changed, 4 insertions(+), 27 deletions(-)
> > > > ---
> > > > base-commit: 7fd22855300e693668c3397771b3a2b3948f827a
> > > > change-id: 20220902-get_gpiod_from_child-remove-a62638849e91
> > > >
> > >
> > > Could you please consider picking this up for 6.1? Or would you be OK
> > > with this going through other tree (GPIO maybe)?
> >
> > *ping* Could this go through GPIO tree? Dropping this API helps with
> > some outstanding work that I have...
> >
> 
> Sure! I'll let it wait for another week - it would be great to get an
> ack from Pavel - but in case of no response I'll take it through my
> tree.

Pavel, any chance we could get an Ack for this?

Thanks!

-- 
Dmitry
