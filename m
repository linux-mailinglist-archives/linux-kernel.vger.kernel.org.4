Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D993C68B326
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBFAQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBFAQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:16:39 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C1618179
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 16:16:37 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-15f97c478a8so13345317fac.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 16:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwqMPPyY51EV2jUmrtHciC13l76bJLdemVUP+XoDQUw=;
        b=IKB/6CdIkb5usBVqXhP/9KUGQRr8+kLzTgEQSaYaqJrdFXw32vOHiPBnkcSLUBr+xU
         e0epRrth3NHk2DPvqWT+7WLyQNFbH0flKEWC8AGCmqJ17AdWnefUmiuWGbx2C7Czb7oH
         8ykdnAsh5bF71JRq+/Fa8L2ylg6r+Jmkpa3Xn0MwgNzjMZ54i7d0b08O8oQ7hdwJLDIH
         os+7POEMWOKJO7oWuP32s9DUw/MYoczy6EsyWciV4WBw6CWp5mn53cTL4sDIn2CmZ+h5
         QxmOgCW0rXBD0p2Gjje/1FFtZiKmfRqC44qH0VmzWok6GD0qRkstvpZiIHn+DEjYObNU
         Fnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwqMPPyY51EV2jUmrtHciC13l76bJLdemVUP+XoDQUw=;
        b=BJZ7XCkr/vAuIPzb1/qpCvSzMEdRlhGh08SD+1foV+UZxsGoisQ6xwNXUaMsFXxCWk
         7j2+RgkRU2/pL5CTQZEpX17WGoNe5Z+lKgox4qmbgxHaKvXh2A8WMFYKJCW7wr94MvJr
         sgQu9pIgs1xQL5VWeh2HO75x3y1jFaPKiSMVAzckkdVfc1vKPwNqpgqq8s+0hP5irca1
         3RcNVQxogkT+Je/tmW+tgpsIW5P3sdpMH4nBqABhDshX8TtCxUzADv8gNKy+LQ0SNs1D
         /QY0J3bdQFOi8ijAhQw1yiG3m7S92nOtdIYWTh3MAOTSuoy0BjLaO8mlG6G84mkZCSHD
         RPtg==
X-Gm-Message-State: AO0yUKUErNMKaB08X0lqzSZac5AgTFjci4Rj1b/5w4QnA4S3awbnzghs
        YfzPOpWCj+7cqcW2iA5tH0+Diw==
X-Google-Smtp-Source: AK7set/SG/WNa4GTrT3QUz5mxquFlm7mbBz9XvFk+WQvDcKfXxXUP8y+KoCxt3A9StQh74gp+TwzWw==
X-Received: by 2002:a05:6870:8187:b0:163:2fc9:c17 with SMTP id k7-20020a056870818700b001632fc90c17mr9408083oae.21.1675642597331;
        Sun, 05 Feb 2023 16:16:37 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id l22-20020a056870d4d600b001636786f7absm3462133oai.43.2023.02.05.16.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 16:16:36 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v3 1/4] dt-bindings: net: Add WCN6855 Bluetooth
Date:   Sun,  5 Feb 2023 18:16:31 -0600
Message-Id: <20230206001634.2566-2-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206001634.2566-1-steev@kali.org>
References: <20230206001634.2566-1-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the QTI WCN6855 chipset, based on the WCN6750.

---
- v3 No changes from v2
- v2 drop second binding in subject line

Signed-off-by: Steev Klimaszewski <steev@kali.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index a6a6b0e4df7a..64e278561ba8 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,wcn3998-bt
       - qcom,qca6390-bt
       - qcom,wcn6750-bt
+      - qcom,wcn6855-bt
 
   enable-gpios:
     maxItems: 1
@@ -121,6 +122,7 @@ allOf:
           contains:
             enum:
               - qcom,wcn6750-bt
+              - qcom,wcn6855-bt
     then:
       required:
         - enable-gpios
-- 
2.39.0

