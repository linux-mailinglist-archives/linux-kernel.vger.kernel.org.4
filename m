Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD974D219
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjGJJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjGJJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:48:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1F49C4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:43:46 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-78363cc070aso206104839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688982225; x=1691574225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWvqokmp7r4qpLb1zZr/K+Grf5K67mplcBtMET9ZvCc=;
        b=GuLbKlzbbm4+IQ1CE2fG/Sh0nv+IuRFqdVmE9lHlCnzZvCYcJ+fNJwYSnPgIzs+2LV
         0IumeDVWpjLHWIAwGn8ZjRZ0r1R1/9vJRUN9TaFiD3zMurfzY5FyomAvdQdAftRrvSlC
         72NrgVLlgcFtJggqHFSs+M/7UafyA2H+VYl6h8Yf78Hd3q4y5NOQ7MzGdq0rbQXFNHYo
         1NHVjpf9Dy3tZWu5EWaO88c/SG2Q7jQlqvSa6npE0kZuPIOt2Vl03C8cwLz1ojq3wVsL
         lBJfnTyUc+N4gS4/WzoxhxqCjVAfxLl19R5srAdH//IlLNZqP53SsgxbqhNDM/8ZvGcJ
         eWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982225; x=1691574225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWvqokmp7r4qpLb1zZr/K+Grf5K67mplcBtMET9ZvCc=;
        b=I8Ny7/zkEv1cDQWrs9xsj+h22nvq4BEhI35NzDZARmN0PPBkGn7EI/PhL8JrO+qH2z
         uaZ6M6rFZNwY8swbzjmYDq87WUamCAhRcS9/QmAQUH97lx5kow6kLk9mvLhwECC/lEIk
         hxDID7VYMPNwnvSEY93jRXdZ4qbcWHmGFFV/Kahv36brdPCyq+lVcAVhfto5GfK+P7hg
         VaR4YbqPzM+zIFwhINepqI6VXi/nQ5YABh0IuWRe8JkxnwgHHA3ob6DDqBbMLzuF5zxu
         GPhtHVFMRL0ANQzUcyqSFjnMymNjKKBL2ZLpsyNetdKCMWaq6i6f1Sh+S2i47E4Sd+ak
         tiEw==
X-Gm-Message-State: ABy/qLbDKMt7wmZIEFDGvKIsjlcd9JpDkBkzwmRzD5V8A8qduOq4sEL7
        hZzplvyyi+cR37nUwtGbpKkasw==
X-Google-Smtp-Source: APBJJlFEyLkIuL8Wq3Jqu7Z6swRF/VIvMb80OEnwDuIryYk6JE6AjqCkbB4cESzshC7MW2kIN8b3BA==
X-Received: by 2002:a5e:df01:0:b0:786:fff8:13c2 with SMTP id f1-20020a5edf01000000b00786fff813c2mr5491462ioq.11.1688982225538;
        Mon, 10 Jul 2023 02:43:45 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k1-20020a6b7a41000000b007870c56387dsm936938iop.49.2023.07.10.02.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:43:45 -0700 (PDT)
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
Subject: [PATCH v5 1/9] RISC-V: Add riscv_fw_parent_hartid() function
Date:   Mon, 10 Jul 2023 15:13:13 +0530
Message-Id: <20230710094321.1378351-2-apatel@ventanamicro.com>
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

We add common riscv_fw_parent_hartid() which help device drivers
to get parent hartid of the INTC (i.e. local interrupt controller)
fwnode. This should work for both DT and ACPI.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/kernel/cpu.c            | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c950a8d9edef..39dc23a18f88 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -81,6 +81,9 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
 int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *hartid);
 int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
 
+struct fwnode_handle;
+int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *hartid);
+
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..9be9b3b1f333 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -96,6 +96,22 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
+/* Find hart ID of the CPU fwnode under which given fwnode falls. */
+int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *hartid)
+{
+	int rc;
+	u64 temp;
+
+	if (!is_of_node(node)) {
+		rc = fwnode_property_read_u64_array(node, "hartid", &temp, 1);
+		if (!rc)
+			*hartid = temp;
+	} else
+		rc = riscv_of_parent_hartid(to_of_node(node), hartid);
+
+	return rc;
+}
+
 DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
-- 
2.34.1

