Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9661567DFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjA0JVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjA0JVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:21:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA293D0;
        Fri, 27 Jan 2023 01:21:34 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4623:efe7:8a8:33c2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B35FF6602E66;
        Fri, 27 Jan 2023 09:21:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674811293;
        bh=REsCtAkZRuIgQgakBRZ6FEEcPq8lAcKiHRdXzz5RX8s=;
        h=From:To:Cc:Subject:Date:From;
        b=b4PszC+NphdjWD0SnVj5join0Iiiuu16xO81xWXFlCKCIIOgsCrUoQZLn/Rzh9kFu
         dQyfWf4jdiIFsbkLDaH5w93/r1j0PPa8Hrd6BbCCYx0TdOIDo8BnTG5KSl+NalC8IG
         HTYQV3Tm3NvZOpWrb8J2ELoHW8jvrysU77zwO56SNR/DFKbRcJ97LbvJ4NTclsAYMf
         a/WRkpS1gha8n9DjVju5QE5Fa3wqJ/KJIwDzzk7i5pdhmioGAxThBDS2rpD30zPixA
         nFgQeYVYhVgswsF+KU5U5ztbZY2c8Hbb5gpNTWnHUsf0zZ60Yck/GrpkEyo9cn/Jii
         Wle80RsO+J5ew==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 0/2] media: verisilicon: HEVC: fix 10bits handling
Date:   Fri, 27 Jan 2023 10:21:24 +0100
Message-Id: <20230127092126.318268-1-benjamin.gaignard@collabora.com>
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

version 5:
- Add Nicolas's review tags
- Add Fixes tags

version 4:
- Split the change in 2 patches.
- Change hantro_check_depth_match() prototype to avoid using
  ctx->bit_depth
- Return the result of hantro_reset_raw_fmt() to the caller.
- Only set ctx->bit_depth when hantro_reset_raw_fmt() returns is ok.

 
Benjamin Gaignard (2):
  media: verisilicon: Do not change context bit depth before validating
    the format
  media: verisilicon: HEVC: Only propose 10 bits compatible pixels
    formats

 .../media/platform/verisilicon/hantro_drv.c   | 44 ++++++++++++---
 .../platform/verisilicon/hantro_postproc.c    |  2 +-
 .../media/platform/verisilicon/hantro_v4l2.c  | 53 +++++++++----------
 .../media/platform/verisilicon/hantro_v4l2.h  |  3 +-
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
 5 files changed, 66 insertions(+), 38 deletions(-)

-- 
2.34.1

