Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8801C704733
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEPH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjEPH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:59:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8D51FD8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:59:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24e3b69bc99so9895784a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684223956; x=1686815956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D4oENqIYSMzqSFVdiXrWLuYPU6+wfFpb3LNzJPfqzTM=;
        b=xzeoVYTGYQQRtRwbGYo0UyrPzY5wXZQPzo+S5CtG33uIYGleaVYk2PG7CTTbg1cWGH
         /dqtHwtoeYnWX6StuDYWkvvoJK71cRpqPGPVTHK9douyL9DLcAwBbeBC/U3BEXlxsvA+
         HpqCWK/MgXYdbAl+ZxgquCUbTlEYQBM0YrnXd96d6dVIcqv+DaKb7ZhL8+c5riTTqOZa
         qHTeKo5FZlko0OaVrJ+v6+RUiXOiGaG3dktyH9uCtrfn94cqhe0/K6ggHtG/ykuWyUNe
         n1TqeEnoOroX6dXZ7lYjcpsjyV+w48AJ6Gg6fI7ssbQn1wfenKLw2DHTzw+t794YEGXT
         N/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223956; x=1686815956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4oENqIYSMzqSFVdiXrWLuYPU6+wfFpb3LNzJPfqzTM=;
        b=YzMkRDF0XTsWV40qeExqSlde4WBT3Ccqq1PZrfuJ9azCnRp0nSX8JgMUEKbcwcSqCl
         HQsbivuQHZ65d5npcE/bsYbfcJxPF5ReHJBqBYf8u75hF/Q9M8J+QnPdffUll/T1P7xl
         Axb76Pa7o1GW+a4l6AbUYJStkSIlbypEui5iQDjaOQGL5mAqE6ei3C5Kv5W2pbZ1L99Y
         IxRT8Gp0Jq8D9yJR/vGAnDMrLlUrkvgRUd+w7yUUZRAocYX6BjCPAkuNhP/iTwdVfDik
         zMA5i9pNQFaFWXFkmduQIX+w0xT/yrixrLwxMaaIUiVil7wTwbKKLRDLfrwJzuTtNU+B
         UkFg==
X-Gm-Message-State: AC+VfDydz9IoVzqjbitsgbmZWGnGTQTzrFwp7Oi4lky5PEuuwqRIQLk9
        N/Y4PlCsQla4+pjCNiW2TjA2aQ==
X-Google-Smtp-Source: ACHHUZ4tOBs8CvBob9BAXULtfjs/hcE7owydDTE0MKrQGm5sOH1BTjtasIrhozVqq+S6qZdXyQiePQ==
X-Received: by 2002:a17:90a:890a:b0:250:ce6a:cf1a with SMTP id u10-20020a17090a890a00b00250ce6acf1amr21233402pjn.38.1684223955727;
        Tue, 16 May 2023 00:59:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:62ca:2e52:e0c5:d0cb])
        by smtp.gmail.com with ESMTPSA id cl16-20020a17090af69000b002532d74fb59sm469725pjb.22.2023.05.16.00.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:59:15 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/3] arm64: dts: qcom: QRB4210-RB2 board: Enable more peripherals
Date:   Tue, 16 May 2023 13:29:05 +0530
Message-Id: <20230516075908.2323372-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Changes since v3:
-----------------
- v3 can be seen here: https://lore.kernel.org/lkml/20230505075354.1634547-1-bhupesh.sharma@linaro.org/
- Use explicit qrb4210 .mbn files instead of qrb4210-rb2 .mbn ones.
- Collected R-Bs from Dmitry.

Changes since v2:
-----------------
- v2 can be seen here: https://lore.kernel.org/linux-arm-msm/20230501105832.1185477-1-bhupesh.sharma@linaro.org/
- Use explicit qrb4210-rb2 .mbn files instead of sm6115 .mdt ones.
- Collected Acks and R-Bs from Konrad and Krzysztof.

Changes since v1:
-----------------
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20230501102035.1180701-2-bhupesh.sharma@linaro.org/
- Converted the SDHC2 CD gpio fix into a separate patch as
  suggested by Krzysztof.

Add the default and sleep pinctrl states for SDHC1 & 2 controllers
on QRB4210 RB2 board.

While at it also fix the Card-Detect (CD) gpio for SDHC2 which
allows the uSD card to be detected on the board.

Also enable the adsp and cdsp remoteproc nodes on QRB4210-RB2 board.



*** BLURB HERE ***

Bhupesh Sharma (3):
  arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl states
  arm64: dts: qcom: qrb4210-rb2: Fix CD gpio for SDHC2
  arm64: dts: qcom: qrb4210-rb2: Enable aDSP and cDSP remoteproc nodes

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 30 +++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

-- 
2.38.1

