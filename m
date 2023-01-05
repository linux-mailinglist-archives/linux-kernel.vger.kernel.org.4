Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46FE65F354
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjAESD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjAESDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:03:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43710564D6;
        Thu,  5 Jan 2023 10:03:47 -0800 (PST)
Received: from jupiter.universe (dyndsl-085-016-198-020.ewe-ip-backbone.de [85.16.198.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63AF46602D30;
        Thu,  5 Jan 2023 18:03:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672941825;
        bh=AjVkCvwd25Eqi7gunh0LzeJ3T0+2xIcK9Yge17EECto=;
        h=From:To:Cc:Subject:Date:From;
        b=k7KvuEVUCQtkqfAG0xuCFEC3PeX7vNU5bpGhKoYkQ99j186WwTVMrPgUPAQXdTCZf
         1zNGnMUa7ArMRvuF3mXKKMosiAA3d5rr4H3J7nsL0LifQT7IT9Nqw1TdUkvUcEbGtp
         7WhqYp5ShPNKZO3ipEj4ZDeh0eYAYFC+aCGxoJGvGqREoMtmt+7emgWST+6B396cOs
         2gqCKN+ZLPtj4IEhWpkiWNo+FaXxpX1jqiH64JTBKlyNUZ39Ew3yUnpOWoIVzF/BcH
         EeEjHFZDgjVdfDm3PgzavyQLUtsfoRQ+TAxUUCvRXitdo5oKSzDhp8zPQtRpumXDpL
         P83Xl722q7kyw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A1E21480117; Thu,  5 Jan 2023 19:03:42 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv3 0/7] RK3588 Thermal Support
Date:   Thu,  5 Jan 2023 19:03:33 +0100
Message-Id: <20230105180340.29140-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds thermal support for the new RK3588(s) SoC series. The
series has been tested on the RK3588 EVB1 board.

Changes since PATCHv2:
 * https://lore.kernel.org/all/20221031175058.175698-1-sebastian.reichel@collabora.com/
 * rebased against v6.2-rc1
 * drop useless cast from patch 1
 * add Heiko's reviewed-by to patches 1-3 & 5
 * The discussion around patch 4 died, so I kept it unchanged

Changes since PATCHv1:
 * https://lore.kernel.org/all/20221021174721.92468-1-sebastian.reichel@collabora.com/
 * Collect Reviewed-by/Acked-by
 * Use TRM channel info in commit message (Daniel Lezcano)
 * Add patch removing channel id lookup table (Daniel Lezcano)
 * Add patch allocating sensors array dynamiccaly (Daniel Lezcano)
 * I also added patches simplifying up the probe routine a bit

-- Sebastian

Finley Xiao (1):
  thermal: rockchip: Support RK3588 SoC in the thermal driver

Sebastian Reichel (6):
  thermal: rockchip: Simplify getting match data
  thermal: rockchip: Simplify clock logic
  thermal: rockchip: Use dev_err_probe
  thermal: rockchip: Simplify channel id logic
  thermal: rockchip: Support dynamic sized sensor array
  dt-bindings: rockchip-thermal: Support the RK3588 SoC compatible

 .../bindings/thermal/rockchip-thermal.yaml    |   1 +
 drivers/thermal/rockchip_thermal.c            | 322 ++++++++++++------
 2 files changed, 226 insertions(+), 97 deletions(-)

-- 
2.39.0

