Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D906965FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjBNOKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjBNOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:09:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA6429419;
        Tue, 14 Feb 2023 06:09:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A219B615EA;
        Tue, 14 Feb 2023 14:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66BFC433A0;
        Tue, 14 Feb 2023 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676383667;
        bh=hilxX2cQjknwppv7cWUkYn/TC2HNghGbRCGtPZUipXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fb1OpkD1Rcgt+yjx6j0dskJpmYd7Wcm79sGSRVdoifLSQVDsuflzPNK9L15x5pkRv
         lCXqi9/drSZIXX8jqhBIK6zQ2s7M82tSH7IVmllUviRrFkH9LQovRU98TBMC83lLMz
         0gQVQRezqi1LsB9rh2ixY3CfTMSRMqnXqyYZZgn55tOVjr6AalSV851qW1rMEzN2vD
         0gbR2lNgvjhFTyt6QFQQ+Wk0UPfnS6RMem7wYAiZchjU8qBEGsjYXSG9xXeSy5vCgy
         kG0arrNCXb/+ylN6xHu64RF8d0QYnn7414CBeGgFnQC5aXXlPTugLBq2WS4pZBf3J2
         vV9SkD2uB11Aw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org
Subject: [PATCH 1/2] m68k/nommu: add missing definition of ARCH_PFN_OFFSET
Date:   Tue, 14 Feb 2023 16:07:28 +0200
Message-Id: <20230214140729.1649961-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230214140729.1649961-1-rppt@kernel.org>
References: <20230214140729.1649961-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

On m68k/nommu RAM does not necessarily start at 0x0 and when it does not
pfn_valid() uses a wrong offset into the memory map which causes silent
boot failures.

Define ARCH_PFN_OFFSET to make pfn_valid() use the correct offset.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: d82f07f06cf8 ("m68k: use asm-generic/memory_model.h for both MMU and !MMU")
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/m68k/include/asm/page_no.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index 43ff6b109ebb..060e4c0e7605 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -28,6 +28,8 @@ extern unsigned long memory_end;
 #define	virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET) && \
 				((unsigned long)(kaddr) < memory_end))
 
+#define ARCH_PFN_OFFSET PHYS_PFN(PAGE_OFFSET_RAW)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _M68K_PAGE_NO_H */
-- 
2.35.1

