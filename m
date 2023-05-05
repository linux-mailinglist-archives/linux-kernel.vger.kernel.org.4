Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA36F8882
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjEESOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEESOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE902D63
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A47163FB6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31340C433EF;
        Fri,  5 May 2023 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683310458;
        bh=0BxOsweHAsdSWwpMc1VYAmtq0gF5pxlUHWsC8Y24ZNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNwdu0OIW76KAjenXjaZsiXJVTDfeFjpl86Xt688+csW3DdJtQwgf6gxvWIARc8It
         9NyALEij4thtsMl73Ex5Ifl6tupPOhAAg/FB613jKLtcLpSfrMTRd4IsxHBcsSMPBY
         x/8pwCGWR5fTK1v/x6mQkIA0y4sUFrLqTHgdkIujCHID1cOT1Yxzp/3oo0tniWgDhJ
         BvxKMzAN+lL/5ajjRkyNYRRDJDZQg/mVjbZzmoh4SScw0O08EDXCMg50VPS5O2PE3C
         PrgWjZ/Okqhy8Q1Azsg3Y38W7QXMwfmwTf9BLA9qnE/OkVGMXZSaOA+romMGy8+XUx
         51J/o3fLoDWoA==
From:   rfoss@kernel.org
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        tomi.valkeinen@ideasonboard.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>
Cc:     Robert Foss <rfoss@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/9] drm/bridge: tc358768: various fixes on PLL calculation and DSI timings
Date:   Fri,  5 May 2023 20:14:11 +0200
Message-Id: <168331044052.921601.10791583333930906104.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230427142934.55435-1-francesco@dolcini.it>
References: <20230427142934.55435-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <rfoss@kernel.org>

On Thu, 27 Apr 2023 16:29:25 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This series includes multiple fixes on the tc358768 parallel RGB to DSI driver.
> 
> With the following changes I am able to have a stable display output using a TI
> SN65DSI83 (DSI-LVDS bridge) and a 1280 x 800 LVDS display panel and the
> register values are coherent with Toshiba documentation and configuration
> spreadsheet, I was not able to test any other display sink.
> 
> [...]

Applied, thanks!

[1/9] drm/bridge: tc358768: always enable HS video mode
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ee18698e212b
[2/9] drm/bridge: tc358768: fix PLL parameters computation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ee18698e212b
[3/9] drm/bridge: tc358768: fix PLL target frequency
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ee18698e212b
[4/9] drm/bridge: tc358768: fix TCLK_ZEROCNT computation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ee18698e212b
[5/9] drm/bridge: tc358768: fix TCLK_TRAILCNT computation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ee18698e212b
[6/9] drm/bridge: tc358768: fix THS_ZEROCNT computation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=77a089328da7
[7/9] drm/bridge: tc358768: fix TXTAGOCNT computation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3666aad8185a
[8/9] drm/bridge: tc358768: fix THS_TRAILCNT computation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bac7842cd179
[9/9] drm/bridge: tc358768: remove unused variable
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=e4a5e4442a80



Rob

