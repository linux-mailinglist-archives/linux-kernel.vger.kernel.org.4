Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA9B7504C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjGLKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjGLKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:36:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7A71FE1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66767d628e2so4658417b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158152; x=1691750152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFjFH233scMmITorrcsknOFXDQIt6REL4AFr2F5rKyQ=;
        b=EH1y6ekc5Wzc8ViAqmKnrOTF2Via7DgXFlhQockOiZt+XdNY+a+Ekqt0vPvEcK1pjV
         Qq0FZDsNcPbtmxS9l15tWiRO1s2zathdlGaNTmudM3FszkGELXzuxZzJwLUL5/6dN0aS
         UMYysA1FpMEZfv18ikZTQWr3ITae1uPcnQUKzNuncDaAlS5zpHb6kuHvga91Gkt1ahg5
         BgYRUqydPzRVCPNTAee3M910vZejDtyyWXclYSJ6GCNJeDQ23o11wahoZvnC1HT02YLP
         nw4McMLxNDEt88mZh/RrjEBq0nezN3ysJDPbdo6oyZfHi0WvQIdW/E3tRdnigkQCckv2
         P1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158152; x=1691750152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFjFH233scMmITorrcsknOFXDQIt6REL4AFr2F5rKyQ=;
        b=X3MbFDqE9se37AYDyK03jkbzYxXKLtAxI6r6n+T6Z7s7j8ZjLdIH7cE0fxJgAFqpYi
         ZfqJLNKYvftyE6ABydnPYQ7QM3dbP0KPr6cl4kSBSDZeidWVYGipeuRxnDEzGfyJGoGm
         eJh+FXitldbHbTdnkv6cSTSb5UvN2ihrtIETLaV8SCGTXUwkYKcMdb8VhFc0zfW0oTrf
         Ws1xKmJg1oGPnTRJeL3FYNnk22jClMyGJSg+afcvgYXfyG/8a7rdo2lzYwd7q3G8vC/z
         21P8EFZoZRf8KQDVBC8db3CCkQuYG7FF6GNzjT0UIR2OMM8mLaz4LwbLd9SnpRF2CqI0
         JCmw==
X-Gm-Message-State: ABy/qLaGub1Nh3T/1xgkmGVTlmp4huR7imjTcdfWE+Qcn0a5BcOV3BID
        nrnyVo+L65NnvqgaNwT7mnfu
X-Google-Smtp-Source: APBJJlG6NS4d7h919E7mMzWP+Ffih1PggzK8zbQg3ZC763/yLWygTiAzu6+LifsJ4ZwtCGY8KL2t8w==
X-Received: by 2002:a05:6a00:1943:b0:67a:a4d1:e70 with SMTP id s3-20020a056a00194300b0067aa4d10e70mr16361154pfk.16.1689158152681;
        Wed, 12 Jul 2023 03:35:52 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:35:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/14] arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC
Date:   Wed, 12 Jul 2023 16:02:11 +0530
Message-Id: <20230712103213.101770-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS host controller requires interconnect path configuration for proper
working. So let's specify them for SM8250 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 72fd66db9c51..7a495ff7512f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2197,6 +2197,10 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			operating-points-v2 = <&ufs_opp_table>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
 			status = "disabled";
 
 			ufs_opp_table: opp-table {
-- 
2.25.1

