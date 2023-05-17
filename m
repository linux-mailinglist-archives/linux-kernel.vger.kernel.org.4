Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB65706E64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEQQk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEQQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:40:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B540CE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ad89c7a84fso10237711fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684341650; x=1686933650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGFT+wjphG28hwnPjTkUYcKbXPZiE3HV0SuQwI1BQuo=;
        b=tiYtdPRSS5OEaeC6FPpC77eMRKHKuH8xMPa+TlI8AI77Znq/T31xAIXm/aPQ572PEs
         XsUqU73sE/cK2rnT0+OCc1xbbYB/z6+aaQhX6LOCsDozNXO+t2WdZGHS2lSZ3aIZBjTo
         taCNQNv9X/lHqf3KyO47Ffi4psBt9z7KK0cL1ZWqtyyzdY95H8wkttyJCu4s47SVWQvn
         QwA0kt1kGqG8aHEI9silkPmIeCG7CE/j6A/DrLhs1mDfifXc84LJQI08UtShloGx3S4j
         6mNTYu9Ti4qul6624iAPtrp/f4Yg0DrtbSd8u96UG8VFzl1A2618SgTzGH8hFjjsP6al
         5mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341650; x=1686933650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGFT+wjphG28hwnPjTkUYcKbXPZiE3HV0SuQwI1BQuo=;
        b=ZqKEMWIgOfpU4MtGyKqioA5kpOqNiedCspasGCKPgRYryyrg0fOcocevZkX2z2I57e
         D14PmjwQ82KevAh7MrQ5Md5l2IERCEzjXTuthcrQ/NRVoJKegjwsDVLArzshUYGAWAMW
         X/eZIsPt/4hGFUwbUI/ODItXBt+BSLWidWbMeaEfKpbzZz4SU+aWq2LtAr/16i/vy5sg
         PW/fyjwbB6v+OiHL4kdbehyRvl9WFT1wh34wWsJ984tO+K1zO8WHbOXKx0+FV99ectjs
         CB5zdP6j+kvColtojHmjv3Ss45cyCA2ghoXXY/RSM4tYLaWUMVTkk/Bd6M7CfhNWmFdh
         IrXA==
X-Gm-Message-State: AC+VfDzCC32axPCZ8ru8N0APKplEPVueJDElBRdc1f+ohb4NQsa/+h4T
        6L1stUX/S2KpM2q0KDoYtOao8A==
X-Google-Smtp-Source: ACHHUZ7AnvhYliNKkvo1wXuA6iTJAjlwQDBn+N59qe0ubrnV2L6uSxGKtLeIama5Frq1U5dGduIzeg==
X-Received: by 2002:a2e:8e86:0:b0:2ad:9751:8d79 with SMTP id z6-20020a2e8e86000000b002ad97518d79mr9234043ljk.31.1684341649893;
        Wed, 17 May 2023 09:40:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id 9-20020a05651c040900b002a8c271de33sm1919259lja.67.2023.05.17.09.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:40:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 18:40:39 +0200
Subject: [PATCH 2/4] clk: qcom: rcg2: Make hw_clk_ctrl toggleable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-waipio-gpucc-v1-2-4f40e282af1d@linaro.org>
References: <20230517-topic-waipio-gpucc-v1-0-4f40e282af1d@linaro.org>
In-Reply-To: <20230517-topic-waipio-gpucc-v1-0-4f40e282af1d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684341644; l=1689;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fnX8Gs7THnPKyxc7XYOaJzSXtKdHLn/shBY+gLa1OAc=;
 b=dc7FDYnfPDVDqiSyXx2sBVWzWIEGK2mW+pKm3QRUvO8ubVk5bfUJ7nDe0HxUNk6RCH6W5Kwgo
 5HC3owtkZg7Dw/0EFcRcNNhwp7/Ei6prAIfkiumFuISDWhw/Cw+Mazg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain SoCs use the HW_CLK_CTRL feature on some of the clocks they
host. This allows the clocks to be turned on automatically when a
downstream branch tries to change rate or config.

Make it togglable so that we can utilize this.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-rcg.h  | 2 ++
 drivers/clk/qcom/clk-rcg2.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 01581f4d2c39..e6d84c8c7989 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -141,6 +141,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
  * @clkr: regmap clock handle
  * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
  * @parked_cfg: cached value of the CFG register for parked RCGs
+ * @hw_clk_ctrl: whether to enable hardware clock control
  */
 struct clk_rcg2 {
 	u32			cmd_rcgr;
@@ -152,6 +153,7 @@ struct clk_rcg2 {
 	struct clk_regmap	clkr;
 	u8			cfg_off;
 	u32			parked_cfg;
+	bool			hw_clk_ctrl;
 };
 
 #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 76551534f10d..e22baf3a7112 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -325,6 +325,8 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
 	cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
 	if (rcg->mnd_width && f->n && (f->m != f->n))
 		cfg |= CFG_MODE_DUAL_EDGE;
+	if (rcg->hw_clk_ctrl)
+		cfg |= CFG_HW_CLK_CTRL_MASK;
 
 	*_cfg &= ~mask;
 	*_cfg |= cfg;

-- 
2.40.1

