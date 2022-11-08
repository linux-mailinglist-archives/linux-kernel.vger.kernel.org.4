Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395CC62203B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiKHXWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKHXWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:22:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45633220E7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:22:36 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7A1D66029AD;
        Tue,  8 Nov 2022 23:22:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667949754;
        bh=If3RzEPoQSdqQd6aSJzJUBtCgmOKiO/pTx7pUAX3mcs=;
        h=From:To:Cc:Subject:Date:From;
        b=i04Zu7Z3Mo28lUcMCElBYEEWe/peX14gGl6XD1x2WjDPdZkW+/0VcXa6mOK8Z/jmr
         I21tKxTLgkB9Uc5Y3rztS+h+/mLVrd0er99HeQjzpxc7OoehpBMeC1aC5Jf6VhXF40
         Zff4MZ3B0+R+oeXwFijboDqXS9f6/G73BevrRcJCPbiu1ZCvuMgeg9g7YBfKbeF1pl
         5pV4G+uHdlTXjV8NKURx56U2S1RBDoN9YPL3oT1RA3UxrWoGT6v2XZb3+y3mk1NoKy
         uK9aY6GwLRACwsU/Dt0FR85ccRAosrZMyQWO3Lme8dGEJX0Erx4lbnN1ndvCKj6kiO
         2OdorLy9CLgSA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] arm64: defconfig: Enable missing kconfigs for mt8183-kukui-jacuzzi-juniper
Date:   Tue,  8 Nov 2022 18:22:15 -0500
Message-Id: <20221108232228.1177199-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
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


mt8183-kukui-jacuzzi-juniper is one of the devices set up to run tests
on KernelCI, but several of its drivers are currently disabled in the
defconfig. This series enables all the missing kconfigs on the defconfig
to get everything probing on that machine so that it can be fully tested
by KernelCI.

Given that all kconfigs added in the series are to enable support for a
MediaTek platform, it seems reasonable for it to be applied through the
MediaTek tree, but the commits themselves are independent (apart from
MTK_CMDQ and MTK_SVS) and could be applied separately.

[1] https://github.com/kernelci/kernelci-core/pull/1352
[2] https://github.com/kernelci/bootrr/pull/22


Nícolas F. R. A. Prado (13):
  arm64: defconfig: Enable SPI_MT65XX
  arm64: defconfig: Enable ATH10K_SDIO
  arm64: defconfig: Enable TOUCHSCREEN_ELAN
  arm64: defconfig: Enable sound support for MT8183 based machines
  arm64: defconfig: Enable DRM_ANALOGIX_ANX7625
  arm64: defconfig: Enable MTK_CMDQ
  arm64: defconfig: Enable MTK_SVS
  arm64: defconfig: Enable CR50 TPMs
  arm64: defconfig: Enable MTK_SCP
  arm64: defconfig: Enable VIDEO_MEDIATEK_JPEG
  arm64: defconfig: Enable ARM_MEDIATEK_CCI_DEVFREQ
  arm64: defconfig: Enable GENERIC_ADC_THERMAL
  arm64: defconfig: Enable MEDIATEK_MT6577_AUXADC

 arch/arm64/configs/defconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.38.1

