Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B98602E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiJROWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiJROVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DCED38DD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158E4615B0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE6DC433D6;
        Tue, 18 Oct 2022 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666102896;
        bh=OjvCILdRZ1jTgOB8uJxjbPuWbLlr+2SnsWohtENFRCg=;
        h=From:To:Cc:Subject:Date:From;
        b=aoTEAMpyNjdPXWRKOCnpVaEpUWLCCaiO0uiq0Goxv7apJDZwk4afsALeKT1ZIpzpo
         RP+kSCt8txv1PTUDy3g1Sd0LWiP2pulpuJ/Ww6uYnNmlGvOaFJSWwMdKGRQlVfiaNx
         UtPTsNSa9PCM+eJk7d5u9egQ7QCMoOcUjsQ39tZ00shvIVbyxXsSpsLNP5mdT5j7Us
         ZJVyLoZWEnThm8YSgnQE1X/AE98ATEHUFRZrj3yCX7WesGjHznRj5Fl2FRlj4EJ8rj
         Q7GMxgRV/ZPobO9+xBaWq9kIDlYzysIIRUMzHBuG5kfNLMkK8fizxNAV61rgEom+o0
         B4aXi5ZIhfMxw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: remove special treatment for the link order of head.o
Date:   Tue, 18 Oct 2022 22:12:00 +0800
Message-Id: <20221018141200.1040-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/riscv/kernel/head.o does not need any special treatment - the only
requirement is the ".head.text" section must be placed before the
normal ".text" section.

The linker script does the right thing to do. The build system does
not need to manipulate the link order of head.o.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 scripts/head-object-list.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index b16326a92c45..105ea7ac4751 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -39,7 +39,6 @@ arch/powerpc/kernel/entry_64.o
 arch/powerpc/kernel/fpu.o
 arch/powerpc/kernel/vector.o
 arch/powerpc/kernel/prom_init.o
-arch/riscv/kernel/head.o
 arch/s390/kernel/head64.o
 arch/sh/kernel/head_32.o
 arch/sparc/kernel/head_32.o
-- 
2.37.2

