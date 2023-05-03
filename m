Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254546F59E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjECOXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjECOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:23:13 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5527E7692
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:22:39 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id E7DE720012;
        Wed,  3 May 2023 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1683123757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uwxo62b1FjDP4W7+iA0HCFX6QqvdaT3I2gnswLMerSk=;
        b=FB08IkDN48YJRRLSHfeNgGlOMZREE3ZUEkFby9Cv+aGnB/sZq08iCFL8Edlmh++pWVjiRb
        MwWxNKoeEGR7QKMyaWPb6jQO7qUvatbqu8ndXhE18UPCFjxqQhQo9HOi4T7YxIBXimgSot
        mRuRo9cxs5euEITFQ0KBEIGmqki143DSaSn6gyFFviGrOoI5UHXXBTtEglILF2Vkt9zQue
        0+DLIhORCVQ0x0/0EmHZHgHeFV8qilx4njBppMlLW6EFR78prU0j1bVFYK+x1wN/c4A4Ct
        V9DyAoB0Ztbdh/IrN8ZO9bEt/LfRMl37aItpqkPTxYclousaDuRpOCMWONd8yg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 03 May 2023 16:22:32 +0200
Message-Id: <CSCPKPC8OB80.1TTBCM3YDVJQ5@void.crly.cz>
Subject: Re: [PATCH v2 0/7] drm: sun4i: set proper TCON0 DCLK rate in DSI
 mode
From:   "Roman Beranek" <me@crly.cz>
To:     "Frank Oltmanns" <frank@oltmanns.dev>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>
Cc:     "Chen-Yu Tsai" <wens@csie.org>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Samuel Holland" <samuel@sholland.org>,
        "Ondrej Jirman" <megi@xff.cz>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230418074008.69752-1-me@crly.cz>
 <87cz3uzpx1.fsf@oltmanns.dev> <87mt2o9njh.fsf@oltmanns.dev>
In-Reply-To: <87mt2o9njh.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I apologize for my absence from the discussion during past week, I got
hit with tonsillitis.

On Mon May 1, 2023 at 3:40 PM CEST, Frank Oltmanns wrote:
> Looking at ccu_nkm_determine_rate(), we've found our culprit because it
> does not try parent clock rates other than the current one. The same
> applies to all other ccu_nkm_* functions.

Yes, that's why I dropped CLK_SET_RATE_PARENT from pll-mipi in v3.

>  b. Add functionality to ccu_nkm_* to also update the parent clock rate.
>
> I'm actually interested in tackling b, but I can't make any promises as
> to if and when I'll be able to solve it. I'm not certain about any side
> effects this might have.

It sounds like an interesting exercise. But what if HDMI is then added
to the mix?

Best regards
Roman
