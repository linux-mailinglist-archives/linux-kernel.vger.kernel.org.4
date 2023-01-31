Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556ED682D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjAaNDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjAaNDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:03:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4361041B;
        Tue, 31 Jan 2023 05:03:43 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d507:461a:a036:bf89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EF6256602E23;
        Tue, 31 Jan 2023 13:03:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675170222;
        bh=ywf8wvzGvrBOTq7V4rX3r1UAVqKt2wfzIb6q7nPGBn0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZO42ntVoIXd1r49AEjT0OYGNro8sGPZyFhwOFHnDSWhFR7VddD/wqXY/5Rlh0te7+
         xud4/HRJQJ3B7lT0p1kMHFPcJgTMKmOmJsaQwjcApmldVkBohPKfR0734bv/GOd8GW
         8KH4ACaz4o4e6td4xMX2QgBa6tZTS91xA+bDCeYL8vFXuzmTW3DkBfKdT/4xRue9Uy
         r/omfGjyChxNo8EMz4v5WaYGoY/tNH7pyRxAd65rxwOYnh6ACUCQHht3r+2CmP2xGa
         jOhUFphENI58fFKdkifeB9Ggwpn0itCffUCylhvWd6V1GBXVnQbLlvYpZTF27GXwGX
         7gms6gimf0cRg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 0/5] media: verisilicon: HEVC: fix 10bits handling
Date:   Tue, 31 Jan 2023 14:03:22 +0100
Message-Id: <20230131130327.776899-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
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

When decoding a 10bits bitstreams HEVC driver should only expose 10bits pixel formats.
To fulfill this requirement it is needed to call hantro_reset_raw_fmt()
and to only change driver internal state in case of success.

Fluster score (140/147) doesn't change after this series.

version 7:
- Remove unused ctx variable in hantro_try_ctrl().
- Change HANTRO_DEFAULT_BIT_DEPTH value to 8.
- Simplify hantro_check_depth_match logic.
- Keep ctx->bit_depth as integer value because it is use
  to compute buffers size for hevc.

version 6:
- Split the patches in multiple sub-patches.
- Rework hantro_reset_encoded_fmt() usage.

version 5:
- Add Nicolas's review tags
- Add Fixes tags

version 4:
- Split the change in 2 patches.
- Change hantro_check_depth_match() prototype to avoid using
  ctx->bit_depth
- Return the result of hantro_reset_raw_fmt() to the caller.
- Only set ctx->bit_depth when hantro_reset_raw_fmt() returns is ok.

Benjamin Gaignard (5):
  media: verisilicon: Do not set context src/dst formats in reset
    functions
  media: verisilicon: Do not use ctx fields as format storage when
    resetting
  media: verisilicon: Do not set ctx->bit_depth in hantro_try_ctrl()
  media: verisilicon: Do not change context bit depth before validating
    the format
  media: verisilicon: HEVC: Only propose 10 bits compatible pixels
    formats

 .../media/platform/verisilicon/hantro_drv.c   | 39 ++++++--
 .../platform/verisilicon/hantro_postproc.c    |  2 +-
 .../media/platform/verisilicon/hantro_v4l2.c  | 90 +++++++++----------
 .../media/platform/verisilicon/hantro_v4l2.h  |  3 +-
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
 5 files changed, 78 insertions(+), 58 deletions(-)

-- 
2.34.1

