Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4B6F6A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjEDLjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDLju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:39:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0C10B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:39:49 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABED666031D7;
        Thu,  4 May 2023 12:39:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683200388;
        bh=9rPMidGo7VzPQrQAdmCcj3emYqwqhn2GCJrcqjNy2DE=;
        h=From:To:Cc:Subject:Date:From;
        b=oNb0vggHdu6K02LSzKwWEembjWYjw1bhjPRCAF1o4n0EVd8Uyj1I3TMMOSDg02z0b
         Sw0fNpVYFKRnzAcE2YdzSNxxe8PVx1olM8GQAvdlGJWiuTMqBSgEpOnUXJcOq9qApm
         r9WHtDnHRJHDovcmVXoMgRun+Zo2FQ48qI9HmPxcE1WC8XngWnYCE1y6EKxYNmsnLU
         Ed3WzW6MNYmIpVndj/Co0TCkHRlYQWgqhp15tcK3l4d6ZZpbOYImNNFtArzCGZSBRt
         oYi0yM8dRAWYCSM3Kdc74EMV/yTkWJQcccQNn6xQ6oJzBrNL1uYSvx1aj0IF2ECUi6
         rsQKvHm16iolg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        hsin-hsiung.wang@mediatek.com, james.lo@mediatek.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH] spmi: mtk-pmif: Add a WFVLDCLR specific timeout
Date:   Thu,  4 May 2023 13:39:42 +0200
Message-Id: <20230504113942.187054-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
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

At least on MT8195, in some instances, at cold-boot the PMIF seems to
get busy and slow, triggering a failure in pmif_spmi_read_cmd() with
"failed to wait for SWINF_WFVLDCLR" message: at least on the Tomato
Chromebook, this gives issues with the GPU power supply, resulting in
a probe failure for panfrost.

Through trial and error (rebooting the machine ~50 times), it was
found that a timeout of at least 50 milliseconds does effectively
mitigate this issue, hence add an "extended" timeout and use it for
the WFVLDCLR polling.

Fixes: b45b3ccef8c0 ("spmi: mediatek: Add support for MT6873/8192")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi-mtk-pmif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index b3c991e1ea40..a7b4b030929e 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -22,6 +22,7 @@
 
 #define PMIF_DELAY_US   10
 #define PMIF_TIMEOUT_US (10 * 1000)
+#define PMIF_WFVLDCLR_TIMEOUT_US (50 * 1000)
 
 #define PMIF_CHAN_OFFSET 0x5
 
@@ -357,7 +358,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	 */
 	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
 					data, GET_SWINF(data) == SWINF_WFVLDCLR,
-					PMIF_DELAY_US, PMIF_TIMEOUT_US);
+					PMIF_DELAY_US, PMIF_WFVLDCLR_TIMEOUT_US);
 	if (ret < 0) {
 		dev_err(&ctrl->dev, "failed to wait for SWINF_WFVLDCLR\n");
 		return ret;
-- 
2.40.1

