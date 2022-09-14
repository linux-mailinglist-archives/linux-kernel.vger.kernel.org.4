Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5202B5B8AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiINOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:47:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC03659EE;
        Wed, 14 Sep 2022 07:47:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y17so30241143ejo.6;
        Wed, 14 Sep 2022 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=y0tx4iXEt6rtKpQ7JfJuD84UB0Bf5IVCRu8OAnpgQxs=;
        b=F4doHotWLWUSfD3H6nxU9wHelCDt5FuEFgfpisf/KHiEVlxit1EN2h52YJ0B5Z7NLg
         jf1BIFET+hvXkpn8Vb6OToIUyAQn1H7SkXCfQTuph9wnNssGHV/rgXdV9zXZpFoQfc/y
         VD7kIS8JqMwyXFyelZbMZFpVwbhI8lU7SDiz6yy4uakTycvdOjCUkwhHXPIBZ0wxUXFg
         SxbwYWcHFkFS/vgZ2akRRNENy04tpQOLM6uBdqBrOAbjyJnUK1rMgbiRjiDauC16t3EN
         Tg4qSlTsMNaVoISwIoIvVfhZROA7/d7LKnijVl+0eKfFoAUoYFiJMjkLsjFOW5+4TLDd
         c7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=y0tx4iXEt6rtKpQ7JfJuD84UB0Bf5IVCRu8OAnpgQxs=;
        b=qnPD80dWz52KeiVFAN/Yby/6BybphMzRUqPNcpRgjjKVZH47+YyzLuwiBsGc3ISZv/
         AkwnGBdJEqDexpQ6I3m6+3NEAjPMyZwpWd1gtjt+97aKHH7RrhWl5E23i6Mse7Swo0AK
         jUVzY2NoKsR7KDYFXFEX3YPeD4eiLpOjDdgTTDUgb0jq1azk/YvnHPki5HpZyKvGZj6/
         2CIcuFwrd8hJdJJiWaXKQDZkNPzNbogEYbxOE92NhEzNBkQMBzTCEd0+rxn1NT78q//L
         M+G+4iAwhrjr5+Gx8QqvRKghrvhOQryrv9d/XLDSygoC9E3+rasNGR4ju62dICE0njMJ
         JGhQ==
X-Gm-Message-State: ACgBeo3kq5Xsqk2qm8KPl9BLMtfiL/8vvMwddJe8e0EHL5Q0wI2ljSRl
        AxjkL+mD0Qk4NvOpZcTOj64=
X-Google-Smtp-Source: AA6agR7TCG6qJgnxms9eWwvhts2s5/ovjaT5lWQx3UyShlI9J/b3cee8fmDf8c6CPxU2yTEE/mXYug==
X-Received: by 2002:a17:906:5a6a:b0:77c:2c7f:bd69 with SMTP id my42-20020a1709065a6a00b0077c2c7fbd69mr13308438ejc.283.1663166870614;
        Wed, 14 Sep 2022 07:47:50 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id 6-20020a170906300600b0073ae9ba9ba8sm7601484ejz.3.2022.09.14.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:47:50 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/2] clk: introduce (devm_)hw_register_mux_parent_data_table API
Date:   Wed, 14 Sep 2022 16:47:42 +0200
Message-Id: <20220914144743.17369-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Introduce (devm_)hw_register_mux_parent_data_table new API. We have
basic support for clk_register_mux using parent_data but we lack any API
to provide a custom parent_map. Add these 2 new API to correctly handle
these special configuration instead of using the generic
__(devm_)clk_hw_register_mux API.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
v2:
- Rebase on top of linux-next/master

 include/linux/clk-provider.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1615010aa0ec..65b70f0d62c5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -974,6 +974,13 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 	__clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL, NULL, \
 			      (parent_data), (flags), (reg), (shift),	      \
 			      BIT((width)) - 1, (clk_mux_flags), NULL, (lock))
+#define clk_hw_register_mux_parent_data_table(dev, name, parent_data,	      \
+					      num_parents, flags, reg, shift, \
+					      width, clk_mux_flags, table,    \
+					      lock)			      \
+	__clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL, NULL, \
+			      (parent_data), (flags), (reg), (shift),	      \
+			      BIT((width)) - 1, (clk_mux_flags), table, (lock))
 #define devm_clk_hw_register_mux(dev, name, parent_names, num_parents, flags, reg, \
 			    shift, width, clk_mux_flags, lock)		      \
 	__devm_clk_hw_register_mux((dev), NULL, (name), (num_parents),	      \
@@ -987,6 +994,13 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 				   (parent_hws), NULL, (flags), (reg),        \
 				   (shift), BIT((width)) - 1,		      \
 				   (clk_mux_flags), NULL, (lock))
+#define devm_clk_hw_register_mux_parent_data_table(dev, name, parent_data,    \
+					      num_parents, flags, reg, shift, \
+					      width, clk_mux_flags, table,    \
+					      lock)			      \
+	__devm_clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL,  \
+			      NULL, (parent_data), (flags), (reg), (shift),   \
+			      BIT((width)) - 1, (clk_mux_flags), table, (lock))
 
 int clk_mux_val_to_index(struct clk_hw *hw, const u32 *table, unsigned int flags,
 			 unsigned int val);
-- 
2.37.2

