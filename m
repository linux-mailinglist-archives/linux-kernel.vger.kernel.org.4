Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57266DF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjAQNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAQNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:55:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8A235B4;
        Tue, 17 Jan 2023 05:55:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so8189435wmc.1;
        Tue, 17 Jan 2023 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwWU7AdxQV1P5kT8whSf7fiDiHebnCcfByCUm7DXuys=;
        b=moF8JUP4g12vZ+LyUzrSDk44FqgJDsTh6zw+IyMKvh9Fvl2OTcydCTRSA0dT7dwngW
         4SztmBNasf5vBnAHvXRjG3ofaDa5SEoV8nSVQTuW/6K/WFvLvzZ0NTf8eYTZk+GCyCRI
         6O2b7RuakWUa4+p570Zps+qw9w1TvUzhaptIKzYWwMlEhkf8EbBhABLcxc+QaTKBy3aF
         fl/4CHl5yh00mvPTkLQ0oYqlwf3Czh9NHfm7RiT9hUSqNF/DuuO4pNDIcU+iQrCbS67+
         vD+Ble8ZxF52usjtmaoQUTDfUbOtsZEVc0IdzQHstRonAK2ejmKwn4j794DcyOgby2Ut
         9IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwWU7AdxQV1P5kT8whSf7fiDiHebnCcfByCUm7DXuys=;
        b=jDzYWtTVvx6R1C9AGiv5iHvUpGcEwo9ZDx+WlKoNiOnKZZqrFbDfsVQkwNE1PnN42n
         pHtjfEV2Sn80vjaBe68DeNq+vbuokmXrHG/8c9U1vZMMxwj0lQXjzDnyqVcXr0kIYw+l
         Oa2uceOkFkfoMDGytIVHwnNNTXzju7nKYQqjbdq/ahZYv7rf1qqROM5BN6110q4XIwlu
         aaJPsjy1fF34x7OVFUibggPFcgTACXy3hVCUqeEb/86hOfozLayK/+Trf1iXoQcUQThi
         jz4uKdjeLQsnvcrF8J9SNKmOTlCgaW4ymfd5UojWPYgxiB8t0qXUSlLaZWYA145BHDcq
         G/yQ==
X-Gm-Message-State: AFqh2kqKR+wxbfTq9f64lhVsVGetu+hiY2RpQM0va/nTLA61SHS7yxF6
        bBMfKkOo7lusDeqQ0X+7Qq4elUl/Mp4=
X-Google-Smtp-Source: AMrXdXv7NhmI8KHAY2Zm6qp8v1PMeYLEn+ydYPElk46w3qg4IQANcdKKxub3GdbK60ryGGtJvjPJiQ==
X-Received: by 2002:a7b:c302:0:b0:3d3:5c9e:6b27 with SMTP id k2-20020a7bc302000000b003d35c9e6b27mr11915381wmj.12.1673963721329;
        Tue, 17 Jan 2023 05:55:21 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm35147461wmc.34.2023.01.17.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:55:21 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 1/6] clk: qcom: gcc-ipq6018: drop redundant F define
Date:   Tue, 17 Jan 2023 14:54:54 +0100
Message-Id: <20230117135459.16868-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230117135459.16868-1-ansuelsmth@gmail.com>
References: <20230117135459.16868-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same exact F frequency table entry is defined in clk-rcg.h
Drop the redundant define to cleanup code.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq6018.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 3f9c2f61a5d9..350ead66914c 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -26,8 +26,6 @@
 #include "clk-regmap-mux.h"
 #include "reset.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_XO,
 	P_BIAS_PLL,
-- 
2.38.1

