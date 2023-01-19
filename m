Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD8674C65
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjATFaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjATF3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:29:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D8672C12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:23:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ADBDB825D1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2773FC433EF;
        Thu, 19 Jan 2023 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674144285;
        bh=pK9Wljug0Rn52ySou16paWAQsJuCdZT50slSKiioR6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2M7OjAvb5J/bLEAc1b32Jtbukywae8404syAwBYwhKyD3JPidlY3A/Es8gJ9BQAu
         Qp3p/b4rqgs8vNq/1frbEJyI3+RM1MtOo9DD/VCKW2lRBqscBhmIZpxiSHWL2aY4Pw
         RdH4jlK74S/mq0YVuTN1YkdGZzaCjh8SJmPJyJkqoidzKDfoxrLjAhOxPLwnmmwJ9V
         a3b/giUqbhV9myKXy0jPD8f6ZNFRvNZw9GTjnogGUilLxlvCG3/kvhLhBy79ECywzy
         XiMevmoyYtgRE3B/EnERlqPBLQH5PPSmaelHe/isPHMXpPMzdRh02oY/k0x3sc7Y4L
         Jqvc86erhRayw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] riscv: vmlinux.lds.S: explicitly catch .init.bss sections from EFI stub
Date:   Thu, 19 Jan 2023 23:54:16 +0800
Message-Id: <20230119155417.2600-5-jszhang@kernel.org>
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
ld.lld: warning:
./drivers/firmware/efi/libstub/lib.a(efi-stub-helper.stub.o):(.init.bss)
is being placed in '.init.bss'

Catch the sections so that we can enable linker orphan section warning.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vmlinux.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 7eb3d25d0dae..b2813b5e47a0 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -87,6 +87,9 @@ SECTIONS
 	/* Start of init data section */
 	__init_data_begin = .;
 	INIT_DATA_SECTION(16)
+	.init.bss : {
+		*(.init.bss)	/* from the EFI stub */
+	}
 	.exit.data :
 	{
 		EXIT_DATA
-- 
2.38.1

