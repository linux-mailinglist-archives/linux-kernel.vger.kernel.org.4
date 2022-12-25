Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20BA655C53
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 05:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLYEId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 23:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYEIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 23:08:30 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F564E7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 20:08:28 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so5020642oto.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 20:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9p5wCl2OafBHhf+KW3AP6d7Rq+hvbB/t0P57O7S1WYk=;
        b=jLHM1pMNEn8rx8qlW94YiAEoNoD4/4wmZEMXjCb+gIzwsvVxrsTF8ikP+s8YjiQgWf
         AZ5LDZ8JL4KIBZ4Cesx6WPf1IrykVZG4uFHl1IKfSBU1uu0W0qjAyp8b/UdMK+lF825O
         aZKRQenIBom1uDyKAqD9+RaTwTRYP1azW4qNn+CEOKavMb0YgL+QnI18MX1sRgBX4ZhH
         u6S42aLdzuRzAvZ0lCUnLVZpC9HemE83DXpmjkW45mUbIN8QQyhbitq3UNPDE4pWpl7P
         kpAALPV8RVFhxEq2tTS9F7DqYRZN1rgDHEw0zfTvOGaLrMu8ZmAZHmrl3vGhehi4RLuB
         Hebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9p5wCl2OafBHhf+KW3AP6d7Rq+hvbB/t0P57O7S1WYk=;
        b=y8ANYYAxwVEQkVqVVnhSvIebRxUS105fIzDpieVqwpQ5oNu+KllkJGdWJn6ZLt815A
         IW+VXM9av2kRmdYwCJzjHQBks/PRAeFUTsuI2ekSl7brFmZgxDOAu2qZNEDQukRr7lyl
         BbwZIN9y4G8fjosTqub778kfxSNqxt3QQVylCq/hQXdCvCypOJSo1+2SUh9a472WPs/R
         yaIpbUBs/XmsO1UJnXO2H8wc2brezb7mn02ul+iajk2dPlT078RayFZIkQoGxdUDJEBv
         Z4VLLvJhaTxp4dlmTAAeUQ+65On7qLrbGxWfxS8UyUXn+Ja4XsAqqZN5tsVvzFDfaNPC
         2ZUQ==
X-Gm-Message-State: AFqh2krHtR6Y1clN7qcPGwU7hvn2h+2qZoKWABS0McrMTFt+wZNhNOJ4
        4TM9kcztp9Pvn32qrBW03e9jZw==
X-Google-Smtp-Source: AMrXdXuJNs/cEbQyiCD658cj9FBLhZY5wdFir1v5mJUf8/gDyAUEQrtPGs8VuAVqaQv+XyWl/8Z4Jw==
X-Received: by 2002:a05:6830:6486:b0:678:2963:3832 with SMTP id ck6-20020a056830648600b0067829633832mr8942033otb.20.1671941308082;
        Sat, 24 Dec 2022 20:08:28 -0800 (PST)
Received: from localhost (2603-8081-5300-41db-0000-0000-0000-127b.res6.spectrum.com. [2603:8081:5300:41db::127b])
        by smtp.gmail.com with ESMTPSA id f19-20020a056830265300b00667d9a866b0sm3658306otu.59.2022.12.24.20.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 20:08:27 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/26] arm64: dts: qcom: c630: set venus firmware name
Date:   Sat, 24 Dec 2022 22:08:20 -0600
Message-Id: <20221225040821.8395-1-steev@kali.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Yoga C630 can't use the generic venus firmware that is in the
linux-firmware repository, and needs a signed one.  This file is
qcvss850.mbn from the Windows partition and needs to be copied manually.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 7e80e2950f8d..78a14f899df9 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -801,6 +801,7 @@ &usb_2_qmpphy {
 };
 
 &venus {
+	firmware-name = "qcom/venus-5.2/qcvss850.mbn";
 	status = "okay";
 };
 
-- 
2.35.1

