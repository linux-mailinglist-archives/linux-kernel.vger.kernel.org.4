Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFA627C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiKNLo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiKNLoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA701F2E0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C556B80E76
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13334C433B5;
        Mon, 14 Nov 2022 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426246;
        bh=Kzg4cZoweNmjL16Z27jdyhSbNXbJfBWwbmh5FgksE4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DK4Z5dmsCCFNhlyXArZQesbHiS2bgahYRLOSN31NemV/F4+JLy9FW61lL3aPTJU08
         ztNEYSFk/h8nQTukpozOw1OJA6azx2QRns8q64k0//yv3tIfJI2Dr5mPh4E/EM9DW4
         EE67HZn5MhxxKJR6NjSVwNc6xIb0cZPO94fgAHh+rZxb42s2wM5ThzjPZ2f2cqvIzq
         RVpYj8edO6P6Ybl9IEzWG3R+delTThTe0Nap4N9Jbf3WCwHKnnO4+cDefEltib9TJo
         1klr2NSQpW/v73V7ETanqEBpbiRJoxampbh8Emrhbm6XPccRBXc3I07Bj4mvoCx+9b
         3DvXEcgM20hGQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>, Martin Liska <mliska@suse.cz>
Subject: [PATCH 05/46] compiler.h: introduce __global_on_lto
Date:   Mon, 14 Nov 2022 12:43:03 +0100
Message-Id: <20221114114344.18650-6-jirislaby@kernel.org>
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

__global_on_lto is defined as "globl" when gcc LTO is turned on (see
later patches), and "local" otherwise. It is needed for top-level
symbols which are referenced in assembly. It is because the assembly and
the symbol can each end up in a different file with gcc LTO. And that
leads to linker errors.

So the symbols have to be global when gcc LTO is in charge. On the
contrary, they can remain local on non-gcc-LTO builds.

Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/compiler.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2305a3cbe99c..16e4c1de14c4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -135,8 +135,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #ifdef CONFIG_LTO_GCC
 # define __visible_on_lto		__visible
+# define __global_on_lto		"globl"
 #else
 # define __visible_on_lto		static
+# define __global_on_lto		"local"
 #endif
 
 #ifndef unreachable
-- 
2.38.1

