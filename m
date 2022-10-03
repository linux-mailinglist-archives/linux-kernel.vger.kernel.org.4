Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157895F3296
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJCPfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJCPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A4E020
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arpFl93eCu4VRK8HZxr5R+cc0l1GALQ+UU+vo8Q36Tc=;
        b=JcX+OBnfktZj5QZHobNgxeMVyWlRMNgBGSaAw//uRHf82s/eaAXlPvWt+r9wKmHzfHBdLM
        vEseG8XLSu6/kb1Oj3gESVPKzTeIK5ArWq8CD+kbcTS47ta3itK0jZOdfVZJuC0fCqfnKi
        vt56pYHfhqnA+D0nQdKocYKtGjK3u2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-z6gv90XhMuCbqh7QkZG01A-1; Mon, 03 Oct 2022 11:34:46 -0400
X-MC-Unique: z6gv90XhMuCbqh7QkZG01A-1
Received: by mail-wr1-f70.google.com with SMTP id p7-20020adfba87000000b0022cc6f805b1so3150407wrg.21
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=arpFl93eCu4VRK8HZxr5R+cc0l1GALQ+UU+vo8Q36Tc=;
        b=27fhtwSkZA2YwSKb2AQwI7+J+dBTuAYKrxt6f9st6m4c9V56a6LOUPjejxadnyM5ga
         fCVCm++qZ8dUPUAlEune1EpnIB3ZqnUleQZoxFufY4QflvaC8XuEzhpxNeyIPkfIhvAr
         raj0QkheS7bDS1Eg9Q8ZMbT5DXl+zNjM64u2trRKMcXX2LfB/Y4MA1J/nhZB/uNKy0xg
         +aTo3vP6tulqVGWaRYBIoMjSRjsRNtOaENgAZQyTPulTvsK+O58K1gUu5r6BVDmeT0L6
         973U8gbzBNrcolEqV+6sJ69elkOJ+HlBIM/e1+yl7fWrdK2RVE5jark84mg9AIwo0c88
         k5Ag==
X-Gm-Message-State: ACrzQf0vejVpQBOvWsjm/vedUtra/DCVqV/7stBvEGfdZdl3KJrh8sWj
        QimCueVATOGPEbmSHcH2Uis0+OTXG5xyyQXD5FgoS1JF9RcnJdrrZ+xF/kLXCOzl4YxnhEeWBKw
        821H0PXfMMA1ONvJWTO1W0wVR
X-Received: by 2002:a05:600c:4fd1:b0:3b4:c00d:230a with SMTP id o17-20020a05600c4fd100b003b4c00d230amr7086582wmq.62.1664811285123;
        Mon, 03 Oct 2022 08:34:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5HFAm+wSvaJDfxQ4UcUyn6T4neRKzOgQk7Nth3fuyLRYFQZj5JvPP9+Ll3a76uaMR7QmiqBA==
X-Received: by 2002:a05:600c:4fd1:b0:3b4:c00d:230a with SMTP id o17-20020a05600c4fd100b003b4c00d230amr7086570wmq.62.1664811284906;
        Mon, 03 Oct 2022 08:34:44 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:43 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH bitmap-for-next 2/5] lib/find_bit: Introduce find_next_andnot_bit()
Date:   Mon,  3 Oct 2022 16:34:17 +0100
Message-Id: <20221003153420.285896-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
References: <20221003153420.285896-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of introducing for_each_cpu_andnot(), add a variant of
find_next_bit() that negate the bits in @addr2 when ANDing them with the
bits in @addr1.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/find.h | 33 +++++++++++++++++++++++++++++++++
 lib/find_bit.c       |  9 +++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index 0cdfab9734a6..2235af19e7e1 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -12,6 +12,8 @@ unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
 				unsigned long start);
 unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
+unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start);
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
@@ -91,6 +93,37 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_next_andnot_bit
+/**
+ * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
+ *                        in *addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_next_andnot_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_andnot_bit(addr1, addr2, size, offset);
+}
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 25609974cbe4..18bc0a7ac8ee 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -164,6 +164,15 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
 EXPORT_SYMBOL(_find_next_and_bit);
 #endif
 
+#ifndef find_next_andnot_bit
+unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_andnot_bit);
+#endif
+
 #ifndef find_next_zero_bit
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start)
-- 
2.31.1

