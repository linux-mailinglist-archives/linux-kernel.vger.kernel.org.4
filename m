Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22C6DD69B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDKJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDKJ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:28:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A71C4C3;
        Tue, 11 Apr 2023 02:27:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0E0BD75;
        Tue, 11 Apr 2023 02:28:41 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578DC3F73F;
        Tue, 11 Apr 2023 02:27:56 -0700 (PDT)
From:   Kevin Brodsky <kevin.brodsky@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
Subject: [PATCH RESEND] uapi/linux/const.h: Prefer ISO-friendly __typeof__
Date:   Tue, 11 Apr 2023 10:27:47 +0100
Message-Id: <20230411092747.3759032-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typeof is (still) a GNU extension, which means that it cannot be
used when building ISO C (e.g. -std=c99). It should therefore be
avoided in uapi headers in favour of the ISO-friendly __typeof__.

Unfortunately this issue could not be detected by
CONFIG_UAPI_HEADER_TEST=y as the __ALIGN_KERNEL() macro is not
expanded in any uapi header.

Reported-by: Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
Tested-by: Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/uapi/linux/const.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index af2a44c08683..a429381e7ca5 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-- 
2.38.1

