Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8256574F283
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGKOmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjGKOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:42:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47210BC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57320c10635so63070157b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086560; x=1691678560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dufumGN0X5SXjxYpittS7pKflaiJdPliu9At6Sap++c=;
        b=dLRkccixklYYXR2WU6Ln/pjVdN3Qd9Ec+IRQSqKyylEED1pH7A8wD4Qv2myKG/RfLD
         Jmz7qFSWO5vQZdgvSSTVF0jfpbFG+iIWCuI73GkGjsLdmmFtHeaEXarEarzKRxLo3Bbu
         Oa7iNom8QaPEKsXkrFwKbZwche58tepyDYMn2uuFlCkTDLEMqryEOghFXXF/Xr3QtaQA
         O9v+M21PEGqtdr36HSBveJlshivuqQkleC6reypNk8f7QOeE59/oCbcDig3awR0KcPbJ
         GOVy7GA+6yaCuScu0UfAVfJfq/ycqEaCCA0f2JkINq5xfGn+SvqCQktRwaRosZt61X7s
         6FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086560; x=1691678560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dufumGN0X5SXjxYpittS7pKflaiJdPliu9At6Sap++c=;
        b=jbWyCw0gm32sqLV6q/bag/3DoyNaCVJ+AZYIhuaszxJRoD2vSYV8ZPFQkNSHyF/lI8
         xro4BC/7qmbeEn9zq4fpGbki1QX4qj57HfBkOdoAZmVBaAjnXAPZvKJWGeuGRepo0RZX
         HKZVUHaEFVMQuflCHzeJhZskqVYooBGEe6cPYii/bdZzKyXSHzai7+UBIANfFXJs5/Za
         YgRHAONUplBj1qvz+Bk9hMxkOG9+dnySc2lmsDk8IpmTip2GZqgToLQuZ8z4J6HwhDAC
         D/OkKx5D3mhL3SSSxq48ovqHMrREMmy03hQBdvx0aiYVfS9fESAi94JbVepHWoKLSUj0
         SWgQ==
X-Gm-Message-State: ABy/qLYBzpOS1bHdtInqcmRYFHusUvds/IsIskfA2RFrkhjdZ1ZpVKDP
        nwEP0llwQVQC3TKX8dfr6y9b78APywA=
X-Google-Smtp-Source: APBJJlFIZz3CqK9sHFiNkuXlFYUZxhErF6A+cY/vC/nVCEfDRQwrtiXHgvzlHG6TlEhbEb3LNYtF3wh57Bs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a05:690c:705:b0:565:a42c:79fe with SMTP id
 bs5-20020a05690c070500b00565a42c79femr126547ywb.1.1689086560587; Tue, 11 Jul
 2023 07:42:40 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:42:29 +0200
In-Reply-To: <20230711144233.3129207-1-glider@google.com>
Mime-Version: 1.0
References: <20230711144233.3129207-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711144233.3129207-2-glider@google.com>
Subject: [Resend v1 1/5] linux/bitqueue.h: add the bit queue implementation
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct bitq represents a bit queue with external storage.

Its purpose is to easily pack sub-byte values, which can be used, for
example, to implement RLE algorithms.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 include/linux/bitqueue.h | 144 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 include/linux/bitqueue.h

