Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFBF673E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjASQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjASQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:04:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D386EE6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:04:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E99C61CB5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F1C433F0;
        Thu, 19 Jan 2023 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674144283;
        bh=HZ2KeW9xZS9UJRxhjs2snT6EZu0lqTWV3MzCCMYghqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPQmJJUes4tQ1AHeqLpcuDsBW0QuzfZesiN8dtYdaZeUVxPt0hMlcL2HqoMfSORIU
         R0OGX1vIgqw3Szuz+yOhOdEK31eu6KYWEOSNPET/XJ0cnB+S8FklJuGJ9vsNuRKPvw
         RQyodrQj7IYIZcVX2nPnM/kdUcw6rvQ1sEp7TaCJ2c1LZFR35A01Va75F6cuiIKlgA
         7IsczqPTd5NABgRSLCJBfB5wPxqtdNdKc0B/oSOiRf21wenFIlD+c4l+B2b7vqzHgn
         McDiYiDWtnsikeoHgFtGuixpH1sleZfxOm9OJ2VMgTBfNfi23ir6UeiBOBda2Fz/lc
         3KP1k6cQgZ7Zw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] riscv: vmlinux.lds.S: explicitly catch .riscv.attributes sections
Date:   Thu, 19 Jan 2023 23:54:15 +0800
Message-Id: <20230119155417.2600-4-jszhang@kernel.org>
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
riscv64-linux-gnu-ld: warning: orphan section `.riscv.attributes' from
`init/main.o' being placed in section `.riscv.attributes'

While I don't see any usage of .riscv.attributes sections' in kernel
now, just catch the sections so that we can enable linker orphan
section warning.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 6a250313b752..7eb3d25d0dae 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -146,6 +146,7 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ELF_DETAILS
+	.riscv.attributes 0 : { *(.riscv.attributes) }
 
 	DISCARDS
 }
-- 
2.38.1

