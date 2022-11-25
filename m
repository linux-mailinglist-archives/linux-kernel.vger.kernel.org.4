Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE69163871F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiKYKMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKYKMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:12:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D802663D8;
        Fri, 25 Nov 2022 02:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669371152; x=1700907152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o//XUtOlF+UX8a4XRDWL4tEuWkSd7eyjbaM1wz1SITA=;
  b=YTPHWM4AEbaGftks/hydfoSgel3uCKeZrzOlEwyyVbBmgyWdTMx+ayRW
   3U/YaU8kv/sVu+OIU+BqIMwzIpeXLZXxnqEJ9i/x1vbELEEvXi/Sm8zRZ
   rJsgIfmEG6VXN7z2bAyc1Wm5SUKwV4Wbe/zUnPBlfOSG0onmRk5bDNx/k
   rCS2lbiX+/ZKZViMcL2mZu1iOP+BlJVe0TNNrtuy19pVnUkgBPgy17sNe
   JCXmI+IakXcRpjnY6tQsKmyniV90Q8jM19DSyYfRZ4wmcoAvBwHEXtn0S
   xdfIIcrqWAkf0Y0d8kpegFNUOSIzlZsBIuKUg1lXx/ZMOx8+0Syy/XwRS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="314489050"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="314489050"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 02:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="767329452"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="767329452"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2022 02:12:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C9DF12B; Fri, 25 Nov 2022 12:12:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] modpost: Mark uuid_le type to be suitable only for MEI
Date:   Fri, 25 Nov 2022 12:12:49 +0200
Message-Id: <20221125101249.24931-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uuid_le type is used only in MEI ABI, do not advertise it for others.
While at it, comment out that UUID types are not to be used in a new code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

If you confused by acrn user of the uuid_le type, the patch to fix that
is pending for v6.2 as well 1dbb4f0235a4 ("virt: acrn: Mark the uuid
field as unused"). Nevertheless this patch doesn't break the things and
hence can go independently to the respective tree.

 scripts/mod/file2alias.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7df23905fdf1..91c2e7ba5e52 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -34,19 +34,23 @@ typedef Elf64_Addr	kernel_ulong_t;
 typedef uint32_t	__u32;
 typedef uint16_t	__u16;
 typedef unsigned char	__u8;
+
+/* UUID types for backward compatibility, don't use in new code */
 typedef struct {
 	__u8 b[16];
 } guid_t;
 
-/* backwards compatibility, don't use in new code */
-typedef struct {
-	__u8 b[16];
-} uuid_le;
 typedef struct {
 	__u8 b[16];
 } uuid_t;
+
 #define	UUID_STRING_LEN		36
 
+/* MEI UUID type, don't use anywhere else */
+typedef struct {
+	__u8 b[16];
+} uuid_le;
+
 /* Big exception to the "don't include kernel headers into userspace, which
  * even potentially has different endianness and word sizes, since
  * we handle those differences explicitly below */
-- 
2.35.1

