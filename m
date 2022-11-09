Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4362259B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiKIIi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKIIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:38:21 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365F13F9B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:38:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id 13so44832894ejn.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mSqik3rxjfUwFIPuwdL2bfvmWkPZxeeN66JvCGTMZuI=;
        b=IdTK6q0AI/+gRQ29/pvGAHr9D2TdJpwFSpm3gknaIg2EDBMeKy7D2Hj0IE+nZV+GRX
         wRBVEmw0+LmdXSX/1lDbushStSCIAQDtVCJINug5iOtCU5kEmsgC7PfjXQEKqlxxwxoK
         1khdhOiOoDFle8XDOcjugvvGrf6ddp2GeuDP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSqik3rxjfUwFIPuwdL2bfvmWkPZxeeN66JvCGTMZuI=;
        b=27I1mdCYrvd6HNnn6BHI084gjCkD8LIclsbSxBsC0r6XEqeWOeJ4rsTRhckUUkRnjm
         z68hLBXZz8BF2ITwPeRFk3zh7N6HDFKmyQWizGlPK4v9DP/3XL1uwfBzoa0mmu7xv9Mw
         Y5ftVuwLv1uUr9wHeHTyPJMjK8nNygXHvznSbsQiM1lB/4d/sgvUFDn2hpeUEEwO3a2c
         /Mh6qxTSEEYjVEY54Yo2VT/4pZdvCIAmqOukdjWvBz1+yRFFb++eqDcQbsVI9Oho6zdM
         W2shLwJxXOwYCiy3DUOT7FjUX0ebof1CmzfnCYGt05n1Ci9LvtEGuLtLP6Akji9pA4Jr
         GIiw==
X-Gm-Message-State: ACrzQf2ORC+bpw45MMHlP4dWteGu7DzdXwjKCX2C0D1Z7AuVevwpoxRQ
        /R3piGQjQ0X2mCZYV7FD26XEh4/FKr/dw6PGLM6Z9g==
X-Google-Smtp-Source: AMsMyM66uNQ6nvWE+msNF+dvlf/6F4BeteTJztdeUq/qPmCufp4nXFQATR3FREnJuWKqQugU6bs5rSKSpQx9ihgiMrs=
X-Received: by 2002:a17:907:6d82:b0:7ad:dfb1:bcc with SMTP id
 sb2-20020a1709076d8200b007addfb10bccmr45568424ejc.766.1667983098310; Wed, 09
 Nov 2022 00:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20221106154612.3474940-1-dario.binacchi@amarulasolutions.com>
 <Y2thuiR3UVEeLCQO@atomide.com> <Y2tiHNLPiAwV6oEn@atomide.com>
In-Reply-To: <Y2tiHNLPiAwV6oEn@atomide.com>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 9 Nov 2022 09:38:07 +0100
Message-ID: <CABGWkvrEGKTrwMgedzE1Oj0F+Fgpmzm6sB4hs7wcNn3xKPUupQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: ti: add of_ti_clk_register() helper
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang He <windhl@126.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, Nov 9, 2022 at 9:17 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Tony Lindgren <tony@atomide.com> [221109 08:06]:
> > * Dario Binacchi <dario.binacchi@amarulasolutions.com> [221106 17:36]:
> > > The ti_clk_register() function is always called with the parameter of
> > > type struct device set to NULL, since the functions from which it is
> > > called always have a parameter of type struct device_node. Adding this
> > > helper will allow you to register a TI clock to the common clock
> > > framework by taking advantage of the facilities provided by the
> > > struct device_node type.
> >
> > Makes sense to me.
> >
> > Do you have a patch to make use of this I can test with?
>
> I mean a patch to convert the ti_clk_register() callers to use this or
> what's your plan?

The first patch that calls this function is the second one in this
series "clk: ti: dra7-atl: don't allocate` parent_names' variable ".
Since I don't have the dra7 hardware, I have indirectly tested it on a
beaglebone (gate clock driver) board. To do this I also
had to add the of_ti_clk_register_omap_hw() helper. In the case of the
dra7-atl driver it was not necessary because the setup
function calls the ti_clk_register() directly.
If you think it makes sense, I can do 1 or more patches that replace
ti_clk_register() and ti_clk_register_omap_hw() with their
counterparts of_ti_clk_register[_omap_hw]. And I could test this
further series on the beaglebone board.

Thanks and regards,
Dario

>
> Regards,
>
> Tony



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
