Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281CD5F3299
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJCPfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJCPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910BBC35
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojCbGuFmiyLgdgSBf4HLyZfSJMuzgvdBj8Ilq3qJPwM=;
        b=HfA7hYfnFFIB3OUM6kLv0B7gibd2sEURwo6klT73ljS4AHRwc083BnfwwRsWVJg5SJNJ0G
        it/O9vojV2HpukBfZhS4FbHe4ZEKIliU8HDhRwNb9WxdBInmqZ7Z8n2CbnDOCz7J5qTgPo
        adi1XL8KsVJuG1LnHqyTBmgmICxh6uo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-L7Xe-_VwOUipKcBL-JFn-g-1; Mon, 03 Oct 2022 11:34:49 -0400
X-MC-Unique: L7Xe-_VwOUipKcBL-JFn-g-1
Received: by mail-wr1-f72.google.com with SMTP id k30-20020adfb35e000000b0022e04708c18so1873467wrd.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ojCbGuFmiyLgdgSBf4HLyZfSJMuzgvdBj8Ilq3qJPwM=;
        b=1+o+NmhYHBFWENx+Z0PMR6hBGdNIuorfSaTpk3hoe4lk3Bg36wJrBzqVFUulQPjq4t
         HYNOIZTM5Q5JrYbfoZHKLa60od/ZKU6iw1zWyWzDXL2JQ9nCa8K9r0AG1uoYVM+YWF28
         xVmTnGB716nXZ6HH73Vll/I2VM+i0L/vyz3P4CTJA+R/XZCAGSCiP9X5D644DwWDFHoM
         VaQ1B99uA50ttt6h4yDww/HEogwiIWb6Qw2JIONL1bTI8hDMx7wqt2w5DWkjnLICb7nz
         Vq+ofuhG49CTpfBa5sgUAAOZS5c66iuhzx7ZG3Kq+38Otf4JriVJ0iSMvag8a/qE4y/5
         h2bw==
X-Gm-Message-State: ACrzQf3qVMVtSseEVwU+hpIIAGrT7s9rfFvqUfZB2jJEQ5ZgVf3I4JrB
        MZnxaS5cqdDo9BGUsbe4rERVjgKfBo0sQXnqHB2pE9zdVoIFjkkbhttCXG1UjXV+BVBTdBc9oUE
        akLfF1C0LZnlpP3K57MVMOXFf
X-Received: by 2002:a05:600c:3d0c:b0:3b4:c481:c63b with SMTP id bh12-20020a05600c3d0c00b003b4c481c63bmr6941544wmb.147.1664811286767;
        Mon, 03 Oct 2022 08:34:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4DC0p2uhrZdvpPbhbvwisJCgZSihR5TsChXOyUBUKDJL+xI/cPY6MLHDizyk+JnQ7+AazWyw==
X-Received: by 2002:a05:600c:3d0c:b0:3b4:c481:c63b with SMTP id bh12-20020a05600c3d0c00b003b4c481c63bmr6941528wmb.147.1664811286530;
        Mon, 03 Oct 2022 08:34:46 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:45 -0700 (PDT)
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
Subject: [PATCH bitmap-for-next 3/5] cpumask: Introduce for_each_cpu_andnot()
Date:   Mon,  3 Oct 2022 16:34:18 +0100
Message-Id: <20221003153420.285896-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
References: <20221003153420.285896-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_cpu_and() is very convenient as it saves having to allocate a
temporary cpumask to store the result of cpumask_and(). The same issue
applies to cpumask_andnot() which doesn't actually need temporary storage
for iteration purposes.

Following what has been done for for_each_cpu_and(), introduce
for_each_cpu_andnot().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/cpumask.h | 18 ++++++++++++++++++
 include/linux/find.h    |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 286804bfe3b7..2f065ad97541 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -306,6 +306,24 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
 #define for_each_cpu_and(cpu, mask1, mask2)				\
 	for_each_and_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), nr_cpumask_bits)
 
+/**
+ * for_each_cpu_andnot - iterate over every cpu present in one mask, excluding
+ *			 those present in another.
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ *
+ * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *	struct cpumask tmp;
+ *	cpumask_andnot(&tmp, &mask1, &mask2);
+ *	for_each_cpu(cpu, &tmp)
+ *		...
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_andnot(cpu, mask1, mask2)				\
+	for_each_andnot_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), nr_cpumask_bits)
+
 /**
  * cpumask_any_but - return a "random" in a cpumask, but not this one.
  * @mask: the cpumask to search
diff --git a/include/linux/find.h b/include/linux/find.h
index 2235af19e7e1..ccaf61a0f5fd 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -498,6 +498,11 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_and_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
 	     (bit)++)
 
+#define for_each_andnot_bit(bit, addr1, addr2, size) \
+	for ((bit) = 0;									\
+	     (bit) = find_next_andnot_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
+	     (bit)++)
+
 /* same as for_each_set_bit() but use bit as value to start with */
 #define for_each_set_bit_from(bit, addr, size) \
 	for (; (bit) = find_next_bit((addr), (size), (bit)), (bit) < (size); (bit)++)
-- 
2.31.1

