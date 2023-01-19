Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6054673E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjASQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjASQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:04:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2DC66ED6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:04:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34B9C61CB2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C585C433F0;
        Thu, 19 Jan 2023 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674144279;
        bh=J6NfBaiAHaZuC3c1U8Q2mwYoiCAI9Bs41guM1DxDgPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGvlB0CvLLTbE3PEOLaWlAM8hyCbtspLIpmMAXkQE65qKeOs1S5YQ6tFOIDNNMTzm
         +mfaKlbigHE/gP4UIVpLKkUE8RGRAFTkwiUgY7UbGhAwFnghvwDYSxA3c8c+df+tEU
         +TXbI3TJkWdTzjtp+4PwcoQY1uuf+slEpGzFUMAiEhuex7y9DTZRa3elnetXCqZEcg
         J6QyYJbwP7Ni+xJqI5I5SWy/e+hvTRPVgwtDMy3tasF8/13mclwc4BQKJhm/3nNxXs
         bV1G5T1YvVXfIcg3yoatppjIV7UlRoU3+cbjKK09/GhIkXKDRLZhxjqvpxAcSI/CyH
         gPkwFYrYYBfMA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] riscv: lds: define RUNTIME_DISCARD_EXIT
Date:   Thu, 19 Jan 2023 23:54:13 +0800
Message-Id: <20230119155417.2600-2-jszhang@kernel.org>
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

riscv discards .exit.* sections at run-time but doesn't define
RUNTIME_DISCARD_EXIT. However, the .exit.* sections are still allocated
and kept even if the generic DISCARDS would discard the sections due
to missing RUNTIME_DISCARD_EXIT, because the DISCARD sits at the end of
the linker script. Add the missing RUNTIME_DISCARD_EXIT define so that
it still works if we move DISCARD up or even at the beginning of the
linker script.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
---
 arch/riscv/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 4e6c88aa4d87..07c19f2a288c 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -5,6 +5,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	4
+#define RUNTIME_DISCARD_EXIT
 
 #ifdef CONFIG_XIP_KERNEL
 #include "vmlinux-xip.lds.S"
-- 
2.38.1

