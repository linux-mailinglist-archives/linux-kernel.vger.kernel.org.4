Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B40F705AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjEPXCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEPXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:02:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442972B6;
        Tue, 16 May 2023 16:02:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3AB98660322D;
        Wed, 17 May 2023 00:02:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684278162;
        bh=zxx/0uLHIiU/dV4bb646/T74e4BDMJ4Bb1ejBv5KV0w=;
        h=From:To:Cc:Subject:Date:From;
        b=kduFv+PCqztIKtviaxymKsO7g3OzFC6kl3N+qEgVpTWLRW7wRfH7HlRuJhfPhzYOY
         gGUPzcy6uK1oC6LzCB6PDtyeQkPj2A8fGIdHeyElTpUvWZ9GzXHvxC+j82HQw6h5cO
         vR4R2Pb7NhKORf16ioZaS6VFPVuE76pNzbp/+XqKAo+SVah6G24U9SbuUh50r/uUT8
         FNf9Dkh+7Xg4fvBnG+f9B0tiWAQC+ppFPPCjOoNQvKl4SslOGs4w5rIFAADAP5Tq2i
         T+TIlGtUWNQc1+QWEghzYxjamLLwnlHQHHUWeIUCehI/vsOejaLf0PXmtM3kR2hF3o
         Sqtc/4rU0Xz6g==
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
Subject: [PATCH 0/7] RK3588 ADC support
Date:   Wed, 17 May 2023 04:30:44 +0530
Message-Id: <20230516230051.14846-1-shreeya.patel@collabora.com>
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
tests were ran for testing the buffer and trigger using the
iio_generic_buffer tool.

Shreeya Patel (7):
  iio: adc: rockchip_saradc: Add support for RK3588
  iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled
  iio: adc: rockchip_saradc: Use of_device_get_match_data
  iio: adc: rockchip_saradc: Match alignment with open parenthesis
  iio: adc: rockchip_saradc: Use dev_err_probe
  arm64: dts: rockchip: Add DT node for ADC support in RK3588
  dt-bindings: iio: adc: Add rockchip,rk3588-saradc string

 .../bindings/iio/adc/rockchip-saradc.yaml     |   1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  12 +
 drivers/iio/adc/rockchip_saradc.c             | 260 ++++++++++--------
 3 files changed, 164 insertions(+), 109 deletions(-)

-- 
2.30.2

