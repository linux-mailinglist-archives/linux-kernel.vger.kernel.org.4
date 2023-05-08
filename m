Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0E6FAF88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjEHL6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjEHL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:58:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62024473F6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:55:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51f597c975fso4161906a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546949; x=1686138949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXbI3HNo2LwXyvQs8qly8d1W6GTwS2nLVT7+MHc+VBo=;
        b=VJ05ByxAGU0vvx8FU1rjL6l0PIhYquRStC62VT+/S2jdFsLmaNzstWpoe/hp4v7/fY
         9Ylc58Ec1X59MDBgEvRnZDYa2YK4has1nYcaIChEcUHpK9Rtzzs0lN8auNvjP/eS/mzF
         b/q8IeE+kqnv4kgmSGEDfxohLmsEDEAmTj4HLYxPf8Gjz4R36yz+fRDNLHDdLtDGxoAl
         7mtfwXr9/djJaaG1DwPbd57mwyG5l4sdX1mA2Rl2byTeWWF1TsEdVB1cs1cR+R0R1EW9
         +Ash7wiwJX0Utkc0AktTYUTxTmaoyjAeBGJFDxoAhquycttgz+y0oV4T4PsNDlPm/P57
         2AwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546949; x=1686138949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXbI3HNo2LwXyvQs8qly8d1W6GTwS2nLVT7+MHc+VBo=;
        b=H0IwnPqg+J624hqPZEhL8/A1nM59uWGTqTmPr9UezVwKJuyulO6GNfuZyGqf+BeCHF
         AX7Fam0krXIuEpdaYcQgnS75ry1k8ZXdGwEOcg3glBA81kjAbWX8Ctkpb9X1JByNQn8z
         ZjWthOdi0Kx0RD/Abn9vulviESZT2LRhuVvEtDXhLydKnVtHuaKEfx5AIEEeJJh78fIv
         pmSDLxt5D55NpwOrmN7w1tGvvpa34HCFNabgTY2ctJSdenUXudpzkHupSqlfYu4S+01Q
         EH3F2dZdYY1MPB91Yi9UJySfROR+a/jQZIkBSyJqADApsLZc7TPQ6Ga4kC+vvLiYpnDj
         O02Q==
X-Gm-Message-State: AC+VfDy2UgP/wmG8mBaVbNQLDy12NBcijY8FAovROIzkrMTI96bl9s4Q
        mDrizV60gkQHk8/OlcUWitSUHA==
X-Google-Smtp-Source: ACHHUZ4GEr9Y9j7DgnPzlC1fbWrO73mkCaN33oq08+WeT0xKd/++5k0KyC4CIRoSU1LTRnVvt3Uuyw==
X-Received: by 2002:a17:902:b20a:b0:1ac:3e90:7c4 with SMTP id t10-20020a170902b20a00b001ac3e9007c4mr10016908plr.2.1683546948833;
        Mon, 08 May 2023 04:55:48 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:55:48 -0700 (PDT)
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
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V5 21/21] MAINTAINERS: Add entry for drivers/acpi/riscv
Date:   Mon,  8 May 2023 17:22:37 +0530
Message-Id: <20230508115237.216337-22-sunilvl@ventanamicro.com>
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

ACPI defines few RISC-V specific tables which need
parsing code added in drivers/acpi/riscv. Add maintainer
entries for this newly created folder.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..083ba321fc7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -406,6 +406,14 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
+ACPI FOR RISC-V (ACPI/riscv)
+M:	Sunil V L <sunilvl@ventanamicro.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/kernel/acpi.c
+F:	drivers/acpi/riscv
+
 ACPI SERIAL MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.34.1

