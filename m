Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59522622044
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKHXXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiKHXXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:23:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45925985A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:22:57 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB79A66029B1;
        Tue,  8 Nov 2022 23:22:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667949776;
        bh=w2Tw9BNtdcNeeTvJ45kVRaX/QNBeZnEddMsQkOLxDYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdBorP2WuTPXQho8lUeITOeCKocfexTzWIn/Nxd5ydEXdokKAOCTjHrlPMp2oOgzV
         MXUhCukwL+PVDqcMFSRuEYN54Mzvr0e53KLx3ffnqfvjawADinSo5/lcoSlqtJUwtU
         /BNQKJ+e3HvJkTx19mdqMMOcDPqrcdC9GUvV2jdIotPeDiX+qip3oH2jby+SSPqi20
         yQcBFsPmTmfz/0B1WExVfG8Y6i+Z9JD6QcgbUsRgeqP0i4i8X7ha4MCyDYpknEaaYz
         KFGg5h84QC61/Vm5ZqIfP4hjNC8UUnRZqrva3C76zQe801ojp6QMqmLep35pK6CTYu
         U3F+AQ4YEcgng==
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
Subject: [PATCH 08/13] arm64: defconfig: Enable CR50 TPMs
Date:   Tue,  8 Nov 2022 18:22:23 -0500
Message-Id: <20221108232228.1177199-9-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108232228.1177199-1-nfraprado@collabora.com>
References: <20221108232228.1177199-1-nfraprado@collabora.com>
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

Enable support for the CR50 TPMs present on Chromebooks. They can be
connected through SPI or I2C, and there's a different driver for each
case, so enable both.

By enabling this on the defconfig we make it effortless to test the
relevant hardware on CI systems like KernelCI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9fe43387d83f..c54a85679d40 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -464,6 +464,10 @@ CONFIG_IPMI_HANDLER=m
 CONFIG_IPMI_DEVICE_INTERFACE=m
 CONFIG_IPMI_SI=m
 CONFIG_TCG_TPM=y
+CONFIG_TCG_TIS=m
+CONFIG_TCG_TIS_SPI=m
+CONFIG_TCG_TIS_SPI_CR50=y
+CONFIG_TCG_TIS_I2C_CR50=m
 CONFIG_TCG_TIS_I2C_INFINEON=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
-- 
2.38.1

