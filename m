Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD572B228
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjFKOEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjFKODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B3E7A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so35463165e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492227; x=1689084227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlpWIDDoTMDzC7Jc26F5UZA31B7vwDV86ZZqiF0p8S8=;
        b=Qc1/cFgGpeSUN7ZkGzby/fLmBnnLVcWG//gyWdXxeDM/zRAsTh7WDAA+sbhkdkH/cb
         0jfMdGnffcI13iaWqG3kOfZKd5MVf8Ue79eBenE1yZEoliRf45QcHvSn2xN2oTACWae2
         7qMT1O+FC3DfDG5TKKZcpNy975xveNdQMfHBH6SejuJ7JT3hpl9e7VFPdUyX7m11Gck8
         WfTgJ4lIoHfVvfusu/djspZX37YxII711OUphEhlluYg17MWOqpPjvePj2FF43shkFm2
         eGwLZL614ThjrCXZ4I+E7kcwK3nnRG41zYZFZbbi5t2AxEAJ/NPbd0+Ii4VgxBPWyIAe
         izuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492227; x=1689084227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlpWIDDoTMDzC7Jc26F5UZA31B7vwDV86ZZqiF0p8S8=;
        b=ikum5M945RK0SqgSPi4cCP6QmSveJJaOY0PH90P89lmyP5QkYnApE/hLZgKjMkyf8B
         xJm119BpruBHTV9Mb044cqi4KnWG668I2qvcfTl9TH8Dj7yzLxWfZ1WGNlybiHjCtE3L
         fSoLIE/kSvvVl6Ra9MZLTkhAq/u34JUUv9QA8GbT/ocuf8zuXFG+8g9O0qmAtVRaGFJJ
         V3Tu+YfgMYkRe1JY2YZUuBK60auJgWNZKjcMCZ236BHDk4Hpd0Ayq7pTcHSlLB0JRhSG
         Ft3ipZO5aDm54DS6IuR2USugaQaFnaXWmhn3GEO3Qq2UMPqE+lxwXkiKh9VRAJztG3Eq
         n0xw==
X-Gm-Message-State: AC+VfDzRmUEei17bjyPL68mhoCB5j8FwcoTPTP8fbYspJlKTVHFva1Gg
        LTNCxtx7bpt2+t0kIqB+V5i5xnyLD+m03PGwq10=
X-Google-Smtp-Source: ACHHUZ7ZtrepGg/0CXk4VvUKy3egFlmxyh4B1KAZmnxYJ0V46kzjVmSCasnCjJjS4n7aYIOzNlrT0g==
X-Received: by 2002:a05:600c:2147:b0:3f4:16bc:bd19 with SMTP id v7-20020a05600c214700b003f416bcbd19mr5526149wml.23.1686492226979;
        Sun, 11 Jun 2023 07:03:46 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/26] dt-bindings: nvmem: brcm,nvram: add #nvmem-cell-cells for MACs
Date:   Sun, 11 Jun 2023 15:03:07 +0100
Message-Id: <20230611140330.154222-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom's NVRAM contains MACs for Ethernet interfaces. Those MACs are
usually base addresses that are also used for calculating other MACs.

For example if a router vendor decided to use gmac0 it most likely
programmed NVRAM of each unit with a proper "et0macaddr" value. That is
a base.

Ethernet interface is usually connected to switch port. Switch usually
includes few LAN ports and a WAN port. MAC of WAN port gets calculated
as relative address to the interface one. Offset varies depending on
device model.

Wireless MACs may also need to be calculated using relevant offsets.

To support all those scenarios let MAC NVMEM cells be referenced with an
index specifying MAC offset. Disallow additionalProperties while at it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/brcm,nvram.yaml     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 36def7128fca..13412af7f046 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -36,14 +36,29 @@ properties:
   et0macaddr:
     type: object
     description: First Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
+    additionalProperties: false
 
   et1macaddr:
     type: object
     description: Second Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
+    additionalProperties: false
 
   et2macaddr:
     type: object
     description: Third Ethernet interface's MAC address
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
+    additionalProperties: false
 
 unevaluatedProperties: false
 
-- 
2.25.1

