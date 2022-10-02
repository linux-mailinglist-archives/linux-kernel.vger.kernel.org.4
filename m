Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00C5F2193
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJBGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 02:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBGps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 02:45:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C92D1D3
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 23:45:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lh5so16498124ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8DoxyrrNurSSCa9HyAR/BM9iY3WZi9m5+lPpxJ0Uuwo=;
        b=PODqI7EtFcGiZpzJBCGkv4ktWLDnRU9EOapB6eH3P9+9XM5qNC7Gyoku5e5dYaCD2k
         5lPV1udTtxuYEW3Ye2pn7Gs3ljboJN3ezbSriC7kNh3YWMNL5jZZ+UhsX97qVqmjXXhk
         SCvB0/xkHPFxkHg+UK1Icwm5mHCknJ219+W+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8DoxyrrNurSSCa9HyAR/BM9iY3WZi9m5+lPpxJ0Uuwo=;
        b=iiY8bUm0eBhhOFAT6MSymqstO8Ia4c7diagjbTby+NxYUjTZ57R2MymRLUSnRLRET5
         PXeZbR/qBGtM3JYfsp+lhborHIxrKlaxdLBaPg5TLRCEx9qae1X2o5ivDmgdBXMji+7w
         L/kFRuvvp6G1gU0uJuN1luyIqnr0aUbYey5YVI90ZLqT8UpyJZKuNf+zb9D7JkzGH6bk
         ONNUOqOpCk/nVSePwt/EZNIGsrG45zOFZCTKlwiOBFj9DGJf6IG90f2P0LIbQ3XCT3I6
         921oNmWkl9KCwrx+dWoIZkgx+ZCOPrkA+ERpZKkTAf8DAB4Q9zzMPiL/iufA5LWTo/c4
         LwVQ==
X-Gm-Message-State: ACrzQf2N+xEWauDZyabY4DzxdSKKlpJfvAffm7B1a+gN9D74i1Woi613
        GxkJ894gLZDp8hn69jUHiKNNkg==
X-Google-Smtp-Source: AMsMyM4/ckulTLgZqHNHnMxdJWtdBMFlK4rffsHgscSLjCkKU2bBfQg8KGjFilHHLfjxdWmKDWM1aQ==
X-Received: by 2002:a17:906:5d16:b0:783:78d5:e47a with SMTP id g22-20020a1709065d1600b0078378d5e47amr11572855ejt.453.1664693143152;
        Sat, 01 Oct 2022 23:45:43 -0700 (PDT)
Received: from panicking.. ([109.52.206.103])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906329a00b0077f5e96129fsm3569894ejw.158.2022.10.01.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 23:45:42 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amarula@amarulasolutions.com
Subject: [RFC PATCH 0/4] Add RGB ttl connection on rockchip phy
Date:   Sun,  2 Oct 2022 08:45:36 +0200
Message-Id: <20221002064540.2500257-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip phy can be convigured in ttl mode. The phy is shared
between lvds, dsi, ttl. The configuration that now I'm able to support
has the display output on some set of pins on standard vop output
and a set of pins using the ttl phy. The solution is not clean as I
would like to have because some register that are used to enable
the TTL, are in the same register area of the dsi controller.
In order to test I must add the following

dsi_dphy: phy@ff2e0000 {

	reg = <0x0 0xff2e0000 0x0 0x10000>,
		<0x0 0xff450000 0x0 0x10000>;
	...
}

The problem here is the second region I have added is the same of
dsi logic. Only one register is needed by the the phy driver

Michael Trimarchi (4):
  phy: add PHY_MODE_TTL
  phy: rockchip: Add inno_is_valid_phy_mode
  phy: rockchip: Implement TTY phy mode
  drm/rockchip: rgb: Add dphy connection to rgb output

 drivers/gpu/drm/rockchip/rockchip_rgb.c       | 18 +++++
 .../phy/rockchip/phy-rockchip-inno-dsidphy.c  | 72 +++++++++++++++++++
 include/linux/phy/phy.h                       |  3 +-
 3 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.34.1

