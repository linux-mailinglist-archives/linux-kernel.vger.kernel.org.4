Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0666B6333F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiKVDab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVDa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:30:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A325E94
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:30:28 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b62so13007420pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5oDlArRtMmw99urVyDNSpVN62izNr9i9C2sCE4fBF0=;
        b=GK+ZdDEb16GYXHPP2FnOoiF0rXW/dmeHHI2xYmmoVPSDbAzwQbGcWqsm3zmo9XpPke
         1BZZN8h3+7ZjDJ+NgpejGPT4UdN5rw4Uxrh9zncpYu49mrJPUI6M6SjnVsKToYv5rV89
         XcmIg92sRueqeLyGVvUZUBHPHh9jRuGXMOm9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5oDlArRtMmw99urVyDNSpVN62izNr9i9C2sCE4fBF0=;
        b=3M/r9MDFUGmsvPTpAoVc4wKxAGP09+KeY7xxY0yB6tVXTI5wQwrT6tortr4BDLoRJ6
         xpnprWX3fmwsVxt5F1p+/t/TsvBMTvDmpyfg/+kXH1EAkIKD0gDRGzcFhJolQmoePpmu
         GpyvgKjJ7k7HQUzYBmrQDC1FNetVfisFK0ea9FEyIgAMa2s/wq1ihd3AycMpX8Oaey4f
         DhEINuwiNpXaL2tvM3m4lJXTk04dBAFO2dh9Oopwo9xge+tV33Uq+CGjhgZ0FUJDJkgN
         LXbcK44eMBVvRzDT5fIicCfSOuHqslHGfyN+m5Yt2yBn7hdhuimx4JUZ1zZhJaFNQ6te
         q0/Q==
X-Gm-Message-State: ANoB5plWFs8FByvxcTyZIYK9KS4umEcLVV8ywhDE8BLT7RPf9SBLVJGc
        1PsL/mQBUHg/0R518b+90x+MuQ==
X-Google-Smtp-Source: AA0mqf4VZRRZaWCn9No0pC1Jg+R9MBk28gho9viR3o3LSoSprNWTLt4wSzhaPrqz2vt0oShWyP/Y1A==
X-Received: by 2002:a05:6a00:439a:b0:56b:c95f:34dd with SMTP id bt26-20020a056a00439a00b0056bc95f34ddmr2006400pfb.74.1669087827579;
        Mon, 21 Nov 2022 19:30:27 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78f30000000b0057280487af3sm9279703pfr.203.2022.11.21.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:30:27 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:30:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not allocate from atomic pool
Message-ID: <Y3xCTr6ikbtcUr/y@google.com>
References: <20221122013338.3696079-1-senozhatsky@chromium.org>
 <Y3w/DFTAypX7L2mp@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3w/DFTAypX7L2mp@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/21 22:16), Johannes Weiner wrote:
> On Tue, Nov 22, 2022 at 10:33:38AM +0900, Sergey Senozhatsky wrote:
> > zswap_frontswap_load() should be called from preemptible
> > context (we even call mutex_lock() there) and it does not
> > look like we need to do GFP_ATOMIC allocaion for temp
> > buffer there. Use GFP_KERNEL instead.
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  mm/zswap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 2d69c1d678fe..f6c89049cf70 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1314,7 +1314,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
> >  	}
> >  
> >  	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> > -		tmp = kmalloc(entry->length, GFP_ATOMIC);
> > +		tmp = kmalloc(entry->length, GFP_KERNEL);
> 
> There is another one in zswap_writeback_entry() that seems equally
> arbitrary. They came in through the same commit, with no further
> explanation as to this choice. Do you want to pick that up too?

Yup, you patch it in https://lore.kernel.org/lkml/20221119001536.2086599-2-nphamcs@gmail.com/
and I guess it's there just by accident. We probably want a separate
patch instead that touches those GFP_ATOMIC allocations in both places.

So I have it like this at present

---

From 66e4acffc0926498f818d11f2f57b9c772131f6e Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Tue, 22 Nov 2022 10:26:13 +0900
Subject: [PATCH] zswap: do not allocate from atomic pool

zswap_frontswap_load() should be called from preemptible
context (we even call mutex_lock() there) and it does not
look like we need to do GFP_ATOMIC allocaion for temp
buffer. The same applies to zswap_writeback_entry().

Use GFP_KERNEL for temporary buffer allocation in both
cases.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zpool.c | 7 +++++++
 mm/zswap.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/zpool.c b/mm/zpool.c
index 68facc193496..f46c0d5e766c 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -387,6 +387,13 @@ bool zpool_evictable(struct zpool *zpool)
  * zpool_can_sleep_mapped - Test if zpool can sleep when do mapped.
  * @zpool:	The zpool to test
  *
+ * Some allocators enter non-preemptible context in ->map() callback (e.g.
+ * disable pagefaults) and exit that context in ->unmap(), which limits what
+ * we can do with the mapped object. For instance, we cannot wait for
+ * asynchronous crypto API to decompress such an object or take mutexes
+ * since those will call into the scheduler. This function tells us whether
+ * we use such an allocator.
+ *
  * Returns: true if zpool can sleep; false otherwise.
  */
 bool zpool_can_sleep_mapped(struct zpool *zpool)
diff --git a/mm/zswap.c b/mm/zswap.c
index 2d48fd59cc7a..3019f0bde194 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -958,7 +958,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	};
 
 	if (!zpool_can_sleep_mapped(pool)) {
-		tmp = kmalloc(PAGE_SIZE, GFP_ATOMIC);
+		tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!tmp)
 			return -ENOMEM;
 	}
@@ -1311,7 +1311,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	}
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
-		tmp = kmalloc(entry->length, GFP_ATOMIC);
+		tmp = kmalloc(entry->length, GFP_KERNEL);
 		if (!tmp) {
 			ret = -ENOMEM;
 			goto freeentry;
-- 
2.38.1.584.g0f3c55d4c2-goog

