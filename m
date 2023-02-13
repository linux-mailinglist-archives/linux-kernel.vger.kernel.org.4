Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E94693DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBMEzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBMEzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:55:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C58C126CA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mg23so4213246pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7d4Qtypw6ksd0rXUCdfOWzkU5LDKwcQ9sGuN3ONcAw=;
        b=31KnFLQ1jXjMLjTchl1w4moDo9CD9TiKyNs+4OObUXS/bu6U2VBl4731Df6PD7Y9/g
         2XNYNTjZyG7bXyvHEUioI3gERdD7LvSkrCK98xrIHVYmvA5asSACcG8DzwHY9Elw91gc
         KrYDDfbQ0WGQKLe3OQqMCXoSdQognrXbgKTQeLFi2du2ewZSoi8M3yoq4iVIAUO0iC8j
         c+HEm7ay6XzwKJD0dg054Mp6qh6jGMCArVxGFrAxDUUDqIrGtX7IhEKyTa8tCMlq6uPJ
         YpP8FzRMvT6ihcXz/hH1cCXAqlBEJCSPIWcmpziCZgstPBhZ07n1DnUYd6pvHpmuIT8C
         lNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7d4Qtypw6ksd0rXUCdfOWzkU5LDKwcQ9sGuN3ONcAw=;
        b=uphVc5LetU2O2THXc8NksRM3oDoPpEVeU/U3WTlHb2I8o60lEIW4cjFqgIMTTAkzGT
         6QkNrHx3iWdW8wv3WDBMr5EsHzBZoVEP0tYalpYwdQOyKSMgSZg0kl+PmdytR+UHObim
         doQpunw1X4PvcA7YJMfhNNS9iN8oJ7y8Io0QS2rgCMbmU9xCN7cZuAAvqreH/MWAFxmM
         bLZrrFPu4YYn0qxv3xAT36oMVNJC/OR7g9NMJMBSjJ0FKRkIeDq3YzILojNSgq6piLxU
         89nl9FPsxcaUpoBCiuQpiixQ8MlMwvebkXRCPcDttg/a/yLyLDo08gRncJRFXyLs6rAT
         0Knw==
X-Gm-Message-State: AO0yUKUswz0j4+UwyAF6havxgRJh9ASphjYe0vec5839ZN9HKiXAJNIF
        JWij3xMkTjrhcKwumboH5sDEUQbsxAQWgL+Q
X-Google-Smtp-Source: AK7set/LsQt20km3cdR/Kp4fADKzzPOahuIH182d8bTSETTWkRIjfVk2zOeUnxJfWQP4yrfUrjZ6+g==
X-Received: by 2002:a17:902:e843:b0:199:2a89:f912 with SMTP id t3-20020a170902e84300b001992a89f912mr27069676plg.20.1676264070858;
        Sun, 12 Feb 2023 20:54:30 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:30 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 20/20] riscv: select config for shadow stack and landing pad instr support
Date:   Sun, 12 Feb 2023 20:53:49 -0800
Message-Id: <20230213045351.3945824-21-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
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

This patch selects config shadow stack support and landing pad instr
support. Since shadow stack support and landing instr support relies
on ELF header, this change also selects ARCH_USE_GNU_PROPERTY and
ARCH_BINFMT_ELF_STATE.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..9a39ada1d9d0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -132,6 +132,10 @@ config RISCV
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select USER_SHADOW_STACK
+	select USER_INDIRECT_BR_LP
+	select ARCH_USE_GNU_PROPERTY
+	select ARCH_BINFMT_ELF_STATE
 	select UACCESS_MEMCPY if !MMU
 	select ZONE_DMA32 if 64BIT
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
-- 
2.25.1

