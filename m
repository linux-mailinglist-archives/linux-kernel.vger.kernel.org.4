Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C686E6EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjDRVvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjDRVvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:51:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EFB119;
        Tue, 18 Apr 2023 14:51:01 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8599B6603206;
        Tue, 18 Apr 2023 22:50:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681854660;
        bh=RGjq8g5zSwAVgKk0TGPC1T322t6+hUZkLQBY3DZCsjA=;
        h=From:To:Cc:Subject:Date:From;
        b=Br0CFSM/bNNEoa2cmi08w2PcL224kZEvs14SsLrjZDiVhdEyj0BqUKp3AfK19sIlY
         BUae7lT0Kx8nvK/46VxRjtetrMQA1FsfQFqk2Y7qIjFuDkYMMAY4BcMfbMp+NaJRip
         jSxSYACVjbo1zKHQBPAMksA51SPcEfdnzMoUUwDKGtXbjQP/zY0DE/guGbz5xjRytL
         gkFZ8vJ9XWXI2bRtZQ30UySsit0/moqKCeUF1FC8K0WyLVO+1+vqJ1GVvTOWAlopFu
         mrPowIxJJapDbkbovtst0QIhQ9DgmRRmR9IU0d66a+aZAo1AbC0E18fhAOLB+lePyV
         LirMr8K+BJeEg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] Revert "media: mediatek: vcodec: Fix bitstream crop information error"
Date:   Tue, 18 Apr 2023 17:50:52 -0400
Message-Id: <20230418215052.2371755-1-nfraprado@collabora.com>
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

This reverts commit cd61f3c6794bea2b717fe6083ca2ad189db75418. That
commit's purpose was to prevent the padding from being decoded when
userspace didn't set a selection, relying on the default one.

However, as described in the Step 6 of the Initialization procedure for
the Memory-to-Memory Stateful Video Encoder Interface [1]:

"Set the visible resolution for the stream metadata via
VIDIOC_S_SELECTION() on the OUTPUT queue if it is desired to be
different than the full OUTPUT resolution."

And from the Note:

"To avoid encoding the padding, the client needs to explicitly configure
this selection target"

Hence the behavior in the original commit doesn't follow the interface
and needs to be reverted.

This fixes the following v4l2-compliance failure observed on
mt8192-asurada-spherion:

		fail: v4l2-test-formats.cpp(924): sel.r.width != fmt.g_width()
	test VIDIOC_S_FMT: FAIL

[1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-encoder.html#initialization

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Hi,

With this patch applied, there's only one failure left on
mt8192-asurada-spherion:

                fail: v4l2-test-controls.cpp(1167): node->codec_mask & STATEFUL_ENCODER
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: FAIL

But from the documentation I see that the V4L2_EVENT_EOS for stateful
encoder is deprecated behavior, so should the v4l2-compliance test be
the one changed to not require this?

We're enabling running v4l2-compliance with this driver in KernelCI [2],
so after we fix these two remaining issues it should be easy to notice
if any failures are introduced.

Thanks,
Nícolas

[2] https://github.com/kernelci/kernelci-core/pull/1889

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index db65e77bd373..9ff439a50f53 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -505,13 +505,13 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 
-	q_data->visible_width = f->fmt.pix_mp.width;
-	q_data->visible_height = f->fmt.pix_mp.height;
-	q_data->fmt = fmt;
-	ret = vidioc_try_fmt_out(ctx, f, q_data->fmt);
+	ret = vidioc_try_fmt_out(ctx, f, fmt);
 	if (ret)
 		return ret;
 
+	q_data->fmt = fmt;
+	q_data->visible_width = f->fmt.pix_mp.width;
+	q_data->visible_height = f->fmt.pix_mp.height;
 	q_data->coded_width = f->fmt.pix_mp.width;
 	q_data->coded_height = f->fmt.pix_mp.height;
 
-- 
2.40.0

