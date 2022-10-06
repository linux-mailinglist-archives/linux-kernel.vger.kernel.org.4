Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446AA5F5F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJFDLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJFDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCFC83F37;
        Wed,  5 Oct 2022 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WMlMs/xbXPm9HFkvcomif/uGTZLnPTS3/4GXNuyX6Ss=; b=ADhlNaG6OWZ4HpPcn+axhUY5GI
        GP4NHGPDx0VYW9Vs3WWWNCNzYLs9jzp6n0dyoGGncDhHo5aO8t5Wi+kSluZPYE/yXbJ/mLWNRwSpX
        XZOUL8cjlpmYO3kqkjN74zEdoxoELKs4zd6BcDKX36lsfVmu+A9Ys7u/mTZLjsCR0PhtIAmUzBtac
        qmWgLuMllZiKXUsxgiM9q1kmn+jMbeiTgUVjQvE5//SjIkKj9l6jZfz8zhGadNfoPTz/CPHUgRyTD
        36W8OuqIB9mO0HP8ZoAkExOo6QWa85E/rY+74XrJ8rdT+3YRGxaO5bsKPdTJml9rXpQBzvM8ktCJh
        gh235odQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogHID-000pYD-Ez; Thu, 06 Oct 2022 03:11:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] of: fdt: add stub for early_init_dt_scan()
Date:   Wed,  5 Oct 2022 20:11:16 -0700
Message-Id: <20221006031116.13586-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
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

When CONFIG_OF_EARLY_FLATTREE and CONFIG_SH_DEVICE_TREE are not set,
SH3 build fails with a call to early_init_dt_scan(), so add a stub for
this function.

../arch/sh/kernel/setup.c: In function 'sh_fdt_init':
../arch/sh/kernel/setup.c:262:26: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
  262 |         if (!dt_virt || !early_init_dt_scan(dt_virt)) {

Fixes: 7480e0aabd5f ("sh: add device tree support and generic board using device tree")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/of_fdt.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -85,6 +85,7 @@ extern void early_init_devtree(void *);
 extern void early_get_first_memblock_info(void *, phys_addr_t *);
 #else /* CONFIG_OF_EARLY_FLATTREE */
 static inline void early_init_dt_check_for_usable_mem_range(void) {}
+static inline bool early_init_dt_scan(void *params) { return false; }
 static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
 static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline void early_init_fdt_reserve_self(void) {}
