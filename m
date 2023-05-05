Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA626F7E41
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjEEH5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjEEH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:57:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E36A1814E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:57:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64388cf3263so1119935b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683273462; x=1685865462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHIGWfJ3P3ckMZVZgZyw3oCAYq6PaRo42KN+42XYvhc=;
        b=tP+7eJp2UFy1LYmKQQDUU4fnCsS2FAyBHmnGsSLrdinHQz9I/zJ0bHqj/WXw6+5qdq
         gyswhFD7wMKKZlMhmZ2kZQgj+xYCadWEiScfCtDC1pOVUhuFVQ2VqmmAsWRIerbjiTuc
         mqbC3MlcZof5pAbk2JNbzC4Pr6PbP4av1GjmXjJ54s2soGonObF5jWm2WbSsWdd2E+UV
         k+nYeJpZ5gQmABTk3/8K5GNkt2ICX5yLyRqTE9a4KE2bwqKdbrSYfQ1dcWFPAgPPqgVZ
         /uetu1JzL9ZRQtt6pmQ2BWXCfDc3DrlkzqBm3AGl5bk6rWlXO+jti8tz1zwknv0Aji/b
         5CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683273462; x=1685865462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHIGWfJ3P3ckMZVZgZyw3oCAYq6PaRo42KN+42XYvhc=;
        b=AJLe1/du1fmieq+LsIkkoT4BI0or2NI6Sy3MbHUn+kyam/ByA6wmtN4Pl+XZtHk0mQ
         /OQ1mB8jysRVAwBNYA7W39rZrT0Udkz3DpBMvKLxVkK/ejp1f9amxK4pA18hDX1e99Sy
         xY7CGt+3zvmPN+jngqosbr6eYgw7gNQT28oU1xBdA/2wEVvFObjcdwG55TQi3cZDAIss
         ygy7tv72sbQm96dvo1MRtGsmeijsL2JpWPHGG9rx8fNocuVzdRiin4kwMACsH2jEHnFT
         XbwscgRImWWgplCttU7Tb1ZYv1O91/mAUShgPbkGZJyIPl2DOgnOJb+0Wlc1+LjdxzSk
         3pMA==
X-Gm-Message-State: AC+VfDyenUEYmPmjVzh7o9WbH9iKNn8AlLr4TYrtcZXwF8ud8xkFmIEu
        GYVY/6YBmZ31MvsXxPl1FPE0kA==
X-Google-Smtp-Source: ACHHUZ4AYhaQ2a/Kk+LpoSo1OTMPb60IIAZ8CLt5FZQnXom4kRo49XluGSGgecyM+7o4uqSbeV2sog==
X-Received: by 2002:a05:6a00:2183:b0:63f:cfd:5d10 with SMTP id h3-20020a056a00218300b0063f0cfd5d10mr1153372pfi.8.1683273461813;
        Fri, 05 May 2023 00:57:41 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id p17-20020aa78611000000b006242f4a8945sm988873pfn.182.2023.05.05.00.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 00:57:41 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: dts: qcom: QRB4210-RB2 board: Enable more peripherals
Date:   Fri,  5 May 2023 13:23:51 +0530
Message-Id: <20230505075354.1634547-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Bhupesh Sharma (3):
  arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl states
  arm64: dts: qcom: qrb4210-rb2: Fix CD gpio for SDHC2
  arm64: dts: qcom: qrb4210-rb2: Enable aDSP and cDSP remoteproc nodes

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 30 +++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

-- 
2.38.1

