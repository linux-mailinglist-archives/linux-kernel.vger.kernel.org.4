Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43472E767
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbjFMPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242919AbjFMPem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:34:42 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0F510E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:34:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b162fa87d8so3046091a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686670480; x=1689262480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaKztkphf6Bxk7epVR1Wqf3vysiYNPTt+hK5SRnwDA8=;
        b=oeYO7hapZBlaFPJX1SWGXlckvFpmgvdEQoR7Hdm+8KE+HpXFwmSrfNfkCAR9rHgKHk
         tT3q3cYy257vFWErU6BWhttTkFNTnmi39WE5TJXcJ8/IuT2xmK2orgTRvmsiJXVcIXnB
         /HRCq16h0pKYGI01r/NNH+vtdIEBQiPOof4pXJVqdaQkw/86ifq5mKgtffxZHwdPVE7k
         UoYfVnqTiE5i8yAeJe8QWotssx5NiHuyq13oMHjW8lubXHGzxkvTgfeK9aiP79UaZQtE
         5emH1jKV9m0myuqPez+BXC+6wvubfxpN7p3PF/54FyqRj3hLSVh3gdp2gFDTxdyBvUpl
         egWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670480; x=1689262480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaKztkphf6Bxk7epVR1Wqf3vysiYNPTt+hK5SRnwDA8=;
        b=b5p7eXDgjOX6fFZjrkuOmm7NYwtuARxKTdconeHXKIiyDePg2m+xRT4MIP/uyPj4Bu
         XPb2AOPK498aBxwnVYeT0kuNNOnrxz2Dpq9DTYp/PriTtnCDbcrJ/fyEnQ4QtDyfrwdN
         q7xIsv03SpAK7XME2RG+O1mWWihqFAQmbKD6Q9HscS5qlDgicMz6H+fmZ871ecyDsZLb
         u4cXtQlxFixixPSK7ygOPOyUJmpEIhGkduJRtRptAkjgGwT12FkqgUbmXRB1hp/qtfGl
         OpRJlPOAFr7W4dR+Z5C0UqhQUkCf1Opr1U7Yg8FYJSwst+ttGZY6bFUdSeRLxIffFVKC
         V0Lw==
X-Gm-Message-State: AC+VfDyMaMCxOUZpUgBnxZG+Z6hHJ9Bt3Qr5gXdvJ48E9Tiod98s2NMB
        5dS64l1NzICpZ3hQOHFaf8dbIQ==
X-Google-Smtp-Source: ACHHUZ5bFvT8beTRSpq/IpBy8h5mVYBspjf+Wsvpe0B+YtIFMJxpp8SFXQt2G2tf2Mp5NyW2jc9/NA==
X-Received: by 2002:a05:6808:87:b0:398:f48:eb4 with SMTP id s7-20020a056808008700b003980f480eb4mr6986593oic.36.1686670480558;
        Tue, 13 Jun 2023 08:34:40 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020acabd02000000b0039ce305ea4fsm1630807oif.14.2023.06.13.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:34:40 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 01/10] RISC-V: Add riscv_fw_parent_hartid() function
Date:   Tue, 13 Jun 2023 21:04:06 +0530
Message-Id: <20230613153415.350528-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613153415.350528-1-apatel@ventanamicro.com>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 94a0590c6971..6fb8bbec8459 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -77,6 +77,9 @@ struct device_node;
 int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
 int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
 
+struct fwnode_handle;
+int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *hartid);
+
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 5de6fb703cc2..67b335789b22 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -73,6 +73,22 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
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

