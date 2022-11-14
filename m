Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3ED627CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiKNLsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbiKNLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:47:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427C821804
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD35DCE0FA7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B2AC43470;
        Mon, 14 Nov 2022 11:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426324;
        bh=ZL8klCP1h/76P9kKdRbQUqGgBjn+aOHuV9EO8AnyNpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDBhXqESy6UCVyjpxo3+gHOdn5+SwcoEj+Qouka4izFXaIPdOuHoSpb7k+SFn8oth
         VXuPpZRMcCBKR4Xw+OevAnNvdq5k3eMN/i84bvYUEFHdPDd4BoFx9FtnmgrO0i3xRF
         ivayV7hWJ8m3iLSTe02S8hRElQjKacFRyR9IFaoD2gauyajwW1hT/MaKiV2ShRD6gO
         h3+tgaW552ZpfxVqw5BIYEsiDZJyWkmNMXCqtQiX7sOBj10i/5f6pWmcc9K2uBFT6o
         lMzmLMQTMKOFTTaa+kz3osbkQX8JW+Evh3eViaTG6NbUHImSKEWdb0N6ny77tLWAw3
         uuw6XHCb0q7zQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 36/46] lib/string, lto: disable gcc LTO for string.o
Date:   Mon, 14 Nov 2022 12:43:34 +0100
Message-Id: <20221114114344.18650-37-jirislaby@kernel.org>
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

From: Andi Kleen <andi@firstfloor.org>

gcc can generate calls for string functions implicitly, and that assumes
they exist in a non-LTOed copy. Mark string.o as LTO disabled to avoid
missing symbols at link time.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index 59bd7c2f793a..bf72b58de5c8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -27,6 +27,8 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o += -fno-stack-protector
 endif
 
+CFLAGS_string.o += $(DISABLE_LTO_GCC)
+
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 maple_tree.o idr.o extable.o irq_regs.o argv_split.o \
-- 
2.38.1

