Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46B26672BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjALM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjALM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:56:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F24914A;
        Thu, 12 Jan 2023 04:56:42 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 830346602DB1;
        Thu, 12 Jan 2023 12:56:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528201;
        bh=AVEg4DSMK0gqYca27eD54R157QB5YV2sWChYYaBFpmI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LM1vgt+pOaabBAJ85FdbLo9wq5mUT0w0x5nAszJ37VGijYHKcIXfdOuoVfBt0gFKM
         6V0TsNYP9Ceg5NVgCMb5s0IZWo5rZ1dbo1r5fvwCxpo0VEyHldVhngCZ0XpZuXi7cB
         aNfDgYu++punO6h4oxFkcZ7KjeWXaYxHFhfFxOuq9Le8mNU8nv04VPbmGJwPlU5+L9
         H+xIH29P1Jx2f8ei32MK42TPAd34QOcwHrFPJGwMZzJFHYJ2kzjYxAbPEAb3fIUCjd
         6xgX3fHo389Rsu+JdAl860N6hgqDWhXpo04SbF0lJbmDCfInbfMID2Zwd3C7+fJY9z
         H5eTXOOfjX8wQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:19 +0100
Subject: [PATCH v2 04/12] staging: media: rkvdec: Block start streaming until
 both queues run
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-4-fa1897efac14@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=1025;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=AVEg4DSMK0gqYca27eD54R157QB5YV2sWChYYaBFpmI=;
 b=4fInMsBgcT6jf30p/7TvMJW1s4sjmIUMu2MIX6uCwRuxM7iBhvTpC/00Nu4xtEZo2TrulpGwWaVw
 pfVDB17lDTsDfzQFYB1UAn0aetGnBIbCWNnkmQVCdoIqa/IR7mT0
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that both the CAPTURE and the OUTPUT queue are running (e.g. busy
-> have buffers allocated) before starting the actual streaming process.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index c849f6c20279..e0e95d06e216 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -562,6 +562,13 @@ static int rkvdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (V4L2_TYPE_IS_CAPTURE(q->type))
 		return 0;
 
+	/*
+	 * Make sure that both the output and the capture queue are running
+	 */
+	if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) == 0 ||
+	    rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) == 0)
+		return -EAGAIN;
+
 	desc = ctx->coded_fmt_desc;
 	if (WARN_ON(!desc))
 		return -EINVAL;

-- 
2.25.1
