Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1F74D22D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGJJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGJJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:49:57 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327C3AA2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:44:41 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-78666f06691so132367539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688982280; x=1691574280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofm6ZZqXNuqTlD7ApqCkKz5DMt6TsGfpSNKkfwssKPg=;
        b=HcWz9mfkvs5FdQY6JwaYRUd1x8Cydw6tK0ZbXGUcKgU982e37q4E7DEL8SMpbHVCek
         M18eeY26JQfb8yLWtVGnb/mbiBhz7bDi6Jt7gUOzTDJk1z0MaOriGxYSWXQG4bzGYKev
         v4bOEb0eVuyxFcLta/fAS25xXCPi0L59bz+N3v4Xk5kGQEv+evkmjnbtfi7htPVyWmTO
         0zojqgco6pcgUMwp8ayE+uk7yZs4xUExX2EKBkM9YIAHTQrSGx+FPvH+ExJXkvVYV+be
         +5z4fAaaipT4bwaa+qmU6zBhN2PB7VC8HwD0qBM5R1QC4D/yN7BgfG3DalcrQEWjquqp
         sKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982280; x=1691574280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ofm6ZZqXNuqTlD7ApqCkKz5DMt6TsGfpSNKkfwssKPg=;
        b=kMNpDIidZ0YBPyC01/wsxq9bzGCh7d/NSTp2hkuf2vI5w0oWoQf0LgIURW+/Msx303
         E1iFT5m2yyw4u6cPVklQFkF2leN+y25kbSxtkleKwZcIbro4QpNWVXmjSp6cATTAZXwu
         O0jSNO6GJIszc7QTFs2MfQY2KYtU4W9bCcRfOJPvVa+q8pi+zuBMMEJLptqPL2/K3p83
         P4JuIO3b/ni9o28UW1/Y5B+lm4rCcG6xK+i5BJZRSoX9FBWSXYYI6pkQGKM4Wd6xpXU0
         +J4l529LIjtBmcgjT546nJHJw0qCnj+MAoxFIuH5zsXEE3TgPfKhH14lvBtt1LYzqJD3
         d6MA==
X-Gm-Message-State: ABy/qLblSdCft6Il470243bcwupN/ZRJ7MLbKC24adyaEhg6aPAAEZ3e
        veWKdRAyDZVA7F2mHTDkWGTyTw==
X-Google-Smtp-Source: APBJJlEvN/kXRYuvvzZyagkj3gVCiXxnv/KMPVlBOAwwPNxqHe9Zm6PU9NkVs/vOaNFxbKR3Q+kpMg==
X-Received: by 2002:a5e:c910:0:b0:77e:3d2f:d1f4 with SMTP id z16-20020a5ec910000000b0077e3d2fd1f4mr11945598iol.15.1688982280420;
        Mon, 10 Jul 2023 02:44:40 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k1-20020a6b7a41000000b007870c56387dsm936938iop.49.2023.07.10.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:44:40 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 9/9] MAINTAINERS: Add entry for RISC-V AIA drivers
Date:   Mon, 10 Jul 2023 15:13:21 +0530
Message-Id: <20230710094321.1378351-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710094321.1378351-1-apatel@ventanamicro.com>
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 3be1bdfe8ecc..a85fc0102179 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18245,6 +18245,18 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
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

