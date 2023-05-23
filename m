Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB7070E350
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjEWRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEWRSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA39B5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C366634F5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4702AC433D2;
        Tue, 23 May 2023 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862313;
        bh=QAmV/MySDa38HeQ4kzqqa+UgwdNEFUnttUtX/X1Giyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPlBr/depd8TepfUxwlsGQCIMwPFvotBMqlw6tLwHNBLAZikk1as1KFpfXgANutTm
         ymQAB6mhACNF4ENADO93aYAW1VXPN2MqSNvpRINc8C9wPQf9kuGO5d42mbppgfNiza
         rncT0B7psiSiYMwS6YKDv74JfC3bifzfni9Nc8OJngJqn8pX3R6ciFIqJyhE7SvFkT
         BfeKpF5vXOPfB70NghMNiZ0KgmDx+Ut1RiomAx5n2UWAic3FLHUFZP3FQxGGrYPolP
         4iYduFlAmjV6hMjS+mKSJjT+0KVrCZ0RcvElIiHswX/9/E/lz0Pb8NGQiiCgVQgGKp
         vORyhHZhAW4Lw==
From:   rfoss@kernel.org
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Cc:     Robert Foss <rfoss@kernel.org>, Xin Ji <xji@analogixsemi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        owen <qwt9588@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pin-yen Lin <treapking@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] drm/bridge: anx7625: Prevent endless probe loop
Date:   Tue, 23 May 2023 19:18:24 +0200
Message-Id: <168486229619.3612901.1076023158254701111.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518193902.891121-1-nfraprado@collabora.com>
References: <20230518193902.891121-1-nfraprado@collabora.com>
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

From: Robert Foss <rfoss@kernel.org>

On Thu, 18 May 2023 15:39:02 -0400, Nícolas F. R. A. Prado wrote:
> During probe, the driver registers i2c dummy devices and populates the
> aux bus, which registers a device for the panel. After doing that, the
> driver can still defer probe if needed. This ordering of operations is
> troublesome however, because the deferred probe work will retry probing
> all pending devices every time a new device is registered. Therefore, if
> modules need to be loaded in order to satisfy the dependencies for this
> driver to complete probe, the kernel will stall, since it'll keep trying
> to probe the anx7625 driver, but never succeed, given that modules would
> only be loaded after the deferred probe work completes.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: anx7625: Prevent endless probe loop
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1464e48d69ab



Rob

