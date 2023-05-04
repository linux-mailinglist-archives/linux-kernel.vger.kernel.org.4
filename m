Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A136F6776
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjEDIad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEDIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:30:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA866188
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:27:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643846c006fso306761b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683188835; x=1685780835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmaLfLchQ4rAHy5t1YFYbHdQn/tu5s+YbDZEOcELexg=;
        b=O7IuTY7Xl9h8/AUCgL62GBsuZuAifKLapHZk0H3kSWhURmopInl7dQRbIUQFLLaGGT
         +upT51N7E6oc3pYoumUAmRx2jlrBlQSnbgfmsqLJM83Vmg/L7IJlbrR4E0WZg4VE4PcY
         d7QMdIOjxqCjuapOqfvNXiu4eq9MKyhPlrwhVCIfn8MxcGdVCrwF1XyoEJZp04QbFp6E
         xJ3sPrcn+oafKDbam5T1VEdVVcE6iajwK8nGZNrpR3TDieatgML4eMd7uzz8NMzDo/Ae
         UPsYdVb5nLKBgM4IH/i+wRibcO1PANAHmBE52xxe8qunM4jz0yvqOa75zDcG5pzzQTRR
         pGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188835; x=1685780835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmaLfLchQ4rAHy5t1YFYbHdQn/tu5s+YbDZEOcELexg=;
        b=lZcZUTy5e3qia8Ljr4mYTsxay/dyvlwfz9fyAivZLIXn2P6Beq/odMxgBv8JHhLYcp
         7Qqqq5KjLutG2thaOwzHt+EsBZ6lc6mtXUqqIUnQDm52ZXMLIwPcXLgYBLMq8oodDuK/
         jbMcUrQX1seFxX/Sje1ldtRJHc09pZolfKFaSJ3jlnjSw7UvcgpisdM0gGnT9uWCt8ig
         pbM674wTjHOJdAFfOIS6hxjuPORF0gpBMlIaKgv4WJ2wC0y1v4CYCUdEwuZNtfZ3paXY
         X/5WPUmfc2OTigqrKmDdG5HGMZVbd7VJOvdHJHOm3cetRg9eQu1vAbPxqL+MpMNq3GPh
         92QQ==
X-Gm-Message-State: AC+VfDz3Km831q3noIEj5FHBE7FN+fgQuhVf1Qhe7JmUroKaI+V8mD0o
        9jZPY/NMnIrvS8yOhhqToMfqOQ==
X-Google-Smtp-Source: ACHHUZ435F//tL0eS3YIpLg+RkgxRAGF5zZHKtthn+XkXKTItns7c2uRorHCLxqq+IpPQBJjnslLxA==
X-Received: by 2002:a05:6a00:88b:b0:63d:3a18:49ed with SMTP id q11-20020a056a00088b00b0063d3a1849edmr1603633pfj.15.1683188834701;
        Thu, 04 May 2023 01:27:14 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id s1-20020a056a00178100b00625d84a0194sm24913973pfg.107.2023.05.04.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:27:14 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 1/5] usb: misc: eud: Fix eud sysfs path (use 'qcom_eud')
Date:   Thu,  4 May 2023 13:56:40 +0530
Message-Id: <20230504082644.1461582-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
References: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
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

The eud sysfs enablement path is currently mentioned in the
Documentation as:
  /sys/bus/platform/drivers/eud/.../enable

Instead it should be:
  /sys/bus/platform/drivers/qcom_eud/.../enable

Fix the same.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/ABI/testing/sysfs-driver-eud | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-eud b/Documentation/ABI/testing/sysfs-driver-eud
index 83f3872182a4..2bab0db2d2f0 100644
--- a/Documentation/ABI/testing/sysfs-driver-eud
+++ b/Documentation/ABI/testing/sysfs-driver-eud
@@ -1,4 +1,4 @@
-What:		/sys/bus/platform/drivers/eud/.../enable
+What:		/sys/bus/platform/drivers/qcom_eud/.../enable
 Date:           February 2022
 Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
 Description:
-- 
2.38.1

