Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F6070473C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjEPH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjEPH73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:59:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EE74C0A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:59:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaef97652fso95231805ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684223967; x=1686815967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/Vr1VrfFDgER7ZvfIYiWcEUpN45WoK7FIASNi3fnLM=;
        b=CgvzS+P3X3MERJa9EOXCYLt0dg3TvlF7Gj4ZmvhC24UGgeeeeWdcTrsX2/isQOcW8T
         mtbFe8hi+zJAGpcBTaJjWDC/x9nA/6EpTQUhc3F3fj+KMiAbXcjAtghcMHJCFAqropk8
         rSGpXlTNmWEhnFM78pVAJXGEng/nCWfJHrxCW1XTkiD6V0/LbCjzNbR75dcITQZu7pkp
         m++Z9vkkXlQOOJXu6vmLBkhok4B7bLgD944G8iVZ2RzQCmhvIQ/ZL4eJyYKD4XpQso4N
         QtGm6f3hUq8+YvfU8D8Jb3JhRCAxRJhdRBDq+0bBNbt7HOD1UAxa/2lktd2n0tAiardt
         /VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223967; x=1686815967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Vr1VrfFDgER7ZvfIYiWcEUpN45WoK7FIASNi3fnLM=;
        b=aCoq6JGjbI8eZI08eM6+wvoEDpWb/yTekhzFWyOrNOUzLZhksZUioIUoGmXjTOve20
         p35keeM/BAt5aMwUKWyPGh3Wy/yE5JH/bfklMyEMl8Ao+q6yqr/17/W+GEzm/SA/MFLs
         5fZV5iQlCd7HERTJ/vhtYosZGxVf4a+ler160fm/R6fUpBHJraYZ4soC3sX4UE4lsald
         +QVeVpPiS9XGlU/WvBMhYfhPF8pMUDbh+RbKoCfip2moCUvgWEsz3h4IN7DDH5owkRCl
         EYHbAutQlS5Oi8HvdOp+jq/Pc6wwCxUSmlXaX6nU15yMbviTAeEqkhFnBrp4QnaoD4C8
         TeLQ==
X-Gm-Message-State: AC+VfDw8XyZIwgVRyvjgQkGp0/pH4FrFSoBPtpwe2TeIecgkBIYnjKR+
        S53Ck20kYNdg/RcWmJxioPiKgsYtVaC7wZba3XQ=
X-Google-Smtp-Source: ACHHUZ5N8kiBkMolOzjgeBzPVizuVb2dadk8Fz6kf2vERXui0GySY3/b1R+jdQIIc3UuWqncFtdxdA==
X-Received: by 2002:a17:902:a584:b0:1aa:f173:2892 with SMTP id az4-20020a170902a58400b001aaf1732892mr798873plb.57.1684223967317;
        Tue, 16 May 2023 00:59:27 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:62ca:2e52:e0c5:d0cb])
        by smtp.gmail.com with ESMTPSA id cl16-20020a17090af69000b002532d74fb59sm469725pjb.22.2023.05.16.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:59:27 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: qcom: qrb4210-rb2: Enable aDSP and cDSP remoteproc nodes
Date:   Tue, 16 May 2023 13:29:08 +0530
Message-Id: <20230516075908.2323372-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230516075908.2323372-1-bhupesh.sharma@linaro.org>
References: <20230516075908.2323372-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the aDSP and cDSP remoteproc nodes on Qualcomm QRB4210 RB2 board.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index abea44fd369d..5cbca0e4ec90 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -34,6 +34,18 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/qrb4210/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qrb4210/cdsp.mbn";
+
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators {
 		compatible = "qcom,rpm-pm6125-regulators";
-- 
2.38.1

