Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE05BBB37
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIRDH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIRDHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:07:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABECC29827
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:24 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w2so14964665qtv.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VgTcXwGZrpzBbQzsthzQYcLd10lXthgvNsdCg7qOn24=;
        b=noMRXT/IG3xK+9Trj/o5NbybSsqx1IUB3gQoufMRjY7nf9bo/prXXJ7e60VGmSa+ON
         HNPufmT1VVr2TRVp0tqUgoxaUATNOrkBp5FK3T/9Tv74S563UNPUokqABra+Jv9+UJTs
         F6OfQV0PY25UA8ATuMPOnskwCdlpukHovIiHGSqIxAAmyNy0lLbU9TJnRJMu5Cv9wAbp
         xbM9+G749ztOL2FUnSmVIRcjFcn1tm3XoOZ3pN6KcC1vNOHsk5TeDICesw/QkELrRSSF
         YXvD9z6gwkERexp/GyhF7j6tNGwbeHCH8NirjSGgErLKWSSH1TLVt7k7ngb+VImgokiA
         AHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VgTcXwGZrpzBbQzsthzQYcLd10lXthgvNsdCg7qOn24=;
        b=bhxhLq52aKC4+2Bqc0d0zn8uNt3udH0WIqIiUb+h7KgHhaBv7aivQvuBTCkGjZ5nFj
         efXSkGLE6Sc5WOi/YnhFCi6iTSE7ZQVv46wxIxSBth/M6WWMt/5JTN8l/C+fpHQc2uYE
         rEMfYJitkNbK+/YA/q4CjqNCzj4hhoqdlSIImDQwj4DfOw/OcnYyt6BIWDtoFHPxpwby
         vrxTJr8nOGm01bZZ5VKH8RbhUwKbR3zg1YXhS8AL6mT56ewE4fhbzvb9Jus9VxIX9Jep
         qRNSK3jtJplPrJLk0NWQMMIO0pXpOkHTr43Gfrg8Aee+/AzsRKnYWi21KQa1qxqm3lxf
         M2kw==
X-Gm-Message-State: ACrzQf3Ac/U7cij3iGcWxIf2fsBi/Km1dL4vgZOgs20DA5FnkXydlzeg
        QY1Hgb9djdc0cvToQx38GjbL+YcxBs4=
X-Google-Smtp-Source: AMsMyM71a5PlRJYT6IDljqkK2nI5OCN0aQ3SXq0eRC6hcPn4eo14erIjg7ktHEsE/mIfEdy8/11SoA==
X-Received: by 2002:ac8:7dc6:0:b0:35c:c9b1:9f98 with SMTP id c6-20020ac87dc6000000b0035cc9b19f98mr10466823qte.170.1663470443652;
        Sat, 17 Sep 2022 20:07:23 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:a495:2224:867e:566a])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a29c300b006bb8b5b79efsm4993612qkp.129.2022.09.17.20.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:07:23 -0700 (PDT)
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
Subject: [PATCH v3 5/6] lib/bitmap: remove bitmap_ord_to_pos
Date:   Sat, 17 Sep 2022 20:07:15 -0700
Message-Id: <20220918030716.1252285-6-yury.norov@gmail.com>
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

Now that we have find_nth_bit(), we can drop bitmap_ord_to_pos().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h   |  1 -
 include/linux/nodemask.h |  3 +--
 lib/bitmap.c             | 36 +++---------------------------------
 3 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index b2aef45af0db..7d6d73b78147 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -225,7 +225,6 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
 #else
 #define bitmap_copy_le bitmap_copy
 #endif
-unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
 int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
 
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 4b71a96190a8..0c45fb066caa 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -508,8 +508,7 @@ static inline int node_random(const nodemask_t *maskp)
 
 	w = nodes_weight(*maskp);
 	if (w)
-		bit = bitmap_ord_to_pos(maskp->bits,
-			get_random_int() % w, MAX_NUMNODES);
+		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
 	return bit;
 #else
 	return 0;
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 3fc2e338ec30..1c81413c51f8 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -968,36 +968,6 @@ static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigne
 	return bitmap_weight(buf, pos);
 }
 
-/**
- * bitmap_ord_to_pos - find position of n-th set bit in bitmap
- *	@buf: pointer to bitmap
- *	@ord: ordinal bit position (n-th set bit, n >= 0)
- *	@nbits: number of valid bit positions in @buf
- *
- * Map the ordinal offset of bit @ord in @buf to its position in @buf.
- * Value of @ord should be in range 0 <= @ord < weight(buf). If @ord
- * >= weight(buf), returns @nbits.
- *
- * If for example, just bits 4 through 7 are set in @buf, then @ord
- * values 0 through 3 will get mapped to 4 through 7, respectively,
- * and all other @ord values returns @nbits.  When @ord value 3
- * gets mapped to (returns) @pos value 7 in this example, that means
- * that the 3rd set bit (starting with 0th) is at position 7 in @buf.
- *
- * The bit positions 0 through @nbits-1 are valid positions in @buf.
- */
-unsigned int bitmap_ord_to_pos(const unsigned long *buf, unsigned int ord, unsigned int nbits)
-{
-	unsigned int pos;
-
-	for (pos = find_first_bit(buf, nbits);
-	     pos < nbits && ord;
-	     pos = find_next_bit(buf, nbits, pos + 1))
-		ord--;
-
-	return pos;
-}
-
 /**
  * bitmap_remap - Apply map defined by a pair of bitmaps to another bitmap
  *	@dst: remapped result
@@ -1047,7 +1017,7 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		if (n < 0 || w == 0)
 			set_bit(oldbit, dst);	/* identity map */
 		else
-			set_bit(bitmap_ord_to_pos(new, n % w, nbits), dst);
+			set_bit(find_nth_bit(new, nbits, n % w), dst);
 	}
 }
 EXPORT_SYMBOL(bitmap_remap);
@@ -1086,7 +1056,7 @@ int bitmap_bitremap(int oldbit, const unsigned long *old,
 	if (n < 0 || w == 0)
 		return oldbit;
 	else
-		return bitmap_ord_to_pos(new, n % w, bits);
+		return find_nth_bit(new, bits, n % w);
 }
 EXPORT_SYMBOL(bitmap_bitremap);
 
@@ -1210,7 +1180,7 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 	 * The following code is a more efficient, but less
 	 * obvious, equivalent to the loop:
 	 *	for (m = 0; m < bitmap_weight(relmap, bits); m++) {
-	 *		n = bitmap_ord_to_pos(orig, m, bits);
+	 *		n = find_nth_bit(orig, bits, m);
 	 *		if (test_bit(m, orig))
 	 *			set_bit(n, dst);
 	 *	}
-- 
2.34.1

