Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5749961FC53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiKGR5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiKGR4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:56:22 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 09:54:32 PST
Received: from mailrelay2-2.pub.mailoutpod1-cph3.one.com (mailrelay2-2.pub.mailoutpod1-cph3.one.com [46.30.212.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9712611F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:54:31 -0800 (PST)
Received: from mailrelay1.pub.mailoutpod2-cph3.one.com (mailrelay1.pub.mailoutpod2-cph3.one.com [104.37.34.6])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPS
        id 15347bb4-5ec5-11ed-a925-d0431ea8a290;
        Mon, 07 Nov 2022 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=SLyAxHhS6Hp5u+fEweOLsy65p6aKk/bAOsQqjWK82MY=;
        b=pLvJx/ARXL8BUweavzGmY9yhuhJx4ANZhYhH4Ey7652wAuZsu+XXmrHfCZChe9vHlBlsG4CyCXtlj
         hrEzdHnBkt6ZFdGqw39l2g6UAHJorZWQzSmsPJInytNFbwdsZYXSeaZC1sVxd6BMymOznpK85oX0WP
         ijjDs8Qq4xSeEVCXZC+uzQRTVDiVem49GueY0Fm9B1h05u7kzq22IaV0WSXPdI5ugdhVkuenpGuJg9
         f3lzeDjbPYxYeJ062zih9F5sXp9ibWKdODp6lwDQlwI883o74pzp1xEtIr9tWCoFpNHFWo8hwxTTK6
         bXGgJua39P8SwRBu/4WPu+/abuydNxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=SLyAxHhS6Hp5u+fEweOLsy65p6aKk/bAOsQqjWK82MY=;
        b=WySIdHcNNGMTnlpGu4csUpXl6pOQ2/QYNqYWjoAIHij0UYRD0CbpxoQjInz/WdK/+LR0doOYDL455
         BGnDrH3Ag==
X-HalOne-ID: 13afeb26-5ec5-11ed-ba33-1b2345786432
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 13afeb26-5ec5-11ed-ba33-1b2345786432;
        Mon, 07 Nov 2022 17:53:27 +0000 (UTC)
Date:   Mon, 7 Nov 2022 18:53:25 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/26] drm: atmel-hlcdc: Remove #ifdef guards for PM
 related functions
Message-ID: <Y2lGFZi+VHZCRvGN@ravnborg.org>
References: <20221107175106.360578-1-paul@crapouillou.net>
 <20221107175106.360578-9-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107175106.360578-9-paul@crapouillou.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 05:50:48PM +0000, Paul Cercueil wrote:
> Use the DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to handle
> the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks for taking care of this.

	Sam

