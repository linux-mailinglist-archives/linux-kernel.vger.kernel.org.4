Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD09D6F0F73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbjD1AUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344165AbjD1AUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:20:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9132D47;
        Thu, 27 Apr 2023 17:20:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2fddb442d47so8371900f8f.2;
        Thu, 27 Apr 2023 17:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682641199; x=1685233199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZrH6+6IbeVshYJ6pXjPVvHFDvO94wadeWCs5fY2QiA=;
        b=KUSC9zf2hVdft30Wie201SfB7m8CWgJ087v8vcxIGbp6iAuJ03zAAzLxSM3MNPJ4p9
         LtHXdwxcO+Z3Eo+sIQkHzTrgUUjEtXIQq9dLE6F9dXSKkcgOpJRaYkv+z23WvV7NA1+F
         YiBPftW1//VriJS4IUHD0I+OQq9P/JH6YTRPKNcR+6MIrm/I/Y9eaiZrFZXXufh1HmYc
         bbgNmMclgUBdHPRHTAFzN5269NqutwTLXdNKeMza7LwLlp5+z2tij2vCbTv9jRMp5Mf9
         xT+MOIFYqXP5hve9ZxPS8w1eQI5b8PDJmxbMg/uQhaSRMG/bMrCHoLeEeA0OlAZ5jsu+
         UeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641199; x=1685233199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZrH6+6IbeVshYJ6pXjPVvHFDvO94wadeWCs5fY2QiA=;
        b=RekZpw3xcAzx0L0s8ayN+95VCviMYevs0YZ1bJACVooSpto0rbmdmCZofWxkHJp1Ov
         xBny7QcM4Zyui6vQrwUnROWUnqQ6DRXk3fQnXO9iyZRGHVtG51E7pj9fJT8lZs/x911d
         R1OYqBBZ8+1zY5F/rC7XmKnATov85CqBhLrdYI2FZMnWPUKA88JgS1B2xbTkyoecn8/v
         TFeWhhPtREIXRWB2c1jfo0VYfOvmcR4dNTCO5+SIoZoSLIwKW9dPwd2kFuzBDMiHgmb0
         H5ILXH5JQpAf8i239KlhGpEeGE8S8sWK6/T9l9hWij9YTLnGvFFvkMv4Ii8x5OaXj5pf
         BFHg==
X-Gm-Message-State: AC+VfDxs3rN0kLetjYosfMQVGbEhkeW1hHCVw8gTZCOR7Ly04YVtb2G9
        MOyjp8QVp2ZcXU2FPTL+FEU=
X-Google-Smtp-Source: ACHHUZ5fgGMgCuHZ6B4gcxH5PGbTs67mVtVdIN+OriG8Qz5AQdDizdAOIEGO2tIwkKGGXcpAr3DppA==
X-Received: by 2002:a5d:4a0f:0:b0:2ef:b4a9:202f with SMTP id m15-20020a5d4a0f000000b002efb4a9202fmr2522698wrq.69.1682641198338;
        Thu, 27 Apr 2023 17:19:58 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id d3-20020a05600c3ac300b003f19b3d89e9sm16362095wms.33.2023.04.27.17.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 17:19:58 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 1/3] clk: qcom: clk-rcg: introduce support for multiple conf for same freq
Date:   Thu, 27 Apr 2023 17:07:15 +0200
Message-Id: <20230427150717.20860-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230427150717.20860-1-ansuelsmth@gmail.com>
References: <20230427150717.20860-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RCG frequency can be reached by multiple configuration.

We currently declare multiple configuration for the same frequency but
that is not supported and always the first configuration will be taken.

These multiple configuration are needed as based on the current parent
configuration, it may be needed to use a different configuration to
reach the same frequency.

To handle this introduce 3 new macro, C, FM and FMS:

- C is used to declare a freq_conf where src, pre_div, m and n are
  provided.

- FM is used to declare a freq_multi_tbl with the frequency and an
  array of confs to insert all the config for the provided frequency.

- FMS is used to declare a freq_multi_tbl with the frequency and an
  array of a single conf with the provided src, pre_div, m and n.

Struct clk_rcg2 is changed to add a union type to reference a simple
freq_tbl or a complex freq_multi_tbl.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 01581f4d2c39..dc85b46b0d79 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -17,6 +17,23 @@ struct freq_tbl {
 	u16 n;
 };
 
+#define C(s, h, m, n) { (s), (2 * (h) - 1), (m), (n) }
+#define FM(f, confs) { (f), ARRAY_SIZE(confs), (confs) }
+#define FMS(f, s, h, m, n) { (f), 1, (const struct freq_conf []){ C(s, h, m, n) } }
+
+struct freq_conf {
+	u8 src;
+	u8 pre_div;
+	u16 m;
+	u16 n;
+};
+
+struct freq_multi_tbl {
+	unsigned long freq;
+	int num_confs;
+	const struct freq_conf *confs;
+};
+
 /**
  * struct mn - M/N:D counter
  * @mnctr_en_bit: bit to enable mn counter
@@ -138,6 +155,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
  * @safe_src_index: safe src index value
  * @parent_map: map from software's parent index to hardware's src_sel field
  * @freq_tbl: frequency table
+ * @freq_multi_tbl: frequency table for clocks reachable with multiple RCGs conf
  * @clkr: regmap clock handle
  * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
  * @parked_cfg: cached value of the CFG register for parked RCGs
@@ -148,7 +166,10 @@ struct clk_rcg2 {
 	u8			hid_width;
 	u8			safe_src_index;
 	const struct parent_map	*parent_map;
-	const struct freq_tbl	*freq_tbl;
+	union {
+		const struct freq_tbl		*freq_tbl;
+		const struct freq_multi_tbl	*freq_multi_tbl;
+	};
 	struct clk_regmap	clkr;
 	u8			cfg_off;
 	u32			parked_cfg;
-- 
2.39.2

