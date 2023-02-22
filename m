Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0FA69ED0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjBVCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBVCuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:50:44 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479EB33471
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:50:35 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v1-20020a9d6041000000b0068d4a8a8d2dso1271923otj.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McQi89uTbN7DF8jJyCgZeVyYtI7bAf8jLzdMMiV8l3U=;
        b=c1xI3XHKGohwQIKFk42Xysj7ExmK5WzvEV05vtimmkIeaaEzd0hMCiE/obU2RZT0Or
         fVE+TI0pYtvIqwYTWtdw5ca8EW5qdCJ6dKI7otBYNiOkOtim/vyLA7ze80BY+4MUGWcW
         m6oHEPFivR5zv3hS/2h/tRHTZkQmHJWIZRhgKNA4+bMY9KDfsJahZg3unsQVNu83BTPj
         f8Lvvcovbx9rMNFB0CQeDZL/BlRlG/FlIm/U/35kCMA5h66CV/KPyaYt7OZh9iv8agF/
         2PfXk0lI+8H1GyUEh0sPj4eeOJO7gOCDTKMC00oKioeclPwHhOGAKHoY+T25MW5kELTr
         HGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McQi89uTbN7DF8jJyCgZeVyYtI7bAf8jLzdMMiV8l3U=;
        b=iYQczpT79PTbEjGIzJvPn9MrBX8x3jsr9V1QdIDBFYgUczCrHNtZeS6lexsbL6saay
         +e/EYKfY/h2CTWAwEngaISqSAd9x0vupeGcKJrlOJIFKyqU0Znkhv+Jz2l6fu68fRZwr
         4BvC6AApEuYpEMvlHDeiPZqLWYURzOzCxm5NEZNu1GiKc2E0XmMosJIH6415wehjj5so
         tA5rE/LYm4GBRglmlyIBp2CX9AmLbinT5g5hfPgSNzYCIyvPE5C1Rpeiz8hK9m29GlCO
         5Oc6E9tN1UvqV4OZxTAIFLKA9bld6FcGF2FZ+QTX9WMZq31IXmRNTeS1RRaJ7OystEQx
         WX9w==
X-Gm-Message-State: AO0yUKXL7H9uWV0SSv1pzG3drU4MmzW0+G228H8zXKkzSBzU52ZOTT+k
        4fw7W0PndHr0f2AJEulv42k=
X-Google-Smtp-Source: AK7set+ZgpgMCsnbEoZOPq/ABD4/QpKNx4uG/xScyv0xZvSeje/L+YyfRFjn6mXEkahnuvnyBw4Uog==
X-Received: by 2002:a9d:60c1:0:b0:68d:53d5:f7d2 with SMTP id b1-20020a9d60c1000000b0068d53d5f7d2mr7853269otk.31.1677034234476;
        Tue, 21 Feb 2023 18:50:34 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id 90-20020a9d06e3000000b0068abc8e786fsm333298otx.10.2023.02.21.18.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 18:50:34 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jeremy Kerr <jk@ozlabs.org>, Jakub Kicinski <kuba@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 2/2] powerpc: use node_has_cpus() instead of nr_cpus_node()
Date:   Tue, 21 Feb 2023 18:50:29 -0800
Message-Id: <20230222025029.453834-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222025029.453834-1-yury.norov@gmail.com>
References: <20230222025029.453834-1-yury.norov@gmail.com>
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

Use node_has_cpus() as more efficient alternative to nr_cpus_node()
where possible.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/platforms/cell/spu_priv1_mmio.c | 2 +-
 arch/powerpc/platforms/cell/spufs/sched.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_priv1_mmio.c b/arch/powerpc/platforms/cell/spu_priv1_mmio.c
index d150e3987304..55b5024b256b 100644
--- a/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ b/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -64,7 +64,7 @@ static void cpu_affinity_set(struct spu *spu, int cpu)
 	u64 target;
 	u64 route;
 
-	if (nr_cpus_node(spu->node)) {
+	if (node_has_cpus(spu->node)) {
 		const struct cpumask *spumask = cpumask_of_node(spu->node),
 			*cpumask = cpumask_of_node(cpu_to_node(cpu));
 
diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 99bd027a7f7c..9d29cc2c6bcb 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -154,7 +154,7 @@ void spu_update_sched_info(struct spu_context *ctx)
 
 static int __node_allowed(struct spu_context *ctx, int node)
 {
-	if (nr_cpus_node(node)) {
+	if (node_has_cpus(node)) {
 		const struct cpumask *mask = cpumask_of_node(node);
 
 		if (cpumask_intersects(mask, &ctx->cpus_allowed))
-- 
2.34.1

