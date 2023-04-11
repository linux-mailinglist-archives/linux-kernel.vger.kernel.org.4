Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB876DE5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDKUVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDKUVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB0F1BD1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681244431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAO/yBZf8skBWnF2ClvjjOWitw4YoPtRAkhOVp1lGw0=;
        b=PqXcA0h18UtPg8yOoPHw7mvT8mxtudkiGE3XaimD+7OQ6ntbY3QG/eBON4Ji3mMwEPu/bP
        Ur2UE2ZtZaUHVJHvgxJYac86X31m3VToioLtSb+E9PWKO1glx18JCnk5O7IIL6uNEkp5cB
        2HvZAA6OIe8Reu9ux64OUWCTSKJL+TM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-NgwvUKtON-K9CUJ9F4-EKQ-1; Tue, 11 Apr 2023 16:20:30 -0400
X-MC-Unique: NgwvUKtON-K9CUJ9F4-EKQ-1
Received: by mail-oo1-f70.google.com with SMTP id o10-20020a4a958a000000b00541a5227788so3809558ooi.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681244429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAO/yBZf8skBWnF2ClvjjOWitw4YoPtRAkhOVp1lGw0=;
        b=NQokqm7cvkuwSLpp1CczMpKwrUu9o6cprAitGFLqc5U5ggEIubZxHq0cACoiE59NCO
         /wh6OVC+0C5YFjVvMFZGFrqAvX7Z7Wik9ry5Pnbol0wqnZEeMCbp3hRE88c1r4DNg6uC
         vs3akjrVXs04bynBiG5+xAecISZIU61xgdwWqqAKTC9F+Xr1oqCS65DzERNiFSedKjN9
         /cPD7/O119230X/aC5f3pBjOxcdfZB1FAGDcbnmThkGLvHmhZRcTM3NECQ5/Aal+Sj+N
         qnOBTepxrJOQTbqgKYSDJszkJx2EN8WgtAp3GPdJNyXON6fNWoi2RUFE6Euxu2pl3SDM
         uW3Q==
X-Gm-Message-State: AAQBX9fxIU1ON2tOp4kPJqkklGsmTgqssKiCmVj/TwZ9qnlHyG/QlUOO
        BPZorgOz51WYWGwc6GsfIAiwZsejFGBgKFb9KtA4prvHOFembYpCRGH5GppOp3rU3sNOSJrTEuJ
        DxNJc8i1LcUctkyyjOf/scurV5M3wMd/v8TLI5GooYkohNHieOpN0IvAk80daqSsbu5jOlZI8Xe
        o9IVUa+B+0
X-Received: by 2002:a05:6808:4049:b0:389:545c:a95f with SMTP id cz9-20020a056808404900b00389545ca95fmr6886882oib.42.1681244429578;
        Tue, 11 Apr 2023 13:20:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350YPR2LQHlTHzQQP2ZpyFnVktCdGOPlwiTBCMdxQEi+/a+dGbDPEWLWzMrMEgK9DEToYfgi+wg==
X-Received: by 2002:a05:6808:4049:b0:389:545c:a95f with SMTP id cz9-20020a056808404900b00389545ca95fmr6886857oib.42.1681244429281;
        Tue, 11 Apr 2023 13:20:29 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id a6-20020a056808120600b003874631e249sm5976710oil.36.2023.04.11.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:20:28 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        richardcochran@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org, bmasney@redhat.com, echanude@redhat.com,
        ncai@quicinc.com, jsuraj@qti.qualcomm.com, hisunil@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v4 1/3] clk: qcom: gcc-sc8280xp: Add EMAC GDSCs
Date:   Tue, 11 Apr 2023 15:20:07 -0500
Message-Id: <20230411202009.460650-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411202009.460650-1-ahalaney@redhat.com>
References: <20230411202009.460650-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the EMAC GDSCs to allow the EMAC hardware to be enabled.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v3:
    * None

Changes since v2:
    * Add Konrad's Reviewed-by

Changes since v1:
    * Add Stephen's Acked-by
    * Explicitly tested on x13s laptop with no noticeable side effect (Konrad)

 drivers/clk/qcom/gcc-sc8280xp.c               | 18 ++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index b3198784e1c3..04a99dbaa57e 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -6873,6 +6873,22 @@ static struct gdsc usb30_sec_gdsc = {
 	.pwrsts = PWRSTS_RET_ON,
 };
 
+static struct gdsc emac_0_gdsc = {
+	.gdscr = 0xaa004,
+	.pd = {
+		.name = "emac_0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc emac_1_gdsc = {
+	.gdscr = 0xba004,
+	.pd = {
+		.name = "emac_1_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct clk_regmap *gcc_sc8280xp_clocks[] = {
 	[GCC_AGGRE_NOC_PCIE0_TUNNEL_AXI_CLK] = &gcc_aggre_noc_pcie0_tunnel_axi_clk.clkr,
 	[GCC_AGGRE_NOC_PCIE1_TUNNEL_AXI_CLK] = &gcc_aggre_noc_pcie1_tunnel_axi_clk.clkr,
@@ -7351,6 +7367,8 @@ static struct gdsc *gcc_sc8280xp_gdscs[] = {
 	[USB30_MP_GDSC] = &usb30_mp_gdsc,
 	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
 	[USB30_SEC_GDSC] = &usb30_sec_gdsc,
+	[EMAC_0_GDSC] = &emac_0_gdsc,
+	[EMAC_1_GDSC] = &emac_1_gdsc,
 };
 
 static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-sc8280xp.h b/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
index cb2fb638825c..721105ea4fad 100644
--- a/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
+++ b/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
@@ -492,5 +492,7 @@
 #define USB30_MP_GDSC					9
 #define USB30_PRIM_GDSC					10
 #define USB30_SEC_GDSC					11
+#define EMAC_0_GDSC					12
+#define EMAC_1_GDSC					13
 
 #endif
-- 
2.39.2

