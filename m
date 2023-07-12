Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A86750460
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjGLKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:25:15 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03AAD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:25:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso233497139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689157513; x=1691749513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZEklEmoui74R6BP6k1awZEHm/ZobwybfWOOPJmYjHg=;
        b=G+q7g1svsWBLC7F7YQyDvoX0qphZ/yRIe1j1nXtvWtB6udd72YV3ZtYzuXWkghjA5J
         ysZummYpQwPhLyTmbAFw7XFfBNy3mCmBZN+sPom0pLUsrfq8wq21avBq9JoXZdeAmQVC
         RclL2ZVbh6TacVceteqCYse2y6DAH8pqEnrdhCfy6GTk/QIdJSkYH/+FB7Kpsq9WS3E1
         xz+r+GLddQTjXWLqkqYesi7sIKFeRnt3v9ZzSaiw+qAdvg7EiMPi8udtDZM1nnSeGeO+
         QxdX8b1XSG4r7BloyxkL+A4W4ZStx4W+A34bXoSgogqPYVc4PEQWbDTKxUZamNgBVKBx
         nSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689157513; x=1691749513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZEklEmoui74R6BP6k1awZEHm/ZobwybfWOOPJmYjHg=;
        b=LpsVuzvarD4/htL1JVAYdlECK9jTK3H4NsEUH5CGeuFQLBEOWYhYec/TZd3hIYtM2t
         hyyyxkqRoLFZY0kd5s53l7Plkd7qJyZjHFXYggC5gwiwtyzxQq0h4I1HauTokNUhB52t
         mlBUzuftZLr5hKxxSuCcLsEJ+dSzpxqZ4c/N9PvZhQDpULoZMAU5iXuLxBRI1zhQBKvu
         y3AUeWWDPFJjpqjT0nv7kh8qDbfGnaEZVsNKs1F+QeLnU62jexm09dIteSPlan3S9NQd
         ZHyBKM/xpsOxw4gEAPsWGpVgbSgSCQF0d4P0HVJKbzzARHxEB+AfzWueDvywwk4gH/7+
         LBEA==
X-Gm-Message-State: ABy/qLZ0Se9iElDjShiNCZWnDMarLGFPgVN+E0as3MnmmjECgAK7CPYx
        SHcpFK7gLbbHy25UfB2lERCT36fonYWlaucCgyO4JQ==
X-Google-Smtp-Source: APBJJlHybeHPi0cL+U1bjL0XkJVNjKtRdvWaIK9atE72jki/anEdcHXdzPLkseXSYnNXBrIaYjAbAsw/a2S6g+K6sxg=
X-Received: by 2002:a6b:5c0e:0:b0:785:ccac:a4db with SMTP id
 z14-20020a6b5c0e000000b00785ccaca4dbmr17490292ioh.2.1689157513306; Wed, 12
 Jul 2023 03:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230711144233.3129207-1-glider@google.com> <20230711144233.3129207-2-glider@google.com>
 <ZK2raeRzTLjyiMLI@yury-ThinkPad>
In-Reply-To: <ZK2raeRzTLjyiMLI@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 12 Jul 2023 12:24:36 +0200
Message-ID: <CAG_fn=UDojnFVetSi=L7n82a2CeWuJwJFz+Jk20GA-p+N1wrcg@mail.gmail.com>
Subject: Re: [Resend v1 1/5] linux/bitqueue.h: add the bit queue implementation
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 9:20=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> + Andy and Rasmus
>
> On Tue, Jul 11, 2023 at 04:42:29PM +0200, Alexander Potapenko wrote:
> > struct bitq represents a bit queue with external storage.
> >
> > Its purpose is to easily pack sub-byte values, which can be used, for
> > example, to implement RLE algorithms.
>
> Whatever it is, it's not a queue. The queue implies O(1) for insertion
> and deletion, but your 'dequeue' is clearly an O(n) procedure.

Thanks for spotting this!
I have indeed done a poor job implementing the dequeue method.

> I'm not sure if I completely understand the purpose of the series,

To implement tag compression, we need to serialize/deserialize "bit
fields" looking e.g. like this:

    int largest_idx : 6;
    unsigned char tags[N] : 4*N;
    unsigned char sizes[N-1] : 7*(N-1)

