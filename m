Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD1C63AD67
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiK1QOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiK1QOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:14:42 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7EE029
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:14:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w129so10944931pfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRYTh3DpQ80LeZuXMwrf/BBG8HZ9tRsbrJY4o7VrTgs=;
        b=e1sLIlmJiHEANPq+U54eAHf3W4Nh0ttJp7jgZEIsl19CGXzTS5KTdXxdGnZVN95VOm
         +fAjj4XJIlDcHqh/lhmM2cKyH8S7xnJ6+xt9Xoc3zF1xyNHKqfxdMk+nr7kzDY35QfXJ
         sXCb4pmj60ibe5fwRoceD8yLBnBMr8xYrO8nlMwYwUpdcrzfzC0l9xsHZAejcc0BYvlG
         mSYPf0SqDvsN/0nnevlQ3Ndz/freshRH8YX0YTQfmVaUuKSzIelx2EoRE/8e5aVkTNKg
         oNksB5v1mkmr1c36OgBHsAdJ7725WTdLQuwabxSvQntLoGYMzYNq2l5CjNVxBGc/URnO
         hkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRYTh3DpQ80LeZuXMwrf/BBG8HZ9tRsbrJY4o7VrTgs=;
        b=hKAZwaXYFPqw6qAzD57zbfginrvoewEfYl9Zwus27yqGuxE96JyYdOFAIlhmK7EO32
         22S4wASufFXEjv6zQLoWq2lS/7J2VKBrdgVI//XtYxc079JDJdvHfLsRIi64jEyJHETU
         yl9LlqWrImjKuZnwGodFbM0GSU527LKvoMB147OTij+tpjthWfO6AUxsa2bRdXkOrf1P
         2K2zOdPJDNZgON1CZ2lN2OAFb2fY4nCAoXkusRccnZeDPuk8/cGpVNU5YhKBEZJ2zWNh
         yP1XbTUhMF94L2v1TTD627TWUTepe1tJmOXKmWrOQc/wt4Gc824QKzIJLpLz8gPt+CmE
         F6LQ==
X-Gm-Message-State: ANoB5pm9vb5RGoUyb76mFwHNC2suoUfircFLSXcf19xFjy8DoofI8gug
        t+jSzxHRpUojVJqIJz7XLbULOg==
X-Google-Smtp-Source: AA0mqf6vP9RNcrwrw3LdbjlhLu/1pbC3GRsHHYss/6pjysHf8CgIMVkMyhfjH/kOyyBMFMTwZ7i6GQ==
X-Received: by 2002:a63:5c0f:0:b0:470:8e8a:8e11 with SMTP id q15-20020a635c0f000000b004708e8a8e11mr28249402pgb.490.1669652078905;
        Mon, 28 Nov 2022 08:14:38 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.0])
        by smtp.gmail.com with ESMTPSA id k145-20020a628497000000b0056246403534sm8210805pfd.88.2022.11.28.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:14:38 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/9] RISC-V: KVM: Fix reg_val check in kvm_riscv_vcpu_set_reg_config()
Date:   Mon, 28 Nov 2022 21:44:16 +0530
Message-Id: <20221128161424.608889-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128161424.608889-1-apatel@ventanamicro.com>
References: <20221128161424.608889-1-apatel@ventanamicro.com>
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

The reg_val check in kvm_riscv_vcpu_set_reg_config() should only
be done for isa config register.

Fixes: 9bfd900beeec ("RISC-V: KVM: Improve ISA extension by using a bitmap")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 17d5b3f8c2ee..982a3f5e7130 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -296,12 +296,15 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
 	if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
 
-	/* This ONE REG interface is only defined for single letter extensions */
-	if (fls(reg_val) >= RISCV_ISA_EXT_BASE)
-		return -EINVAL;
-
 	switch (reg_num) {
 	case KVM_REG_RISCV_CONFIG_REG(isa):
+		/*
+		 * This ONE REG interface is only defined for
+		 * single letter extensions.
+		 */
+		if (fls(reg_val) >= RISCV_ISA_EXT_BASE)
+			return -EINVAL;
+
 		if (!vcpu->arch.ran_atleast_once) {
 			/* Ignore the enable/disable request for certain extensions */
 			for (i = 0; i < RISCV_ISA_EXT_BASE; i++) {
-- 
2.34.1

