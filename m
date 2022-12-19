Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C8650F81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLSP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiLSP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:56:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4BE656A;
        Mon, 19 Dec 2022 07:56:27 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f69c:5603:d4ce:7aa2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 855BC6602C9B;
        Mon, 19 Dec 2022 15:56:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671465385;
        bh=clrb85uBLZrtq/eiKowGtGKaTSUfChoOlR8wUbgxMps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERhshhQa3OMjKETsx63bhrPVufqu1a3ezfVAAB8P6RuiUzaxA8pn03ZeycG5zrbae
         aA/oBkgg59k52dHVxUPbY2+YMHJXbK+chjaHiFdwXcs5q3/yzWowWzFp2Pt3lB1C4h
         qiH6hJ4JXgtbgH/CW81R3VLedEORdBC2perbghUSFF6gZvmBGgeYN1aF7/FyP17ItB
         q+boacas9RyIUOv3FlXt15AFLX1/Pf9cbB2if6Ki4jCVw97wVldmCCCTP19Z5+IEfW
         Jq7WNilJSP2NlSx32Nr7mpg+QzhQpVLatzDTHIckfGrhvm31+8zSyF7jI5fezTIJgF
         xIaqrF64LnLrQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v1 4/9] media: verisilicon: Check AV1 bitstreams bit depth
Date:   Mon, 19 Dec 2022 16:56:11 +0100
Message-Id: <20221219155616.848690-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
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

The driver supports 8 and 10 bits bitstreams, make sure to discard
other cases.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 8e93710dcfed..e10fc59634dd 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -282,7 +282,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 		/* We only support profile 0 */
 		if (dec_params->profile != 0)
 			return -EINVAL;
+	} else if (ctrl->id == V4L2_CID_STATELESS_AV1_SEQUENCE) {
+		const struct v4l2_ctrl_av1_sequence *sequence = ctrl->p_new.p_av1_sequence;
+
+		if (sequence->bit_depth != 8 && sequence->bit_depth != 10)
+			return -EINVAL;
 	}
+
 	return 0;
 }
 
-- 
2.34.1

