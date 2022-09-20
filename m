Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96365BEA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiITPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiITPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:31:51 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6BD67C9C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:31:50 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-127d10b4f19so4723823fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NSVDXfSRUDiwSJM94IRfEXRWFe0gjMqEORV1yJ1Cr/g=;
        b=GZvvYs8QmONhNtvXrYrUFMpoJ84rht+aW6CrX7UAdPQuRptDlZcYDtA77Ohj6q3tjE
         e3KZ7Iflou0f6pfJCVCTp9db/mcuYM/kAo31GTyWHkEOcpr9VK5+86DF01k9/5LD1za+
         GmH1c0WMIpTy44oZvMNYt8e6twYc4DxacunJTkfg0Mnl0UbulOPIDX4+uQNhh/qFcMHl
         vlWYmwiWHUWnJI9LhvhuU8lzhw8PjreNdi2vx6trOjt+OC+McQpUDeJfEnl0HCKKtbn0
         a2//xL01A298AgEgJF+iTGAqDvL+XXHWO40zaKmUpsJx0O3m8JLnY3b7UNefhKFGtBGj
         Cb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NSVDXfSRUDiwSJM94IRfEXRWFe0gjMqEORV1yJ1Cr/g=;
        b=kVBbrOuyENi7z2ICm1kvSuzbHtHyQnMFKovaoeUSVDg7SNBtbAZQPcObbtc0emt+Un
         A3SpxjO/CY89ltW5Gf+89UrfEugb8CjLdL0HVgwtFfUV8IfK5HLEAqr+zZTDzGvi1Ku2
         51Qpq5M+7nFaPnfanDMMyZUfZ61Jhiy+PFNAM8ZrZRIkUtvlHt0lN+BgUnodzxKEYpJS
         UDxYzw6cO82BvUp/gmxWsxEC7EGfuFR9WAXnzmy/CY5TBXvCGJaLbsbBd4F5Epb+4Icg
         Y2KIEMeUzbrEIRgwnsTennG3hr/RWaWv7sZ1dGp+iIHby7oOcG7wXyYkHqdnp8qq2PvP
         yKig==
X-Gm-Message-State: ACrzQf2U8m3c83aVkqOhNjHBiisKubMWIJidZ0KcGs73ql/9qOYo6fnG
        jB+sz1XNSlapY9RDS2KV0o4=
X-Google-Smtp-Source: AMsMyM4WgwMmk5VzErXM6IcIhRMz8WP7ZQ5NaOyzKBL0qI0fTo38tGTcDavZLCzqdCdOUJu5P5PQpw==
X-Received: by 2002:a05:6871:5d1:b0:127:7771:f0d3 with SMTP id v17-20020a05687105d100b001277771f0d3mr2373464oan.199.1663687909805;
        Tue, 20 Sep 2022 08:31:49 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id u28-20020a4a615c000000b00448985f1f17sm39521ooe.9.2022.09.20.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:31:49 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alan Modra <amodra@au1.ibm.com>, Daniel Axtens <dja@axtens.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] powerpc/64: don't refer nr_cpu_ids in asm code when it's undefined
Date:   Tue, 20 Sep 2022 08:29:35 -0700
Message-Id: <20220920152935.1569605-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic_secondary_common_init() calls LOAD_REG_ADDR(r7, nr_cpu_ids)
conditionally on CONFIG_SMP. However, if NR_CPUS == 1, kernel doesn't
use the nr_cpu_ids, and in C code, it's just:
  #if NR_CPUS == 1
  #define nr_cpu_ids
  ...

The [1] makes declaration of nr_cpu_ids conditional on NR_CPUS == 1,
and that reveals the issue: compiler can't link the
LOAD_REG_ADDR(r7, nr_cpu_ids) against nonexisting symbol.

Current code looks unsafe for those who build kernel with CONFIG_SMP=y and
NR_CPUS == 1. This is weird configuration, but not disallowed.

Fix the linker error by replacing LOAD_REG_ADDR() with LOAD_REG_IMMEDIATE()
conditionally on NR_CPUS == 1.

The issue was spotted after applying [1], which adds a CONFIG_FORCE_NR_CPUS
option that has the similar effect on nr_cpu_ids. So, in this patch, make
the LOAD_REG() conditional on CONFIG_FORCE_NR_CPUS too.

On top of:
[1] https://lore.kernel.org/lkml/20220905230820.3295223-4-yury.norov@gmail.com/T/#m96ffe122721893471fd3470d911a8f2fad6d03b3

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/kernel/head_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index cf2c08902c05..7cb97881635e 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -400,7 +400,11 @@ generic_secondary_common_init:
 #else
 	LOAD_REG_ADDR(r8, paca_ptrs)	/* Load paca_ptrs pointe	 */
 	ld	r8,0(r8)		/* Get base vaddr of array	 */
+#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
+	LOAD_REG_IMMEDIATE(r7, NR_CPUS)
+#else
 	LOAD_REG_ADDR(r7, nr_cpu_ids)	/* Load nr_cpu_ids address       */
+#endif
 	lwz	r7,0(r7)		/* also the max paca allocated 	 */
 	li	r5,0			/* logical cpu id                */
 1:
-- 
2.34.1

