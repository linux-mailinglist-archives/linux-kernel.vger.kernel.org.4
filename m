Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7196252CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiKKEpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiKKEnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:43:53 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D593511A2F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:33 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r76so3927361oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8gSH7BcMR9LDTkxT6jjny0t/ryCD1BHxDOjt6nko30=;
        b=B1fbdqeqOnEjmS7EmE5s2SyFAwtXh283Wobtd82xebmBEWTDII8pDruptfCG9by4OD
         tNfL2DrTyXPnKHmsB763KykEg8WFc13JoOJ99qSRMvTI/SUc1XTyl6QhdLMPhqhKkvE5
         gTFCRfzXoNxfFxLrAWweTeGdOQLiAabsl5NO7h6Yhz3XPdsee/yelTN7Q+4ICO4Vg9ik
         AIhmtczOtaLdysRIlotaElBiWXA0Eib637rPNIrhLDpdE12CXtVrVXn8rH8/O0AwNz7T
         tUj445tiDa8xIhQxoKqH9ywcZ/UhWMyU1KvXtpxgJYILzpcfRli//p2HkzoLFE4K0ZIc
         R+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8gSH7BcMR9LDTkxT6jjny0t/ryCD1BHxDOjt6nko30=;
        b=5JlDW06ftrRL/ldJjNuyMR/SogdvqmnPk6nodl0XozPLYmu1MCF5ZtNpkmmQpiB12f
         NuBWKreoXBNCdsleixus1i62bl+hjRwojiikMLGIASv7jcOqhBggVEKTWKKYLZBNFVmJ
         NLVduEPzi7rwWDPkC0Kse3xWuSodyM3pHSPKeut21vHFIaWJgrpTkrDfiXOpKo7c3a7I
         jX1je5NqZ3xsICCa3E6hDMQZgWBrO1E4LTFGeQOVgZGqGd6xF8Hnv6AHbHzXIzhw0veD
         uxiGSgYLW6UoT+o8VYjfthxQETGMP+gjPpjgcKFr45PuL5wuU5u2ajNm6rLR0ks2jV7Z
         8y+w==
X-Gm-Message-State: ACrzQf0yWpwr6xjAPliLvVrOQba7GRbiQ5sMxZyRO2NZDebthqIW8mm3
        Mv5K6qB1PIk7863IB0n7lMO7tw==
X-Google-Smtp-Source: AMsMyM47O4BVwT9ukeNOv94QQ2Gb+D+i7LnaMxMt3+onc4DfQh3ou/4WMkYMAO5SzNBICgMNslOAhA==
X-Received: by 2002:aca:44d7:0:b0:35a:6dc0:2132 with SMTP id r206-20020aca44d7000000b0035a6dc02132mr2479193oia.266.1668141813088;
        Thu, 10 Nov 2022 20:43:33 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870350e00b0013d9bd4ad2esm787353oah.12.2022.11.10.20.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:43:32 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 9/9] MAINTAINERS: Add entry for RISC-V AIA drivers
Date:   Fri, 11 Nov 2022 10:12:07 +0530
Message-Id: <20221111044207.1478350-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111044207.1478350-1-apatel@ventanamicro.com>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for RISC-V AIA drivers including the
RISC-V INTC driver which supports both AIA and non-AIA platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 046ff06ff97f..8b998144a1bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17713,6 +17713,18 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
+F:	drivers/irqchip/irq-riscv-aplic.c
+F:	drivers/irqchip/irq-riscv-imsic.c
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.34.1

