Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E573D66DFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAQNzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjAQNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:55:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D5CA5D1;
        Tue, 17 Jan 2023 05:55:24 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so4757711wmb.0;
        Tue, 17 Jan 2023 05:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/YQBj43LvkuMtMLizVCG8ygRtt4qtKP2BAx3uKg5y0=;
        b=OdHzgEo61CAxJoYC3tyZRbSQ5t1Ix3w/mnWeZRcfXysN0zeH/HfqmnhjOeOIzjKRqx
         b51SfG3Q2sgY3X7M6NtioNu2Xn2vvZflbQdoqdDzIl3bFlU2nsGxKm+Ccbzoiqh5O+vQ
         hq9klslOQwg3PbB2CuUsbx12+qAC7zegju3FY0fxkr8yO3Tla0acf1FvGB0w69xhh9N4
         fuyfvPfUfWROlFIu3gltjOFwftfIaUcoc1YIEds4fOCz/Dbn7YjoV18wTFd3Ik2tL5LF
         FDzQaeD90mo+OMBddt46YKScvhLrImFpub/zYfblt4cXJ62ZhfweCO1o5qs25aTBvoEu
         DYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/YQBj43LvkuMtMLizVCG8ygRtt4qtKP2BAx3uKg5y0=;
        b=A7ezuIzQe8ptldXCkrQJ+7WCYc/LgeN3nK1Lv1ZkacaE5By/JT9a9MnabiiJEGUd6x
         wENCxXzDxNkUJubAM7bFM3RqwruNW63b65M30hvs13doiIQqg3+1vgbR/zJvnzyJmd4U
         Vp13PK6AEOi/AgUL/qOHNpyKG4S/7lj/7pbtHv98VNKaNAhWEzXL+iC5o0LDo/8etWVb
         jgrY1ZRML1GDpW8FVPb3L4SnohUAhUSmMNx+lp8nDuzR+LVy9RsF3QGGsLwfGesbJqZS
         0BpRbUtu921bXTzVrDcJFzQjr1FRlLmlyLsjL+TVH7xyf4j02ByGcyAZuoXYbl581p9H
         f9dA==
X-Gm-Message-State: AFqh2kpvCCdqYRj2UHUg/tHO7CWM0s0PuC76g0G7Yp6nNRoGshcxBVXT
        /WleoS5MlIPX0bRo92js7Vz+dDCOhus=
X-Google-Smtp-Source: AMrXdXsRDfxE+e1mW+DGRGFaUCRg6QC+YCfV+vS4G0Z+znPnK9bfeZc9SZmp3fILlNA3wsP6tOoonw==
X-Received: by 2002:a05:600c:2046:b0:3d2:3ae8:886a with SMTP id p6-20020a05600c204600b003d23ae8886amr11807809wmg.17.1673963723187;
        Tue, 17 Jan 2023 05:55:23 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm35147461wmc.34.2023.01.17.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:55:22 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 3/6] clk: qcom: common: add qcom_find_freq_exact
Date:   Tue, 17 Jan 2023 14:54:56 +0100
Message-Id: <20230117135459.16868-4-ansuelsmth@gmail.com>
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

Currently qcom_find_freq will always find a freq following a CEIL logic
but we may need to find the exact requesting frequency or return NULL.

Add qcom_find_freq_exact to perform a search of the exact requested
frequency.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/common.c | 17 +++++++++++++++++
 drivers/clk/qcom/common.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..ffa91bcc0b0a 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -57,6 +57,23 @@ const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
 }
 EXPORT_SYMBOL_GPL(qcom_find_freq_floor);
 
+const
+struct freq_tbl *qcom_find_freq_exact(const struct freq_tbl *f, unsigned long rate)
+{
+	if (!f)
+		return NULL;
+
+	if (!f->freq)
+		return f;
+
+	for (; f->freq; f++)
+		if (rate == f->freq)
+			return f;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(qcom_find_freq_exact);
+
 int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map, u8 src)
 {
 	int i, num_parents = clk_hw_get_num_parents(hw);
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..7bd935332634 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -45,6 +45,8 @@ extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
 					     unsigned long rate);
 extern const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
 						   unsigned long rate);
+extern const struct freq_tbl *qcom_find_freq_exact(const struct freq_tbl *f,
+						   unsigned long rate);
 extern void
 qcom_pll_set_fsm_mode(struct regmap *m, u32 reg, u8 bias_count, u8 lock_count);
 extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
-- 
2.38.1

