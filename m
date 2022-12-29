Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27244658E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiL2PwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiL2Pu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F1265A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m3so4513086wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=4kzrZQmNW5u/l4/1vb9iBZY0YVFfU2bOnHmtPuVdGbScyFaLWhKbgRrlhxtDjssfYe
         R7MNm+xzvPgFEyUktzm6RREID7GIjuIbqVd9h6aiB1pTwAbItO4bTjlMWru0Y97Qpk9n
         uMD/omxP3gOIyQScd+F25tHMNadcbCrQg1qnUVPugSBp7e5wAywlvRYJwGAcM7SGjIxt
         7yZnqgJtBYb46Hy9F8CUXUwgQ+o4lnEvuMbSHAb9mHvObhlmpXFk1TDNfdjEyt+5qWg+
         HQqS+NzY4O4245fiHiCHvaXsOVZGxYTssijiGTe+KICDuWgz0+ZOcNVJcPVu0uBBZ4Wf
         hK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=MblHwFaZH9l1POvEF2Rai2ZQgcNO/ik6IMA3EpPzGVTrw+kgRYyyoNHmgxjTeP7yws
         tTO63QetOnLyIiMKTwa1nR+fQtKAUeX1UY1Dvzu4XomMhkBarXIJ53yoIKjjmAjGIcFV
         4xJI6HzYTBbuZ74UjqZkSKbGlDDPZNOtewzz4AnY+o7qyNZWaCsh9gKLtPjN2vCBb4/c
         gt/cWwYRjm9ftFh5kvaXahYkQwYGZ41C2eDLD8e0C0lZ6LKOixlxCDYU6HvAvj7U+a2e
         7q8oaB/j+i2/neMacYkuYGz4IGRCcmBVuoBysf7KO3y4gN8vhfwA7qPJqyi2AkpIZ4Bf
         g6IQ==
X-Gm-Message-State: AFqh2kpuQTY+j4s4hZ61diTw8Vc1uLMJYr/ja04WsHcXLpnUro+tKAF4
        C6TPfH+Ba7zM7o8egNI2iMfjTw==
X-Google-Smtp-Source: AMrXdXv/VSEhNbI3QagWbDm4m7zmgaLffIGnwbBoZ6BqvGbUS/wDYVUhT45sEgxHuItqffNN/ZwuZA==
X-Received: by 2002:a05:600c:d1:b0:3d3:4d21:704d with SMTP id u17-20020a05600c00d100b003d34d21704dmr20349196wmm.14.1672329046542;
        Thu, 29 Dec 2022 07:50:46 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 13/14] soc: qcom-geni-se: add more symbol definitions
Date:   Thu, 29 Dec 2022 16:50:29 +0100
Message-Id: <20221229155030.418800-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The following symbols will be used when adding support for SE DMA in
the qcom geni serial driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/qcom-geni-se.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f5672785c0c4..400213daa461 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -103,6 +103,7 @@ struct geni_se {
 #define SE_DMA_TX_FSM_RST		0xc58
 #define SE_DMA_RX_IRQ_STAT		0xd40
 #define SE_DMA_RX_IRQ_CLR		0xd44
+#define SE_DMA_RX_LEN_IN		0xd54
 #define SE_DMA_RX_FSM_RST		0xd58
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
@@ -235,6 +236,8 @@ struct geni_se {
 #define RX_SBE				BIT(2)
 #define RX_RESET_DONE			BIT(3)
 #define RX_FLUSH_DONE			BIT(4)
+#define RX_DMA_PARITY_ERR		BIT(5)
+#define RX_DMA_BREAK			GENMASK(8, 7)
 #define RX_GENI_GP_IRQ			GENMASK(10, 5)
 #define RX_GENI_CANCEL_IRQ		BIT(11)
 #define RX_GENI_GP_IRQ_EXT		GENMASK(13, 12)
-- 
2.37.2

