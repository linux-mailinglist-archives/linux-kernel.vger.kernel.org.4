Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2314365BF55
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbjACLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237465AbjACLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:48:30 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9FDFF8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4ONywomPbIGONSoqWDknxv4XAXDI2Go48FFqWCe9iwM=; b=YNkCBpYaqDT/AHeI3M30isEq/v
        RIzqAdqd5VbYV6jn+b1pPUAKPPy+zq9aub9QYWsNBUUmWP6P5d+/yTYkBIzD8pKLuzLxd9NaCy+qD
        T5kO9Kp1bd0s0POYCt0B5aJEwpYYbNFXaS+DX6H0BOeyCTtk/rSYyHTPgKGRJr/B2bPZ6ACwWUZht
        iRa4MrjOfX7Ix75xV6fynFNJY8IUIx5IuOH9FoPggnc81u8eCFwPP+rukNu8HeOhzSRHot7x3SEiu
        Pfb1vsM9Q5VbgVcfSKSROwm38DGscK86PRMzX933s7i6eLD0IUvPWaFLVx8Zl9z2UvXsVAw6G8tfA
        /9LhDvJw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1pCfm9-00ExLv-Vf; Tue, 03 Jan 2023 11:48:14 +0000
From:   Anuradha Weeraman <anuradha@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     anuradha@debian.org
Subject: [PATCH] x86/lib: Fix compiler and kernel-doc warnings
Date:   Tue,  3 Jan 2023 17:17:24 +0530
Message-Id: <20230103114725.108431-1-anuradha@debian.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=anuradha@debian.org; h=from:subject; bh=ZuLyxA0e6cEwqyyfs6INF9RFCwMgITdtSmgyzSCOeHs=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBjtBXMKtcNYaBAtZv+2XZ3POW85tZn1h15LmDOyHoT LFJeMAOJAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCY7QVzAAKCRBjbbWh2Rhg/YI8EA CFL+Kf4SE53UictT3pwc/NABj/YdSHJKff5jnbk0zMN6yr2CHaeGWADq972z2kjlB4li5hkwSHBYgI pgVDJGbzip/jFd3l0ep1gzR/ai3++VZiVzFgAIQ58zabCN6/iJi1KKl++DhxyR1IBxW0MSs7u9dxCA ltd8qsgxiSHsWPcMqjmkJ9HLrsW5MSVg4PXNPDrxQ697J/WpM3Rp5vDtLXoYekFWS9GavdI+aijRy/ 8NXxV6t6SBwJhH7S5GsUtrUEZC0si8z3B9U7pC3S7UU6sto03uOnjQhVnxuKxOTcPFcSv6cgXtHuc1 xv9ZQ6RHNjbnrwsYiPfmxB6uukl9yJWdLplIrySVxa9j7fbdcyEQRiAhVrq0KyATuh5i970/KfoPvi GJFwIeyz9mC2AIWa3sQ3a8J8dBawkJK2sS6k+jPwS31+JLq7HGdU5qs8HTmPxAuufLlgqAOjwjwUO6 3G8rlY8zr5XRU4XRITQSIlRG4JC3keKwCb8Td9zMvShmidijOgDRc/G0eRy8jiCwVN0amuWyK+FkvI bL8drI4aHBLjKqVJoYS/JHwUz31ry/6y+rMYVEiqFOJ/huB5OtBUg7mfdwF5Yjsl/HYKyqPDDUWJNk r6WAmP/skXGUlP65GKj8S3ODxKji5N06lpICR8+1nBhsCFhCfWJTYP/MIIcw==
X-Developer-Key: i=anuradha@debian.org; a=openpgp; fpr=F56B8F14E014CDEF5D047FC1636DB5A1D91860FD
Content-Transfer-Encoding: 8bit
X-Debian-User: anuradha
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 warnings

arch/x86/lib/cmdline.c:
  - Included <asm/cmdline.h> to fix missing-prototypes warnings.
  - Updated comment for __cmdline_find_option_bool to fix a kernel-doc
    warning.

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
---
 arch/x86/lib/cmdline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index b6da09339308..80570eb3c89b 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -7,16 +7,18 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <asm/setup.h>
+#include <asm/cmdline.h>
 
 static inline int myisspace(u8 c)
 {
 	return c <= ' ';	/* Close enough approximation */
 }
 
-/**
+/*
  * Find a boolean option (like quiet,noapic,nosmp....)
  *
  * @cmdline: the cmdline string
+ * @max_cmdline_size: the maximum size of cmdline
  * @option: option string to look for
  *
  * Returns the position of that @option (starts counting with 1)
-- 
2.35.1

