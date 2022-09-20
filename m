Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C345BF15A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiITXju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiITXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:39:21 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75BA7C319
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:36:57 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1280590722dso6701597fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IRDa0k/5OP13nGxllwfWF1EOQGOPviM7zC68vUvS8jc=;
        b=nSlKnczQGqN1Us7whr/LRt5gaNNsUx6ooGDTzx23pwJu7GAQG6xX33Xuk4q82lL7rl
         ROLfBhqMNooyocPd1Hs9Czajwik4AxWlhQuxhsenSIS6jeZrlLZHtd3xOprE3ZhE39Kt
         JKKCTGtEHMfAR26JMC+ULiK7/KGtk8zs22E0hFtjPOxSsklxW6rS+hGYFH+KxfrNu5MC
         DBTIhQOIDHJmP9FfnQpkmignF0sBFechkoGKp0kKAz8mr9frjJWNWy+cpBZ/47kQzGvo
         pI72meHb0V1eIJJjNXM2giAs5PcMFsYNATvbq6VhWv1YGGy9SoYwYGgxK1fzXXYkLkPw
         jpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IRDa0k/5OP13nGxllwfWF1EOQGOPviM7zC68vUvS8jc=;
        b=1bCkI2MTqK9XGiJ8fKqhrLOapSxTURlcWqYEnU/rY2zKvda0Zs4uhh8YMiBAqfDoCa
         8ilb87ANKaD9txC28EBN30bksoC3PSclGn6ury+EtZRU1kbkK+YROFl0rWgVMcXOiKu6
         +1+Zq8PRzmzoveqtDpU5bihWPcNkkTzWwNbAZULTnJZOVKa98SbxotxAHWPilhD86IAg
         MpEvCApz7yVgkdq2r29oTlVYGiTr3OaiYB9acOrA9QcOHDw7QQkeYdL0WU2NkM+K9VyG
         +oRl/bAQsUQg8Pbl76QIvSMxErCMdmretRZDVZp5gfDigJi2sgSACytuHZb7EqY/PU/I
         Ehag==
X-Gm-Message-State: ACrzQf2yk6xsmKhFPzXrcKANhgsKsUMoij1utZvbd5YGxR7/cFsbOOOg
        m/2Eqaqz8Gz2360s1de0xqk=
X-Google-Smtp-Source: AMsMyM7eVQJV2lPOgYS/WZ4tP3lKzX+i0j3VqqUYBDcPJ8PR85Mbe4BXVSmGTPK1WZVMd+XRPavp/A==
X-Received: by 2002:a05:6870:2499:b0:101:7531:c7ec with SMTP id s25-20020a056870249900b001017531c7ecmr3594616oaq.42.1663716937255;
        Tue, 20 Sep 2022 16:35:37 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id q64-20020acac043000000b0034ffacec0basm547712oif.15.2022.09.20.16.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 16:35:36 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alan Modra <amodra@au1.ibm.com>, Daniel Axtens <dja@axtens.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] powerpc/64: don't refer nr_cpu_ids in asm code when it's undefined
Date:   Tue, 20 Sep 2022 16:33:25 -0700
Message-Id: <20220920233325.1614019-1-yury.norov@gmail.com>
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
v2: move "lwz     r7,0(r7)" under #else conditional.

 arch/powerpc/kernel/head_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index cf2c08902c05..d36939029701 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -400,8 +400,12 @@ generic_secondary_common_init:
 #else
 	LOAD_REG_ADDR(r8, paca_ptrs)	/* Load paca_ptrs pointe	 */
 	ld	r8,0(r8)		/* Get base vaddr of array	 */
+#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
+	LOAD_REG_IMMEDIATE(r7, NR_CPUS)
+#else
 	LOAD_REG_ADDR(r7, nr_cpu_ids)	/* Load nr_cpu_ids address       */
 	lwz	r7,0(r7)		/* also the max paca allocated 	 */
+#endif
 	li	r5,0			/* logical cpu id                */
 1:
 	sldi	r9,r5,3			/* get paca_ptrs[] index from cpu id */
-- 
2.34.1

