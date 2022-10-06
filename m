Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA95F7027
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiJFVZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:25:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59CDA4864;
        Thu,  6 Oct 2022 14:25:35 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 24154660230F;
        Thu,  6 Oct 2022 22:25:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665091533;
        bh=aOnsKC+E1877mOO1xAIQ+QVFtrIRW/5ZxTE2f8db6Us=;
        h=From:To:Cc:Subject:Date:From;
        b=IObwZSt+H9Y3Jf4eaRH+vlmt01qKOZsCrYrMTcenENW9UxdZTaEU9yHBD6l0Bi7fJ
         Rnw9yo3is+Vigq5jnb0hwGA6sEKO69FO1PROUbB86Vxwyimdoh79QvD0f3hrXLwHMg
         kwXu6S0ZvqApb7U8ueUu3v0GW2x8kHbjXJHC5Gls6MbxXdF86C/FyooWMF4n4JpS1h
         NTQzvkUhxt7g64GMyU60Qawp78xRsJzvGpczQxzuB8cJXfubVxfUytb/wll56l4SK6
         bCcfTbyJ0Tmzm7yOsrZA8q4dc7IHystR4LQt8MiQXuLM477Lzi0C6nb3egRgJNh6eL
         B42i7GfKP1s9w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/5] MT8192 Asurada devicetree - Part 2
Date:   Thu,  6 Oct 2022 17:25:23 -0400
Message-Id: <20221006212528.103790-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series improves some more the support for MT8192 Asurada-based
Chromebooks, by enabling some missing functionality, namely the internal
display and audio.

In addition to that, aliases are also added for the i2c and mmc nodes,
which should've been done while adding the devices in the previous
series.

Some notable components that are still missing support are:
- external display/HDMI audio (waiting for [1])
- GPU (waiting for [2])

As part of testing the audio, an UCM file was used, which has already
been submitted upstream [3] (note that while that UCM configures HDMI,
kernel support for HDMI audio will be added in a future series).

[1] https://lore.kernel.org/all/20220622173605.1168416-1-pmalani@chromium.org/
[2] https://lore.kernel.org/all/20221006115816.66853-1-angelogioacchino.delregno@collabora.com
[3] https://github.com/alsa-project/alsa-ucm-conf/pull/217

v1: https://lore.kernel.org/all/20220908171153.670762-1-nfraprado@collabora.com/

Changes in v2:
- Extended series to also include patches 4 and 5 enabling audio and
  adding aliases
- Adjusted display regulator hierarchy and voltages to reflect the
  hardware

Nícolas F. R. A. Prado (5):
  arm64: dts: mediatek: asurada: Add display regulators
  arm64: dts: mediatek: asurada: Add display backlight
  arm64: dts: mediatek: asurada: Enable internal display
  arm64: dts: mediatek: asurada: Enable audio support
  arm64: dts: mediatek: asurada: Add aliases for i2c and mmc

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 507 ++++++++++++++++++
 1 file changed, 507 insertions(+)

-- 
2.37.3

