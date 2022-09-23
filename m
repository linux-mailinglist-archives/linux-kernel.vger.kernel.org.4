Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA35E7BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiIWN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiIWN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C995145C93
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663939559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3v7UUwoj2z6XyTFhjMkkxJBC5oQ9g5/RV9r887kLcjk=;
        b=b24WeaM3ICEOnA1HrruF+86WBoFkjMap94Fd8LByeWa8lvQ9W/bLIK87M2jeHsikZUSS5S
        WPPbQEouIH9tAOC4sG7qeRolDccbtx+hJHkrKfyb3ZLnHxjOyvZn4/DCzDXOfYm8fMoyqx
        jGXw8br/GlhET/DDv5rGg6ZqpgkUE7A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-kztvOpkUMQ6aXZ1bYW_3_Q-1; Fri, 23 Sep 2022 09:25:57 -0400
X-MC-Unique: kztvOpkUMQ6aXZ1bYW_3_Q-1
Received: by mail-wm1-f71.google.com with SMTP id l15-20020a05600c4f0f00b003b4bec80edbso123633wmq.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3v7UUwoj2z6XyTFhjMkkxJBC5oQ9g5/RV9r887kLcjk=;
        b=r2BHAoBxCII2Q3giE7vLm7XV2GKosDkZq7n3s7Dil4zd8rf8L3dImX4tFbCA9CfBNL
         pZ7W3zwRQFJaMeAXbTI/Agcfar422/Cyu5l9em6apjwCUqIxWHymKbNSFD2a/Md7gBK5
         F9wZAAyvzRPaHLhFBFHB++sGLEQdjxKHIvJAhQJv9F0c1ac0DjB4chcSHHXyyG0LW0Fu
         e480O9XGwUZbFT0rpzyty/UlhKGh4Aj1lQ2zj4RViKmfUxNGWvnDTewHu/6hV8e8qspB
         MBB6KKD24EtaZqGUd75gOoImqyfR2wjaDNKXt8SdhiwPXKyCgQq+REEmnsrALqd1T7eD
         HkZg==
X-Gm-Message-State: ACrzQf2+Skik4z/CLX9a4XFXr5uv8d0lrqjNoljAmexDXgWpBQ7irP94
        6lnmKKVFAJaVAdsdpkrYb7S7ECLOKMauE9y3KILDz+lS6HekhfplY5Zgo9kKv9CeozyqEi0RIxh
        59GlviqeDO57DpFlcKy+zlvtW
X-Received: by 2002:a7b:ca46:0:b0:3b4:7ff1:4fcc with SMTP id m6-20020a7bca46000000b003b47ff14fccmr13250199wml.47.1663939551504;
        Fri, 23 Sep 2022 06:25:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7G6JjOLCwT6f+/rhD9fsfQaNjJBH3cpQyFzkJ5Y39WRlDbzFautTo6dP0A7bA2xxxc1pNi1Q==
X-Received: by 2002:a7b:ca46:0:b0:3b4:7ff1:4fcc with SMTP id m6-20020a7bca46000000b003b47ff14fccmr13250179wml.47.1663939551281;
        Fri, 23 Sep 2022 06:25:51 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0022add5a6fb1sm7067306wru.30.2022.09.23.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:25:50 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v4 1/7] lib/find_bit: Introduce find_next_andnot_bit()
Date:   Fri, 23 Sep 2022 14:25:21 +0100
Message-Id: <20220923132527.1001870-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220923132527.1001870-1-vschneid@redhat.com>
References: <20220923132527.1001870-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index dead6f53a97b..e60b1ce89b29 100644
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
@@ -86,6 +88,37 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
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
index d00ee23ab657..53b02405421b 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -120,6 +120,15 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
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

