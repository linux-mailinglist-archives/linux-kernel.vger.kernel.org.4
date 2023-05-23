Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1470E313
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjEWRWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjEWRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:22:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C1218E;
        Tue, 23 May 2023 10:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C78634FC;
        Tue, 23 May 2023 17:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C999C4339B;
        Tue, 23 May 2023 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862516;
        bh=VonElC8wOqM+LDZvf96EDpTmmf7XGYZNo7lSoNX7MvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgkgY52gosRPlhPkg1lcyCVYJ7yXg4hXYtHMPyRd+JWfGqeP3zQeyTWwo5IeHQaJx
         l2+hWw/h7dl8814tBajCwHeIUSsuF/F+uHBAjWsl4vZ2UKSgMi3zo7ZrwiXm6FBVw0
         qsODYwcepkXjxczxys9GWoEK1o5Ph091t9Q8glEncAhOhas2VdeLt0FFO5qXFMBAAN
         fHLf3iBrfZYxhTfJW9HplhGaLGPEAmc5ec6M2jLvUZfFfwzVe8s/af3IloZ075S803
         wTji+8LNmZpOy934aXtQGDd8qxCTWU7uOdZqGti42iYO5V/dYdnInZPxg4CXbecNwk
         4uju8eX08/OtA==
From:   rfoss@kernel.org
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Guillaume BRUN <the.cheaterman@gmail.com>,
        linux-hardening@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 19:21:49 +0200
Message-Id: <168486250045.3617730.17499429425987433532.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522155210.2336690-1-azeemshaikh38@gmail.com>
References: <20230522155210.2336690-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <rfoss@kernel.org>

On Mon, 22 May 2023 15:52:10 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: dw-hdmi: Replace all non-returning strlcpy with strscpy
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=37cee4876a45



Rob

