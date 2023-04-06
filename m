Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542DE6D9E51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbjDFRSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:18:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288BA4C08;
        Thu,  6 Apr 2023 10:18:12 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8EFE366031C8;
        Thu,  6 Apr 2023 18:18:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680801490;
        bh=2AfLYbNSjfZV3YG3Ai3MasSQj9DQevx49CcK7v80Dvo=;
        h=From:To:Cc:Subject:Date:From;
        b=W+or+1/PaZ75ACKxUhiQGDStPhwVkMVgQOg/sgIjdggf3wOoesYySOA5vOMTGoHgK
         eAsWWmkH0SWvqsQ7ERV+KpRWprDkw/GgDPqmIMRkVITyNzaJW2kSUBykfCrNsaNrV8
         fCrFOkF+fJwPnWo57yuf5bAmBU0mrtNCSIkEzbEFQXCDDKp81/elsPclGNZz0CqP/p
         FtwPcci4pVNqtyc75CMW6DENLP1AGuCET4iec+WB12AsHPR8wgnzOJeSOuNb3ETFUu
         mwWTCTsJT0xhyWulm6LwNPetqPEqsQsYa/L3xT7y7pszKBYLRg+ttZ9Z16HMWLNWms
         x2HFHr9ADc1vg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 0/8] Add support for Rockchip RK860X regulators
Date:   Thu,  6 Apr 2023 20:17:58 +0300
Message-Id: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces support for the Rockchip RK860X regulators, 
while also providing a few fixes and improvements to the existing fan53555 
driver.

RK8600/RK8601 are fully compatible with the FAN53555 regulators.

RK8602/RK8603 are a bit different, having a wider output voltage
selection range, from 0.5 V to 1.5 V in 6.25 mV steps. They are used 
in the Rock 5B board to power the ARM Cortex-A76 cores and the NPU.

Changes in v2:
 - Dropped the rk8601 and rk8603 entries from the device_id arrays 
   in PATCH 8/8 and updated the bindings accordingly in PATCH 1/8,
   per Krzysztof's review
 - v1: https://lore.kernel.org/lkml/20230405194721.821536-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (8):
  regulator: dt-bindings: fcs,fan53555: Add support for RK860X
  regulator: fan53555: Explicitly include bits header
  regulator: fan53555: Fix wrong TCS_SLEW_MASK
  regulator: fan53555: Remove unused *_SLEW_SHIFT definitions
  regulator: fan53555: Make use of the bit macros
  regulator: fan53555: Improve vsel_mask computation
  regulator: fan53555: Use dev_err_probe
  regulator: fan53555: Add support for RK860X

 .../bindings/regulator/fcs,fan53555.yaml      |  22 +-
 drivers/regulator/fan53555.c                  | 203 ++++++++++++++----
 2 files changed, 172 insertions(+), 53 deletions(-)

-- 
2.40.0

