Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9336F6E80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjEDO7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjEDO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:59:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A1359B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:58:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a79db4e7fso770190276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212314; x=1685804314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8IvnB7h0HAb5+pIi9GxWOAfPdgUl4BJHVh6FYr/ed4=;
        b=kuPcLL3YoUQz+usR6xPzkJy7Qzr+xCOBwv6dT38Ejb2rkKMHl6Kndt9vgn2RH4iitP
         GJzORCEA21O3g7/+GS33g9uei5QHrpLimIHK6fsQUacmH2Ffj7SjKmI206Xa7q3FfAQi
         y0KxVKkNxuqVL/Y5uOl7Vn77LsMWYTuLC9BGNUjEoBMOCy3RNHDuPInha6yTRnHysOvv
         87lKZJwjKlaTS/8g3dW2kRdfZ59pgJYwl/S5nwAj4svodlkgx0dFw2640Q/nGRWC7fPl
         qDXmBQWzRWA9JPZf/U42JKCVkiRpstLjCijuixLhhfkoz85C07G08kXg+HuqmmsDwhzu
         hgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212314; x=1685804314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8IvnB7h0HAb5+pIi9GxWOAfPdgUl4BJHVh6FYr/ed4=;
        b=bcE3eZnONHKMbLxKybfYOhufMVElvVgiFQX0tUXGFiPyUvhEyCL/Q2EDIRbW6id42p
         qmrYed68rnfMVDjd/wRIdR8cmmMbje52RDRHGUIERh/61I9Q0o2s85YQk3q8TA+DA93W
         vVWuH9hqoCUswiyUNXhzaN7IDoBvqeoxqT5K7DCgpL5AVW/a+oQfvaqn+29+NLYmNd83
         KNgOsX2V77JwhfGJ6JtBcGIDlYwt9tVWC32nJw52XorYVrLso5aT6fJecTrTbKGhVBp7
         5J6KSfcAb4EjG67BpKb6BUuhkkaqciCjerwr1VvblgfT/W6a7p1FBUMgk19fB10HnJ6B
         /Jpg==
X-Gm-Message-State: AC+VfDxlp9S1nxYSpwPy92U90Zp1RzpKArygO3vNI/8IsJa5oltmyhMs
        /1bm9S/YZioFJWuvtsv0l2Uv6l+3S/LD3g==
X-Google-Smtp-Source: ACHHUZ6iw4g9UiLmwSI+Th1Vi+OjDYXsXi9WmxXGjir0X1Fu8w/cioZXKeCSGJecPFY3tcD4sPqcliqCieMm+Q==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:c2:b0:b96:7676:db4a with SMTP id
 i2-20020a05690200c200b00b967676db4amr152609ybs.0.1683212314520; Thu, 04 May
 2023 07:58:34 -0700 (PDT)
Date:   Thu,  4 May 2023 14:57:37 +0000
In-Reply-To: <20230504145737.286444-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504145737.286444-8-joychakr@google.com>
Subject: [PATCH 7/7] dt-bindings: dmaengine: pl330: Add new quirks
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 new quirks added to the driver "arm,pl330-optimize-dev2mem-axsize"
and "arm,pl330-periph-single-dregs"

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 Documentation/devicetree/bindings/dma/arm,pl330.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
index 4a3dd6f5309b..0499a7fba88d 100644
--- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
@@ -53,6 +53,14 @@ properties:
     type: boolean
     description: quirk for performing burst transfer only
 
+  arm,pl330-optimize-dev2mem-axsize:
+    type: boolean
+    description: quirk for optimizing AxSize used between dev<->mem
+
+  arm,pl330-periph-single-dregs:
+    type: boolean
+    description: quirk for using dma-singles for peripherals in _dregs()
+
   dma-coherent: true
 
   iommus:
-- 
2.40.1.495.gc816e09b53d-goog

