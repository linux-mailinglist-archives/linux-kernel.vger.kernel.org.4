Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A496FAF87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjEHL6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjEHL5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:57:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA13473E9
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:55:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaed87d8bdso30316395ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546941; x=1686138941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38k1Pzb7K1cfn0j2an7l+ypiTAB8VfWPvQzIb1c40CU=;
        b=PChmFsn3jZ8YIN6et/HE2FT9KTKcn+85yUyr9DAN37WxMFW8+DniecytVJXMB+E4Yt
         cwg8NffeENFCvkKnaWixs6tUyDd3Pe6n2aLn4UIePpKETvgDRw/tKZj+YWWWcT4mL8PX
         tYib/TSvHrN7Ey/NaA2sBIl3ZhsF/OALW01VQPmUVWr5lFOnvHHzhr8ONcBU4wdYDXUM
         2glikRs238NvoLM/xUbz0Xj6aUVZA+JwoGLMj1OClPKRSjyvFoYHdvDFP9z9Wm3UBUso
         nG8WFplmCxjrRVNpFWVJOLFxXe7WeRsIP9yzHVTVBjY97ncMG5iq4wNUkEILfoLw9j50
         tEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546941; x=1686138941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38k1Pzb7K1cfn0j2an7l+ypiTAB8VfWPvQzIb1c40CU=;
        b=Kk3cvJveXnN1Si4zuqtJZNM8EZtsHYq1RXUQh9POs5c0+cMnoODMjDxVQrLXMCz08C
         OTxK232jjGgPxzjn/vPWukNTZUpam5z9B17GVpCbTB2QpET2G8u8B9WG6g9xyblI2Mo9
         WCUdLouvRIj23EGzxgECznVyR9hzmxUNF1TJzR7S8ToQfhkLj1/34cG7eIv9SkJlBzq6
         4J2ddGgevyfE8VRPfio5+ZrkO91xDq0CRK67TowqAWF6yf2HIu2a/EIWQVEAKJBJsZBU
         NrHEKC0fe5dgrNRQ+XDFHQ6JXVMsuGUhWHiJWD5w4AOYjfNrgpqgENyBlABl/fsaWHuh
         RERw==
X-Gm-Message-State: AC+VfDzcAvCQ6SRY/8Wq60YpFd9YJ34pZfgAlNxkHOcuKLIpNIovSD/h
        SSvldztoClDR0dCnxlUDMrk5+g==
X-Google-Smtp-Source: ACHHUZ6zMo1/GVdCMuvw4uqUNbB5el8P538gaRe9zZQmHaDTlvRjtiHbiNIa2a1kNbjX1A6CxKl+VA==
X-Received: by 2002:a17:902:8c96:b0:1a9:631b:7d68 with SMTP id t22-20020a1709028c9600b001a9631b7d68mr8947702plo.8.1683546941248;
        Mon, 08 May 2023 04:55:41 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:55:40 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V5 20/21] RISC-V: Enable ACPI in defconfig
Date:   Mon,  8 May 2023 17:22:36 +0530
Message-Id: <20230508115237.216337-21-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to build ACPI subsystem in defconfig.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d98d6e90b2b8..d3d1fbf2dd5f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -37,6 +37,7 @@ CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
+CONFIG_ACPI=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.34.1