to/from a byte array. This actually needs to be done only once, and
enqueue()/dequeue() operations do not interleave, so there is no need
for an actual queue.

I'll try to come up with something simple - maybe reimplement it as a
ring buffer, or even skip the "ring" part, because it is not needed
for my purpose.
(The struct may end up being less generic - in that case I'll move it
from include/linux arch/arm64/mm/)


> but
> from this description:
>         enqueueing/dequeueing of sub-byte values
>
> I think, the simplest solution would be a circular queue (ringbuffer)
> based on bitmaps:


> > +/**
> > + * bitq_init - initialize an empty bit queue.
> > + * @q:               struct bitq to be initialized.
> > + * @data:    external data buffer to use.
> > + * @size:    capacity in bytes.
> > + *
> > + * Return:   0 in the case of success, -1 if either of the pointers is=
 NULL.
>
> ENIVAL?

Ack, better use the common error values.

>
> > + */
> > +static inline int bitq_init(struct bitq *q, u8 *data, int size)
> > +{
> > +     if (!q || !data)
> > +             return -1;
>
> This is a useless check. Erroneous code may (and often does) pass a
> broken pointer other than NULL.

I am actually a fan of defensive programming, but it's a good point
that it does not defend against non-NULL pointers, and NULL is anyway
an unexpected input value.

>
> > +     q->data =3D data;
> > +     q->size =3D size;
> > +     memset(data, 0, size);
>
> Useless memset?

An overly cautious one, that lets us fetch values from partially
initialized bytes. This code will be removed anyway.

> > +static inline int bitq_init_full(struct bitq *q, u8 *data, int size)
> > +{
> > +     if (!q || !data)
> > +             return -1;
> > +     q->data =3D data;
> > +     q->size =3D size;
> > +     q->bit_pos =3D q->size * 8;
> > +     return 0;
> > +}
>
> This all should not reside in a header.

There's a handful of examples in include/linux where meaningful code
is written in the headers, but I agree that in this particular case it
is probably not justified by performance reasons.

> > +     if (!q || (bits < 1) || (bits > 8))
> > +             return -1;
>
> Pushing 0 elements in queue is usually not an error. Implementations
> usually return and do nothing. From the malloc() man page:

Agreed.

>         If size is 0, then malloc() returns a unique pointer value that
>         can later be successfully passed to free().
>
> > +     max_pos =3D q->size * 8;
> > +     if ((max_pos - q->bit_pos) < bits)
> > +             return -1;
>
> ENOMEM? Or probably better to resize the queue.

This "queue" relies on the external storage that may not be easily
resizeable (e.g. when we are using a local u64 as a storage).
ENOMEM sounds better (should we stick to this interface).


> > +             /*
> > +              * @value needs to be split between the current and the
> > +              * following bytes.
> > +              */
> > +             hi =3D value >> (bits - left_in_byte);
> > +             q->data[byte_pos] |=3D hi;
> > +             byte_pos++;
> > +             lo =3D value << (8 - (bits - left_in_byte));
> > +             q->data[byte_pos] |=3D lo;
> > +     }
>
> This piece should be a bitmap_append() function, like:
> bitmap_append(addr, 3, 2, 0b11) would append 0b11 to the bitmap at
> offset 3. We already have bitmap_{set,get}_value8, so I suggest
> to extend the interface for unaligned offsets and lengths up to
> BITS_PER_LONG.

Interesting. Yeah, this could be part of bitmap.h instead.


> > +     /*
> > +      * Shift every byte in the queue to the left by @bits, carrying o=
ver to
> > +      * the previous byte.
> > +      */
> > +     for (i =3D 0; i < q->size - 1; i++) {
> > +             q->data[i] =3D (q->data[i] << bits) |
> > +                          (q->data[i + 1] >> rem_bits);
> > +     }
>
> As I already mentioned, this is O(N), which is wrong for queues. Add a
> pointer to the head in the bitq structure to avoid shifting every
> byte.
>
> BTW, we've got bitmap_shift_{left,right} for this.

Ack.
