Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF5728080
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjFHMxQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjFHMxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:53:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5982D42
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:53:07 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1q7F8D-0003bo-0V; Thu, 08 Jun 2023 14:52:49 +0200
Message-ID: <343dc13df7369ccee22f51852b3e8518e500025a.camel@pengutronix.de>
Subject: Re: [PATCH V8 0/7] drm: bridge: samsung-dsim: Support variable
 clocking
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        aford@beaconembedded.com, dri-devel@lists.freedesktop.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu, 08 Jun 2023 14:52:44 +0200
In-Reply-To: <CAHCN7xKdKGA02=ZDNQkVVVDV0AZTqd7QpHA2Nq9LNnbmK=hKxA@mail.gmail.com>
References: <20230526030559.326566-1-aford173@gmail.com>
         <e1379d94-66a5-8538-abdf-de7770befb7d@prevas.dk>
         <CAHCN7xK9RaLRSK_jSbbuGBUf14-FOHsrawi2J8G29iHSOj2Nyw@mail.gmail.com>
         <bfd050f2-b39e-c091-614e-0c77fe324435@prevas.dk>
         <CAHCN7xKdKGA02=ZDNQkVVVDV0AZTqd7QpHA2Nq9LNnbmK=hKxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 08.06.2023 um 07:30 -0500 schrieb Adam Ford:
> On Thu, Jun 8, 2023 at 6:40 AM Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
> > 
> > 
[...]
> > > Have you tried using modetest to see what refresh rates are available?
> > 
> > Hm. My userspace may be a little weird. When I run modetest I just get
> > 
> > trying to open device 'i915'...failed
> > trying to open device 'amdgpu'...failed
> > ...
> > trying to open device 'imx-dcss'...failed
> > trying to open device 'mxsfb-drm'...failed
> > no device found
> > 
> 
> One the 8MP, I think you need to append "-M imx-lcdif" to the modetest
> command  to specify the driver being used.
> I don't have my 8MP with me right now, but I think that's the right name.

That's correct. Alternatively update libdrm to >= 2.4.114, which knows
to look for this driver in the tests.

Regards,
Lucas
