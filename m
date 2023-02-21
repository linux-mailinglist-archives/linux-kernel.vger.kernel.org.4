Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6D69E81A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBUTKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBUTJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:09:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD862DE66
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:09:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s5so6098543plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4Uz8oInxrBVxdaNnCcRWzHNxIOpRGtwNCns0Csq24o=;
        b=5CAoJgBaxdsOsjJt2ARXvUAXbErBCB8xjhCRl/00BIB0m+EhiyRU3XZSidGXeE83LK
         +FRtmHOsemIRPQ/ytDa3xi5xQubu32PfYgOv1GgPMlj8GBuwVt+RKxxhFTTWQgWjLJbH
         yVO3GZ6Dl6SpXYXL2PGhBsRPKRHAhmrU/mwngeMnCLv+FnBGjy3WnIrrSyPN0GYSZyeo
         jlCTpaCtDtXLMs75oLfPUTbR6nm5b9ZUPk1JPx7ptYDFvYWEZy841oLGvuf8Tn0KoTed
         qy2eDXvLc8W845c/ngN141rjsv76Zdue6P6r4RixeblK422nJLdTcHMc3EqqMVYNZDZP
         9Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4Uz8oInxrBVxdaNnCcRWzHNxIOpRGtwNCns0Csq24o=;
        b=Vp34W06GSNyD/zmHwunKPd6cgF35xVGp5J0RhuXxiSG8oMj35VpId/4SOGI7e7/ew6
         82NANWvExpj90NvgZh1jVlTl0ygOebY84eJDLFyMC2fMr0t9WUMSsQBZ/+lqsQgdtAbb
         swSwsqwi9BT9e+hbib/vvAI2x+i5dVk4urVtuyzRVtGOCoduLT/g7g8Qw6iBcpZMQi3q
         1+uUHtR/HjTCG22z766oitz1lcRtH9EUmk9g0660viX0UoLr0JE9ffJzGClklpIAnJN0
         1U/WZOS/0Yd8iqo3KdGUUAvDNmCCWp3dof+96werth5QHSDFfLRgkIcni4/gDu8SpMMK
         OYBQ==
X-Gm-Message-State: AO0yUKUC584yszrDv7W5rRdQjiGPcQAOcI2Lle1n6EIeAzqS4j+R6pzp
        SPxyC3ufxFj9EBZonhj9nm00/Q==
X-Google-Smtp-Source: AK7set+it96+69j6MVRhBhTTnrkru5X6NVtEvUnH9vgxsurcSiwoU7po5lf6y/VdEVorq3aQjAMmjw==
X-Received: by 2002:a17:902:c407:b0:19b:dbf7:f9d1 with SMTP id k7-20020a170902c40700b0019bdbf7f9d1mr6464689plk.37.1677006573615;
        Tue, 21 Feb 2023 11:09:33 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b0019602b2c00csm1583863pls.175.2023.02.21.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:09:33 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     heiko@sntech.de, Conor Dooley <conor@kernel.org>,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 4/7] dt-bindings: Add RISC-V misaligned access performance
Date:   Tue, 21 Feb 2023 11:08:55 -0800
Message-Id: <20230221190858.3159617-5-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221190858.3159617-1-evan@rivosinc.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This key allows device trees to specify the performance of misaligned
accesses to main memory regions from each CPU in the system.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Evan Green <evan@rivosinc.com>
---

Changes in v3:
 - Added | to description: to make dt-checker happy.

 Documentation/devicetree/bindings/riscv/cpus.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index c6720764e765..f79e9e5c5ee9 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -85,6 +85,21 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/string"
     pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
 
+  riscv,misaligned-access-performance:
+    description: |
+      Identifies the performance of misaligned memory accesses to main memory
+      regions.  There are three flavors of unaligned access performance: "emulated"
+      means that misaligned accesses are emulated via software and thus
+      extremely slow, "slow" means that misaligned accesses are supported by
+      hardware but still slower that aligned accesses sequences, and "fast"
+      means that misaligned accesses are as fast or faster than the
+      cooresponding aligned accesses sequences.
+    $ref: "/schemas/types.yaml#/definitions/string"
+    enum:
+      - emulated
+      - slow
+      - fast
+
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
 
-- 
2.25.1

