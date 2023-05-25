Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7B7117DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjEYUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjEYUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:10:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA5A9;
        Thu, 25 May 2023 13:10:41 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:17:6c0::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 895DD6606E80;
        Thu, 25 May 2023 21:10:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685045440;
        bh=6K4oxHbB+nTrEz4B2HipTaW/E968gqdNKKQAyz2Otu0=;
        h=From:To:Cc:Subject:Date:From;
        b=nAlC6QgjmICFfhX8wFdFN2nqipwwE6YqwZ+OdbIskGL+4q50twU8bR69/IR4tvPMU
         ctJdRSvy1GlOQFlrIr3eZxKlhvxeDi/RIirl+2YqWF0Y+ffweYtOTQai2RXyqm3Vie
         50H4Ys55RXrgycTupLgFiFv90k1pny7w1XpSfwlrbCJFneg7kwj+QBivUpA3iyX+hU
         VhAgHKO0hesk2O/UcPkaxCOta5HkKUdKdFL4hi7RnG0mmAdt8suOc0vbu/cjnWM61y
         tztHLJj5uPapQQhh7PdJZByBc5lTFrNWfyvCCJ++tR4Y9tHpWK9TF6uxMzhQOoM229
         3Wjq1602lkubQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] media: amphion: Fix firmware path to match linux-firmware
Date:   Thu, 25 May 2023 16:10:15 -0400
Message-Id: <20230525201015.503063-1-nicolas.dufresne@collabora.com>
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

The path did not match the one it was submitted into linux-firmware
which prevented generic distribution from having working CODEC.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/amphion/vpu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index de23627a119a0..82bf8b3be66a2 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -826,7 +826,7 @@ static const struct dev_pm_ops vpu_core_pm_ops = {
 
 static struct vpu_core_resources imx8q_enc = {
 	.type = VPU_CORE_TYPE_ENC,
-	.fwname = "vpu/vpu_fw_imx8_enc.bin",
+	.fwname = "amphion/vpu/vpu_fw_imx8_enc.bin",
 	.stride = 16,
 	.max_width = 1920,
 	.max_height = 1920,
@@ -841,7 +841,7 @@ static struct vpu_core_resources imx8q_enc = {
 
 static struct vpu_core_resources imx8q_dec = {
 	.type = VPU_CORE_TYPE_DEC,
-	.fwname = "vpu/vpu_fw_imx8_dec.bin",
+	.fwname = "amphion/vpu/vpu_fw_imx8_dec.bin",
 	.stride = 256,
 	.max_width = 8188,
 	.max_height = 8188,
-- 
2.40.1

