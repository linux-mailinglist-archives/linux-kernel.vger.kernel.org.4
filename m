Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510846955BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBNBJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBNBJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:09:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662D2D7C;
        Mon, 13 Feb 2023 17:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/eABX6egoR0ltWSchldSbx/9FFqW2AHIMhWCGphM4EY=; b=2hzbhy8v65THGe976hZPPjc08P
        oegSFNkNGtnSaT2ET0jQuZ3GspnlP1n22uio3LGfxKOuibZ5NeJJvdl70qrZ7M13DkrBNtbzemhE7
        50GiaYhRG14WEmd7l7Er+7zySyJYfat4fhBygkIs3Pz2YIQImzAhDl9GBkE25PydIiF9DLy4wAYDk
        BN+f0L/CwUpz0FTSNJTGnw6nWOl8PajrW8XZvBApaBf7IzcsnNUnN3tDf+MICUUn5y+cQj4hwjIvd
        LZWBTkkxKXyuLR+N2e6qzPH0S9GfvGdq77rndxV9foCaT73RCP6jGQcE53G7opvOX7OmrlYhXwhi5
        JiswBvag==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRjpH-00GyUj-4f; Tue, 14 Feb 2023 01:09:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH] MIPS: vpe-mt: provide a default 'physical_memsize'
Date:   Mon, 13 Feb 2023 17:09:42 -0800
Message-Id: <20230214010942.25143-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
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

When neither LANTIQ nor MIPS_MALTA is set, 'physical_memsize' is not
declared. This causes the build to fail with:

mips-linux-ld: arch/mips/kernel/vpe-mt.o: in function `vpe_run':
arch/mips/kernel/vpe-mt.c:(.text.vpe_run+0x280): undefined reference to `physical_memsize'

Fix this by declaring a 0-value physical_memsize with neither LANTIQ
nor MIPS_MALTA is set, like LANTIQ does.

Fixes: 1a2a6d7e8816 ("MIPS: APRP: Split VPE loader into separate files.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202302030625.2g3E98sY-lkp@intel.com/
Cc: Dengcheng Zhu <dzhu@wavecomp.com>
Cc: John Crispin <john@phrozen.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
How has this build error not been detected for 10 years?

 arch/mips/kernel/vpe-mt.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff -- a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -22,6 +22,15 @@ static int major;
 /* The number of TCs and VPEs physically available on the core */
 static int hw_tcs, hw_vpes;
 
+#if !defined(CONFIG_MIPS_MALTA) && !defined(CONFIG_LANTIQ)
+/* The 2 above provide their own 'physical_memsize' variable. */
+/*
+ * This is needed by the vpe-mt loader code, just set it to 0 and assume
+ * that the firmware hardcodes this value to something useful.
+ */
+unsigned long physical_memsize = 0L;
+#endif
+
 /* We are prepared so configure and start the VPE... */
 int vpe_run(struct vpe *v)
 {
