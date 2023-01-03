Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB4E65C1C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbjACOXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbjACOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:15:00 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CEE1180A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:14:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c9so15748694pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9cahVv2TInUZQq8hRVXfSnhUh5CoJndbcse7r+efrI=;
        b=JvQp+D22PddPJwvOIzWqpbiumCna0mY0Qs6kY5uGOPhttIQbAM07RfSktwA4YPQDfl
         FRzZBAQa1PKaQ4UOFU8QKXnvXEq9fkmdQVQzIxvWxnMxmq+/PDipRUhO8QEZiF9wTfMU
         P52esXVKy7v38CPrSEkE68VSvOw77TJgHkFqytND0WptHKP4kcU4dR7iKqTNVgp7n072
         q5q4uG7oGjmRdcQQogprEohimTvr8TGccFiqF7wBLc6VQPwPG7u0F0S09v1MTCiW9TIC
         yCy+hpq5AQGc+VyAeDFktNK0ysxTjMzLHXasMDKkUO6XMMAenXgOCUhII9mEC2Pz56ig
         9D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9cahVv2TInUZQq8hRVXfSnhUh5CoJndbcse7r+efrI=;
        b=hjq/VY/f+GltqNkTGk4TlhiQTU71EHCjjoOqccGoBZqQ2+YG2pjS8zqsYpb0MwhaNs
         aOXLlQLWMxt//sRVnnqybveZxnesQdPdKJtW9EO9bCXAG4XqDVo0/ZBywOJXa8jWcnO5
         sbVmeTQNGFjLoK9jx/eww3aNP8+rA9ge9EbWV4HGUVakdbWhxQdvD5UAjEOY6lqzESSZ
         IxnNRxRh3GtA8a+o8YKwfThgscT9hFlSx2XpGNGC8wK1uOijDF5z7/j/rZ094ZPce75o
         JOi0nrFWVmn5lXjodqUo0dLd5x8FxufaMhkEeq1xvfljJPNYeDdUa8/y+rpefOoVh5/Q
         YMwg==
X-Gm-Message-State: AFqh2krpLIo2JUQGarqvdzV2HN/okbWp8A8lJ5qt1TziOXU7ZWx2qnPh
        u8JphSf/UreCA1nefsTDUpExDw==
X-Google-Smtp-Source: AMrXdXvCOxRJHxTUnBXhg91eXznx4qUxOjJDdB2DRp725FJ6It0JynsEemtk32n/ofi6kbO+KalXBg==
X-Received: by 2002:a62:cf42:0:b0:581:a004:3f36 with SMTP id b63-20020a62cf42000000b00581a0043f36mr21220945pfg.25.1672755298798;
        Tue, 03 Jan 2023 06:14:58 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id h1-20020a628301000000b0056be4dbd4besm5936035pfe.111.2023.01.03.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:14:58 -0800 (PST)
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
Subject: [PATCH v2 9/9] MAINTAINERS: Add entry for RISC-V AIA drivers
Date:   Tue,  3 Jan 2023 19:44:09 +0530
Message-Id: <20230103141409.772298-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141409.772298-1-apatel@ventanamicro.com>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
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
index 7f86d02cb427..c5b8eda0780e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17942,6 +17942,18 @@ F:	drivers/perf/riscv_pmu.c
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

