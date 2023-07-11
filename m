Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74B74F854
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGKTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGKTU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:20:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A210C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:20:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8bd586086so45538755ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689103226; x=1691695226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1RdjQ4NrY+dTIP5U7ks2Bp8VWT43m8mQA91HDnFqNQ=;
        b=dJcHKJ/wkSPqpiz930XCirSfpLMbFYzCQ7DZnephHtgcgDueSJjN0A86ixgq2U0352
         3PXeSyaI/fDYieyLcsRROYYRHbFsf4NoXnKEIKHnZrl0QiqbGnPTmfePHjVlUFnHnkgh
         h5hnJ6h459913WyizTWk+nSfz1gBtp181TKIn3UvHCQjQoj4H5k7OPij+LklYHCClUR2
         vUWAHmOL0D8HWUPLcmv1Wb3u7bmV9vQ8rvRRpYPlS5S1Hb4GPiII6RuPSqqTuTjKAyRu
         Kx9Tl6k2HiDFKjg2aVpSK8JEgLeoGNwtOyAIqYXsVKwph+TFvk5xAaXi+LGRBq1a2zck
         yr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689103226; x=1691695226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1RdjQ4NrY+dTIP5U7ks2Bp8VWT43m8mQA91HDnFqNQ=;
        b=Y/mb6dK/8SxwCeVf19R/NlMcnFFjs7uQFiK51eAlUNKG9xoTMsvgKW06dp3OMCG6vP
         y8pLggSn0kqMDutCh8z2eviOZ2s2lntd5OUx/lf5UhPtABiMM+bq1uES8NmTaF7s19BU
         G1mWfXqVADPQQqTLnMzPQCBmLOUOK1hCWawGIPVR1QJGsJUlXrqQxJR2QNTwgRpEaZQY
         /QjzBQrN/um077dGGxqQFB5p/qKcbaHAPIEBw904qDwWAje67PAv+eEd6DZ61i3nFN5m
         bMB4nc/upB0IwH27hPZFmfnry9WWKIUkyoukp8dO89/xTYFXT2q6G6qzYPi3bcoKG0Rq
         jh2A==
X-Gm-Message-State: ABy/qLanWrvoElbZ4im3+a7Y+gaVfTi59boJQEnyNiMe9d6apSkdNZCR
        8D515DNpkOtpzev6AjnP6Nku+xhfEHEoUg==
X-Google-Smtp-Source: APBJJlETMmHWv5veKD3fT8ZGjLGUpXn9Wi3gEfg00gV5lXwzh5xAyLs9MkviCWty+0DVsEYqH1bNFQ==
X-Received: by 2002:a17:903:1c5:b0:1ac:451d:34a with SMTP id e5-20020a17090301c500b001ac451d034amr19111806plh.33.1689103226404;
        Tue, 11 Jul 2023 12:20:26 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090aae0800b00263f40cf83esm8461495pjq.47.2023.07.11.12.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:20:25 -0700 (PDT)
Date:   Tue, 11 Jul 2023 12:20:24 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [Resend v1 1/5] linux/bitqueue.h: add the bit queue
 implementation
Message-ID: <ZK2raeRzTLjyiMLI@yury-ThinkPad>
References: <20230711144233.3129207-1-glider@google.com>
 <20230711144233.3129207-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711144233.3129207-2-glider@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Andy and Rasmus

On Tue, Jul 11, 2023 at 04:42:29PM +0200, Alexander Potapenko wrote:
> struct bitq represents a bit queue with external storage.
> 
> Its purpose is to easily pack sub-byte values, which can be used, for
> example, to implement RLE algorithms.

Whatever it is, it's not a queue. The queue implies O(1) for insertion
and deletion, but your 'dequeue' is clearly an O(n) procedure.

I'm not sure if I completely understand the purpose of the series, but
from this description:
        enqueueing/dequeueing of sub-byte values

I think, the simplest solution would be a circular queue (ringbuffer)
based on bitmaps:

Init an empty 10-bit bitmap:

Head = 0
v
..... .....
 ^
 Tail = 1

Enqueue 6-bit value 0b101010 at the end:

Head = 0
v
10101 0....
      ^
      Tail = 1

Dequeue 3 bits from the beginning:

   Head = 0
   v
...01 0....
      ^
      Tail = 1

And so on...

See some other comments inline.

Thanks,
Yury

> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  include/linux/bitqueue.h | 144 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 include/linux/bitqueue.h
> 
> diff --git a/include/linux/bitqueue.h b/include/linux/bitqueue.h
> new file mode 100644
> index 0000000000000..c4393f703c697
> --- /dev/null
> +++ b/include/linux/bitqueue.h
> @@ -0,0 +1,144 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * A simple bit queue which supports enqueueing/dequeueing of sub-byte values.
> + *
> + * This can be used to pack complex bitfields into byte arrays.
> + */
> +#ifndef _LINUX_BITQUEUE_H
> +#define _LINUX_BITQUEUE_H
> +
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +/**
> + * struct bitq - represents a bit queue with external storage.
> + * @data:	data buffer used by the queue.
> + * @size:	size of @data in bytes.
> + * @bit_pos:	current bit position.
> + */
> +struct bitq {
> +	u8 *data;
> +	int size, bit_pos;
> +};
> +
> +/**
> + * bitq_init - initialize an empty bit queue.
> + * @q:		struct bitq to be initialized.
> + * @data:	external data buffer to use.
> + * @size:	capacity in bytes.
> + *
> + * Return:	0 in the case of success, -1 if either of the pointers is NULL.

ENIVAL?

> + */
> +static inline int bitq_init(struct bitq *q, u8 *data, int size)
> +{
> +	if (!q || !data)
> +		return -1;

This is a useless check. Erroneous code may (and often does) pass a
broken pointer other than NULL.

And to make it worse, this error handling (instead of run-time
segfault which can be easily caught at debugging) may make users think
that passing NULL is the right thing. Check bit/bitmap and other kernel
functions: they don't check against NULL as a general rule, except for
well-justified cases, like 'free(NULL)'.


> +	q->data = data;
> +	q->size = size;
> +	memset(data, 0, size);

Useless memset?

> +	q->bit_pos = 0;
> +	return 0;
> +}
> +
> +/**
> + * bitq_init_full - make a bit queue from an initialized byte array.
> + * @q:		struct bitq to be initialized.
> + * @data:	external data buffer to use.
> + * @size:	capacity in bytes.
> + *
> + * Return:	0 in the case of success, -1 if either of the pointers is NULL.
> + */
> +static inline int bitq_init_full(struct bitq *q, u8 *data, int size)
> +{
> +	if (!q || !data)
> +		return -1;
> +	q->data = data;
> +	q->size = size;
> +	q->bit_pos = q->size * 8;
> +	return 0;
> +}

This all should not reside in a header.

> +
> +/**
> + * bitq_enqueue - push up to 8 bits to the end of the queue.
> + * @q:		struct bitq.
> + * @value:	byte containing the value to be pushed.
> + * @bits:	number of bits (1 to 8) to push.
> + *
> + * Return:	number of bits pushed, or -1 in the case of an error.
> + */
> +static inline int bitq_enqueue(struct bitq *q, u8 value, int bits)
> +{
> +	int byte_pos, left_in_byte, max_pos;
> +	u8 hi, lo;
> +
> +	if (!q || (bits < 1) || (bits > 8))
> +		return -1;

Pushing 0 elements in queue is usually not an error. Implementations
usually return and do nothing. From the malloc() man page:

        If size is 0, then malloc() returns a unique pointer value that
        can later be successfully passed to free().

> +	max_pos = q->size * 8;
> +	if ((max_pos - q->bit_pos) < bits)
> +		return -1;

ENOMEM? Or probably better to resize the queue.

> +
> +	left_in_byte = 8 - (q->bit_pos % 8);
> +	byte_pos = q->bit_pos / 8;
> +	/* Clamp @value. */
> +	value %= (1 << bits);
> +	if (left_in_byte >= bits) {
> +		/* @value fits into the current byte. */
> +		value <<= (left_in_byte - bits);
> +		q->data[byte_pos] |= value;
> +	} else {
> +		/*
> +		 * @value needs to be split between the current and the
> +		 * following bytes.
> +		 */
> +		hi = value >> (bits - left_in_byte);
> +		q->data[byte_pos] |= hi;
> +		byte_pos++;
> +		lo = value << (8 - (bits - left_in_byte));
> +		q->data[byte_pos] |= lo;
> +	}

This piece should be a bitmap_append() function, like:
bitmap_append(addr, 3, 2, 0b11) would append 0b11 to the bitmap at
offset 3. We already have bitmap_{set,get}_value8, so I suggest
to extend the interface for unaligned offsets and lengths up to
BITS_PER_LONG.

> +	q->bit_pos += bits;
> +	return bits;
> +}
> +
> +/**
> + * bitq_dequeue - pop up to 8 bits from the beginning of the queue.
> + * @q:		struct bitq.
> + * @value:	u8* to store the popped value (can be NULL).
> + * @bits:	number of bits (1 to 8) to pop.
> + *
> + * Return:	number of bits popped, or -1 in the case of an error.
> + */
> +
> +#include <linux/printk.h>
> +static inline int bitq_dequeue(struct bitq *q, u8 *value, int bits)
> +{
> +	int rem_bits = 8 - bits, i;
> +	u8 output;
> +
> +	/* Invalid arguments. */
> +	if (!q || (bits < 1) || (bits > 8))
> +		return -1;
> +	/* Not enough space to insert @bits. */
> +	if (q->bit_pos < bits)
> +		return -1;
> +	/* Take the first @bits bits from the first byte. */
> +	output = q->data[0];
> +	output >>= rem_bits;
> +	if (value)
> +		*value = output;
> +
> +	/*
> +	 * Shift every byte in the queue to the left by @bits, carrying over to
> +	 * the previous byte.
> +	 */
> +	for (i = 0; i < q->size - 1; i++) {
> +		q->data[i] = (q->data[i] << bits) |
> +			     (q->data[i + 1] >> rem_bits);
> +	}

As I already mentioned, this is O(N), which is wrong for queues. Add a
pointer to the head in the bitq structure to avoid shifting every
byte.

BTW, we've got bitmap_shift_{left,right} for this.

> +	q->data[q->size - 1] <<= bits;
> +	q->bit_pos -= bits;
> +	return bits;
> +}
> +
> +#endif // _LINUX_BITQUEUE_H
> -- 
> 2.41.0.255.g8b1d071c50-goog
