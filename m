Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEFD68B3BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBFBX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBFBXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:23:55 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388117CD4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:23:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i5so1854230wrc.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 17:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUksypkjsjXmpug5tiXZYyYvtBaikan2cm9Jx3UJnKk=;
        b=bPD2724PdcjqFUXa5Y3b0pWm8+SZq7varn1UebsqrTb1x3muquLQsTG8UYPIG7A4L8
         zHj+91rHCtOefQI8HsicmAjcDU6OBgG6o4qoktve0tv4nvQWBh+x6dCiTnoGMsiu9wXb
         QVl9n5eYJmLMbicDxdl2JkozUQIMy1IQYSVJYXCdPIfdrbpfgrQUOreQxOHLI66bEenz
         IJ7+UfG+UvBuRxycLigWLWl0roI41LgYYWmUrrtxPHSeA0abuaJJ32ctKI5f7PHxThDy
         JgE+9kQhvunQ/Ux+N8eIvRSd140pWR7003inaTWhdnMVJd1zCvqyGEN6zEqPUWhRvAW/
         MFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUksypkjsjXmpug5tiXZYyYvtBaikan2cm9Jx3UJnKk=;
        b=d9JV8O+7qeg/cQ0cBjXqQ1eFiTJwwVzIOhcmUnWzV+W0YGffQ0s1wRMNPjpNYmEGXI
         vu2cFhAoNnyoc5/ZnWdOTV0LlKT9l7380hInARrn0YjU0r9H4AMZj8tOPqAsbAeMadfA
         49dh8SM3jnOPu1qy+I20Gc0CG0UVcOLYFjLSe5yS8mWYWYB2P5xqUx/iP6dmSKLCLid1
         vdHk1BwtRFShdTkh4DBU2I/rKAlg29EMemSFd0+Vqj2oPjXINbWzehqdL7aZpSJhtyib
         7lM2DS9W0J1u/nSEsaw9VYRQFgnU42sq0hEnuwYZCbMI43xJM72OKSGX48XnTk4Zx3vc
         pyxA==
X-Gm-Message-State: AO0yUKWEwpXFfh92vK1Xv4wuQV90bkikMr9UcFNOfWo65PJilNSOXQoh
        tIOmxwJz8MlKRvxV65mNYmZv6w==
X-Google-Smtp-Source: AK7set9dHz3P3hwjKVybJO3qPKLRoeToWsqhddoNn1OUs7tbgi6fQVRYHHBdL2yABD5atWIgVtlGRw==
X-Received: by 2002:a05:6000:1449:b0:2bf:b080:77ea with SMTP id v9-20020a056000144900b002bfb08077eamr18489321wrx.9.1675646630563;
        Sun, 05 Feb 2023 17:23:50 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d2-20020a056000186200b002bddd75a83fsm8048027wri.8.2023.02.05.17.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 17:23:50 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v5 1/5] dt-bindings: vendor-prefixes: Add Square
Date:   Mon,  6 Feb 2023 01:23:32 +0000
Message-Id: <20230206012336.2130341-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
References: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Square (https://squareup.com).

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1f7a519a936fd..6e03409c44cec 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1249,6 +1249,8 @@ patternProperties:
     description: SpinalHDL
   "^sprd,.*":
     description: Spreadtrum Communications Inc.
+  "^square,.*":
+    description: Square
   "^ssi,.*":
     description: SSI Computer Corp
   "^sst,.*":
-- 
2.39.1

