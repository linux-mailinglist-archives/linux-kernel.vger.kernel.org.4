Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288725FFB5A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJORFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJORE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:04:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD9E2036C;
        Sat, 15 Oct 2022 10:04:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w18so16553755ejq.11;
        Sat, 15 Oct 2022 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ak95R1Ig7bcqzgI1JkSE9VXDwN5PjDoVw7jZQxgkZYk=;
        b=M85ctE7t0KkSww5KY5TqrRIwUG0LMuy92c6IN1zQcC8RIoi4PegrLIfP4NE0CCCn1W
         HmFNeGyU+U6i0fusTh5uwyjKcLtSboOKRswtow5RCMlSZFT6d+DkQ1UZ0gZxmsOCRWrs
         TWNIaaJfMrUDZ1JRbrrujueaYk8rH2Q52RcFXcBOQV2sO4OtsiSMtAXV06ZttCngSd6C
         qncGzUIE1D/cFyh0bj1c/4yvC9s+o3QmsSAzqUMBsZKfXaIhVEPpE4odXeuiH7QRH8w9
         iNRTHLCOHhRM5HOsx61ZtcJYY8n7Sj6DGg3XdKBt1xJ0+qQ6piivtzd1SNfcQtDscAmf
         kZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ak95R1Ig7bcqzgI1JkSE9VXDwN5PjDoVw7jZQxgkZYk=;
        b=jUSYlCiE5+uIT3xd2jFYTHaM78IFMswDsGRV2kVxouSQN3LIVzo6CmYavLRkm/jWaa
         qRiNWuozPQegmZLTSA0QyXcj4O2Qetm5s6oS6vyA8R3oInkVz4wsgg6x0lfKUEpxxw5t
         6X5p/2etF32AUxBoOSIkEuzyvkRIHLIEni79jW/RCXL1kV7maMu3ukuP3I4i9qBHIhax
         VJNjoTnj7m1grLBqydT2HP8xAn/LYep5MJiAI1vflG7e7H6+tkf7lXLPm/vUMxTeqIml
         IzVHStA/KmAGf66OV/d7Gq2sW9TNeMYShStW7gRuO9pqXrXrM8snQXluPtyJBlHvqWFR
         Scdw==
X-Gm-Message-State: ACrzQf1NxyMoQ5D1VuFVanMSrtK4ct3PScFmiahY+vVgEkb0oM9EkxYl
        mc6AMpSvcfOO4v8Hw4P8BiyCuh21zKhjQg==
X-Google-Smtp-Source: AMsMyM7SjJjXArX5a5sLAPlAPkLUdg00ONIc1sw7t666GzJ/e6NQ3vAfpi99IMz8pOae6Efi+ETWow==
X-Received: by 2002:a17:907:a43:b0:77b:ba98:d2f with SMTP id be3-20020a1709070a4300b0077bba980d2fmr2692863ejc.270.1665853493035;
        Sat, 15 Oct 2022 10:04:53 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906701300b0078d25e0f74bsm3362484ejj.46.2022.10.15.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 10:04:52 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] ARM: tegra: asus-tf101: fix accelerometer mount matrix
Date:   Sat, 15 Oct 2022 20:04:24 +0300
Message-Id: <20221015170425.83233-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accelerometer mount matrix used in tf101 downstream is inverted.
This new matrix was generated on actual device using calibration
script, like on other transformers.

Without this patch on DE which support orientation change based on accelerometer
data display will be upside down (checked by a device owner).

Svyatoslav Ryhel (1):
  ARM: tegra: asus-tf101: fix accelerometer mount matrix

 arch/arm/boot/dts/tegra20-asus-tf101.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

