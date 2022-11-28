Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBB63AD68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiK1QOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiK1QOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:14:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81CD62DF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:14:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so6296712pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7x0oTKpsWp1eBMVcd2HvR7GLV5FrDh1MXNEuBtWibU=;
        b=GdZOldmSeoejY/4MEdz+TDxR+dEPbxAHB2nFoU0GWyxVoxQhUERCL+ZxaQCp1JkRK0
         KhzMcM1nrUYd9KYVlLYnbC17ODw/dUbnRoGsYGB7y8iw08CP2OMlbZ3Tdu9Ag7j8rSoN
         QOUXNtJ7qcbTfXaMrwQ05eXW3JnpLDLGReoYynXAGlFdrLOjgPNGnBBxxoLDR2kwPy2B
         vD+qzpsMtpHy8F1xF7IG3RsR+xK1Ofxq2aXVIUqCjhZC8W0HpDEbv39lHq38zVTbxttZ
         rDWQtzL4WRfsED+a1UfPwP1DqwSyIvz7n72G4HGVBcspcAQCONIAtb+597M9SqvswxVw
         GmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7x0oTKpsWp1eBMVcd2HvR7GLV5FrDh1MXNEuBtWibU=;
        b=2tYYmjtpJBE2ZxCJTt5OJII09AnwmCBxguN51FrSqKN2Sw46uD0w1K/gq6vAr30tWo
         J2TKxGrALWGLvSOOReBk6r6CG5/ZxvZ9WELPiR21IyFyCEk+xbiS40Y//F4hhFtr4pPo
         z/0vD9bd44v3Gt0EHNTJO9dhkpXP5YCH3RXa7bS74RJ+Zvi9ZwB1Oqi4eH/iqbJ2E57Z
         a5H/lxQugtXDp92zzIRuBM0LsI/4M5Kgku1aeuyvuLouPxbUsswc9PSbDuw5t10zypaf
         PVtbtbpqgU+NyyaYtOUlt+fU3pVxzYcHOuw+lEHkFmccXVFuAZs04QSchvXY8mnlDIFu
         EbJQ==
X-Gm-Message-State: ANoB5pnL+VUSabHpnnzvssHxUf9yOJZINYkp6/tJiONrcWTRSYdk0g7T
        G4wYAy0xt0dCeEQ8LXohfWsq6Q==
X-Google-Smtp-Source: AA0mqf6a4nNMoI9Pp6ntgyunakgkDq9LNUMsEe3B51BBv8WT18Ot9XuFrO2+cmOg/sKUyAgU98S8SQ==
X-Received: by 2002:a17:902:e886:b0:188:fb19:5f39 with SMTP id w6-20020a170902e88600b00188fb195f39mr36071752plg.21.1669652083071;
        Mon, 28 Nov 2022 08:14:43 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.0])
        by smtp.gmail.com with ESMTPSA id k145-20020a628497000000b0056246403534sm8210805pfd.88.2022.11.28.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:14:42 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/9] RISC-V: KVM: Remove redundant includes of asm/kvm_vcpu_timer.h
Date:   Mon, 28 Nov 2022 21:44:17 +0530
Message-Id: <20221128161424.608889-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128161424.608889-1-apatel@ventanamicro.com>
References: <20221128161424.608889-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm/kvm_vcpu_timer.h is redundantly included in vcpu_sbi_base.c
so let us remove it.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_sbi_base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index 48f431091cdb..22b9126e2872 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -12,7 +12,6 @@
 #include <linux/version.h>
 #include <asm/csr.h>
 #include <asm/sbi.h>
-#include <asm/kvm_vcpu_timer.h>
 #include <asm/kvm_vcpu_sbi.h>
 
 static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
-- 
2.34.1

