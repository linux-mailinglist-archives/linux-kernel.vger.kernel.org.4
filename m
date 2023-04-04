Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36396D6BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjDDS0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjDDSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:25:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1055FCE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:23:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ja10so32149688plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8jniZVFM5VdIC7zEQqZON+ttcH4hGM09Ty8jho7PtM=;
        b=l4Jw1Rq2ntfHAMU4Y/Hm9cQCfDsI39b8psQRCZLgg7ZBeveqOfGhPNw3A44NfjsPNt
         CDKqtSOQE0ZvLjdx7COmE7Mmmrg95qIj8JP5YmXaGEVFBmrJrdMDDFWnVXKN/Hi3Wdzv
         m7j9aJzVpOi+j8aj17Zs85oruoTEu/NnXDzWeoMKKL+qQSnp6dtAlbbUr8MJhZ7snY/m
         UAdB4JApQKXF0moipSxBKcnvaKFXZhpP/jzffrNHKJ3HaMLoqBJk2NDoulhVo6A56Xt4
         64gplAMVGV20KfPamu5185j/DJgIptQzQinjGOAraB+/y3g6Hlz9Pwdurbr5SvSLD1Kn
         nvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8jniZVFM5VdIC7zEQqZON+ttcH4hGM09Ty8jho7PtM=;
        b=I1mm9ituELgC+Sv7X3NPzzGI03l9t8HAdbxJYRxu4Z3XfpREbutgVzNFG1HEHmODau
         +KToHOdKEuRBVNzumhV+ZL8bdGLS/r8WCbYnATQU/JfA7hIvT4kW2rAOfoMTV18uKuqT
         1Yg1TrAfnh4hNpN2SKI9Q4xifMRvCwXFxZYB5t6qprewKuM7fKQwVFJ7HFLqacIVTe/h
         DDFqmSKKYEm2RH1BhDphdLfoPjSSzh7B9hjkZsV03juxVaKsfTvEhx+MgHPbLPbE7HnT
         dwYjDrYijJdc3+7ahzTjjAZsaebTmwNpNX2TyV+FsWuoooSiYLX6mViZx6Wlnk1ks44D
         QywQ==
X-Gm-Message-State: AAQBX9cOauWELtU6TpXBzvM7Wj7sXG9X6mRHEtYTEa/NVu5hD9HN+Nk8
        bMJQlLynXtpvTxKQ9V5fYCnY1A==
X-Google-Smtp-Source: AKy350YWtiByLvuA5MHF6bNdPYqUjMVVmlzTK+bqmZihos/8knO44e4LwsVq3Bx9usreNyRcUWXZ0w==
X-Received: by 2002:a05:6a20:7b2a:b0:db:1d43:18fe with SMTP id s42-20020a056a207b2a00b000db1d4318femr3016723pzh.8.1680632588299;
        Tue, 04 Apr 2023 11:23:08 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:23:08 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V4 20/23] RISC-V: Enable ACPI in defconfig
Date:   Tue,  4 Apr 2023 23:50:34 +0530
Message-Id: <20230404182037.863533-21-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to build ACPI subsystem in defconfig.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d98d6e90b2b8..8822b49ddb59 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -238,3 +238,4 @@ CONFIG_RCU_EQS_DEBUG=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
+CONFIG_ACPI=y
-- 
2.34.1

