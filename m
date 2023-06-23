Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6D73B62D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjFWLaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjFWLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:30:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F82686
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:30:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9896216338cso45189366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687519814; x=1690111814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JUTP9KVdzCwXWEwQEK/WejGY1+tnzW8te7FkC1dLoUk=;
        b=Ryr1CDxaKF6klmfgzieOQd0RUv82RS6cdmB4lzrb2CxCHmGN58GhreizxfG5yU/BRR
         PnVaoMBV54RF4gSMlQWwEuBqiN7sU84FCjWpqTav3GPGNxvGtrveqtU7qZ85URuvR0Lg
         oY6f25j+rOfWqd3Yqab+/D84yb2Vr9s4LEb2zDOUp5Zl92YpmAHJLDOR8StSU4fyZqBN
         KYV7JsgR+mlmKhV5Dr+LHDtJikqPcnXoizq9+Z7wE4ObxYjmj1DHtOqkJHZD0Z8lxVSp
         Eyavsq0gisJd8fGV6IuTNw/V/H0m/vNf/PouoavbQxwW0Sb9RLW+MeIo+MsOSkllodUL
         c88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687519814; x=1690111814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUTP9KVdzCwXWEwQEK/WejGY1+tnzW8te7FkC1dLoUk=;
        b=CBMNsGQ++tkLMhuZPXxBUreFXkzdBHjx/Xu+BgpzMc1XJeU+TpfWGGmbc+bYZO2QsW
         2veQrXKLI2YvxugagIujv+e5DNreNz5VdEJv8RymkOonF7gTS9vE7Vfq237E8Z9XKnrk
         3a41oel37N7Fc0fvN+GT6+69vcXVXAyCgyOUz8EKGq73GZ60OBjaFgrYTXuDHJ9FfFKu
         j/zb9Srpgj8OIE5RmHir+X8KmgEm3XyzGKCFwJxkm1NoI6Ql0xMrOYtPR7mbOjSQWSu8
         fTuNwbyXIM0feCEnEuyMCgPA7AN5MQr1DL6PqKkGAWn2er75a2C2Ao+pZCPKVntDIwJI
         aIvg==
X-Gm-Message-State: AC+VfDx/Bq+I72yeKlXRrRbXlJo1L4pyU6QykW00EEezVUCn1tEkrdIl
        xvoha/BksFjfWzH4FQeL4jrzEA==
X-Google-Smtp-Source: ACHHUZ4be4+kKq0mciVEYRYbXmHEBQgeyuORUYXwDn/q+SYYNMtYOzdSeAFZMWMlYLVGaLxRvHATwA==
X-Received: by 2002:a17:907:1c9c:b0:960:d9d:ffb5 with SMTP id nb28-20020a1709071c9c00b009600d9dffb5mr21446151ejc.41.1687519813731;
        Fri, 23 Jun 2023 04:30:13 -0700 (PDT)
Received: from hackbox.lan ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id z17-20020a1709063ad100b009821ce1ea33sm5908033ejd.7.2023.06.23.04.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:30:13 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] scsi: dt-bindings: ufs: qcom: Some fixes to clear all dtbs_check warnings
Date:   Fri, 23 Jun 2023 14:30:04 +0300
Message-Id: <20230623113009.2512206-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are all the warnings left to fix for qcom,ufs schema.

Abel Vesa (5):
  scsi: dt-bindings: ufs: qcom: Fix ICE phandle
  scsi: dt-bindings: ufs: qcom: Add compatible for sm6115 and sm6125
  scsi: dt-bindings: ufs: qcom: Add compatible for sc8180x
  scsi: dt-bindings: ufs: qcom: Fix sm8450 clocks
  scsi: dt-bindings: ufs: qcom: Fix warning for sdm845 by adding
    reg-names

 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 49 ++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

-- 
2.34.1

