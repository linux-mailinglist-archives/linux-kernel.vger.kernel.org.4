Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F15B3762
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiIIMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiIIMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E314480A;
        Fri,  9 Sep 2022 05:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E37C5B822A8;
        Fri,  9 Sep 2022 12:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B6FC433D6;
        Fri,  9 Sep 2022 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662725583;
        bh=wyT+RSE2oHYcIwAAxN7k6rwPkCm4BMGf+S0umuD69PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBqgc3wBvCesUWYOaFSVqvPibG0TlWjXeieipY3hhTeBxSYoj4x1Ndfxzn1f+HITd
         yN8VLlCxn+pr+ThxvZ1Fk9DT8rpqDqFcoPD/2b9Ai2KTvvIEiSrmiksGL4LAWWUfR4
         qEmg4H+k0qGHIGGFd2Uw131KFADN81mhBgE1JvKuhGcQ6J+hUHG8Ni05+WGomVshAk
         NlR1nW4/iXg3S/T8qQ3X0iueyhrovxA0ThwAs1PUhJBmrrR/Wz9O9pxTHzTJi+9y9A
         RIP5Ox2cQVTZZOmCYB/xxqpnGxpNE997blqsjsOdbrxxkENe+qqZRpLbuQnGjAtLqJ
         0foEurx1g3yVg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oWcsi-0001Ru-3k; Fri, 09 Sep 2022 14:13:12 +0200
Date:   Fri, 9 Sep 2022 14:13:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
Message-ID: <Yxst2PGeiQN+dL9e@hovoldconsulting.com>
References: <20220906104805.23211-1-jslaby@suse.cz>
 <Yxcvbk281f/vy4vb@hovoldconsulting.com>
 <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:19:25AM +0200, Jiri Slaby wrote:
> On 06. 09. 22, 13:30, Johan Hovold wrote:
> > On Tue, Sep 06, 2022 at 12:48:01PM +0200, Jiri Slaby wrote:
> >> This series introduces DEFINE_UART_PORT_TX_HELPER +
> >> DEFINE_UART_PORT_TX_HELPER_LIMITED TX helpers. See PATCH 2/4 for the
> >> details. Comments welcome.
> >>
> >> Then it switches drivers to use them. First, to
> >> DEFINE_UART_PORT_TX_HELPER() in 3/4 and then
> >> DEFINE_UART_PORT_TX_HELPER_LIMITED() in 4/4.
> >>
> >> The diffstat of patches 3+4 is as follows:
> >>   26 files changed, 191 insertions(+), 823 deletions(-)
> >> which appears to be nice.
> > 
> > Not really. This is horrid. Quality can't be measured in LoC (only).
> > 
> > The resulting code is unreadable. And for no good reason.
> 
> IMO, it's much more readable than the original ~ 30 various (and buggy 
> -- see Ilpo's fixes) copies of this code. Apart from that, it makes 
> further rework much easier (I have switch to kfifo in my mind for example).

Sure, but you can't have that at the cost of something that is
unreadable. Arnd's suggestions seems to improve things somewhat in this
respect, though.
 
> > [ And note that you're "saving" something like 20 lines per driver:
> 
> It's not about saving, it's about deduplicating and unifying.

It was you who brought the diff stat that up and I put this in
parentheses for a reason.
 
> > 	 12 files changed, 84 insertions(+), 349 deletions(-)
> > ]
> > 
> > NAK
> 
> I'd love to come up with something nicer. That would be a function in 
> serial-core calling hooks like I had [1] for example. But provided all 
> those CPU workarounds/thunks, it'd be quite expensive to call two 
> functions per character.

Yeah, that was even worse so no need to reiterate that.

> Or creating a static inline (having ± the macro content) and the hooks 
> as parameters and hope for optimizations to eliminate thunks (also 
> suggested in the past [1]).
> 
> [1] https://lore.kernel.org/all/20220411105405.9519-1-jslaby@suse.cz/

If that works then that should improve readability as well.

Johan
