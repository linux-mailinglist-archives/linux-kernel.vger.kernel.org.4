Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2CB6D1273
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjC3WpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjC3Wod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:44:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C285811EAB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:44:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 4-20020a251904000000b00b7f75c3cafdso5000323ybz.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680216269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcnJNCHDCGQ7Pzom/y/MQEMC0VEcznZRpNuHkAP16dM=;
        b=h+fWFQgFgIewRQ/oEBbhup3NdEkI7VTVNsuOE+DEbbkPezfcqmPxt821KjIEBRuQbG
         l0zjD5y2da69givEVl5sGT/LrKzZ3TjBHss675g7X6otDgYpfdh+qN2+RTa4QLDKNv9g
         PDcFoEuUC2taY6ePkBcT1Z7N0RA9q3bwXricL/gDzEv4dXafQDmGXlIKBeyXeR2sEz8o
         E9FH3ufwR/fPbEciGQgLYG6zQkSaBSw0BtOfmnkR4YfxaB7/7EETD5gleyNZwM9ywyrO
         n+i0UKoKt4E+CXqxkN8hBn0e4jSHrCNiFCw+gjvKmBdlUar6F84Pyzh3o9haY+aKhz2B
         Wi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680216269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcnJNCHDCGQ7Pzom/y/MQEMC0VEcznZRpNuHkAP16dM=;
        b=q/HijtyBwAHs0E/tmqkgYSU0as7djtXg/mL25rS9PwsX8o2mLYJ/pmuHXI0hHwt41t
         4Utbw7UjtpnXqPqOJ3hBhD46iapOhLyD4g+Z6YnO/feW/S8odTd1nlMi+PwdIznBE3A7
         +QwhlBTvY17hthA4N15ZBhp7jPaefCeqTrJcRkMLr9W96ZlzpwbbKQ5oUFX+s0lobtYT
         Mq+J9ee0SZHiNQ1ky2kkVvYLObFdzE0w4g3xSbbslziH6Xbzszv5f/0meu2jmXrT6gzJ
         OLgSH7X8ndwW5Hp2Sa3tC7/wyrkakH3WprKofTprD7CJoiA4+loCk8mssFr/2ZKNR/6G
         K9kQ==
X-Gm-Message-State: AAQBX9dTRuvW81N51Y0TdtxfOj4ogjxfscbjmRa3fi5reY6zSGLm3ZsZ
        8cMPWHmTizcW2sCUDCjKH5ghT5mC78PY
X-Google-Smtp-Source: AKy350bH+FT4rO63l4r7xqHnuPynxVbMsgCzCxhntsgRkI9CjhoZf4Ra9qEtMvcWq32MGU3qdNWQmk0U4T9r
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:c162:24e8:ec5e:d520])
 (user=davidai job=sendgmr) by 2002:a25:c58f:0:b0:b7d:87f:ce3e with SMTP id
 v137-20020a25c58f000000b00b7d087fce3emr8231840ybe.6.1680216269063; Thu, 30
 Mar 2023 15:44:29 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:43:40 -0700
In-Reply-To: <20230330224348.1006691-1-davidai@google.com>
Mime-Version: 1.0
References: <20230330224348.1006691-1-davidai@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330224348.1006691-6-davidai@google.com>
Subject: [RFC PATCH 5/6] dt-bindings: cpufreq: add bindings for virtual kvm cpufreq
From:   David Dai <davidai@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Dai <davidai@google.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for a virtual kvm cpufreq driver.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 .../bindings/cpufreq/cpufreq-virtual-kvm.yaml | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-virtual-kvm.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual-kvm.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual-kvm.yaml
new file mode 100644
index 000000000000..31e64558a7f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-virtual-kvm.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/cpufreq-virtual-kvm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual KVM CPUFreq
+
+maintainers:
+  - David Dai <davidai@google.com>
+
+description: |
+
+  KVM CPUFreq is a virtualized driver in guest kernels that sends utilization
+  of its vCPUs as a hint to the host. The host uses hint to schedule vCPU
+  threads and select CPU frequency. It enables accurate Per-Entity Load
+  Tracking for tasks running in the guest by querying host CPU frequency
+  unless a virtualized FIE exists(Like AMUs).
+
+properties:
+  compatible:
+    const: virtual,kvm-cpufreq
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      cpufreq {
+            compatible = "virtual,kvm-cpufreq";
+      };
+
+    };
-- 
2.40.0.348.gf938b09366-goog

