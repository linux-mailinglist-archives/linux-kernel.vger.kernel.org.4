Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE47B5BA0A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIOSRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIOSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA288051F;
        Thu, 15 Sep 2022 11:17:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so32100558wrp.11;
        Thu, 15 Sep 2022 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X4rbQc4oV+bydO7a6rZsBq97B2o4NMxj4PuPki8DHnc=;
        b=DKBfGOmBjJRLAHPa7vSIJ3W2YqFaciMatHj7CvSQ+8kNOwzWtnVpg+yZkqhtnvq0Gu
         v6x+l2l7RX0XEuc/WWce27FaeRA3j+KZH6hucoGoWka/j9DVYFbdnSq51GP/GFU6GUfj
         qjExGIcIQKeSd8KCJYe0nVkNpNAn0gokqAJkunaDKV36uRNpm8tib6E3ZGmoZzTGoU95
         9s8e5CsPblzhiqFir1Q2H8aS7vj6H0ZvHvjvB4pAe3jjrTWf1dUZMDurELXLMek6Jp3Z
         psZAlgxMcW2sp87DDoskCWC+wv/7wJC2qTHCZyezhfbxSJDi2lmtHN4dCmOdthoEKS17
         CQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X4rbQc4oV+bydO7a6rZsBq97B2o4NMxj4PuPki8DHnc=;
        b=Ql3YbWtMSINA7ybBqiclpMP062svvWt8z5ZUxdgkdzscRiAwlXVLWQ4GalBTqtKI/E
         X8cEpOnzSqfbJaBwDQrDE6/2qY3rEkIlj0gISGrllgwSpYsdui5Q+7nENy2ReUo4CEWt
         DzhgArOZzcKkZLsPLUb8h8+z581eM9bEsHiaBK92SgC87SYxx96+TEEclp5zgUOEBTf/
         syIQlYtcuHnqS1e/BmH9ko5bRfrGK5erEaFAdc4P/FJa3V9R5Ngj8GMZ8gzPrwMsui97
         91ut8rKmWR1uIUPxWsNrHD49C+x0Lrcl+HwkKSY6byG5mlSBywOV5ZAhFfAfivM0ZNxK
         SmXg==
X-Gm-Message-State: ACrzQf2J0407dqZHg8WKJZoFh4E0vTNTDLhWcaO2hFBY4xemKp4KOHrA
        lUKCLJvoQkMdX4Zs1dw1xNg=
X-Google-Smtp-Source: AMsMyM5pqUAeIdN0oGRgLAL7M1T6tb/7Rj3jvQ7XAGensk0RvonnF1DbHnxRv6txUMRjnPcThNDhDw==
X-Received: by 2002:a5d:468a:0:b0:226:d78a:6af with SMTP id u10-20020a5d468a000000b00226d78a06afmr615780wrq.339.1663265847537;
        Thu, 15 Sep 2022 11:17:27 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:26 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 02/10] dt-bindings: riscv: Sort the CPU core list alphabetically
Date:   Thu, 15 Sep 2022 19:15:50 +0100
Message-Id: <20220915181558.354737-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sort the CPU cores list alphabetically for maintenance.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
* included RB tag from Geert

v1->v2
* Included RB tag from Krzysztof
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 873dd12f6e89..2a1c5ae5b0aa 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -27,17 +27,17 @@ properties:
     oneOf:
       - items:
           - enum:
-              - sifive,rocket0
+              - canaan,k210
               - sifive,bullet0
               - sifive,e5
               - sifive,e7
               - sifive,e71
-              - sifive,u74-mc
-              - sifive,u54
-              - sifive,u74
+              - sifive,rocket0
               - sifive,u5
+              - sifive,u54
               - sifive,u7
-              - canaan,k210
+              - sifive,u74
+              - sifive,u74-mc
           - const: riscv
       - items:
           - enum:
-- 
2.25.1

