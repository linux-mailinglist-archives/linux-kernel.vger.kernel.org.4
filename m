Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28773BB72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFWPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjFWPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B601BCC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B83B261A9C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85396C433C8;
        Fri, 23 Jun 2023 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533582;
        bh=DKp5/78a6MDj0gp2n8rZQ8Kpq++PAr8Z9nTfWBqDhQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPibgxKVFG5zFRKHsjKo1iCmOysa2QIKO28RArp6cabNYboiHhLoulzKJFa1de/xW
         tpiPw72xaaMOu53efVNwMqlkhpsSBDcfAiKOw5s6TLicUKEEcsbOrBTdeli0poaFai
         u8g0syXz1ELxOyYUzjyn3dELpCg/P/P4/i/nETx33N5uuc6k/nbbbGqu6U2nb9W9jf
         zaROPqjbKRmatQChkVsfRjp2NGm36xNqO+f/mKFztAoeoc0x7+/UD80hrI9JAUV7ux
         x2W4/Rd4I/qiB5KWE+GG9rr6unuwX3WJ7+VY17z4rffXFGSo19YNjvsdmv/LBPih0X
         WClL5Z97LCo1Q==
From:   Robert Foss <rfoss@kernel.org>
To:     dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>
Cc:     Robert Foss <rfoss@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        David Airlie <airlied@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2] drm/bridge: ps8640: Drop the ability of ps8640 to fetch the EDID
Date:   Fri, 23 Jun 2023 17:19:33 +0200
Message-ID: <168753355470.231132.10951468877350580125.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616165517.v2.1.I7b8f60b3fbfda068f9bf452d584dc934494bfbfa@changeid>
References: <20230616165517.v2.1.I7b8f60b3fbfda068f9bf452d584dc934494bfbfa@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 16:55:17 -0700, Douglas Anderson wrote:
> In order to read the EDID from an eDP panel, you not only need to
> power on the bridge chip itself but also the panel. In the ps8640
> driver, this was made to work by having the bridge chip manually power
> the panel on by calling pre_enable() on everything connectorward on
> the bridge chain. This worked OK, but...
> 
> ...when trying to do the same thing on ti-sn65dsi86, feedback was that
> this wasn't a great idea. As a result, we designed the "DP AUX"
> bus. With the design we ended up with the panel driver itself was in
> charge of reading the EDID. The panel driver could power itself on and
> the bridge chip was able to power itself on because it implemented the
> DP AUX bus.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: ps8640: Drop the ability of ps8640 to fetch the EDID
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=26195af57798



Rob

