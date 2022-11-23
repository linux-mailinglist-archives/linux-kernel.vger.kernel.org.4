Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB1635B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiKWLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbiKWLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911A5B70F9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a1c4409000000b003d02dd48c45so829779wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=cdSOdHs/KjSXHF/Ujb2s5z+xgIIMYtfWXWH133hqVTHYeWnQHOkZG77vID1B8el//j
         chFMWYMzu34/MUdQwHaNqmA3d4LuFlAe2JvqerDJ1nxFk+xZgQKZQ0B6cRp/LfoCs9LV
         4Iq4L6IfDba925iFhsyOKoxymTbrvWGTdg+GNwlhSPTQgiVMAU0u+EM33F/TRQ/AoO3m
         6VyMhf96Pc8WNqSwa6ZhpqZhre2zigBwbHdKajgI0TLs/7saALPyO0Qnei5sM8pHk0qH
         f+okl74ptDebMSMo9yAT29/Gbxx8pPuZ3xTpW/j0+gLVdMdOcyr4sCVrPsFWvl162j5v
         OCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuwEN90AtgG+bvIlYhOJ4Y3TdxahsORXGOntfwKDvGM=;
        b=0QzrmeKrqCaW2FZ6/SMm3m8mEXuLbOOWW7MM9WdBunyid1Mj5H4Mo7qNQAqmoiYQ20
         5XntVyDnBEnKjXpt7ucmJw3yIBJn7of80aCtk5OBTx7MigIilfaC3I6YMjs2Y4QVNKX1
         KT4so7S02uE/Ekiy36RDu5o83W60b9bcYpIJgztH3DF0Z4QbT4MWQ6Sb+9VKJJs6f0O+
         57DGbSoUvOgOeh9uuNxmanbJxPBp99ewlrXDMVcpNhPvqXt3+ot7mfvHDCVsK/yIl3uI
         ddugUwGFmcTaYCoOmF6Q5VebVgWKlLeYWaCloQ4drGiOrsG7bRyOaJDa4tU0swolKM0r
         Bopw==
X-Gm-Message-State: ANoB5plLipnMM/JU76xB4CFAEr+AaDBxRCwduRWkOFysfvTnKv7nQBO0
        RCZC6lnr9jrQRpiuEjcnqvMwMQ==
X-Google-Smtp-Source: AA0mqf7lrffAavFH15caxjhg3/q3mMYgUIGPIQZ+PhBGWwXzUmcDzYn0NZ+q0yNwuEJgEM6g7lTizA==
X-Received: by 2002:a7b:c4d8:0:b0:3cf:b0ed:de9d with SMTP id g24-20020a7bc4d8000000b003cfb0edde9dmr7243730wmk.188.1669201696131;
        Wed, 23 Nov 2022 03:08:16 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 12/13] soc: qcom-geni-se: add more symbol definitions
Date:   Wed, 23 Nov 2022 12:07:58 +0100
Message-Id: <20221123110759.1836666-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
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

