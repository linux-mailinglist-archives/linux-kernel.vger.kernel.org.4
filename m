Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747B06C62D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCWJJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCWJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:09:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F201C304;
        Thu, 23 Mar 2023 02:08:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7BEF066030B7;
        Thu, 23 Mar 2023 09:08:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679562509;
        bh=FrNqR4ku0iKICaEUucsD1iDyufd8gS7yQCcBq8NLjCk=;
        h=From:To:Cc:Subject:Date:From;
        b=UoiSqZAJ+OsBLSjFthKrc7M9zBYhSaip5DgHe5wwELvBcjsM32KCPOrA7w212f/zV
         BlHbVbKrvnqe//C/9LuPRrKo93J7AFcRskLwwtej/qr9N4VoFL4yUTIwiG94YmPiXz
         u/1Hl805zVAVQ50Sttvq/9Ygojol5mFGMl9TNSPDpKTPJ129MGO+eYGCMbst4gX9wU
         iCQRoUmBOpVW9+ff9ch3fszXBGR3rJ1OACE9joDeyGwgG7KVJa5Cz5M22dScnF+6mH
         Pf+SDZWvLy1eq5txEGN17CAiCU0f8i5UlMQZuFmtV62lCgnruFJQOmLVllcLCmagLi
         VmOZlujSTW9ig==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wenst@chromium.org,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 RESEND 0/2] Panfrost: GPU Speed-binning support via OPP
Date:   Thu, 23 Mar 2023 10:08:20 +0100
Message-Id: <20230323090822.61766-1-angelogioacchino.delregno@collabora.com>
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

The OPP framework supports binning through the 'opp-supported-hw'
devicetree property and some of the SoCs that are using Panfrost,
namely ... MediaTek, are actually binned.
This is especially seen in MT8186, but some other models do actually
support the same.

This series adds basic binning support by simply checking (and reading)
speed-bin from NVMEM (eFuse arrays, usually) and *if and only if* that
is provided, adds the read value with devm_pm_opp_set_supported_hw().

This code expects to receive a value that is compatible with how the
supported_hw checks work in OPP and it should never contain any kind
of platform (or SoC) specific code, since Panfrost is a driver for a
GPU that may be tied to different SoCs... and this is what this series
provides.

Cheers!

AngeloGioacchino Del Regno (2):
  dt-bindings: gpu: mali-bifrost: Document nvmem for speedbin support
  drm/panfrost: Add basic support for speed binning

 .../bindings/gpu/arm,mali-bifrost.yaml        |  7 +++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 30 +++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.40.0

