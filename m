Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A62469559C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBNAyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBNAyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:54:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1B3105;
        Mon, 13 Feb 2023 16:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=maH2SZy98/KPk5SI0WVIPKnJ0GBrmU/W71CMItL8ib8=; b=U05NZKDIp4T6btFRFUQTHY/uOV
        swOuky79Glp29Yi1jzXUjH8YvkxuxZ/u9EqDYiqUCX7SZBUPiE/alTvIt4VB4FEaIPBcLOn742fcK
        6mC7Xx+WWKug2znulWwdEDg158RNYjlTtLUyKQK12F2tBaKt8pNdMtJeQVnY6d8RU6v7+4Nw2267H
        KBfZKFB1kY4F2v4+VkhTA+g5t/G3Co6sRzNgasrZ7+hrydpA/j4wlkOydRKOYxZLvw7XTvpP6F8zV
        Yh9YGM/KUQUmvh4LjSBfPr8MLgwYyHLWPUHQw+0UAlPHjJxMzBvwAgyrCY+JPmU8ndkkzLeDbqyfk
        YWZ/PRmg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRja5-00GwhC-Db; Tue, 14 Feb 2023 00:54:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Song Liu <song@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH] module: fix MIPS module_layout -> module_memory
Date:   Mon, 13 Feb 2023 16:54:00 -0800
Message-Id: <20230214005400.17137-1-rdunlap@infradead.org>
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

Correct the struct's field/member name from mod_mem to mem.

Fixes this build error:
../arch/mips/kernel/vpe.c: In function 'vpe_elfload':
../arch/mips/kernel/vpe.c:643:41: error: 'struct module' has no member named 'mod_mem'
  643 |         v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);

Fixes: 2ece476a2346 ("module: replace module_layout with module_memory")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Song Liu <song@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
Has this already been fixed?

 arch/mips/kernel/vpe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -640,7 +640,7 @@ static int vpe_elfload(struct vpe *v)
 		layout_sections(&mod, hdr, sechdrs, secstrings);
 	}
 
-	v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
+	v->load_addr = alloc_progmem(mod.mem[MOD_TEXT].size);
 	if (!v->load_addr)
 		return -ENOMEM;
 
