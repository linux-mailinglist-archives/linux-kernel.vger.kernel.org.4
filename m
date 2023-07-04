Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9574713E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGDMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjGDMYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:24:32 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015C1BCB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:23:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso9921621fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688473402; x=1691065402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HXiDnQ0NiIURb63rI5A4UzqYhuJjljFFAXFRa3vQSM=;
        b=wV64RoIfLZ65I1BCz5eVLIjxu6o4ANcQjo8OzxBkXfVu6XfkqWwQrGPy+AayEuLdBv
         Mrc/rrWHNKA65mNnkDKzD1HuGHpvKhd/ftSQ+keCCHvXoG/UnII8LiwAYRskgoT0D+oG
         CRhAQao1TmX4CyLiY75n8tHU7SHJsQtraxyv0hnJ/jBEkDIcxipWho0T5yXwSST1an+L
         hh3mOV4zp2FIBqV2qkF6PCn6GaNv1q1qjWgSyYODgJ8dHdM4H2igfUahcS2HqJo9IwgL
         AW9+7UZn9iAWu0RzddUvOEG67E9KsNgdxbuUKFTjPIVLA9aFodxIJgORJn7Zcq25X3XK
         cvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473402; x=1691065402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HXiDnQ0NiIURb63rI5A4UzqYhuJjljFFAXFRa3vQSM=;
        b=hRjrtjGLvcwQ4nPgSC6rXHmfkXQmvZczxl6WyJ3AXjpjrjLMDcadbUCcDf9m5n/Hve
         N45+uN2ruHfn+cVK1SWj/yFY/Isa9omfp/oRdlZz9EJBQqdA4Slm8KEShkXJVj5eHDOm
         ahEH0TnzH0FQwHN82k3F/GvWujAxo3LH01Kl7BaGkaTectHlX0lCfv+fOcavY7DlH0St
         hjrprKusEhy+rGyEBWKODQtCbhmIPD5jF0WWms7R50If+Z/N3ALQwkTRtLgHiC2n3Iok
         BsmFtxdPsGLuRgMXHgUEtlYOI+Tf1RwiIVdqCmwWINUXkcaZlD6d3B4pX4///OLqn+ez
         U1Lw==
X-Gm-Message-State: ABy/qLb4zB1fUnJb97KLpApVAOS2fUp8oE7ypQQJqDWO7HuTdiVy2LEp
        0SKGtcQXBKpmhK+sHlZKEs5eGA==
X-Google-Smtp-Source: APBJJlEJaa47JJg66kpWGHDDlwikd2xdZLU1im4O5/CE+X2qZDWepIcHRTE2kenBPZun9cCYGtB8GA==
X-Received: by 2002:a2e:9d18:0:b0:2b6:dac0:affe with SMTP id t24-20020a2e9d18000000b002b6dac0affemr7589783lji.31.1688473401751;
        Tue, 04 Jul 2023 05:23:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id y16-20020a2e9790000000b002b6d465583csm2851817lji.126.2023.07.04.05.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:23:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] 8250 dma-coherent
Date:   Tue, 04 Jul 2023 14:23:16 +0200
Message-Id: <20230704-topic-8250_pcie_dmac-v1-0-799603a980b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQPpGQC/x2N0QrCMAwAf2Xk2UCsDjd/RcZIs+gCsyutijD27
 wYf7+C4DaoW0wrXZoOiH6u2JofjoQGZOT0UbXKGQOFEFzrja80m2IWWxiym4/RkwTZQL8J9R5H
 B08hVMRZOMnuc3sviMhe92/f/ug37/gNOJZ7QewAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688473400; l=544;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ebgvHGWJNSmcCaSzNGCH5tKf9n7ahelosAOLZnkzPCQ=;
 b=MYS/FAKFBE1TycqhgUSOBDW4NPv9r+lPUDEmVpQQKWU/cgJvUOeI9zseedjElHf8o/VzB8ijV
 Yb0J5sFe/gMBtlL9j7psBL9SOBwFqijkft02IFnQ9wwOe806+Rz1IGy
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

SMMUs and PCIe hosts on SM8250 are cache-coherent. Mark them as such.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      arm64: dts: qcom: sm8250: Mark PCIe hosts as DMA coherent
      arm64: dts: qcom: sm8250: Mark SMMUs as DMA coherent

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 5 +++++
 1 file changed, 5 insertions(+)
---
base-commit: 1c6f93977947dbba1fc4d250c4eb8a7d4cfdecf1
change-id: 20230704-topic-8250_pcie_dmac-5209cca980ba

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

