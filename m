Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5072B67CD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjAZOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjAZOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:12:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38845206AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:11:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m15so1201876wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+b5T9XrtD/RFlpp0uwB7/1Pl9LZdmUTgBTpWnQxQNg0=;
        b=KgkGYKmzHk+umIchVB+AffMuOBKKGy11miVrlbRmgjBYfNUc1d29XbltzlN0TUmmoG
         AOKE3A8VxQeffJ5oKoZ1OSSAz70K7j5AEHM0TjF/s5NOjKf+czL0ikMaOu/4oEQd7wS1
         x3/OT0g7gbMfgnKjL0edCYs00EMHlyGGdd4TsAIFxfyb1O2gKjEUvvn/aBaTaWh+iQ7a
         Bd/bZtN7MzwfJgplXlEAtYHuc6WkrJlRnBW8aF3kqTqNcoauGSxVytMD+NRcoaVfYzkZ
         aAmS3dNgmakfOBGkTV0wWMxPMvZpDbv6S7ZdGpTButK1VL8S58TDTNlYo9cyn0E7IVlE
         FWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b5T9XrtD/RFlpp0uwB7/1Pl9LZdmUTgBTpWnQxQNg0=;
        b=PoWgChsTCWQadogQVVH0VsAI5f9aC/u1z3E3gusrsUm2DnFEY+jhfLZ2iq6+5lP1YN
         zgvrRuJ2yWm1+NUC58aDRzXzdonS1N0BXO0nZVsl+MgnqHSIEb5qHJk5J1FU1jGtEPjl
         yKvoX2VUraxUwz2q5bSPuBG5fKp1Rp6lELkTldrKaMBGm+RUlqCIcHK++ruaTrI7eN6R
         n+QgJMPrGBI2Up0z9+/f3LLf4Y1W4F2LTsP+2p7e1JaUD6PsOJywRhIGlMOgqRtRncGO
         gl+7fQpJP3zgf8glcW/PhrFVfnP26WIfxDM+zhAJLoqF1HIBf+GFM2rrI+BKkChD7Utv
         jD7Q==
X-Gm-Message-State: AFqh2kpVuXqcBhl0xtgdR/WMO/NccUri4cTvLCQufspPIJ/28D5PgDBT
        tzDqeDGBV+j/9HEPBk+wd5s=
X-Google-Smtp-Source: AMrXdXs25gZoS2pK9ThpGF3J8OGsM8W2ixFAUZ2vWOac6jb6rx2vYC15dLav7KyTjl9KgCtCZ4aLeg==
X-Received: by 2002:a05:600c:5390:b0:3d9:a145:4d1a with SMTP id hg16-20020a05600c539000b003d9a1454d1amr32611789wmb.34.1674742309470;
        Thu, 26 Jan 2023 06:11:49 -0800 (PST)
Received: from localhost.localdomain (host-79-44-17-213.retail.telecomitalia.it. [79.44.17.213])
        by smtp.gmail.com with ESMTPSA id e38-20020a05600c4ba600b003db11dfc687sm1532413wmp.36.2023.01.26.06.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:11:48 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>
Subject: [PATCH] mm/highmem: Align-down to page the address for kunmap_flush_on_unmap()
Date:   Thu, 26 Jan 2023 15:11:44 +0100
Message-Id: <20230126141144.11042-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
proposed to call kunmap_flush_on_unmap() on an aligned-down to page
address in order to fix this issue. Consensus has been reached on this
solution.

Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
kunmap_flush_on_unmap() on an aligned-down to page address computed with
the PTR_ALIGN_DOWN() macro.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Confirmed-by: Helge Deller <deller@gmx.de>
Confirmed-by: Matthew Wilcox <willy@infradead.org>
Fixes: f3ba3c710ac5 ("mm/highmem: Provide kmap_local*")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I have (at least) two problems with this patch...

1) checkpatch.pl complains about the use of the non-standard
"Confirmed-by" tags. I don't know how else I can give credit to Helge
and Matthew. However, this is not the first time that I see non-standard
tags in patches applied upstream (I too had a non-standard
"Analysed-by" tag in patch which fixes a SAC bug). Any objections?

2) I'm not sure whether or not the "Fixes" tag is appropriate in this
patch. Can someone either confirm or deny it?

 include/linux/highmem-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 034b1106d022..e247c9ac4583 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -200,7 +200,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
 static inline void __kunmap_local(const void *addr)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-	kunmap_flush_on_unmap(addr);
+	kunmap_flush_on_unmap(PTR_ALIGN_DOWN(addr, PAGE_SIZE));
 #endif
 }
 
-- 
2.39.0

