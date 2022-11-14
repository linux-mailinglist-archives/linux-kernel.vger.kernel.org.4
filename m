Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B4D627CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiKNLqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiKNLpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:45:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848DC1570A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 074546108D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6153DC43140;
        Mon, 14 Nov 2022 11:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426291;
        bh=/HH4N07B4q93OKd/c3IEVtwZviuWBVpZ7Lrl4/tVzls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOe6gD++KNbRrpH/tH10C/6YEBj1n3J5mggy9+veKODvGhC60VJNojDNuQF0/wSjU
         A623zDV6xncmUth8UAG/d0CukPjOSCgIvJzELhFve6+UeasNUQ56hpyZoP/TdCqc+X
         B0S32pILO2Z17YIIhj7l7qhl3P2DXW/k63JJdKovmTldqBM4mBHBxt/K123TlKmZ9T
         M3IYzuBv2DF8pGr5r2fqEfMyHOa2gMTg6IgltR0c4rp3AEfEaS8KIxfvwSG69CzkXq
         5JC++VcI5YEICiiQzcBxgIUEoxQ0g8QE5L2E4LgDADV4VqlUtHuwQTeAv24U96IESN
         9oWv1mXsKgP5A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 23/46] init.h, lto: mark initcalls as __noreorder
Date:   Mon, 14 Nov 2022 12:43:21 +0100
Message-Id: <20221114114344.18650-24-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

Kernels don't like any reordering of initcalls between files, as several
initcalls depend on each other. LTO is allowed to reorder as it wishes
and previously needed to use -fno-toplevel-reordering to prevent boot
failures. Now we can use __noreorder per symbol. So mark initcall
functions as such.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 077d7f93b402..ca827e2fb0da 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -246,7 +246,7 @@ extern bool initcall_debug;
 	static_assert(__same_type(initcall_t, &fn));
 #else
 #define ____define_initcall(fn, __unused, __name, __sec)	\
-	static initcall_t __name __used 			\
+	static initcall_t __name __used __noreorder 		\
 		__attribute__((__section__(__sec))) = fn;
 #endif
 
-- 
2.38.1

