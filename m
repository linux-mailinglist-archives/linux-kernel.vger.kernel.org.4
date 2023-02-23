Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CED6A030E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjBWHB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjBWHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:01:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CE84A1CE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6eyKcKxeMsYYmm98/NS8k7jDKjha+yov5mDRD5bGFDU=; b=cxY5zSb4hUqUbspjYybU6JKQmb
        WTdtv8C1po4tIfjgCCs0LbsZDScsTx4CnpPlToHW3PPJmcje/wc47WZqD56/urWAJ43oAVZQEW4eE
        ZVafpPBbR44MKIfyTicylpB+Yu2Mn76CCkf7guxG7rQSX7plYsCGWrY4ans2nXoUG7obCFxnKRXVf
        grymJooQjDMyZr2FIZ8WXS3SPdZ74khjJJEhCy9E3sQES0ayZWmZKFs9ZZjhgCAaHYozVW0xAw/1M
        nqpPKpCY+nc1/spw/cDDBjn+00yspZkSMT6N9RCwCSx6X6kn0m/9Utraaa3WEqeeatzCv5QgEOFWy
        0Gnn31HQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV5bT-00FMG2-OI; Thu, 23 Feb 2023 07:01:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/pseries: RTAS work area requires GENERIC_ALLOCATOR
Date:   Wed, 22 Feb 2023 23:01:15 -0800
Message-Id: <20230223070116.660-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223070116.660-1-rdunlap@infradead.org>
References: <20230223070116.660-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTAS work area allocator uses code that is built by
GENERIC_ALLOCATOR, so the PSERIES Kconfig should select the
required Kconfig symbol to fix multiple build errors.

powerpc64-linux-ld: arch/powerpc/platforms/pseries/rtas-work-area.o: in function `.rtas_work_area_allocator_init':
rtas-work-area.c:(.init.text+0x288): undefined reference to `.gen_pool_create'
powerpc64-linux-ld: rtas-work-area.c:(.init.text+0x2dc): undefined reference to `.gen_pool_set_algo'
powerpc64-linux-ld: rtas-work-area.c:(.init.text+0x310): undefined reference to `.gen_pool_add_owner'
powerpc64-linux-ld: rtas-work-area.c:(.init.text+0x43c): undefined reference to `.gen_pool_destroy'
powerpc64-linux-ld: arch/powerpc/platforms/pseries/rtas-work-area.o:(.toc+0x0): undefined reference to `gen_pool_first_fit_order_align'
powerpc64-linux-ld: arch/powerpc/platforms/pseries/rtas-work-area.o: in function `.__rtas_work_area_alloc':
rtas-work-area.c:(.ref.text+0x14c): undefined reference to `.gen_pool_alloc_algo_owner'
powerpc64-linux-ld: rtas-work-area.c:(.ref.text+0x238): undefined reference to `.gen_pool_alloc_algo_owner'
powerpc64-linux-ld: arch/powerpc/platforms/pseries/rtas-work-area.o: in function `.rtas_work_area_free':
rtas-work-area.c:(.ref.text+0x44c): undefined reference to `.gen_pool_free_owner'

Fixes: 43033bc62d34 ("powerpc/pseries: add RTAS work area allocator")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -7,6 +7,7 @@ config PPC_PSERIES
 	select OF_DYNAMIC
 	select FORCE_PCI
 	select PCI_MSI
+	select GENERIC_ALLOCATOR
 	select PPC_XICS
 	select PPC_XIVE_SPAPR
 	select PPC_ICP_NATIVE
