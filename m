Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4C620739
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiKHDFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiKHDEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:04:41 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD56E30F56;
        Mon,  7 Nov 2022 19:04:30 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id mi9so9466830qvb.8;
        Mon, 07 Nov 2022 19:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7kc281aVcUMddvIOOcqINBZLyKd0NANguvehTEG+Zg=;
        b=Bnj88o/IpMxFVLdv5E6pTauWyRdR1vKD14e3GykKwAZMHnVTla0COz/e0L3NQ5FqJF
         zFpy9+2T15mlzvogsx0YxcBWDc1PUQdFjAL9uTPVGnUGk56HsJfBL+rqz2gKFLD49Arl
         4vc/7aPyKhMnof2wgv/w30XCbx/t2i/xyYbg6ZVy37MjvXfXqwh+zL93mp+71IQN0oc8
         yN9HQbhVz5LyfWV859zZ7iaqlVfH7OgM/ppJbmjTrMWhpqHRYahNmcRq1p4Jqel11sRa
         dIafoyGAUfcFgOhBNjKKW+qAcj0LjAbN7W1XiqL7zeV08W+n3kezkiMELdxMCxU6rbWD
         Mtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7kc281aVcUMddvIOOcqINBZLyKd0NANguvehTEG+Zg=;
        b=3KKlh03Hx7VQPKqqM37JsmWfIPw8AI+8ujUWtLIKLjsn8bZgZFBr7tF6y+72MQJpG1
         PHT5nkUyyKFGqrAy4k+z7PpOEqBsSdBS1ZS/vrGp0vG9/n1vlcopvF+JY8wxMrHs1Sc0
         IoCUBC9xEVzJOKRAL61xUKRmpNiUOeuy/Ap2vtTLUdS4a/m6kxjkM7fC/+Tku03tRqFg
         klf/8XAQcQGENRIebZuk6USBb/qwBfRF0EGMU4tM2YoXMDncZx+55f2tCEHAJW4u0oU4
         Qo9pheqyPHw77sZmLwvIDQ5PQcx9ulufzuQ8L2KH0rvgRj3stgGwb2dvi3lMNWupf20l
         7h6A==
X-Gm-Message-State: ACrzQf0/gwdkBm0Az+F+ofPSEUiSQFIKhvHuclIcDZkroktyIxscYcf3
        fkNjTtYKTFyddyRPnwcwShQ=
X-Google-Smtp-Source: AMsMyM6XGTzXsXitGr/BDTSMqLXlL3jz3GuNMOy51EHuIz6Glsn3xPXco1n/cHvikH/V01nWa67IsQ==
X-Received: by 2002:a05:6214:c26:b0:4bb:f330:fe03 with SMTP id a6-20020a0562140c2600b004bbf330fe03mr42638992qvd.94.1667876669700;
        Mon, 07 Nov 2022 19:04:29 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a240100b006fa00941e9dsm8390709qkn.136.2022.11.07.19.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:04:29 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 3/4] dt-bindings: firmware: scm: add sdm670 compatible
Date:   Mon,  7 Nov 2022 22:04:10 -0500
Message-Id: <20221108030411.59409-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108030411.59409-1-mailingradian@gmail.com>
References: <20221108030411.59409-1-mailingradian@gmail.com>
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

The Snapdragon 670 uses SCM as for PSCI power management. Document the
appropriate compatible string for it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index be1b5746eddb..25688571ee7c 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -41,6 +41,7 @@ properties:
           - qcom,scm-sc7180
           - qcom,scm-sc7280
           - qcom,scm-sc8280xp
+          - qcom,scm-sdm670
           - qcom,scm-sdm845
           - qcom,scm-sdx55
           - qcom,scm-sdx65
-- 
2.38.1