diff --git a/include/linux/bitqueue.h b/include/linux/bitqueue.h
new file mode 100644
index 0000000000000..c4393f703c697
--- /dev/null
+++ b/include/linux/bitqueue.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple bit queue which supports enqueueing/dequeueing of sub-byte values.
+ *
+ * This can be used to pack complex bitfields into byte arrays.
+ */
+#ifndef _LINUX_BITQUEUE_H
+#define _LINUX_BITQUEUE_H
+
+#include <linux/string.h>
+#include <linux/types.h>
+
+/**
+ * struct bitq - represents a bit queue with external storage.
+ * @data:	data buffer used by the queue.
+ * @size:	size of @data in bytes.
+ * @bit_pos:	current bit position.
+ */
+struct bitq {
+	u8 *data;
+	int size, bit_pos;
+};
+
+/**
+ * bitq_init - initialize an empty bit queue.
+ * @q:		struct bitq to be initialized.
+ * @data:	external data buffer to use.
+ * @size:	capacity in bytes.
+ *
+ * Return:	0 in the case of success, -1 if either of the pointers is NULL.
+ */
+static inline int bitq_init(struct bitq *q, u8 *data, int size)
+{
+	if (!q || !data)
+		return -1;
+	q->data = data;
+	q->size = size;
+	memset(data, 0, size);
+	q->bit_pos = 0;
+	return 0;
+}
+
+/**
+ * bitq_init_full - make a bit queue from an initialized byte array.
+ * @q:		struct bitq to be initialized.
+ * @data:	external data buffer to use.
+ * @size:	capacity in bytes.
+ *
+ * Return:	0 in the case of success, -1 if either of the pointers is NULL.
+ */
+static inline int bitq_init_full(struct bitq *q, u8 *data, int size)
+{
+	if (!q || !data)
+		return -1;
+	q->data = data;
+	q->size = size;
+	q->bit_pos = q->size * 8;
+	return 0;
+}
+
+/**
+ * bitq_enqueue - push up to 8 bits to the end of the queue.
+ * @q:		struct bitq.
+ * @value:	byte containing the value to be pushed.
+ * @bits:	number of bits (1 to 8) to push.
+ *
+ * Return:	number of bits pushed, or -1 in the case of an error.
+ */
+static inline int bitq_enqueue(struct bitq *q, u8 value, int bits)
+{
+	int byte_pos, left_in_byte, max_pos;
+	u8 hi, lo;
+
+	if (!q || (bits < 1) || (bits > 8))
+		return -1;
+
+	max_pos = q->size * 8;
+	if ((max_pos - q->bit_pos) < bits)
+		return -1;
+
+	left_in_byte = 8 - (q->bit_pos % 8);
+	byte_pos = q->bit_pos / 8;
+	/* Clamp @value. */
+	value %= (1 << bits);
+	if (left_in_byte >= bits) {
+		/* @value fits into the current byte. */
+		value <<= (left_in_byte - bits);
+		q->data[byte_pos] |= value;
+	} else {
+		/*
+		 * @value needs to be split between the current and the
+		 * following bytes.
+		 */
+		hi = value >> (bits - left_in_byte);
+		q->data[byte_pos] |= hi;
+		byte_pos++;
+		lo = value << (8 - (bits - left_in_byte));
+		q->data[byte_pos] |= lo;
+	}
+	q->bit_pos += bits;
+	return bits;
+}
+
+/**
+ * bitq_dequeue - pop up to 8 bits from the beginning of the queue.
+ * @q:		struct bitq.
+ * @value:	u8* to store the popped value (can be NULL).
+ * @bits:	number of bits (1 to 8) to pop.
+ *
+ * Return:	number of bits popped, or -1 in the case of an error.
+ */
+
+#include <linux/printk.h>
+static inline int bitq_dequeue(struct bitq *q, u8 *value, int bits)
+{
+	int rem_bits = 8 - bits, i;
+	u8 output;
+
+	/* Invalid arguments. */
+	if (!q || (bits < 1) || (bits > 8))
+		return -1;
+	/* Not enough space to insert @bits. */
+	if (q->bit_pos < bits)
+		return -1;
+	/* Take the first @bits bits from the first byte. */
+	output = q->data[0];
+	output >>= rem_bits;
+	if (value)
+		*value = output;
+
+	/*
+	 * Shift every byte in the queue to the left by @bits, carrying over to
+	 * the previous byte.
+	 */
+	for (i = 0; i < q->size - 1; i++) {
+		q->data[i] = (q->data[i] << bits) |
+			     (q->data[i + 1] >> rem_bits);
+	}
+	q->data[q->size - 1] <<= bits;
+	q->bit_pos -= bits;
+	return bits;
+}
+
+#endif // _LINUX_BITQUEUE_H
-- 
2.41.0.255.g8b1d071c50-goog

