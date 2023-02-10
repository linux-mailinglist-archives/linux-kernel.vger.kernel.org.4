Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F7E69182A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBJFzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjBJFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:55:37 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F37721FE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:55:35 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id r8so5463497pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 21:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOWZYtFSMZdRgTZRtwN+AemiOXW5qdoRRDaQg26mJB4=;
        b=qX2ByVWPE4aBjlRMLrL54OIfFjczNDBVnStOH4o6pBDT7bKsF/KH2nqwolfXEffYfb
         ciaIYD4ToadaVE2zGYSU06S7T1PFzqNvgIv7Vn99W1IEhZCRr44FupgTy7VI8Pu8mbUW
         8CE9MdFGZGOfD2pgTD34FtQyUlu8H7gVh/PGuID/Invcq8qCyzeUZ3vScrtTO1Cq57TF
         UmkYHDi/RwzJLwIZe32q0N/vHJm+F57bQMDeTGfPa4dXJIPhcbzWFh9OL+I5k5SCzDxE
         e/R9cH5BcnTs0K9JmnB1VOYnz92Cq9JpaK6qYlXjSb1b424bIujlcu+pcqdm8Wc8cEui
         WTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOWZYtFSMZdRgTZRtwN+AemiOXW5qdoRRDaQg26mJB4=;
        b=G/DJOW4iC8TPwgqX3n4S2rCdVgNJRdw6QFdYR9zCPmvbhNYvi3DwaXn7H4qBkKg6yO
         Tad7ZNSvF2AZARdA/ShSwQKnmZZYn3BJ4JpcYRAyDUdhbRj8RZjQ7wcFxd+l+SVjyp9o
         bbdL5Rn3MJl212IChaUxd4JKmNWAshniqPiGx+LhpWrFMwZABbGGLb76VhwSI98KzX5q
         PnoroBsylEF4mBccRrHXTWwc8NjEvsFoTl5s9c9bmwRoXb1s2LOBnwqctXfgSYEzJBLM
         USjTX1QCaE3ALbN/xHOHL9u6fSz7TqDgenz2v2teF5qYkmINn/dzgvcLu3d3bPM7vjPr
         Qggg==
X-Gm-Message-State: AO0yUKWuriLCFkO6atkhKIEzLmSFsYrPnH5s5f6ma7LQbXN04eHtRytK
        JuTy4IASrTV//49oigFI4tQO2w==
X-Google-Smtp-Source: AK7set/ykxKlkDwF0/T3aR/bVrgtsB13Pq9PvzCND6CyzvOu6jyi70LyDh3XNdelfmqYZvmGoUVT1A==
X-Received: by 2002:a05:6a20:3d10:b0:c2:fb92:3029 with SMTP id y16-20020a056a203d1000b000c2fb923029mr11057445pzi.33.1676008535517;
        Thu, 09 Feb 2023 21:55:35 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b005a84de344a6sm2500025pfn.14.2023.02.09.21.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 21:55:35 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix for Ufi Space
Date:   Fri, 10 Feb 2023 13:54:49 +0800
Message-Id: <20230210055451.72153-2-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230210055451.72153-1-jordan.chang@ufispace.com>
References: <20230210055451.72153-1-jordan.chang@ufispace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix for Ufi Space (https://www.ufispace.com).

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2f0151e9f6be..ab0dd1cb5ede 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1344,6 +1344,8 @@ patternProperties:
     description: Ubiquiti Networks
   "^udoo,.*":
     description: Udoo
+  "^ufispace,.*":
+    description: Ufi Space Co., Ltd.
   "^ugoos,.*":
     description: Ugoos Industrial Co., Ltd.
   "^uniwest,.*":
-- 
2.39.0

