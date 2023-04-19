Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBC6E72E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjDSGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDSGLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:11:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916DB59F5;
        Tue, 18 Apr 2023 23:11:53 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D3DB2660318E;
        Wed, 19 Apr 2023 07:11:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681884711;
        bh=h0rGIVuQj6zUdLHPgaxEP/V/HKYWI6abOEae2aWJ0Ms=;
        h=From:To:Cc:Subject:Date:From;
        b=K2xWN1RlJGJC9gWo22yxoMW1HP91SRmetxnkQ1wu6urDdcGWQ0K65/q9hSncyk15a
         M76In6U3k7AHq9LGCjzxb/R9FEpOPZNjQMow3rO7XHHgtvchPCXu5B8Hjb52D/BKn8
         wG8rKnr7UWv9E0IZOOJJQih0pwZFTbMEovIXf5PccjgAGZTVvDq4neiUeNL8Kj2uxR
         ZxVveDJcZRHw6lsB0gwqN54lRsUrVGIMBsyQaHTA6jv0PGjmj0YpL/uRihZnAtJov9
         uUl/WV0CJvrTY9qhaG0S2AeAD2c/hIspXPoGzxgFSzl6K8Hf4NxbIdNpJykzlOaZbX
         AhkXa5rqYMfxg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        aouledameur@baylibre.com, bchihi@baylibre.com,
        daniel@makrotopia.org, ye.xingchen@zte.com.cn, hsinyi@chromium.org,
        michael.kao@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] MediaTek AUXADC thermal: urgent fixes
Date:   Wed, 19 Apr 2023 08:11:44 +0200
Message-Id: <20230419061146.22246-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The AUXADC thermal driver unfortunately has issues with a fixed wait
at probe, as this is not only SoC dependent, but actually depends on
the board (and even aging...): for example, that works fine on the
Chromebook that I have here in my hands but not for the ones in our lab.

Some machines are working fine with that 30ms delay at probe, but some
others are not, hence I started digging in downstream sources here and
there, and found that there actually is a valid temperature range for
at least auxadc-thermal *v1* and can be actually found in multiple
downstream kernels for MT8173 and MT6795.

As for v2 and v3 thermal IP, I'm sure that the v1 range works fine but
I've "left room" for adding specific ranges for them later: this fix
is urgent, as many MT8173 and MT8183 Chromebooks are failing tests in
KernelCI due to thermal shutdown during boot.

For the KernelCI logs, you can look at [1] for 8173, [2] for 8183.

[1]: https://storage.kernelci.org/next/master/next-20230405/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/igt-kms-mediatek-mt8173-elm-hana.html
[2]: https://storage.kernelci.org/next/master/next-20230405/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/cros-ec-mt8183-kukui-jacuzzi-juniper-sku16.html

AngeloGioacchino Del Regno (2):
  Revert "thermal/drivers/mediatek: Add delay after thermal banks
    initialization"
  thermal/drivers/mediatek: Add temperature constraints to validate read

 drivers/thermal/mediatek/auxadc_thermal.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.40.0

