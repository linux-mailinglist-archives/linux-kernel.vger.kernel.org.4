Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430F75E6441
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiIVNwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiIVNv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:51:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A8EFA68;
        Thu, 22 Sep 2022 06:51:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D0DE36BE;
        Thu, 22 Sep 2022 15:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663854704;
        bh=uDPuHKFlxyNd6c23deR/oha4FWKGGQOVT5JIulE83wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GO0rSUPLZvMRR7gbcy6/hstYDPuIWntiCMcw1GZSzRrkv9DB5gXfGfLDnjLFFqlWX
         VsRmUMNVY11ef9TxE4DkjVa4ZGRPT7hpwIkmQW6+hh5eK0lsuF/LtUNErzRUMVXad3
         OOOJu/TafgOIH215k2TXIyqE/q8h9uVIBK1zAln4=
Date:   Thu, 22 Sep 2022 16:51:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
Message-ID: <YyxoYSnj9llox5l1@pendragon.ideasonboard.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yys4CRNnKP3LXyAO@pendragon.ideasonboard.com>
 <CA+V-a8uiT9rV=T6LmFovRwULf3SO=JKdqr1yacAqN8gJmv9VPw@mail.gmail.com>
 <YyxWOuWOrYmMexNj@paasikivi.fi.intel.com>
 <CAMuHMdXKz56jxw56fXa7CMh_y4MVYiUT25dqRntJw6481s1FWw@mail.gmail.com>
 <CA+V-a8sW=a6auFH-1WqwK+o2MZGCQk+MAO4+cWKm1M+YrQE+CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+V-a8sW=a6auFH-1WqwK+o2MZGCQk+MAO4+cWKm1M+YrQE+CA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:27:15PM +0100, Lad, Prabhakar wrote:
> On Thu, Sep 22, 2022 at 1:51 PM Geert Uytterhoeven wrote:
> > On Thu, Sep 22, 2022 at 2:34 PM Sakari Ailus wrote:
> > > On Thu, Sep 22, 2022 at 01:08:33PM +0100, Lad, Prabhakar wrote:
> > > > > > * Switched to manually turn ON/OFF the clocks instead of pm_runtime so that
> > > > > >   the mipi/dhpy initialization happens as per the HW manual
> > > > >
> > > > > That doesn't look right. The driver doesn't use runtime PM anymore, so
> > > > > power domains may not be handled properly. What was the problem with
> > > > > clock handling using runtime PM ?
> > > > >
> > > > If we use the runtime PM all the clocks will be turned ON when we call
> > > > pm_runtime_resume_and_get() which I dont want to. As per the "Starting
> > > > reception for MIPI CSI-2 Input" section 35.3.1 for example we first
> > > > need to turn ON all the clocks and later further down the line we need
> > > > to just turn OFF VCLK -> Enable Link -> turn ON VCLK. Due to such
> > > > cases I have switched to individual clock handling.
> > >
> > > If that is the case, then you should control just that clock directly,
> > > outside runtime PM callbacks.
> > >
> > > Runtime PM may be needed e.g. for resuming a parent device.
> >
> > Exactly.
> > So probably you should not consider R9A07G044_CRU_VCLK a PM clock,
> > i.e. you need changes to rzg2l_cpg_is_pm_clk() to exclude it.
> 
> Thanks for the pointer. In that case we will have to consider
> R9A07G044_CRU_VCLK and R9A07G044_CRU_SYSCLK as not PM clocks.

I like when patch review discussions continue on the list without my
involvement, and the end result is exactly what I would have advised :-)

> Does the below sound good?
> - DEF_NO_PM() macro
> - bool is_pm_clk in struct rzg2l_mod_clk.
> 
> I still have to implement it, just wanted your opinion beforehand.

Looks good to me, but I'm no expert in this area. I trust Geert's
advice.

-- 
Regards,

Laurent Pinchart
