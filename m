Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82045B3CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiIIQIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiIIQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:08:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B10612B351
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:08:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r17so5067852ejy.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7ztAGZwk+GqzVB5drcA+V15T7sCoLsRHXepNBFzpmoI=;
        b=NGTU2pOzvBxvSHLsQo8sgvurTHD4QN1coHLO6uRY2FzvCw7eHHT50P73TF3JBgoWma
         yDIY4hzSRq8CkfbUKiiqnt2ZpqIPBjseX+f/t7s3mJ0wWfwE6LMcrH5DbTl01hXZLc1J
         e9KXK3dXX6JR5NormKW8XQG2jrQRyViMsbQ3D0cqd/6w/DBsq0bEyGg1MAB9nItX/bjc
         0l3SvrosxnggALHjPVylWHoSqRKE1lUaxRuycs+i41QiEismhk4+Jeqh3Pa0W3zNYH7h
         530oRK2GkNA6cZLrzSC3Ez0SLvuTcOfhRdZrxUDF9iMwCTEv1rYS84ALAVN7OEhrdTUb
         509w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7ztAGZwk+GqzVB5drcA+V15T7sCoLsRHXepNBFzpmoI=;
        b=72KWxdIeX/MHdol86tqmjTC9kTQ4JwAsR5uIOkV+UTl1mO/Bah49o1sMkDVv7Aofim
         sMyu5Fr8IyR7ITf2rsgY2BOW59ESDAFCLqRIV0ViS5Z8Nl4UrB+xMn/rFeZbybMlWRLY
         nCofnT5XJwSDC97NQqu3nfPkmBaRP1Gu6jJBJpo6zCMEX7APdWyG2wfgEFV5NdSFM7pt
         Y+OZgyfz6bLjt4Ics6Bv2ktjyeoJhWTOPEqXP7cfk7XHRQm7YP/RIpfanYuXe89pJP4W
         iMx3Klbbk1hpUhxUVLqSNftpY3u2/YpUvPhBkt3SMTR79R5gAEXEUMIV8T5N2g69uG/Z
         lmrw==
X-Gm-Message-State: ACgBeo0eJiGWvjlPnZm4MIXDpEsmgickReZxoqjf/A/MEgEJmfyyUTHq
        iw1KeqUigws3QM1e5XUyyFg=
X-Google-Smtp-Source: AA6agR5lnR6vr9t+r5aa8yeLJXDynVGNmInF6M+/FSyBwFmy9GpNrJZfUfvlv5B6ezTHEPyBYiPaNg==
X-Received: by 2002:a17:907:6d0f:b0:773:353e:6502 with SMTP id sa15-20020a1709076d0f00b00773353e6502mr7499035ejc.615.1662739723635;
        Fri, 09 Sep 2022 09:08:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g2-20020a50ec02000000b0043bea0a48d0sm599333edr.22.2022.09.09.09.08.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Sep 2022 09:08:41 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] tools: Split <linux/gfp_types.h> out of <linux/gfp.h>
Date:   Fri,  9 Sep 2022 16:08:01 +0000
Message-Id: <20220909160801.11070-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9f162193d6e4 ("radix-tree: replace gfp.h inclusion with
gfp_types.h") change the include file, which is introduced in
commit cb5a065b4ea9c ("headers/deps: mm: Split <linux/gfp_types.h> out
of <linux/gfp.h>"). Since we don't do the split for test, current build
for radix-tree would fail.

Let's do the same as in commit cb5a065b4ea9c ("headers/deps: mm:
Split <linux/gfp_types.h> out of <linux/gfp.h>").

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Yury Norov <yury.norov@gmail.com>
CC: Mike Rapoport <rppt@kernel.org>
CC: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/include/linux/gfp.h       | 21 +--------------------
 tools/include/linux/gfp_types.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 20 deletions(-)
 create mode 100644 tools/include/linux/gfp_types.h

diff --git a/tools/include/linux/gfp.h b/tools/include/linux/gfp.h
index b238dbc9eb85..6a10ff5f5be9 100644
--- a/tools/include/linux/gfp.h
+++ b/tools/include/linux/gfp.h
@@ -3,26 +3,7 @@
 #define _TOOLS_INCLUDE_LINUX_GFP_H
 
 #include <linux/types.h>
-
-#define __GFP_BITS_SHIFT 26
-#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
-
-#define __GFP_HIGH		0x20u
-#define __GFP_IO		0x40u
-#define __GFP_FS		0x80u
-#define __GFP_NOWARN		0x200u
-#define __GFP_ZERO		0x8000u
-#define __GFP_ATOMIC		0x80000u
-#define __GFP_ACCOUNT		0x100000u
-#define __GFP_DIRECT_RECLAIM	0x400000u
-#define __GFP_KSWAPD_RECLAIM	0x2000000u
-
-#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
-
-#define GFP_ZONEMASK	0x0fu
-#define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
-#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
-#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
+#include <linux/gfp_types.h>
 
 static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 {
diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
new file mode 100644
index 000000000000..cfeea788f273
--- /dev/null
+++ b/tools/include/linux/gfp_types.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_INCLUDE_LINUX_GFP_TYPES_H
+#define _TOOLS_INCLUDE_LINUX_GFP_TYPES_H
+
+#include <linux/types.h>
+
+#define __GFP_BITS_SHIFT 26
+#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
+
+#define __GFP_HIGH		0x20u
+#define __GFP_IO		0x40u
+#define __GFP_FS		0x80u
+#define __GFP_NOWARN		0x200u
+#define __GFP_ZERO		0x8000u
+#define __GFP_ATOMIC		0x80000u
+#define __GFP_ACCOUNT		0x100000u
+#define __GFP_DIRECT_RECLAIM	0x400000u
+#define __GFP_KSWAPD_RECLAIM	0x2000000u
+
+#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
+
+#define GFP_ZONEMASK	0x0fu
+#define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
+#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
+#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
+
+#endif /* _TOOLS_INCLUDE_LINUX_GFP_TYPES_H */
-- 
2.33.1

