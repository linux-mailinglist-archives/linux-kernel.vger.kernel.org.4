Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D82069044F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBIJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBIJ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:58:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC71417CD2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:57:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u10so1030168wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP3LW9NZPdbKneTPu60IP6N2yeUEfnsbaq/RO1FZGIU=;
        b=exRlt/trCA1+LFWdH3XaKTDpX5mPO1nAW8DUS7pbKkAHiMiDhJEOJbeUse41DIuYtE
         zQI8HNbKhv0eqGkvpDHctcmFFyDMbqI7waN+0mOnXOpPizQ2UwFvEDiI4uerraBAxm1E
         2SuX0chT16/SwaAdQSJRmZIL4VADd7XR6bgqkH2Ms1Sx1r9JeEqvbwjR8hLAhiYf5ZgL
         y/c3g+rl/D4p0Xz/HpcAr+s/0w7bgNUuyP4IaJtojS02hVo9pGsyRXeNSZnS6NUh5KAf
         27wkExddO5neGul6ZcI4945hu8F/gu9NLmYdtaBrzcfyA6NN70HSKJUAy1A2uITcjSPH
         e4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lP3LW9NZPdbKneTPu60IP6N2yeUEfnsbaq/RO1FZGIU=;
        b=dgDlYSFwMl6+OYDshcTsgTZFnWILcwmf/D3LYkPaj8uyVjqgF0cndyUW2aAHuxLx7O
         QzaIEtm4/Wp+MCDEzv41EcN6AtjzaezPEuexVBEBWAwzsdXG6e8VlN1xyB2G+0HFnejl
         XejXJeslqBBgnkJB46yvzKZZR/HJlyiIxFP147lrzODnzglweUaixcMWybKLHfHU56fs
         QqlU/TOm2wg1yk/k3SPiugQ5Sh3qW7mghhYEE4yTcg2qSjujmxqwjfAljrXZuDXY4rup
         Ipb1ZR2LdVgx0dFbVmm4STo1FCteVTuFYC+OCdSE052DqVAMYpcEQ9Jw4/JFFALwVGhU
         wJbQ==
X-Gm-Message-State: AO0yUKWmwAlmBN8VT/UY/NFHwJ4XBSWMkU254bKXqWE96CoZYmlQNgBy
        gvQ0IJ+jmhB2bYNo9KWU7apnQw==
X-Google-Smtp-Source: AK7set9lRbjY0oa2Wgr181VmopQdekxSfxjUOlUs9nH0779U2luC8H5QPcm6KynHC+fwuE7jZXpx5Q==
X-Received: by 2002:a05:600c:4b1e:b0:3df:e549:da54 with SMTP id i30-20020a05600c4b1e00b003dfe549da54mr9627778wmp.17.1675936677614;
        Thu, 09 Feb 2023 01:57:57 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7e6e:bfb6:975d:225b])
        by smtp.gmail.com with ESMTPSA id c63-20020a1c3542000000b003df14531724sm4628913wma.21.2023.02.09.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:57:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/3] soc: qcom: smem: update max processor count
Date:   Thu,  9 Feb 2023 10:57:51 +0100
Message-Id: <20230209095753.447347-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230209095753.447347-1-brgl@bgdev.pl>
References: <20230209095753.447347-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Update max processor count to reflect the number of co-processors on
SA8775P SoCs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 4f163d62942c..7666b3425b7c 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -85,7 +85,7 @@
 #define SMEM_GLOBAL_HOST	0xfffe
 
 /* Max number of processors/hosts in a system */
-#define SMEM_HOST_COUNT		15
+#define SMEM_HOST_COUNT		20
 
 /**
   * struct smem_proc_comm - proc_comm communication struct (legacy)
-- 
2.37.2

