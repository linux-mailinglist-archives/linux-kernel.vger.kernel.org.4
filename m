Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D215B3837
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiIIMyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIIMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:54:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09EA102D6E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:54:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l12so1693995ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=hTrH8cxz4TSt0Asuh6c/k+xs7+a/jInDKisWbl+EQh8=;
        b=gSdcGzjbp8X3KMvgs6TWzRwjpGsMhhIG8h3/ZDTo5lrvCeBt3vCFp5p7mhbh676Yyc
         /6hvNi0J7WSCdzyjYK2uXHA1L5XUNn1FVY8g32JN7tb4NcUfguhQAmRceqEFtFfQZ7Zp
         g6WBiiXRNv+N0S4W3luJa0YSuP0E14OtvyVHpVFh+smVmA9kXTTXqn6uWP12vQsRmC+Y
         pd6Cm9Aj3Ir6nXMFKuVsm8VcCogEicWcDOMkZa+kegJEnhoFh24Q+Cvy+qAwkz9PFTB+
         zfUt9W2NWpAA0+KP1DLdO9wDCF+/YGZRaJiK90fHJyuPSqTkVwdQHGKmhaF01KholSF1
         rJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hTrH8cxz4TSt0Asuh6c/k+xs7+a/jInDKisWbl+EQh8=;
        b=yob9MKMlQpvQEr5k3x8CEPRc1su5TFJj9132XRzgE0Xr9nb5sAqxYl2rZZA1RVv+0T
         LFz1HVcAKtP4Ws8tjV+4G7dc3cqaHzt1Amd+4ZLQ6qPLP36NrUCqQV7ynQSBkQahQPz0
         Z1gFTbMpIeztfyPojJGkVUZOOhxpCpUCf/QeH9EvWINtVMcDc3RBx5E5ggg0NAgFTuzu
         A6ZoY7CcsWxZjsjp48TDOUh6OCJAL1pdRSEK8fxRgyEFYuJWYEf9gvMoqb5P3APq8hWt
         daoFHj0JALcwBEi8EiSRwkozideKor/Dw2Jxhfo9F8X9QK46TV/iaXL/200ng3uReP/a
         j52w==
X-Gm-Message-State: ACgBeo20Rk7w4I2dg2Q/6MJTlRfsG9oKYM/GOYx2e7RPPugdSIoih6Ig
        I1Qr4AFWKikUwA6zR53CYWSFBw==
X-Google-Smtp-Source: AA6agR4cN9CSdqcVsPvUl3RBLFSual+P6TIqZqeYPwj9++BgjrtxAOQ64u4ljSl6s18VVn0/UGmpIQ==
X-Received: by 2002:a05:651c:2383:b0:26a:81e6:2590 with SMTP id bk3-20020a05651c238300b0026a81e62590mr3742389ljb.346.1662728047288;
        Fri, 09 Sep 2022 05:54:07 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a2eb0ca000000b00263630ab29dsm64750ljl.118.2022.09.09.05.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:54:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/7] dt-bindings: remoteproc/misc/qcom: stricten SMD/GLINK
Date:   Fri,  9 Sep 2022 14:53:56 +0200
Message-Id: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This depends on qcom,fastrpc.yaml conversion in Rob's tree, therefore
everything should go the same way, I think.

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  dt-bindings: misc: qcom,fastrpc: correct qcom,nsessions name
  dt-bindings: misc: qcom,fastrpc: add compute iommus
  dt-bindings: misc: qcom,fastrpc: restrict channel names
  dt-bindings: misc: qcom,fastrpc: correct example for GLINK edge
  dt-bindings: remoteproc: qcom,glink-edge: require channels in children
  dt-bindings: soc: qcom: smd: restrict child name to smd-edge
  dt-bindings: remoteproc: qcom,smd-edge: define children

 .../bindings/misc/qcom,fastrpc.yaml           | 25 +++++++++++---
 .../bindings/remoteproc/qcom,glink-edge.yaml  |  4 +++
 .../bindings/remoteproc/qcom,smd-edge.yaml    | 34 ++++++++++++++++++-
 .../bindings/soc/qcom/qcom,smd.yaml           | 29 ++--------------
 4 files changed, 59 insertions(+), 33 deletions(-)

-- 
2.34.1

