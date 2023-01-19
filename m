Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786AE674C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjATF3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjATF2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B930518C8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1041AB825CE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DD0C433D2;
        Thu, 19 Jan 2023 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674144281;
        bh=JVI55/ivlZ2TxoJHk0X2NO1E9dymbfoLXWzO4tbPtjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sb/IuKp0gRLNHotZEmSEUC5VIcFKvFDct3mmUFbR/RgMiNz4w6hsFeLsqIRKBxs8C
         SVXmwwejCWXXx9vxIj0okNKj9s9nXgMDRqz8pM/8I/GxVGChP6BGEhZE/0NpaU0OZJ
         cWnOmQ6gTLwfeU7TLmG8uXy9apHLMCIN3feZd77krFdI3QM7+VTln48Qd4Ahs1o1eJ
         CQWzdokDLVZw/3ZLwLJAV+Z42Yn3++93GRXVXXzJbr+WmZ8w2fVTpHa1mk/RKUh2YH
         8ct/q8JlLqoczfUQ4aTZhYBWCiKj761uH8aPsleUEILO0lJBavjg1fLAxvKgrFvDt8
         /NrYA+SchZ3Lg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] riscv: vmlinux.lds.S: explicitly catch .rela.dyn symbols
Date:   Thu, 19 Jan 2023 23:54:14 +0800
Message-Id: <20230119155417.2600-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119155417.2600-1-jszhang@kernel.org>
References: <20230119155417.2600-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling linker orphan section warning, I got warnings similar as
below:
riscv64-linux-gnu-ld: warning: orphan section `.rela.text' from
`init/main.o' being placed in section `.rela.dyn'

Use the approach similar as ARM64 does and declare it in vmlinux.lds.S

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 07c19f2a288c..6a250313b752 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -97,6 +97,10 @@ SECTIONS
 		*(.rel.dyn*)
 	}
 
+	.rela.dyn : {
+		*(.rela*)
+	}
+
 	__init_data_end = .;
 
 	. = ALIGN(8);
-- 
2.38.1

