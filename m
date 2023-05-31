Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4719C718E80
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjEaW2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEaW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:28:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C35F1B7;
        Wed, 31 May 2023 15:28:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f61530506aso1972845e9.1;
        Wed, 31 May 2023 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685572083; x=1688164083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZrH6+6IbeVshYJ6pXjPVvHFDvO94wadeWCs5fY2QiA=;
        b=H4CSI83crZfYh6Jo3K7um1xH/c5908hKfqW328aMr5819CvyXz7KO2v2So9VMW93My
         Do3WjGcQkfRdDbKyuuh5xlbP5HTGVFsI7ujv0O3cZHSZ7kBxgf5NlMODEGxCagbC0U8F
         XodN8lsZtiDukaQ3YBYP+G1XTfaTyd2AVPaycM/7PvufRV2rPP2NDewzWRhSnXFoOunx
         g96H1azM6jHn9ewhwe0PhfDc+eGLKtRkXcTPeLwjp/7bJSRHOpp8NgLcyVbF30IyR9Ta
         pKX0BRzcb5nmm76dBe1ttdqq5FzQZTbliZJyNDrRKJmGAnGid7/BqmqUBGJHnQf9uPuJ
         afyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572083; x=1688164083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZrH6+6IbeVshYJ6pXjPVvHFDvO94wadeWCs5fY2QiA=;
        b=CpUZoOVhWbjFiUQw9EPKDPNd4fazTA2+mUUP729ohnhEfFoM3AHGHpfCWqfQVKBQPu
         zZxahCgkMIWpIi7fJLp55S1cnbW3L3sCVm7YB7KDY46B7bTaJxH4/MRkTt1834sMlYaC
         QxatncyrzCbVqPtncS/RnC976QeG1kcswfyp18g+woWU6MrwLhWMw7HpBMgFKEdeKOno
         nkwUPJoygRqkDlcev1b+QFNsrn3yGmCy6/RjqwJYupt4mec6hWVnvj++5xTOJElnInfT
         dtS6UPHNMlpcNzGxgK4sdv/bl65WS82TIjDIyXWx+fXrAzSXm7qVpz5oy7nLn462cMRp
         IopQ==
X-Gm-Message-State: AC+VfDw0Q12BV9b3bRdi8UxID+idFtrAVh0GUbGAxIkZyI0qr8+ThmKf
        2s+m9kxwuFiOiotNsy89I50=
X-Google-Smtp-Source: ACHHUZ4u3vb9tLYQqfnHtb98Q7pYBnUwLjiBTds/e+ZzRA5HEXqgheByPQDYF9xErLygKLzx5+4qrA==
X-Received: by 2002:a1c:7905:0:b0:3f6:1bb:1dce with SMTP id l5-20020a1c7905000000b003f601bb1dcemr642113wme.13.1685572082701;
        Wed, 31 May 2023 15:28:02 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id 9-20020a05600c028900b003f6132f95e6sm70020wmk.35.2023.05.31.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:27:42 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v5 1/3] clk: qcom: clk-rcg: introduce support for multiple conf for same freq
Date:   Thu,  1 Jun 2023 00:26:52 +0200
Message-Id: <20230531222654.25475-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531222654.25475-1-ansuelsmth@gmail.com>
References: <20230531222654.25475-1-ansuelsmth@gmail.com>
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

