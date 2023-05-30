Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25927716BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjE3SLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjE3SLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:11:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA54A3;
        Tue, 30 May 2023 11:11:46 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D11BA66003B0;
        Tue, 30 May 2023 19:11:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685470304;
        bh=GQF9lUAe0Utvbi867xCuwYxDhrPJXP6m2MEpKIazxXo=;
        h=From:To:Cc:Subject:Date:From;
        b=Gb34rY/H0aIJjjGOchyEPTHOzBtnXtSSUbQsHDxYhKy3LCWlhY1z4fewyDPhPSsfc
         brl+qlCTDcplTnVbe5pdI48q03dxP/JpPd1iiEJiMld3/y2STdpl+kkXHE5gUJUmEH
         kOyZ/P0lmd3mzC0+aiXvNGlEbXt4Q1ewQz5e7KTuz0+Z95Uts7A3Y2nKgSFcYnKUyR
         MYYC4keeqB9I5CEfhzMpE/cCcUpCdIpyraA2KamNxlhfOoERTiL8MmoLspVjplJyLi
         3RppIVXc8AC/rSRches7FtT+H5qT1pmZBsUWNB8mr4yliCZ9dp8loOsUc41lbOHnsZ
         /qT/mR4f+TWYw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
Subject: [PATCH v2 0/3] ES8316 audio codec fixes on Rock5B
Date:   Tue, 30 May 2023 21:11:37 +0300
Message-Id: <20230530181140.483936-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series handles a few issues related to the ES8316 audio 
codec, discovered while doing some testing on the Rock 5B board.

Changes in v2:
 - Preserved original dB gain range in PATCH 1
 - Rewrote PATCH 2 conditional statement, per Mark's review
 - Rebased series onto next-20230530
 - v1: https://lore.kernel.org/all/20230524074156.147387-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (3):
  ASoC: es8316: Increment max value for ALC Capture Target Volume
    control
  ASoC: es8316: Do not set rate constraints for unsupported MCLKs
  arm64: dts: rockchip: Assign ES8316 MCLK rate on rk3588-rock-5b

 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  2 ++
 sound/soc/codecs/es8316.c                     | 23 +++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.40.1

