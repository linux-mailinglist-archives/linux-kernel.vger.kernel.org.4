Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C770E1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjEWQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjEWQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:25:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE373C2;
        Tue, 23 May 2023 09:25:24 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:1ba:3e91:de16:9b34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFFC56605961;
        Tue, 23 May 2023 17:25:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684859123;
        bh=m0wdRLijBXDpapk6u3bXRwyWKtwK52v854JhKYzO1nY=;
        h=From:To:Cc:Subject:Date:From;
        b=Sjc4Xq4ABljQOpIT49MZaaPtLrwgnBcr6oDj8CHt+k7Lhj2kdV3uHLCPoNtziCzTu
         rec4ISSSxD8WNs2hJMFigTXAt2D2M2iH+E1jgxTDFAPBrMKDheBGgAMDDUXmt8TxUP
         yAIxDPZBwgGkZQrmfM1TELJkhvnSNDohXPmre6mGbBouxQBh17/992/yzaFiB1GoRw
         9H+avykPJeQS5hgDoZyBOX+0+apYSA+oHFdB/qHBDgBiNu11BPAzNmN7Ws1ICJ5fSg
         GTQMk6hYEvAeXUklumgZCWnQGRBlXHttBYy7dbR7iMVT6uWol39BG2crC0codYNsIZ
         HK4Kti7Ps9sUg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, m.tretter@pengutronix.de,
        didi.debian@cknow.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: verisilicon: Additional fix for the crash when opening the driver
Date:   Tue, 23 May 2023 18:25:15 +0200
Message-Id: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This fixes the following issue observed on Odroid-M1 board:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
 Mem abort info:
 ...
 Modules linked in: crct10dif_ce hantro_vpu snd_soc_simple_card snd_soc_simple_card_utils v4l2_vp9 v4l2_h264 rockchip_saradc v4l2_mem2mem videobuf2_dma_contig videobuf2_memops rtc_rk808 videobuf2_v4l2 industrialio_triggered_buffer rockchip_thermal dwmac_rk stmmac_platform stmmac videodev kfifo_buf display_connector videobuf2_common pcs_xpcs mc rockchipdrm analogix_dp dw_mipi_dsi dw_hdmi drm_display_helper panfrost drm_shmem_helper gpu_sched ip_tables x_tables ipv6
 CPU: 3 PID: 176 Comm: v4l_id Not tainted 6.3.0-rc7-next-20230420 #13481
 Hardware name: Hardkernel ODROID-M1 (DT)
 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : hantro_try_fmt+0xa0/0x278 [hantro_vpu]
 lr : hantro_try_fmt+0x94/0x278 [hantro_vpu]
 ...
 Call trace:
  hantro_try_fmt+0xa0/0x278 [hantro_vpu]
  hantro_set_fmt_out+0x3c/0x298 [hantro_vpu]
  hantro_reset_raw_fmt+0x98/0x128 [hantro_vpu]
  hantro_set_fmt_cap+0x240/0x254 [hantro_vpu]
  hantro_reset_encoded_fmt+0x94/0xcc [hantro_vpu]
  hantro_reset_fmts+0x18/0x38 [hantro_vpu]
  hantro_open+0xd4/0x20c [hantro_vpu]
  v4l2_open+0x80/0x120 [videodev]
  chrdev_open+0xc0/0x22c
  do_dentry_open+0x13c/0x48c
  vfs_open+0x2c/0x38
  path_openat+0x550/0x934
  do_filp_open+0x80/0x12c
  do_sys_openat2+0xb4/0x168
  __arm64_sys_openat+0x64/0xac
  invoke_syscall+0x48/0x114
  el0_svc_common+0x100/0x120
  do_el0_svc+0x3c/0xa8
  el0_svc+0x40/0xa8
  el0t_64_sync_handler+0xb8/0xbc
  el0t_64_sync+0x190/0x194
 Code: 97fc8a7f f940aa80 52864a61 72a686c1 (b9400800)
 ---[ end trace 0000000000000000 ]---

Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 835518534e3b..61cfaaf4e927 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -397,10 +397,12 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
 	if (!raw_vpu_fmt)
 		return -EINVAL;
 
-	if (ctx->is_encoder)
+	if (ctx->is_encoder) {
 		encoded_fmt = &ctx->dst_fmt;
-	else
+		ctx->vpu_src_fmt = raw_vpu_fmt;
+	} else {
 		encoded_fmt = &ctx->src_fmt;
+	}
 
 	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
 	raw_fmt.width = encoded_fmt->width;
-- 
2.34.1

