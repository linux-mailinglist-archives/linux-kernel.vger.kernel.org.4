Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D36E4F87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjDQRox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDQRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:44:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A5FAF02;
        Mon, 17 Apr 2023 10:44:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id gw13so14228862wmb.3;
        Mon, 17 Apr 2023 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753465; x=1684345465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJW18Rs7JyEs07/Vsxl5Q/32nWcrgJz6KvKEee91fk0=;
        b=BV10jJi+xwQ6OOPKITXXNWMZq06YdlI4y7lJhXPx918vi9tx96j23IdJF8FJ30yeWF
         kHE/oPeOweEOXFPIZM7gTOY8i+YUhXHpfZinoPBJD/zY7gizeO9k+UUMbxR1ioNc7/E7
         y46KJ3eDsRmJ3yTYOcVQJENEmRk3j8f4VThzaELqqpiNf8nLBaIfa+6E74K4K4FY1gWR
         BVfgJ2/EukUqOLwhpzd+MKpORW5ON8kJSG3b7ohVBwe4luZVpqWyPhV4hqRUzwTLhH1C
         KTsjXYoF3JYO740OiQd3VRvVxkcMe+BIe5T49dPCHBcAcrFUZ7dwVEDFnRUyWCqr4kUD
         n3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753465; x=1684345465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJW18Rs7JyEs07/Vsxl5Q/32nWcrgJz6KvKEee91fk0=;
        b=k0eX/PaV+ksyOj7jzDvGa6fyQ11WbmFA/DS1x+BSxphgPR05QA6Vt61ZymkweoSXLI
         w6Lpq+nP0ySJKg/9hlot8rpL53RRAzVMMa/WrUDoQf9HyacdZ7DdEcTordQrIBcLjrmI
         0BtFe/6ksye3Nz8qrbPq0lT3pRiSUfHbfcUq+CrSLikvKF151aiOxkAaCDL052xByCAc
         FzxHAn1NKJmQMvdAGGl4RxCT0+us+OzDx02x/zXf8NIzP1Osqdng2g0L/sUuKNxMJRKo
         WV+sBLUs4nwIEwDDJVxmNYZ/+KsfOY7JSEfdymQ39J78lsGA6PKaOknuiPH4tQJT/ykM
         PdMg==
X-Gm-Message-State: AAQBX9fDyGnevtIyu/9gljr1zua3YgEvZulO/wFfP3rpkBcfuptLpWOo
        pZ73NHvohYNECxz2ztPaYqA=
X-Google-Smtp-Source: AKy350apxZRx4/sxLOBqB59xySZBVPcCeQ+i8o2uxY9qtWQKPTKExJWAsp2IFvQ1442jz7n6Uz1dxQ==
X-Received: by 2002:a05:600c:229a:b0:3f0:a098:f503 with SMTP id 26-20020a05600c229a00b003f0a098f503mr11484013wmf.14.1681753464918;
        Mon, 17 Apr 2023 10:44:24 -0700 (PDT)
Received: from localhost.localdomain (host-87-7-13-196.retail.telecomitalia.it. [87.7.13.196])
        by smtp.googlemail.com with ESMTPSA id f24-20020a7bcd18000000b003f09a9151c1sm12516155wmj.30.2023.04.17.10.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:44:24 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] clk: qcom: gcc-ipq6018: drop redundant F define
Date:   Mon, 17 Apr 2023 19:44:07 +0200
Message-Id: <20230417174408.23722-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.39.2

