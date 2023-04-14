Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD79F6E1999
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDNBX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDNBXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:23:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDDD30FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:23:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7455940pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681435426; x=1684027426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySd2AFOBGRafkZnqoRaWZ+CuGXqcsO86v2c2mbNKCt0=;
        b=ih5QBKpfh12zgAWpWZBSYoZ5iClOskNaxjN6FS5ohodztZdxKJmIOjzVQN4ewzvb00
         WqfzUppOQ+yz46+81FK2uJRQKTUVrTx4O0h3u8sb2EnDwb7538qU6Dt7G0PENasO5cD/
         J0zRcM1HQVTloF2a4UTsA7ZP8KMzUvwIM9H9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681435426; x=1684027426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySd2AFOBGRafkZnqoRaWZ+CuGXqcsO86v2c2mbNKCt0=;
        b=PZpGyM+ZR2iw2i08J7iL9a3VTgp6RCobZzlFCf5oviIWgRHIiFTnYmdFSoXjKi7dJo
         BQm+5tD0qh28WqZiCe4LT0nJZmpY6MIqM8+yv7cG0Mw1fIm8HTBpVYde3/5I2C1xUIXR
         phAUJnePFRvAv55vDIZ8po+KA83k/jGn1CHgEfBVkChcE0+eR0KSLUJlqsyx7CexEF/W
         v9BUMsFvPAsyymuxgCN8GCrVq4cBZLg3FRSiO/DK6xGOLk22aU1v5Pr+thrKcH9RAEt1
         4RQUaFniRaIDdpM5RWQRf0qtGelpZ3Sl+M1eeMhwq982dIFic3mKsNHndUjkmTIBtnLw
         rA4w==
X-Gm-Message-State: AAQBX9fPdGRc/3vgDihpdlQQ13dcyTXpfDchRDe1Jnac+iDa23XvawDC
        C/LMsqHjxIbncc0+kSBHH8SYQw==
X-Google-Smtp-Source: AKy350Zm5gG5OUvroOMZO/PsbzsD1hKld53c1Zd20J6JpXSN+Llq7B3hHMCcHJeq+UjGi/MyKpJy2g==
X-Received: by 2002:a17:902:d902:b0:1a6:47aa:dbd7 with SMTP id c2-20020a170902d90200b001a647aadbd7mr934051plz.53.1681435425851;
        Thu, 13 Apr 2023 18:23:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:d555:e8ef:b29c:bd37])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902d21400b001a05122b562sm2022886ply.286.2023.04.13.18.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 18:23:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH] migrate_pages: Never block waiting for the page lock
Date:   Thu, 13 Apr 2023 18:23:15 -0700
Message-ID: <20230413182313.RFC.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when we try to do page migration and we're in "synchronous"
mode (and not doing direct compaction) then we'll wait an infinite
amount of time for a page lock. This does not appear to be a great
idea.

One issue can be seen when I put a device under extreme memory
pressure. I took a sc7180-trogdor Chromebook (4GB RAM, 8GB zram
swap). I ran the browser along with Android (which runs from a
loopback mounted 128K block-size squashfs "disk"). I then manually ran
the mmm_donut memory pressure tool [1]. The system is completely
unusable both with and without this patch since there are 8 processes
completely thrashing memory, but it was still interesting to look at
how migration was behaving. I put some timing code in and I could see
that we sometimes waited over 25 seconds (in the context of
kcompactd0) for a page lock to become available. Although the 25
seconds was the high mark, it was easy to see tens, hundreds, or
thousands of milliseconds spent waiting on the lock.

Instead of waiting, if I bailed out right away (as this patch does), I
could see kcompactd0 move forward to successfully to migrate other
pages instead. This seems like a better use of kcompactd's time.

Thus, even though this didn't make the system any more usable in my
absurd test case, it still seemed to make migration behave better and
that feels like a win. It also makes the code simpler since we have
one fewer special case.

The second issue that this patch attempts to fix is one that I haven't
managed to reproduce yet. We have crash reports from the field that
report that kcompactd0 was blocked for more than ~120 seconds on this
exact lock. These crash reports are on devices running older kernels
(5.10 mostly). In most of these crash reports the device is under
memory pressure and many tasks were blocked in squashfs code, ext4
code, or memory allocation code. While I don't know if unblocking
kcompactd would actually have helped relieve the memory pressure, at
least there was a chance that it could have helped a little bit.

[1] https://chromium.googlesource.com/chromiumos/platform/microbenchmarks/+/refs/heads/main/mmm_donut.py

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 mm/migrate.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index db3f154446af..dfb0a6944181 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1143,26 +1143,15 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
 	dst->private = NULL;
 
 	if (!folio_trylock(src)) {
-		if (mode == MIGRATE_ASYNC)
-			goto out;
-
 		/*
-		 * It's not safe for direct compaction to call lock_page.
-		 * For example, during page readahead pages are added locked
-		 * to the LRU. Later, when the IO completes the pages are
-		 * marked uptodate and unlocked. However, the queueing
-		 * could be merging multiple pages for one bio (e.g.
-		 * mpage_readahead). If an allocation happens for the
-		 * second or third page, the process can end up locking
-		 * the same page twice and deadlocking. Rather than
-		 * trying to be clever about what pages can be locked,
-		 * avoid the use of lock_page for direct compaction
-		 * altogether.
+		 * While there are some modes we could be running in where we
+		 * could block here waiting for the lock (specifically
+		 * modes other than MIGRATE_ASYNC and when we're not in
+		 * direct compaction), it's not worth the wait. Instead of
+		 * waiting, we'll bail. This will let the caller try to
+		 * migrate some other pages that aren't contended.
 		 */
-		if (current->flags & PF_MEMALLOC)
-			goto out;
-
-		folio_lock(src);
+		goto out;
 	}
 	locked = true;
 
-- 
2.40.0.634.g4ca3ef3211-goog

