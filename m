Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88246725531
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbjFGHPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbjFGHOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:14:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43087E62;
        Wed,  7 Jun 2023 00:14:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9786fc23505so233654466b.2;
        Wed, 07 Jun 2023 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686122091; x=1688714091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uSuufyMcsyCNhc9935w8FFk8/YUkDDPohUMbAYt6SfI=;
        b=ilhgOo6QT90fgsgn+CEW5VvsdcWWOHZfG6Qs1Ms6smfWNMDfUSvmVi+ObuVkmXUXYA
         Y78FMCqjMP6r6TLAXorocecwYVAKnluhtQh4mV/rVABUWyG33HJvDp5Zd6ezMPeGbpzC
         zymQ239q26nE/Uu3Sidy5M/pr8+4AFbr47qpRMpvi+p0r8ri9IqCCPSCFWiOoqC5g4aC
         CvYDGAFPcygcrDuRg2QGwJ6Zu/xt14fDrKtrzfsN20OMkjSVUxNg+jSXU3CnMkk3P1Z3
         NiAKmPC+IxJKn9nkWeQWNo3W8ey5K7ztAUgW1SUs3N/3licrEOjcxwzas+pD0PwZZp+H
         AbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686122092; x=1688714092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSuufyMcsyCNhc9935w8FFk8/YUkDDPohUMbAYt6SfI=;
        b=DNiJYaAsa36ky9N/UlxXTr0FRpmDHrHqS/AswwZ0Gz4OIRFL4uKYG/OUIPxJO7Ddf4
         PztPckV19zewpKntdRZvxXGsWl+jXe94KmLnuMcDZPlsUXK/SYstjml0nBceHyvNAGWc
         y8HQd/QLkcSGFLxbCgfLMVms1TGF1W5vscZdIdz6pfqwI6qp3gDgunKNL0W6JLb/U4ey
         vudGVsEYZT9cXpGg9xCHcDRQmWr4gd3+v/VzbaT2RM4X2ci7CagvX4TD/+5mQtQYPEJo
         LKzf2QdeHFFUGrwxIIevSLg4U7xjzGor+FL2iaj5i/HkMiRj3mknXBzpIVHLnBbatFne
         AqUw==
X-Gm-Message-State: AC+VfDyA2H990jOBGhKDl27gCAiugpoD9URcQKUVO7rCgZ2/zbbzdudl
        avZ6qWfUjp7+km5dxaw1h4U=
X-Google-Smtp-Source: ACHHUZ5RsUVyMc7PHaB7qrI4ubSnR5YtnP5RqWnK43pw5t0wCpMbIO2L6kFAJF1hXn1DJDM+JcZFKQ==
X-Received: by 2002:a17:907:c1e:b0:973:e349:43c9 with SMTP id ga30-20020a1709070c1e00b00973e34943c9mr5805150ejc.77.1686122091313;
        Wed, 07 Jun 2023 00:14:51 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id xo21-20020a170907bb9500b00965ffb8407asm6504007ejc.87.2023.06.07.00.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:14:50 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:14:48 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZIAuaF/5Aib1DoQ+@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-3-tomm.merciai@gmail.com>
 <20230606163656.GI25679@pendragon.ideasonboard.com>
 <20230606-jaundice-womankind-7e583789fb7a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-jaundice-womankind-7e583789fb7a@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thanks for your feedback.

On Tue, Jun 06, 2023 at 07:07:42PM +0100, Conor Dooley wrote:
> Hey Laurent, Tommaso,
> 
> On Tue, Jun 06, 2023 at 07:36:56PM +0300, Laurent Pinchart wrote:
> > On Tue, Jun 06, 2023 at 05:54:03PM +0200, Tommaso Merciai wrote:
> 
> > > +  alliedvision,lp2hs-delay-us:
> > > +    maxItems: 1
> > > +    description:
> > > +      Low power to high speed delay time in microseconds.
> > 
> > You can drop "in microseconds", that's implied by the suffix.
> > 
> > > +      The purpose of this property is force a DPhy reset for the period
> > > +      described by the microseconds on the property, before it starts
> > > +      streaming. To be clear, with that value bigger than 0 the Alvium
> > > +      forces a dphy-reset on all lanes for that period. That means all
> > > +      lanes go up into low power state. This may help a csi2 rx ip to
> > > +      reset if that IP can't deal with a continous clock.
> > 
> > I'd like to propose what I think is a clearer version:
> > 
> >     description: |
> >       Low power to high speed delay time.
> > 
> >       If the value is larger than 0, the camera forces a reset of all
> >       D-PHY lanes for the duration specified by this property. All lanes
> >       will transition to the low-power state and back to the high-speed
> >       state after the delay. Otherwise the lanes will transition to and
> >       remain in the high-speed state immediately after power on.
> > 
> >       This is meant to help CSI-2 receivers synchronizing their D-PHY
> >       RX.
> 
> Question about the property.
> Why not make it have a minimum value of 1 and drop the special-case
> behaviour for zero?

Personally I prefer to stay with zero case.
This reflect better the real camera register behaviour.

(also is optional)

Thanks! :)
Tommaso

> 
> Cheers,
> Conor.


