Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0067CE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjAZOd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjAZOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:33:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2659B4F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:33:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h12so1948821wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OU0yK45p3mXhnfdYpz2kyhhGW9zSC0f2qZ+tl7+B4NA=;
        b=K8lyNBOHqkrf2vgJW88yrJL4+R1oQty4S4zyqscLcPy+iA9vGJ23fLFevpsIMeJch+
         gV37VHJqf4IW+K+jgSndXZLkBdnF5o4I+iDwG3tXMCGnMTpKmDurLvsbeTU/JUhwyVnp
         aJFqAsdhmgFS2pxTxya7/wBEkmHqYEVuaSbLDIzGsq2p+p93GPvQB87G4dnMSdh9gnTl
         DbiQF8ZuJK3K5LyYw0x7D4kSznOw8v8/Y16POmb2e6aP3l+2KNI5ZWutUbth2YWteDPV
         90sO0xxk1XVrX0yMtLjoN/WX6iInxd2FoMrc4dqRfTLrDN9rCinOPMoF5gfzCjBNldyI
         FPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU0yK45p3mXhnfdYpz2kyhhGW9zSC0f2qZ+tl7+B4NA=;
        b=QpoXtszq6nd8j2HkNsT8FFMVml/ay3PTQg8eHyPmxRmCOCCxA43D9UgGbWo5AihmeU
         ioCeiIGs1522hmCKW/sWeCzp3nY/W8xiWTjcaB6ePe4x5PybreG4TE9lIwOLiOI6Svuj
         nmHKR4OeuUrMqSGFmBF0hioji7pWOOcTTnWJ4GqWofv5tBLyi8PxVjHq9KlbOMw804bl
         UeDyRmSPx4kj/UqgeL8F6HaJxROtyw/ytInwr8FMibJtZldJ5keargHhpr4SSIYee59w
         0J7ys6gILxHbf6XBwJdWH/GSI/K/K3krbTd7c3XDW0q0h2lvkLB8Jgtvxdu0wYADoCmX
         6uUg==
X-Gm-Message-State: AO0yUKVeZD9wjBnl8N57lTo9PTetRMt176WiFMRpzlweAO/L8mRb9F57
        AguFn+GuOuwmt5CB0xFjhVw=
X-Google-Smtp-Source: AK7set9NjHQcnEL9ua4giABwR5bEHZl1aD/xwybU5Nl6QekCPubmYZmj0TbnlhTgoZjaRPbAocOgwA==
X-Received: by 2002:adf:cf08:0:b0:2bf:bbd1:1db3 with SMTP id o8-20020adfcf08000000b002bfbbd11db3mr5498905wrj.44.1674743631087;
        Thu, 26 Jan 2023 06:33:51 -0800 (PST)
Received: from localhost.localdomain (host-79-44-17-213.retail.telecomitalia.it. [79.44.17.213])
        by smtp.gmail.com with ESMTPSA id a5-20020adfeec5000000b002bfae6b17d2sm1469495wrp.55.2023.01.26.06.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:33:50 -0800 (PST)
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
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>
Subject: [PATCH] mm/highmem: Align-down to page the address for kunmap_flush_on_unmap()
Date:   Thu, 26 Jan 2023 15:33:46 +0100
Message-Id: <20230126143346.12086-1-fmdefrancesco@gmail.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
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

