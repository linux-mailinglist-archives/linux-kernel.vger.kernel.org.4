Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A338371190D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjEYV16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEYV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:27:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2ACD3;
        Thu, 25 May 2023 14:27:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59D656601F54;
        Thu, 25 May 2023 22:27:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685050069;
        bh=dP+0YR0RnQxfWF3b6qBWLSWc9N7BIfuDH1T6X6tTKTI=;
        h=From:To:Cc:Subject:Date:From;
        b=cEFU5gjHsRkaTMKoERUZBnhYoVu+4ax17TQxCAKp9CIg3LbiC0eVwgVuaz/9JNjxs
         FC9aA9/Oo9pabfPQ9UsLyibIscCtcJnOy9c7YSKpvVmS4HG2Gq5D2ixzpSb8B3bK+V
         E9L7eZ6B5geX1ThOQC4Xp/2qFcL4VP65YVtnmMFJ8Hh/aOnxHxoDKRPLla0DD/MeEo
         vcPRdMeGPHLKG73T7NHv3sHEZSX0g6Txa5ZQzUFxUU4r/Pv9XOUIZzJN97UfkfFJFz
         qgRy8WpExsMydsMOOT17LNKDmLmQNJkj+1YJ1/3Sf5I3OdMFa1aw0cUXScDvNXx52U
         gt3hQGiwtCtvg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 0/8] RK3588 ADC support
Date:   Fri, 26 May 2023 02:57:04 +0530
Message-Id: <20230525212712.255406-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
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

This patch series adds ADC support for RK3588 and updates
the DT bindings for the same.

To test ADC support on Rock 5B board, a voltage divider circuit
was created using the gpio pin 22 ( SARADC_IN4 ) and few more
tests were ran for testing the buffer and trigger support using
the iio_generic_buffer tool.


Changes in v2
  - Add from address in patches 1 and 2.
  - Create separate patches for adding new device support and changes to
    the old device code.
  - Make use of FIELD_PREP in patch 2.
  - Move the enablement of clocks at it's original position in patch 3
  - Add Reviewed-by tag in patches 4 and 5.
  - Add an Acked-by tag in patch 8.

Shreeya Patel (8):
  iio: adc: rockchip_saradc: Add callback functions
  iio: adc: rockchip_saradc: Add support for RK3588
  iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled
  iio: adc: rockchip_saradc: Use of_device_get_match_data
  iio: adc: rockchip_saradc: Match alignment with open parenthesis
  iio: adc: rockchip_saradc: Use dev_err_probe
  arm64: dts: rockchip: Add DT node for ADC support in RK3588
  dt-bindings: iio: adc: Add rockchip,rk3588-saradc string

 .../bindings/iio/adc/rockchip-saradc.yaml     |   1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  12 +
 drivers/iio/adc/rockchip_saradc.c             | 262 +++++++++++-------
 3 files changed, 168 insertions(+), 107 deletions(-)

-- 
2.30.2

