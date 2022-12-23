Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366186553F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiLWTi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiLWTix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:38:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07A620F75;
        Fri, 23 Dec 2022 11:38:48 -0800 (PST)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CA6A6602CE4;
        Fri, 23 Dec 2022 19:38:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671824327;
        bh=eBl4+2U4mQQRTAtyInaP2j+zvWYhkSkjm7NFsSgFaXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJvWKvQjLgZgCirY7Ajy75zAiBEMylZ1tHA5Dv/UZvan9DxnC2Xe4FPZ3PIxO1K/w
         F38xN/A6OmP1IEuIsrcNkNDklBhJTfIKvMpcvaaPWtAVGcuiZYPN0qVOPsdkjvmVjo
         ef3k2PCz9jx2XhcpLMmYFP/cnb3bWRh6C5IQhiDTTC3iXksZZMjAbZT464r+z1f2QA
         zWWGONfBbyKwzmfv2BSU3FAbG9g3/fpifiw/+69wHfCENqpkR8p70h7vksoCfbvRRw
         P/GdIpznA4b/OROhL9Wss32R/UHS0hY5eGKa0EYVpkcAkKCFLZv1Bv9xzQpHmb33ub
         LAvyHe6xEy3Pw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] media: rkvdec: Fix RKVDEC_ERR_PKT_NUM macro
Date:   Fri, 23 Dec 2022 14:38:04 -0500
Message-Id: <20221223193807.914935-3-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223193807.914935-1-nicolas.dufresne@collabora.com>
References: <20221223193807.914935-1-nicolas.dufresne@collabora.com>
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

This information is expressed by bits [29:16], but the actual
implementation was reading bits [13:0] and shifting that 16
bits to the left.

Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-regs.h b/drivers/staging/media/rkvdec/rkvdec-regs.h
index 15b9bee92016c..14530b81560ed 100644
--- a/drivers/staging/media/rkvdec/rkvdec-regs.h
+++ b/drivers/staging/media/rkvdec/rkvdec-regs.h
@@ -212,7 +212,7 @@
 #define RKVDEC_REG_H264_ERRINFO_NUM			0x130
 #define RKVDEC_SLICEDEC_NUM(x)				((x) & 0x3fff)
 #define RKVDEC_STRMD_DECT_ERR_FLAG			BIT(15)
-#define RKVDEC_ERR_PKT_NUM(x)				(((x) & 0x3fff) << 16)
+#define RKVDEC_ERR_PKT_NUM(x)				((x >> 16) & 0x3fff)
 
 #define RKVDEC_REG_H264_ERR_E				0x134
 #define RKVDEC_H264_ERR_EN_HIGHBITS(x)			((x) & 0x3fffffff)
-- 
2.38.1

