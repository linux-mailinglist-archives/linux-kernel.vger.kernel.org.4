Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4760B7B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiJXTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiJXT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:29:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC78192994
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:01:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j15so6889944wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FyTv7D4Ail3A9f9S3utxw/t9/+Mc7/bdxQ5aSmaZ4hU=;
        b=eaIXARF/eciHDHcBHNEBNWKsY1Nd3axjYeOy2NVHQuOI4PSDtN+yb9t3ZifnpWKhxq
         0dwN53gdvnQqyauuoaCGc7C2mtMM/qUqlmqXSgRSejABUOy02ci4fd8g7z7+FbGVeTMH
         FUA4D31yl6HUu8NReIbBKjRzMEnGWTBgyVWUNboWaWAbmcR93xZr4OV9iL+pLxoPGYJW
         36xJyePTneQ6Rs6uKLGQvnCC0FxVFQEf3Ve5BWeAsQ1J/oDgSI34NjYfYr9jE3eF4IgT
         Ca76r/7EKLppXClh5JwgNKkeBTaGiU7odx2jUkqq7M9zDuO8pUw86Jk32HgxXLTx6JSU
         1RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyTv7D4Ail3A9f9S3utxw/t9/+Mc7/bdxQ5aSmaZ4hU=;
        b=Ce6vR13Dx+nuP2nt561O3V08cMOXhOpsWfjXcrxEU4X59fG1nq3DH/rU/T7qfx/HQd
         d+B89+K4pub5NNSx+qhkLlPOH372+HQcWk4MLQYoSy+Lk4/bQed0I11W9hoDyXI7BgAo
         KpKJKvAFirluT/dsifffr6hjfCovEHAZgnyq7wMXjEl3XrHbYKP1kPhMWgrYtDtmj5tW
         04+AoZsrC4em+nLdnDOB3M99pgl4UkyIO1Ezho+mnOjpmg80YLAQm2PUG5kPaooqly2X
         N9GRLsvxJFj6rOk8NVvKLhpgKPctraiOivo7IprkJksOYNQyKYL02faQbn7MZlDwg4P2
         KzIA==
X-Gm-Message-State: ACrzQf2PRxpi+67k/l6/NWLRPk/gHCPYXGjKTns+WtiaxMrn0S2e6XeA
        KDcBBBkdn7bRSI4YH057crIzDvqWr7GriQ==
X-Google-Smtp-Source: AMsMyM5DfFNJU8Qn38BWU+DfHhpJtaO+/Rxy3wbCYTWVTkQCJ+Gmaeqd8OVCWIqOgxYZPQESofdV1Q==
X-Received: by 2002:adf:f081:0:b0:236:5e7c:4ec2 with SMTP id n1-20020adff081000000b002365e7c4ec2mr8566334wro.641.1666630647908;
        Mon, 24 Oct 2022 09:57:27 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b003b47e75b401sm9116426wmq.37.2022.10.24.09.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:57:27 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Alex Elder <elder@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Alex Elder <elder@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] net: ipa: fix some resource limit max values
Date:   Mon, 24 Oct 2022 17:56:34 +0100
Message-Id: <20221024165636.3979249-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Some resource limits on IPA v3.1 and v3.5.1 have their max values set to
255, this causes a few splats in ipa_reg_encode and prevents it from booting.
The limits are all 6 bits wide so adjust the max values to 63.

Fixes: 1c418c4a929c ("net: ipa: define resource group/type IPA register fields")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/net/ipa/data/ipa_data-v3.1.c   | 62 +++++++++++++-------------
 drivers/net/ipa/data/ipa_data-v3.5.1.c |  4 +-
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ipa/data/ipa_data-v3.1.c b/drivers/net/ipa/data/ipa_data-v3.1.c
index e0d71f609272..7ff093f982ad 100644
--- a/drivers/net/ipa/data/ipa_data-v3.1.c
+++ b/drivers/net/ipa/data/ipa_data-v3.1.c
@@ -187,53 +187,53 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 static const struct ipa_resource ipa_resource_src[] = {
 	[IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS] = {
 		.limits[IPA_RSRC_GROUP_SRC_UL] = {
-			.min = 3,	.max = 255,
+			.min = 3,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DL] = {
-			.min = 3,	.max = 255,
+			.min = 3,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DIAG] = {
-			.min = 1,	.max = 255,
+			.min = 1,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DMA] = {
-			.min = 1,	.max = 255,
+			.min = 1,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
-			.min = 2,	.max = 255,
+			.min = 2,	.max = 63,
 		},
 	},
 	[IPA_RESOURCE_TYPE_SRC_HDR_SECTORS] = {
 		.limits[IPA_RSRC_GROUP_SRC_UL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DIAG] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DMA] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 	},
 	[IPA_RESOURCE_TYPE_SRC_HDRI1_BUFFER] = {
 		.limits[IPA_RSRC_GROUP_SRC_UL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DIAG] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DMA] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 	},
 	[IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS] = {
@@ -272,36 +272,36 @@ static const struct ipa_resource ipa_resource_src[] = {
 	},
 	[IPA_RESOURCE_TYPE_SRC_HDRI2_BUFFERS] = {
 		.limits[IPA_RSRC_GROUP_SRC_UL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DIAG] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DMA] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 	},
 	[IPA_RESOURCE_TYPE_SRC_HPS_DMARS] = {
 		.limits[IPA_RSRC_GROUP_SRC_UL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DIAG] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_DMA] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 	},
 	[IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES] = {
@@ -345,22 +345,22 @@ static const struct ipa_resource ipa_resource_dst[] = {
 	},
 	[IPA_RESOURCE_TYPE_DST_DATA_SECTOR_LISTS] = {
 		.limits[IPA_RSRC_GROUP_DST_UL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_DST_DL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_DST_DIAG_DPL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_DST_DMA] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_DST_Q6ZIP_GENERAL] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_DST_Q6ZIP_ENGINE] = {
-			.min = 0,	.max = 255,
+			.min = 0,	.max = 63,
 		},
 	},
 	[IPA_RESOURCE_TYPE_DST_DPS_DMARS] = {
diff --git a/drivers/net/ipa/data/ipa_data-v3.5.1.c b/drivers/net/ipa/data/ipa_data-v3.5.1.c
index 383ef1890065..42f2c88a92d4 100644
--- a/drivers/net/ipa/data/ipa_data-v3.5.1.c
+++ b/drivers/net/ipa/data/ipa_data-v3.5.1.c
@@ -179,10 +179,10 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 static const struct ipa_resource ipa_resource_src[] = {
 	[IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS] = {
 		.limits[IPA_RSRC_GROUP_SRC_LWA_DL] = {
-			.min = 1,	.max = 255,
+			.min = 1,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
-			.min = 1,	.max = 255,
+			.min = 1,	.max = 63,
 		},
 		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
 			.min = 1,	.max = 63,
-- 
2.38.1

