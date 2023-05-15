Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E548702398
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbjEOFvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbjEOFuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:50:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB830E3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:50:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so8651975a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129810; x=1686721810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9sxg5LZ/1sJSiDItv56ESM72UWoohRRXZed1vK0StQ=;
        b=kaAUDpih0jUhuzYDaFUs796OI6OybZW4z1nZqfRrHyrOXA+SPlupF/HJwn/i2GenOO
         MzyPPOY4cGJe4KaAehRUscWd+g2qgi8mDJQ9bV0QRIy55KGVkS+5Wk9vi6J00+PhKh1u
         N13JLuabsr15XiNoT3fNj0HSUfjN+FKWcifF7TyTZk9aAkXAbQ8gkFXOZBmwSAAvKCTL
         3MYAgN0dA6NXMFKHeV4RfH99zIFnQR+6KkKrPs+T9iojC+ZpnXnY93sTEa2NEpBYdBce
         P9i55KrjWZeJfCegm9P77kc0uLXvZQKRDHAALHHW7sYc2vBxeu+5x3taTtSMYGVDdqR5
         dNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129810; x=1686721810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9sxg5LZ/1sJSiDItv56ESM72UWoohRRXZed1vK0StQ=;
        b=kJKabr9bGX++5+aVEzxe7fUXYGeiD12trGiU+3gRHdCYqdLeOgyzaQHcziMZpITLm7
         h44lfMkS7VgofkcSdFXrQvP6m5DawOsScMEYHnxFe8zHXYQnSTB8IsGXsKfvRVl8qSOi
         MQr5PpkdP2CX+TTAvVLxpsNIyUoxD2ZxQp6i3258gYGxw27IPEJctlanyW/acsne1w7m
         WWFDkTn5szxQy3sH66f/yKYsPlNZ0hBR6ML1RZOLAtqSPCE+YVkiK7K47NWasdH2CzC0
         brVY8Bfm34kC8mw/QZkiUSHH+FvcZBQcUeImkuVU0Rku/gPPXfnP4i53sebTuu8gEdX3
         7TWg==
X-Gm-Message-State: AC+VfDxGDLWDZayVakKvpedyCmxCaTgkBMBNaMDGUvghxWXJKNW+lHMl
        dzo5Yn+ufXvROG4n8uaG1ytm4Q==
X-Google-Smtp-Source: ACHHUZ7BcBI2fVa1bsi418TFvoRF8XzHHzGww+BnI1uyuoLqplEZz7lN9zxikSRf/UzeyKFTR+WUzw==
X-Received: by 2002:a17:902:db02:b0:1ae:89a:9e with SMTP id m2-20020a170902db0200b001ae089a009emr5693741plx.61.1684129810542;
        Sun, 14 May 2023 22:50:10 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:50:10 -0700 (PDT)
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
Subject: [PATCH V6 05/21] ACPI: OSL: Make should_use_kmap() 0 for RISC-V
Date:   Mon, 15 May 2023 11:19:12 +0530
Message-Id: <20230515054928.2079268-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
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

Without this, if the tables are larger than 4K,
acpi_map() will fail.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..f725813d0cce 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -276,7 +276,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 	return NULL;
 }
 
-#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
+#if defined(CONFIG_IA64) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 /* ioremap will take care of cache attributes */
 #define should_use_kmap(pfn)   0
 #else
-- 
2.34.1

