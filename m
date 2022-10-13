Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE8E5FD81D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJMLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMLI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:08:58 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB3210CFB8;
        Thu, 13 Oct 2022 04:08:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3756880FC;
        Thu, 13 Oct 2022 11:00:04 +0000 (UTC)
Date:   Thu, 13 Oct 2022 14:08:54 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Message-ID: <Y0fxxsk+e2o0wYZV@atomide.com>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
 <Y0UDEtQlN5Y9h7BU@atomide.com>
 <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
 <Y0V4cLGbYe4j+ls6@google.com>
 <Y0V99Agad6Ma+yTC@atomide.com>
 <Y0V/82JsRVZh6PlL@google.com>
 <Y0WCCw8k+KTuvdWX@atomide.com>
 <41373c20-3b97-ac47-81c8-75bf1bbe3a38@ideasonboard.com>
 <Y0cVw63d3+pAVbd2@google.com>
 <b56197a1-f23d-5f8a-b32d-f8787586364e@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b56197a1-f23d-5f8a-b32d-f8787586364e@ideasonboard.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> [221013 06:13]:
> I would just go with the above for the time being. It should be an easy
> change, and as these omapfb and drm panel drivers are kind of copies of each
> other, I think it makes sense to use the same code in both.

Maybe if a fix is needed, sure let's fix things first, then drop
the unused panel drivers.

We already have drivers/gpu/drm/panel driver for both of these two
omapfb panels:

drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c

The compatible strings used translate to these dts files:

arch/arm/boot/dts/motorola-mapphone-common.dtsi
arch/arm/boot/dts/omap3-n900.dts
arch/arm/boot/dts/omap3-n950.dts
arch/arm/boot/dts/omap4-sdp.dts

These devices work with omapdrm and there should not be any need to
stick with the omapfb driver. We can just drop the omapfb panel
drivers for panel-sony-acx565akm.c and panel-dsi-cm.c. Let's put
the limited effort where there is activity instead :)

The vrfb rotation work has been discussed on the lists, so seems
like we will eventually have that for omapdrm. Meanwhile, software
rotation is being used for postmarketos and leste with omapdrm
AFAIK.

> That said, I personally don't mind fixing the dts files and the drivers, and
> even dropping the omapfb panel drivers. However, as I don't know if someone
> needs the omapfb drivers or has to use an old dtb, I don't want to step on
> that possible mine field. If someone else wants to go there (without my
> involvement), fine for me =).

I belive the only valid use case for omap2 omapfb is the n8x0 rfbi
driver that has no omapdrm driver.

Regards,

Tony


