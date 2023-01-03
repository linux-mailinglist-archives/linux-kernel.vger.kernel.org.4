Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB465C1A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjACOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbjACOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:14:35 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C511470
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:14:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x26so14399317pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjWQ9F0LaanvIi9SVaFlkrqw0WGzFdxUF931tj4YTWo=;
        b=GZYVbitECZoAD3ey9QrMfJLiWi/l3+YL/cWg1JzO1nEzdeiaUZkCF3gCUl7Tk0Z94k
         ABJ8gC8Q0sOTdWpEXCrp4WrrKo4DeeWMs1QMADuHyb0qhckjOYD6zeVCYqL2BvVBdTUy
         uw+FLxBFbVQearylGjJ9Pl4QIjAAzRkUwDK7iZrV4N+d78BEHyeLkaP4bQfvLaO4dofJ
         HtFaNK1XxPw7PDSfRRkzFQU9IZroxEyfXEFqwQaj6dCk1LF/oAvKIT4gpf4zePI/8ijm
         4nbgogtin1Cod/6Ae5EXr62dRm1YRLLUC+36silPmflY8kwSkKK5bsfW8Kso7k3Akexq
         gpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjWQ9F0LaanvIi9SVaFlkrqw0WGzFdxUF931tj4YTWo=;
        b=18jDKRlHi1JMUizDiI7cO4JrleUUELxlSIPfwiKuJlcQf31b1tovbXGwejoy10mINY
         WgWOrUzduIucIVYqvradPORPh4YnNzLguYpDnOGWJD5bqHILM/67wEx8V353ozqW/aOB
         mrnUthHqqq9NRFZxX/Hq6fuEZuz6bhOmz6+kICS4HUs8hC9XXxzgd3WQ73whZLyY0gx+
         KULVX8/vrq1Um7I/YKBD9ZLnbWK0FVEzjRPLDtFrFpqZ19Q0zIjRSlfjC/M2bJ8Xjjzj
         lZWPrgctAcMZ6iJx/x+bcqOoLgcfWtVzIN8iIrUSglilQdLKvwXhgPMlNb1DloNrO2Zf
         NaIQ==
X-Gm-Message-State: AFqh2krUXcevSMcQtz1LyGz5n/nQw5cAALB/lxMWPZt5GA2dVkXzPuoJ
        GDKReTZVoX02YllpgmJinXAOVA==
X-Google-Smtp-Source: AMrXdXvf/gvvn3/oN9lIhKpzGY3lwKjFoI6A82HnYpIyBCDuDPQ3CtXCyMnpDhbny2VDXnNqlYISDg==
X-Received: by 2002:a05:6a00:1d9d:b0:566:900d:5af2 with SMTP id z29-20020a056a001d9d00b00566900d5af2mr47650556pfw.34.1672755268316;
        Tue, 03 Jan 2023 06:14:28 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id h1-20020a628301000000b0056be4dbd4besm5936035pfe.111.2023.01.03.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:14:27 -0800 (PST)
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
Subject: [PATCH v2 2/9] RISC-V: Detect AIA CSRs from ISA string
Date:   Tue,  3 Jan 2023 19:44:02 +0530
Message-Id: <20230103141409.772298-3-apatel@ventanamicro.com>
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

We have two extension names for AIA ISA support: Smaia (M-mode AIA CSRs)
and Ssaia (S-mode AIA CSRs).

We extend the ISA string parsing to detect Smaia and Ssaia extensions.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/hwcap.h | 8 ++++++++
 arch/riscv/kernel/cpu.c        | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 86328e3acb02..c649e85ed7bb 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -59,10 +59,18 @@ enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_ZIHINTPAUSE,
 	RISCV_ISA_EXT_SSTC,
 	RISCV_ISA_EXT_SVINVAL,
+	RISCV_ISA_EXT_SSAIA,
+	RISCV_ISA_EXT_SMAIA,
 	RISCV_ISA_EXT_ID_MAX
 };
 static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);
 
+#ifdef CONFIG_RISCV_M_MODE
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
+#else
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#endif
+
 /*
  * This enum represents the logical ID for each RISC-V ISA extension static
  * keys. We can use static key to optimize code path if some ISA extensions
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 1b9a5a66e55a..a215ec929160 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -162,6 +162,8 @@ arch_initcall(riscv_cpuinfo_init);
  *    extensions by an underscore.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 93e45560af30..3c5b51f519d5 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -228,6 +228,8 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
 				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
+				SET_ISA_EXT_MAP("smaia", RISCV_ISA_EXT_SMAIA);
+				SET_ISA_EXT_MAP("ssaia", RISCV_ISA_EXT_SSAIA);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.34.1

