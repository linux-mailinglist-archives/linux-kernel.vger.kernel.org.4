Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA16F304B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjEAK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjEAK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:58:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABF19F
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 03:58:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24e015fcf3dso578452a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682938720; x=1685530720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agB2JVlLm7qatGarskVqXIUTBDa1pDkkSP4B/2AFuxQ=;
        b=WXUwsiJRouuAC3y9DIr8jQWoR0zDOAlNmlecjvFJQREaW+r0SrC+jwp1Q7MuJS1fj4
         gUuIfCr8h8bEn6udxWzBB2KMY8aFCEtDE196mnqGs8+E3yR5fOfJobLJvf9Sr9lqZUXF
         mGjtahs9dkBP9iMFuU4yIVT010QyhQFfNiFBzWZD3BHvs2QR3pszxP5NF2T77kY44RIZ
         RnmSQi04t7q8RRbjibyMuFkAtZqdS2tMlDTNXxdBj/hHfeYizQNW6KYvprXySgyMvuhV
         x/7GT9+xBvG6s77F4e20iXENsUy9jt55nHd8Lt7DY8KIJByc9VjZKw5+APeqGk8o78Sl
         DmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682938720; x=1685530720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agB2JVlLm7qatGarskVqXIUTBDa1pDkkSP4B/2AFuxQ=;
        b=LGvi4dN5PBQUPE/wKi49W8ZgXusf9sRGfEITrrcm2ZXGyPh+3Ps4xHKtncCJS03thQ
         qmxV9ZWetlTvmqCmgfO32AT0TW/wpeM3NImyf0TSv7e9ATbhZL9E72D0/KE9DWQ+cOIt
         BL9Hc5lUhkKQqsAOcFd9PBLuxpZqEkctAD0tQUQ94symkvXtnfZc8Qf7NUqwhLI0cJ4X
         USrhRqKCZv8Jsbo1m8+epHi6o4MiWdX4t7GpjtlK+SjUSp9Uq5IGXtZg992ZzxhOi56j
         Gs2XHlZahSX6voXGDNixpD0gpGT+8RtDD5z+dLZl2iQQ63nigPEHDEWClhd5kBey8uLm
         SUwA==
X-Gm-Message-State: AC+VfDw5vfUfYK3tfwqwD03zuetziDscFEvtleDPggzZ7oIx5QXgzXQG
        swXVH07jc3jtsQm2ac47uTQXcg==
X-Google-Smtp-Source: ACHHUZ49wOIVT6FmNHeEg4ymKVi5J7feR6/bqFdRXKqDD7+vHGcrDsUuUlZgkQm3gS0Xtk9y++XcNQ==
X-Received: by 2002:a17:902:868a:b0:1a9:6183:f965 with SMTP id g10-20020a170902868a00b001a96183f965mr13732927plo.60.1682938720604;
        Mon, 01 May 2023 03:58:40 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902849800b001a50ae08284sm17569516plo.301.2023.05.01.03.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 03:58:40 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: qcom: QRB4210-RB2 board: Enable more peripherals
Date:   Mon,  1 May 2023 16:28:29 +0530
Message-Id: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
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

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
2.38.1

