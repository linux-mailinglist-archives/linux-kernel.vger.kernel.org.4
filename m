Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6E72280D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjFEOCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjFEOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4709C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3413614C3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E84C433D2;
        Mon,  5 Jun 2023 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685973716;
        bh=fM/dkrSRD7/GVqUEkCT3DJ78pRRjkLSS3NGE52m4So0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLIT+NRa6oO4LUWduQsq29/1p9VLtdYIDFqvtwN7SouW50eNBIDCdXuJUOT77t+p9
         XS8AQfLrTuQZNYRhoBd+Xzzdro9EDQCr663/bgyTunCpLO3pVdNS4nZmbW1GlN9b6B
         cFrVTmh/SAGAX/iz37rYUrg5emNsot2xaA2A7Jfy16x4r8jLcM15sXRc3OonaR5/WQ
         nRPRA+Q460+4tPz2k1Qkwq3CiPHS8kbT7GKAhG/3AlgmGc0wsvyuRrRWYoAoruFwz9
         DekIDhQUmh8QW8+yM6RQ3+R8R6UmmWWZGz3dhh+uIj66CmPqFagGMNN+7yC0Ylx9LQ
         I7xiqo+Rg5Chw==
From:   rfoss@kernel.org
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Robert Foss <rfoss@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liu Ying <victor.liu@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] drm/bridge: imx: fix mixed module-builtin object
Date:   Mon,  5 Jun 2023 16:01:46 +0200
Message-Id: <168597369975.1230687.5029067502371454652.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605120021.1774711-1-masahiroy@kernel.org>
References: <20230605120021.1774711-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <rfoss@kernel.org>

On Mon, 5 Jun 2023 21:00:20 +0900, Masahiro Yamada wrote:
> With CONFIG_DRM_IMX8QM_LDB=m and CONFIG_DRM_IMX8QXP_LDB=y (or vice
> versa), imx-ldb-helper.o is linked to a module and also to vmlinux
> even though the expected CFLAGS are different between builtins and
> modules.
> 
> This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
> Fixing mixed module-builtin objects").
> 
> [...]

Applied, thanks!

[1/2] drm/bridge: imx: fix mixed module-builtin object
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a272cadbd883
[2/2] drm/bridge: imx: turn imx8{qm,qxp}-ldb into single-object modules
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=013413cdfeec



Rob

