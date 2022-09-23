Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE15E7624
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIWIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiIWIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:47:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396F12474A;
        Fri, 23 Sep 2022 01:47:34 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c7so11617747pgt.11;
        Fri, 23 Sep 2022 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=SiSDcP/to3fjSrzC1C4LQLMg/foHxyL063KqzxZ+ZfQ=;
        b=FnAjB1qRX6+QzY4suEaIEjU0Upwk3N9dv1HHDfpfCC6J2zkexZRPXevux0ld2hPMvh
         eR/bDCG9gMYHqaI3KVNWctowtR1qA8x9msZYt96UEOoj0v0JihhoEVw9WGDGeX2P69F6
         4ZiaE59XTNd7DSAZik/EdCF4NnUvdlyhrsazgdGtSmrYGLfe73+vlMbyC5fsP1tOvA9X
         7hc9gJ96vllzrR+PME1OMqetOjb6NRB+HSkDKT9KYva3sg+5Dl3Y5VJ1DPPV4L1GOk5H
         NXz2tXUbWSkxoiN6+hQX6Yc/f66CrQLt1vXE3A7vAkJXmrUUjDUXMjGZSXlJmHlHxtV4
         0L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SiSDcP/to3fjSrzC1C4LQLMg/foHxyL063KqzxZ+ZfQ=;
        b=TUxmfiKxTrS8ENHcD4/kt/Oel+ciWYFPdrfpOHYzunHX8NzfXEbH6YIIx07jhxsdvr
         JRR04k8Jq7YLvxLJ0pHiCt77LaPEnW+JCywgRhayVJFNwcJFPqVjgRUjsnH0AHmSuh9q
         MgNDA4jfYTReQP+bYiJKkthOluQVl3ncGa0P6qI/UOfITDkDxlS3gzVaIUCXrpRxzF+p
         cXAsWUOXaXWv4ZcINaLvyrTXVxZuPs4e0xPj+9aN9CbD4hf2RWoseunYRbzeivQuqc6A
         CMvAe3W7kq7fBdw+5is2krYOuaKxVxNuixUd9Xv+IuSCtRLKms6WESMb57Ke1DDvpc4/
         O3IA==
X-Gm-Message-State: ACrzQf1BwnCUkSzH3BdTARWy3sw5kDuPV7y0rsLzNpOFO0BifZ0VQ6ef
        ytziAQJIK3Z3WluLj/vCRxlQLD3w4GY=
X-Google-Smtp-Source: AMsMyM7kEWxxkJgeKzd444jcHZoSBw0IgQ3vTQwC5cDZVecv0HnSySCt4KyQ8ySoH4LX3dAzRV9eFg==
X-Received: by 2002:a05:6a00:170e:b0:550:dc52:4647 with SMTP id h14-20020a056a00170e00b00550dc524647mr7889958pfc.19.1663922853159;
        Fri, 23 Sep 2022 01:47:33 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001789b724712sm5364986plt.232.2022.09.23.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:47:32 -0700 (PDT)
From:   Yunlong Jia <ecs.beijing2022@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: input: touchscreen: elants_i2c: Add  eth3915n touchscreen chip
Date:   Fri, 23 Sep 2022 08:47:17 +0000
Message-Id: <20220923083657.v5.2.Ic4e8f03868f88b8027a81bc3d414bae68978e6b7@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220923083657.v5.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
References: <20220923083657.v5.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an elan touch screen chip eth3915n.

Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
Suggested-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v5:
 1. ekth3915 is the true compatible and ekth3500 is the fallback.

Changes in v4:
 1. eth3915n dt bindings added in v4.

 .../bindings/input/touchscreen/elan,elants_i2c.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
index a9b53c2e6f0a..f9053e5e9b24 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
@@ -14,9 +14,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - elan,ektf3624
-      - elan,ekth3500
+    oneOf:
+      - enum:
+          - elan,ektf3624
+          - elan,ekth3500
+      - items:
+          - const: elan,ekth3915
+          - const: elan,ekth3500
 
   reg:
     maxItems: 1
-- 
2.17.1

