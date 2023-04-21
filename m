Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D95F6EB47E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjDUWNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjDUWN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:13:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB001FF0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso2269470b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682115208; x=1684707208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u93zuMvcW9crJ3xx/ibodoPbhN86+1UwtbTmDpeZKPY=;
        b=AkSpP2B6MEWZUl0frTvsfsvLWFK8V1GAoZ0xgM/K0816fyASmzFYyukMou4sJkPvvQ
         x8m+0LZ0Kley490iLqLstsoKAwAWY4snWPkkl+IHwzXeFi5Wamq/VJvtD6G0iFq0oHV0
         OAD4MLYCsMD/2Dj11rG/SZNFI7U3EbP8CQc1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682115208; x=1684707208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u93zuMvcW9crJ3xx/ibodoPbhN86+1UwtbTmDpeZKPY=;
        b=FRhlM0nVlmuXXyJQGkf1Ih4s90Pp4BtZOU16pR0mFCgX0NfKb2WtjEo2oX/u0w6+CA
         xGfjktjkNRBN1Xnbqzpehv/GrYEpy5d/iwkR82i7bxCMQ18Yv1XgbwXA7+GG8/6aMvKc
         HDYu9O0cvaRW9xL28LuKpg7q9r9fW6xD/Tag5P3rShYQMmcxuVO27SBSbGd1MRRTva0E
         9SM61PhW8GONeAg7E3PwM2wv3mUbXgO8ZrioYnPJU4GHH6a9WXZ5D8AzOhwUAbEk8aH8
         oMATWCSTrCvCU76W3zq8KDayaJzbkm1S3/2yY1PW+rBHHN+9eKOgbTXb1ObJpcBl2aF6
         DdBw==
X-Gm-Message-State: AAQBX9f24o8zIh9Y0sLZvJfyEFPzhvHgfqvbpY0EGAUrHpMAhkbIJ6CA
        K67/mKyq4zA/PC1Qr3zbBa3nNA==
X-Google-Smtp-Source: AKy350YerkDyIlCdlYz+2bbDYDMPvivuf/02m3z67Um6oKR/8X1Rqic07nKJ4+CvFtUj6ZUAdN+jUw==
X-Received: by 2002:a05:6a00:2196:b0:63a:5bcd:e580 with SMTP id h22-20020a056a00219600b0063a5bcde580mr8793160pfi.9.1682115207703;
        Fri, 21 Apr 2023 15:13:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:87cc:9018:e569:4a27])
        by smtp.gmail.com with ESMTPSA id y72-20020a62644b000000b006372791d708sm3424715pfb.104.2023.04.21.15.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:13:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/4] migrate_pages: Don't wait forever locking pages in MIGRATE_SYNC_LIGHT
Date:   Fri, 21 Apr 2023 15:12:47 -0700
Message-ID: <20230421151135.v2.3.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230421221249.1616168-1-dianders@chromium.org>
References: <20230421221249.1616168-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIGRATE_SYNC_LIGHT mode is intended to block for things that will
finish quickly but not for things that will take a long time. Exactly
how long is too long is not well defined, but waits of tens of
milliseconds is likely non-ideal.

Waiting on the folio lock in isolate_movable_page() is something that
usually is pretty quick, but is not officially bounded. Nothing stops
another process from holding a folio lock while doing an expensive
operation. Having an unbounded wait like this is not within the design
goals of MIGRATE_SYNC_LIGHT.

When putting a Chromebook under memory pressure (opening over 90 tabs
on a 4GB machine) it was fairly easy to see delays waiting for the
lock of > 100 ms. While the laptop wasn't amazingly usable in this
state, it was still limping along and this state isn't something
artificial. Sometimes we simply end up with a lot of memory pressure.

Putting the same Chromebook under memory pressure while it was running
Android apps (though not stressing them) showed a much worse result
(NOTE: this was on a older kernel but the codepaths here are
similar). Android apps on ChromeOS currently run from a 128K-block,
zlib-compressed, loopback-mounted squashfs disk. If we get a page
fault from something backed by the squashfs filesystem we could end up
holding a folio lock while reading enough from disk to decompress 128K
(and then decompressing it using the somewhat slow zlib algorithms).
That reading goes through the ext4 subsystem (because it's a loopback
mount) before eventually ending up in the block subsystem. This extra
jaunt adds extra overhead. Without much work I could see cases where
we ended up blocked on a folio lock for over a second. With more
more extreme memory pressure I could see up to 25 seconds.

Let's bound the amount of time we can wait for the folio lock. The
SYNC_LIGHT migration mode can already handle failure for things that
are slow, so adding this timeout in is fairly straightforward.

With this timeout, it can be seen that kcompactd can move on to more
productive tasks if it's taking a long time to acquire a lock.

NOTE: The reason I stated digging into this isn't because some
benchmark had gone awry, but because we've received in-the-field crash
reports where we have a hung task waiting on the page lock (which is
the equivalent code path on old kernels). While the root cause of
those crashes is likely unrelated and won't be fixed by this patch,
analyzing those crash reports did point out this unbounded wait and it
seemed like something good to fix.

ALSO NOTE: the timeout mechanism used here uses "jiffies" and we also
will retry up to 7 times. That doesn't give us much accuracy in
specifying the timeout. On 1000 Hz machines we'll end up timing out in
7-14 ms. On 100 Hz machines we'll end up in 70-140 ms. Given that we
don't have a strong definition of how long "too long" is, this is
probably OK.

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Keep unbounded delay in "SYNC", delay with a timeout in "SYNC_LIGHT"

 mm/migrate.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index db3f154446af..60982df71a93 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -58,6 +58,23 @@
 
 #include "internal.h"
 
+/* Returns the schedule timeout for a non-async mode */
+static long timeout_for_mode(enum migrate_mode mode)
+{
+	/*
+	 * We'll always return 1 jiffy as the timeout. Since all places using
+	 * this timeout are in a retry loop this means that the maximum time
+	 * we might block is actually NR_MAX_MIGRATE_SYNC_RETRY jiffies.
+	 * If a jiffy is 1 ms that's 7 ms, though with the accuracy of the
+	 * timeouts it often ends up more like 14 ms; if a jiffy is 10 ms
+	 * that's 70-140 ms.
+	 */
+	if (mode == MIGRATE_SYNC_LIGHT)
+		return 1;
+
+	return MAX_SCHEDULE_TIMEOUT;
+}
+
 bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct folio *folio = folio_get_nontail_page(page);
@@ -1162,7 +1179,8 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 		if (current->flags & PF_MEMALLOC)
 			goto out;
 
-		folio_lock(src);
+		if (folio_lock_timeout(src, timeout_for_mode(mode)))
+			goto out;
 	}
 	locked = true;
 
-- 
2.40.0.634.g4ca3ef3211-goog

