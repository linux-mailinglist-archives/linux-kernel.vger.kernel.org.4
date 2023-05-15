Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054757023EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbjEOF4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjEOFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:55:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E88344BB
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:52:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so11316927a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129920; x=1686721920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+OfAZD2wx9PpRLlK5NDY7msLe+VFYQ8VG8zPNASdds=;
        b=UP3JUPsUJ1/3dUsx+9XwRd+aKn0C6kOE6fBDoUikT8FxNl+xp+gB8mahalQmb0ihgd
         Q7u+3H+YPFZonb1x69OUR6zI0rB+riv1UAWhtDwxnb2ZYjGo/KQLlaA9itLN70mdWhJ3
         7MfZAKjmm7ieCLax5AByypANHXzadlQMKgbl2Xf8ed2w1C3Jwb/FagmGdEpKAX5vxhvA
         i5CZcBU38xUHH/66RZgRzORjVVXU5fbL3+wp3DtFJhQa14LyYexnLq/OuimaF0IQwnhe
         ne3HqhdGKqD6OxKvlZZbQphR6a6h4mT305SQZbTST7GxwBLfTLQrpaM7xlGP/Ns5vVfG
         I4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129920; x=1686721920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+OfAZD2wx9PpRLlK5NDY7msLe+VFYQ8VG8zPNASdds=;
        b=XJKmKHZZ5BwjtzcJs7ypXZ/gY1qh7KGCjToDdBU974eJ9FRnZUQFI/47XCuLzutYX+
         EtR4qh6jLER/C/SNu+b4nUVJKLhlu8lIZt/xLA7dcSFBqaIzkI4uqLIYmcPMyBo5uzdF
         +Q0DsOIYdfkULhfcd18HySZvdgmdtPwjrMWm63Rym5C6Ce2+WFydsm8Qv2C6KcOtXO9T
         pmsmpHwJOzmYJZ99zfMmMWLS7px5Vukco9Uj4iMngNr14JSI97lw3zNmv2dUonmM/LJU
         WXuaE83CAkWXRbFuc4dxWk8wrtoMnxsAyj47U5jIPYLJVtt5E/EDDinDX8J3JQXnrrzN
         rwrw==
X-Gm-Message-State: AC+VfDxOr9BusTY3NhLcTVIwT2VmC5b/924hjROe6apPqcTjb2qiqXJ8
        4rcVd2MPa5mCat2pEVf2rSaADw==
X-Google-Smtp-Source: ACHHUZ7raKD1UEB9BO9HO/a5fCkuFHIsdIRcdjSH1aF/He9zg5LJ4Ho9n6tLwYP0ZSkrYVhsLcVMNA==
X-Received: by 2002:a17:902:d48d:b0:1ac:8835:b89b with SMTP id c13-20020a170902d48d00b001ac8835b89bmr30050863plg.5.1684129920075;
        Sun, 14 May 2023 22:52:00 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:51:59 -0700 (PDT)
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
        Sunil V L <sunilvl@ventanamicro.com>,
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
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V6 21/21] MAINTAINERS: Add entry for drivers/acpi/riscv
Date:   Mon, 15 May 2023 11:19:28 +0530
Message-Id: <20230515054928.2079268-22-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI defines few RISC-V specific tables which need
parsing code added in drivers/acpi/riscv. Add maintainer
entries for this newly created folder.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..1b6e41691d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -406,6 +406,13 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
+ACPI FOR RISC-V (ACPI/riscv)
+M:	Sunil V L <sunilvl@ventanamicro.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	drivers/acpi/riscv/
+
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-acpi@vger.kernel.org
-- 
2.34.1

