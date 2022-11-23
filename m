Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA726362FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiKWPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiKWPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:12:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFE12A41E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:12:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D727A61D74
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245BEC433C1;
        Wed, 23 Nov 2022 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669216366;
        bh=sRAK5WjulD/KwNHjgNz+jEe815cMtfQqjqgbH8VwekA=;
        h=From:To:Cc:Subject:Date:From;
        b=g3SwGTECFbfI6ncYLTEOmMkGc2weuIVarAuI2Ucxn3U1LYGuel8V3OAo25/l919yr
         gG0uuE0HN+5brTS7sbYH5+stqVNXmpZethvigWJvn7nDnCXf0JGur4XvBBEXDpbNZg
         LjSPEAmd7eXfRAeLWjPD5Jk5YTRtTRrxoCswo/MUnLsZZpFo77617w3DDbI1k+a8lo
         gSMyhrDlvHbEFlOUxKhOH2fauESUm5zvCQiRYsT7kV1UOnY3yTRH3wP7rIVm60Xsh5
         eMfimX5R2EFGj1c+ikMb/s5GIfzAX1uh5kpE7cE8/HwJGtDLnDBvGhwV3CQCstpxLS
         FcwQjcXCqj4Ag==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Terrell <terrelln@fb.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: boot: add zstd support
Date:   Wed, 23 Nov 2022 23:02:57 +0800
Message-Id: <20221123150257.3108-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
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

Support build the zstd compressed Image.zst. Similar as other
compressed formats, the Image.zst is not self-decompressing and
the bootloader still needs to handle decompression before
launching the kernel image.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index d1a49adcb1d7..c72de7232abb 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -56,6 +56,9 @@ $(obj)/Image.lzma: $(obj)/Image FORCE
 $(obj)/Image.lzo: $(obj)/Image FORCE
 	$(call if_changed,lzo)
 
+$(obj)/Image.zst: $(obj)/Image FORCE
+	$(call if_changed,zstd)
+
 $(obj)/loader.bin: $(obj)/loader FORCE
 	$(call if_changed,objcopy)
 
-- 
2.37.2

