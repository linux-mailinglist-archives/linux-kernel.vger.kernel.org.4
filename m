Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC67082B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjERNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjERNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:30:58 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB881A2;
        Thu, 18 May 2023 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fRqoAfEGrb69vxhTSyLB10x+JE5MQ4XwObAsHGXg2dw=; b=QT8cOkj6ZnwlK7KEFGou1i0Ims
        a/OgxDUpB5KbydZR+HtiBc1t8bql/2eVlQ11ToWwMVibuBWJuOZz7IxC5jJ+6kZdkEyoGu3kIwOdc
        wkKTzz3e4KrRVVQgo32dSpon6qaQcpPaMNyEKD65h0het0ZopPO8/72W31hn0FGrVnRY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55638 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pzdiT-0004VO-SJ; Thu, 18 May 2023 09:30:50 -0400
Date:   Thu, 18 May 2023 09:30:49 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230518093049.1e1cdf9561ea326f4655af02@hugovil.com>
In-Reply-To: <20230517-argue-unbeaten-b07405fdd313@spud>
References: <20230517150746.3823249-1-hugo@hugovil.com>
        <20230517-argue-unbeaten-b07405fdd313@spud>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH 1/2] dt-bindings: sc16is7xx: Add property to change GPIO
 function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 18:25:07 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, May 17, 2023 at 11:07:46AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Some variants in this series of uart controllers have GPIO pins that
> > are shared between GPIO and modem control lines.
> > 
> > The pin mux mode (GPIO or modem control lines) can be set for each
> > ports (channels) supported by the variant.
> > 
> > This adds a property to the device tree to set the GPIO pin mux to
> > modem control lines on selected ports if needed.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../bindings/serial/nxp,sc16is7xx.txt         | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > index 0fa8e3e43bf8..426b7285ad50 100644
> > --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > @@ -23,6 +23,9 @@ Optional properties:
> >      1 = active low.
> >  - irda-mode-ports: An array that lists the indices of the port that
> >  		   should operate in IrDA mode.
> > +- modem-control-line-ports: An array that lists the indices of the port that
> > +			    should have shared GPIO lines configured as modem
> > +			    control lines.
> 
> If this is an NXP specific property, should it not have an nxp, vendor
> prefix?

Yes, I will resubmit a V2 with nxp vendor prefix.

Hugo.
