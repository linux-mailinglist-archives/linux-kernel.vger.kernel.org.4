Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A96C44B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCVIRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCVIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C55D26C;
        Wed, 22 Mar 2023 01:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3AE961ED0;
        Wed, 22 Mar 2023 08:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A400EC433D2;
        Wed, 22 Mar 2023 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679473060;
        bh=4Q0iAD9vF+3RBVg+My0zZAgAHRwIrYDxgeNinL++dLo=;
        h=From:To:Cc:Subject:Date:From;
        b=YW5WFWH/ZrLn+YDPpteJOhgqjZqeNf3+PKnv2gaSmlwxCVASe38G7lbaHQYrkqGwm
         RlXZAD8+8gj7kcQ6bI8XNtuaKafkV+E15o9RAVKGoMu9pwUbamnqIu8pk/nbLi5yLa
         EHGUEFuw3Kr5V4/pyVP0OVnMa9dgsKXvfMwbX0LXm+oIoUF3sadDIVTHRxyTNxnPDh
         WEHe7sUk0XAsvmWm/fS1RXCTMGvLLRK6kMEiXTds4twUsF+dbUbsMC1f0QY/KI87Ln
         lgNlVTiaD4uZykLSSFu4LQfc3AHsPwE+mqLOS8Bc0vlHNSLTrS0bitPJkxJBiIhtoA
         N1BMZizPpPA2A==
From:   Mike Rapoport <rppt@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@vger.kernel.org
Subject: [PATCH] loongarch: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Date:   Wed, 22 Mar 2023 10:17:27 +0200
Message-Id: <20230322081727.2516291-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

LoongArch defines insane ranges for ARCH_FORCE_MAX_ORDER allowing
MAX_ORDER up to 63, which implies maximal contiguous allocation size of
2^63 pages.

Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
simple integer with sensible defaults.

Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
will be able to do so but they won't be mislead by the bogus ranges.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---

This applies to akpm/mm-unstable tree

 arch/loongarch/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 272a3a12c98d..e1e3a3828962 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -420,11 +420,8 @@ config NODES_SHIFT
 
 config ARCH_FORCE_MAX_ORDER
 	int "Maximum zone order"
-	range 13 63 if PAGE_SIZE_64KB
 	default "13" if PAGE_SIZE_64KB
-	range 11 63 if PAGE_SIZE_16KB
 	default "11" if PAGE_SIZE_16KB
-	range 10 63
 	default "10"
 	help
 	  The kernel memory allocator divides physically contiguous memory
-- 
2.35.1

