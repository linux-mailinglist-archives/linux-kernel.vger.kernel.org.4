Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF3613C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiJaRvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiJaRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:51:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6674A63F4;
        Mon, 31 Oct 2022 10:51:03 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-157-181.ewe-ip-backbone.de [95.33.157.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67D0766028C0;
        Mon, 31 Oct 2022 17:51:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667238661;
        bh=LclkUUUuQEL6XWTDbjHN/M93uQibLqIJXoKjFuEGbjU=;
        h=From:To:Cc:Subject:Date:From;
        b=hte6YTXwfWRFfuipTNvRM0vUkZH2ZsvcAYCJui+c/S6n+HrHHVWg+xvej9zswIsKY
         0zlWBz1gIhd5V1E94rG6dEzcFNJyqTNew+8FCf6GbGZpOYWvd+EVSfJNf+baD99L/1
         NmDCuTWbg65Ws5w6mt+VvHb/aDw943mCsEodJeh5u7Y677/cPPni1lDdCHIQrigCBq
         sgIGBqxWTufrBHww9REvEqMiUQN+pAGq6qTFpBwJ8V/Sxxd3lRU6N0VvXCEHRlPLjJ
         di2b7va07Wo+Nh12A8olWkxj7CoptG6dc+mrAwZ5tlytzg4PJHcgqUc9kF+yZ3T3F1
         0Km0E2YJ0gylA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4B9214801B7; Mon, 31 Oct 2022 18:50:59 +0100 (CET)
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
Subject: [PATCH 0/7] RK3588 Thermal Support
Date:   Mon, 31 Oct 2022 18:50:51 +0100
Message-Id: <20221031175058.175698-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
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

This adds thermal support for the new RK3588(s) SoC
series. The series has been tested on the RK3588
EVB1 board.

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
2.35.1

