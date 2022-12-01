Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0206C63EB54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLAImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLAImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:42:36 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C42BD6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:42:34 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w129so1237965pfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUAbzcFVK3ZVITG+2l0a+xKU9wkLH90MaXKWziyaZMU=;
        b=XMafgRnPXr3IThGMY0Kq7ugDvt8kIojuxnOikwBHoRWG3AOjnaOxKgo5j78aV2lGUv
         VU0PdkmKb+AjhopRlrKe19lR1pWSDWbhQxX9n1lDhc6Ym3hFbmkP7L7fB/nFGtRyi5e+
         r3gOgaH78vSTqZxhRBqIEepFi6tiNXg3Bi2vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUAbzcFVK3ZVITG+2l0a+xKU9wkLH90MaXKWziyaZMU=;
        b=1d4kGB+Y3DftCPpSqjA8XjxA3roao3G/H4DCh3MB8Eaf6F2DuaNn1Lz4AzCcfcG4oI
         qBEBXuHT2l2x1QuiI5Jo+z2aSpdp7M3eQ9ExPgN8SumONN7qMz7dwUkTv0WRvOfas7HQ
         4Y0YYJUK71/y8OJMQ9WOBggrI0MgP0c4BVy1Lo2quRcxLJ0GrlKjX8Oo/bg4Py0/mn8D
         DgB+PP0kfVZelpqZa+lWUkFJupIDbgXmSMKRanD1rrjcAr1QLzteLBB7uqYhYH6UJvmj
         Q8312KgG2xC2QhV8407YqpeLqUyDjmEeri+alnXMKj9Z+upEnCwbXtN2jJ+T2J0xJ5SI
         jhBQ==
X-Gm-Message-State: ANoB5pkgjJF3ABfW6AbvkdCE3+HPhw7rS82R8QVGQvxAqNXMNa+Vii/5
        Y48rGsvKmxcaNTvEO4DMLXRp2A==
X-Google-Smtp-Source: AA0mqf4DVjDswN2LkRCBiGdapBmzeJV1WAJKCUf6aSfstFW/XOkPpCzHjNsjqlwZB823ZPCU2MWwIA==
X-Received: by 2002:a63:6f4b:0:b0:470:5619:4d7d with SMTP id k72-20020a636f4b000000b0047056194d7dmr57777194pgc.301.1669884154448;
        Thu, 01 Dec 2022 00:42:34 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2416:fa4e:4eeb:fcde])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902690500b001708c4ebbaesm2932293plk.309.2022.12.01.00.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 00:42:34 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 0/4] arm64: dts: mediatek: Fix systimer clock description
Date:   Thu,  1 Dec 2022 16:42:25 +0800
Message-Id: <20221201084229.3464449-1-wenst@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series fixes the clock description for the systimer block. The
systimer is fed by the main 26 MHz oscillator, and internally divides
the clock, normally by 2.

However this ended up being modeled in various incorrect ways, such as
the clock divider being in the TOPCKGEN block, or as a standalone 13 MHz
oscillator.

This series fixes the description of the systimer clock input in an ABI
compatible way, i.e. the clock rate of the input clock remains the same
at 13 MHz. The clock is now modeled as a divide-by-2 fixed factor clock
being fed by the main oscillator.

An added benefit is that in Linux the systimer no longer requires the
main SoC clk driver to do an early init dance.

Please have a look.

The next step would be to fix up the systimer driver in a backward
compatible way and have it read the divider value from hardware.


Regards
ChenYu

Chen-Yu Tsai (4):
  arm64: dts: mediatek: mt8183: Fix systimer 13 MHz clock description
  arm64: dts: mediatek: mt8192: Fix systimer 13 MHz clock description
  arm64: dts: mediatek: mt8195: Fix systimer 13 MHz clock description
  arm64: dts: mediatek: mt8186: Fix systimer 13 MHz clock description

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 12 ++++++++++--
 arch/arm64/boot/dts/mediatek/mt8186.dtsi |  8 +++++---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++--
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 11 ++++++++++-
 4 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

