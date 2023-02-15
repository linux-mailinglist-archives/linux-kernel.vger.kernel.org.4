Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7213569850E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBOTyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBOTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:54:12 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25613E0BB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:54:02 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id l128so7573229iof.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55iMl67tczsHAriI/5ivr6yqGDBI3afdu3qz4PSaV8E=;
        b=r95+Yi3ZQYV06bxV2XGdq+pI+dROE3kraQJxFy36hyF2kZf3qwVRNdeXalqw7npB7+
         F9nVAN/YGf35TkVigA5agOCI2UcK7xgxJhx6DasaNKKv/QDb+nPHpE4KzTalA2fuK6cD
         haV/45wSAqBwZEe4FboXThoOwDC7Gw6M8j6tPxlS9CbB2K2RulBCHJAVEuHnscEXT7iY
         YxqWzSwguyWx/utxw6jCYraaVAwtKUbla/78RoYlKzVyz7pzfMB+BaKmdLVJyopkh+Hc
         yUCwY9mFhuWlEpeU+rxytxI6caoVaEU0dWdwjVdDagGclrg3dq6CoM+l+v5m39ORSst4
         uRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55iMl67tczsHAriI/5ivr6yqGDBI3afdu3qz4PSaV8E=;
        b=Hz39AySK86vB3RxBOwUndhq+o12EQG1OBwMu0+jjXoCciuHZ4leNMk69tHAWaEWKDr
         QRAOmDe4ufYCBfyl67scBD/e5VkliiCjlw0fFJgqR727dtOwYmixvSEII5blW7/kO7ol
         /58unuo8r+3RGCgFwMfF6KBB2IoLI/THiHNPEMlmeNiS6W28DdgmHd8PhQXOTD1NfedS
         E/ARgRPIV3Mip4+Bvbc0B4mDTQ+GoldRkmaO5FA7QScINr8dgKUUiFZjFrEnyMfabrnC
         UlZUC5jbvnYd4Rc11zUqE0pX4cOlyVJSOh6cqxh91qvgGC+pLkrgs9JTSyiabnby4N0S
         RlBQ==
X-Gm-Message-State: AO0yUKUO/Ge49slhOagRgcXRFR7TgQOkul5hnL63Df0KQzalwIO6RUVn
        m8BlHArV2gHOChNyRFqN7aAxnA==
X-Google-Smtp-Source: AK7set/yolWgnkr5CODPg7mXWkmCahG3Y8RDu89TwGLTMT9/2zUHTtDoF0UAhEUqjoCs+mIPKPyHfQ==
X-Received: by 2002:a5e:8c14:0:b0:720:9057:a083 with SMTP id n20-20020a5e8c14000000b007209057a083mr2630676ioj.13.1676490842146;
        Wed, 15 Feb 2023 11:54:02 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n10-20020a5ed90a000000b0073a312aaae5sm6291847iop.36.2023.02.15.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:54:01 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: ipa: support different event ring encoding
Date:   Wed, 15 Feb 2023 13:53:51 -0600
Message-Id: <20230215195352.755744-6-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215195352.755744-1-elder@linaro.org>
References: <20230215195352.755744-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with IPA v5.0, a channel's event ring index is encoded in
a field in the CH_C_CNTXT_1 GSI register rather than CH_C_CNTXT_0.
Define a new field ID for the former register and encode the event
ring in the appropriate register.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c     | 5 ++++-
 drivers/net/ipa/gsi_reg.h | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 88279956194a9..f128d5bd6956e 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -840,12 +840,15 @@ static void gsi_channel_program(struct gsi_channel *channel, bool doorbell)
 	val = ch_c_cntxt_0_type_encode(gsi->version, reg, GSI_CHANNEL_TYPE_GPI);
 	if (channel->toward_ipa)
 		val |= reg_bit(reg, CHTYPE_DIR);
-	val |= reg_encode(reg, ERINDEX, channel->evt_ring_id);
+	if (gsi->version < IPA_VERSION_5_0)
+		val |= reg_encode(reg, ERINDEX, channel->evt_ring_id);
 	val |= reg_encode(reg, ELEMENT_SIZE, GSI_RING_ELEMENT_SIZE);
 	iowrite32(val, gsi->virt + reg_n_offset(reg, channel_id));
 
 	reg = gsi_reg(gsi, CH_C_CNTXT_1);
 	val = reg_encode(reg, CH_R_LENGTH, size);
+	if (gsi->version >= IPA_VERSION_5_0)
+		val |= reg_encode(reg, CH_ERINDEX, channel->evt_ring_id);
 	iowrite32(val, gsi->virt + reg_n_offset(reg, channel_id));
 
 	/* The context 2 and 3 registers store the low-order and
diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
index 52520cd44c3e1..2a19d9e34a10a 100644
--- a/drivers/net/ipa/gsi_reg.h
+++ b/drivers/net/ipa/gsi_reg.h
@@ -102,7 +102,7 @@ enum gsi_reg_ch_c_cntxt_0_field_id {
 	CH_EE,
 	CHID,
 	CHTYPE_PROTOCOL_MSB,				/* IPA v4.5-4.11 */
-	ERINDEX,
+	ERINDEX,					/* Not IPA v5.0+ */
 	CHSTATE,
 	ELEMENT_SIZE,
 };
@@ -124,6 +124,7 @@ enum gsi_channel_type {
 /* CH_C_CNTXT_1 register */
 enum gsi_reg_ch_c_cntxt_1_field_id {
 	CH_R_LENGTH,
+	CH_ERINDEX,					/* IPA v5.0+ */
 };
 
 /* CH_C_QOS register */
-- 
2.34.1

