Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4D5BBB38
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIRDHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRDHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:07:22 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BA29827
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d15so18430446qka.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hIH+cYLLu5nISquJxX2Y2BfHZrCs6NlFVQp9n+J7Pgc=;
        b=fPKERsemDqrcstzHiRkssOFxyuyOWKPWXycQixi0LQTkrcLpHXWh0n/+WGRK/CLiA3
         /s0MWj48h6ZTtNSH7dU4Kb9hn2xHyM66/KhzqOgMQw9XM4GSYm3Xqv2wovwFdTJZmCj9
         Rkba5PLj+irLjvP+bUWO+787NSKs9jxHmYdmEbePdg+zR7yfkO8vSxIEHyb1bTg6xc0A
         TVRhV9ERIBm4Aeadfuhcpaji5OYWOe1R7eynSDg1bQ93hrQm74JZ0hvMgKzg0IawR+dC
         AjnfjzE8Y3/WdUJ2tIRSFIH+wGt1uwwliOCg1E2ihwBhJ99aYaBFcvaQSWvhVuh9bxmw
         eF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hIH+cYLLu5nISquJxX2Y2BfHZrCs6NlFVQp9n+J7Pgc=;
        b=vmM086yK6XpEGJqzEC7v41wHBLHMUqJ6APLTujf6ZoXKn0hpRHGy4TrnnoliMfoO31
         TCW6pwCjQNhESgi7KVhV04DzywPY8xiDLX8HTs8GaZeeoDik8qMAFp0b+4xbbqiBc0fy
         BWhULwF1xL9IyMc4Q1epqsLOQy/j/IR37cdcIZJhBUmQVbpH75Y52zZas5JBJYGOYvwV
         wMdtvlN1CpiEDyaOjasoFwGA1u8dP+7UBKF6/pBjz51/9Y6+B7oS4Lv5ydRuiNZhSR05
         SZ4NQi0mXIRC/zbLugBEpGfSihN5gw1KplvIn8bwuhbucjDE8CsvvQXwwm3iK4ISxWR/
         QzKA==
X-Gm-Message-State: ACrzQf2k/P59dujBnlLt7jKQZm07Pe49GLWlw1YrvmiDfwRqvpFFV+jq
        88fwP1SLgLIK4E/opqKSkk/SZEurIeg=
X-Google-Smtp-Source: AMsMyM7EYcJ7TQqwfb69HXS3kYjkopMU3K7dFgaYkrMBgx2XfKEulJbaiBzu3vSxAZopiPdewuwJaw==
X-Received: by 2002:a37:c09:0:b0:6cb:d61d:22b8 with SMTP id 9-20020a370c09000000b006cbd61d22b8mr9115535qkm.130.1663470439786;
        Sat, 17 Sep 2022 20:07:19 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:a495:2224:867e:566a])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a16cc00b006a5d2eb58b2sm8844806qkn.33.2022.09.17.20.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:07:19 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 1/6] lib/bitmap: don't call __bitmap_weight() in kernel code
Date:   Sat, 17 Sep 2022 20:07:11 -0700
Message-Id: <20220918030716.1252285-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220918030716.1252285-1-yury.norov@gmail.com>
References: <20220918030716.1252285-1-yury.norov@gmail.com>
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

__bitmap_weight() is not to be used directly in the kernel code because
it's a helper for bitmap_weight(). Switch everything to bitmap_weight().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 fs/ntfs3/bitmap.c | 4 ++--
 lib/bitmap.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 5d44ceac855b..e92bbd754365 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -560,7 +560,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 
 		buf = (ulong *)bh->b_data;
 
-		used = __bitmap_weight(buf, wbits);
+		used = bitmap_weight(buf, wbits);
 		if (used < wbits) {
 			frb = wbits - used;
 			wnd->free_bits[iw] = frb;
@@ -1364,7 +1364,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		buf = (ulong *)bh->b_data;
 
 		__bitmap_clear(buf, b0, blocksize * 8 - b0);
-		frb = wbits - __bitmap_weight(buf, wbits);
+		frb = wbits - bitmap_weight(buf, wbits);
 		wnd->total_zeroes += frb - wnd->free_bits[iw];
 		wnd->free_bits[iw] = frb;
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 488e6c3e5acc..d56e275db73e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -953,7 +953,7 @@ static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigne
 	if (pos >= nbits || !test_bit(pos, buf))
 		return -1;
 
-	return __bitmap_weight(buf, pos);
+	return bitmap_weight(buf, pos);
 }
 
 /**
-- 
2.34.1

