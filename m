Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB41616A41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKBRNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiKBRM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D722019F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8CC61A95
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 17:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862F8C433C1;
        Wed,  2 Nov 2022 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667409156;
        bh=+kXg0AnyKL/yScM5ZpSouZN8e2TVAvvNgXX6EJiKW7E=;
        h=From:To:Cc:Subject:Date:From;
        b=hEgCoycpB6J1T5HC+Re6SnkeRnP0QfYP5e7wbcT445y0reEll/Ej5UdZqRVSgVeo3
         WI/VAofvqGsFYIkEJLxUdf6M/ru616OjmF1WxnsgseWwz5+3oGTiw0kAZSHTuKNE1U
         9oTPfVjciyp4R+LzZMBytiaU/0YUq3ThTkstBKvQRfjLZd1F3YfQ5AwfeytFUcafRS
         u3fV9MW17Fq0JxKAgPfkFOVC1kG8nz7FNSO9WYLozhIawafKn2VtljzKP4iWvo8s23
         aoI2M8rh4f80884o6pEVI63dgdBBqEDvawTlbu5+OtYs2efuj1TX9BuxjwmDUaeZHb
         P4NpjrMfbBY6Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] riscv: vdso: fix section overlapping under some conditions
Date:   Thu,  3 Nov 2022 01:02:54 +0800
Message-Id: <20221102170254.1925-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lkp reported a build error, I tried the config and can reproduce
build error as below:

  VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
ld.lld: error: section .note file range overlaps with .text
>>> .note range is [0x7C8, 0x803]
>>> .text range is [0x800, 0x1993]

ld.lld: error: section .text file range overlaps with .dynamic
>>> .text range is [0x800, 0x1993]
>>> .dynamic range is [0x808, 0x937]

ld.lld: error: section .note virtual address range overlaps with .text
>>> .note range is [0x7C8, 0x803]
>>> .text range is [0x800, 0x1993]

Fix it by setting DISABLE_BRANCH_PROFILING which will disable branch
tracing for vdso, thus avoid useless _ftrace_annotated_branch section
and _ftrace_branch section. Although we can also fix it by removing
the hardcoded .text begin address, but I think that's another story
and should be put into another patch.

Link: https://lore.kernel.org/lkml/202210122123.Cc4FPShJ-lkp@intel.com/#r
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---

Since v1:
 - fix the issue by setting DISABLE_BRANCH_PROFILING

 arch/riscv/kernel/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f2e065671e4d..d6092ff678fd 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -17,6 +17,7 @@ vdso-syms += flush_icache
 obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
+ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
-- 
2.37.2

