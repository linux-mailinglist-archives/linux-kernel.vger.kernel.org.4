Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BEC627C99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiKNLoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiKNLoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963C1570A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35E4461029
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891A3C433C1;
        Mon, 14 Nov 2022 11:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426245;
        bh=/bPckjdOvaLL9aYvpMmz9nRldK/d5QG2/4Y6OavRec0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gcb0VhWKCt/rxScfhWiVX2zbIqOoDNuBGwnZITiBSXj3+tR6NlcaR/m4+URYXcqMJ
         s642tIz5alNfcOpJ0C/ELdyJEhT+nX64teeD/LtSyD7ePpsrExKkdt/YI9C3NfsBSc
         BzWk8i5kc31SotvFZZTIfE/VMK6URsbWVEgpSS06xhe1J4tVNywoOjRgEJhwprz/No
         m5CfY4XAm7qrakrw59iD+BRedBO3DWBHqibzakvPvRNzGj54WyuL9au6+vRgXAwUq6
         c96wd6J89lijmExSkF7PHu4/33ZirEUQCGcR0/JD2qMjgEYFf4CRlg/XAoLCbpx1QM
         E5qhr5gmBhK5A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>, kernel test robot <lkp@intel.com>,
        Martin Liska <mliska@suse.cz>
Subject: [PATCH 04/46] compiler.h: introduce __visible_on_lto
Date:   Mon, 14 Nov 2022 12:43:02 +0100
Message-Id: <20221114114344.18650-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Jiri Slaby <jslaby@suse.cz>

__visible_on_lto is defined as "__visible" when gcc LTO is turned on
(see later patches), and "static" otherwise. It is needed for top-level
symbols which are referenced in assembly. It is because the assembly and
the symbol can each end up in a different file with gcc LTO. And that
leads to linker errors.

So the symbols have to be visible when gcc LTO is in charge. On the
contrary, they have to be static on non-gcc-LTO builds. Otherwise a
warning about missing declaration occurs.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/compiler.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 973a1bfd7ef5..2305a3cbe99c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -133,6 +133,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
 
+#ifdef CONFIG_LTO_GCC
+# define __visible_on_lto		__visible
+#else
+# define __visible_on_lto		static
+#endif
+
 #ifndef unreachable
 # define unreachable() do {		\
 	annotate_unreachable();		\
-- 
2.38.1

