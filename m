Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E03703E67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245302AbjEOUQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245295AbjEOUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D6A8682
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684181717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZ4CwttkciK12M4XhwAUkpXG7e8nMod9VByDK+w92f4=;
        b=HoD3fDx5Mn3p2acOflL+G8i13Q/ELw+Fs/ZeTeBxDqrjvnJ5XcFLZ6LrrA/UV0bHhgoOxJ
        qkbr0tHbBMG7zV5SkiUfw0f+IOLP1l9sc0SYkepmbmaawStdZYFnVc/R5M+Hz5flHtBhKr
        AA4viJv4TOSC2J8QD+DoMjbPVRGH2zY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-IeQGzStaM9C7I4ftoZH1qw-1; Mon, 15 May 2023 16:15:15 -0400
X-MC-Unique: IeQGzStaM9C7I4ftoZH1qw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ab1f10384fso2437308a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684181715; x=1686773715;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZ4CwttkciK12M4XhwAUkpXG7e8nMod9VByDK+w92f4=;
        b=I5pPhD5jHcdeMU9YpLWSZC7aGvwIO+TaEDJ1JXOR4npxvO73Nada9+fn997+so+jc7
         pOVN8KdSiRuKBJkFNC6Yrg+wY4ntMjeYqScVn41GEuje8qt9521Bz/xyfR6BcW9gH7MM
         /u8ZhdktFrvRqaBWD8awU5drcNGAYHI+UIurBuuAe5G8l1yQyoWU7ISnTl+ELOFhbmiY
         7cMYfjxJsF1/XU2548Dg9BnlEd2xej7tR7Mjw4NqNBppyBe6xPdrDW/I6mkXYYsHFcPs
         aMJ9fNosyQyQV1z350wd+9pDR9arGh0gVTnXIQOUehrb7eeqsM5ZnLZVObB16Aw4c3o6
         vxQQ==
X-Gm-Message-State: AC+VfDxxj1EeqVm1qOH51rh+XSOU3krPSlVbixvI/H/ZtrauOO88YBRi
        o26pAYozVSLZwi8JtkC7WyZZHIh0lDweutwBvDvPq8LgBR28CNO4qIk5rVSNYXX7Bqmvo7mJz9r
        NwX0Cy4AVGhH7ADK4p76hMdzu
X-Received: by 2002:a9d:6b11:0:b0:6aa:ecb5:f187 with SMTP id g17-20020a9d6b11000000b006aaecb5f187mr9880739otp.1.1684181714809;
        Mon, 15 May 2023 13:15:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7n077BKvFR4kq4/OG5wnKyYPoneW7fmnYMMNIGg0ySmalDqNRCbhrdhmySfNAEXOKfbZEkzA==
X-Received: by 2002:a9d:6b11:0:b0:6aa:ecb5:f187 with SMTP id g17-20020a9d6b11000000b006aaecb5f187mr9880729otp.1.1684181714550;
        Mon, 15 May 2023 13:15:14 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3? ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id d20-20020a056830139400b006ab37d0b2e8sm5588697otq.74.2023.05.15.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:15:14 -0700 (PDT)
Message-ID: <72b4a9b45f5aea876d4e5aff02534b75cc81e426.camel@redhat.com>
Subject: Re: [RFC PATCH 1/2] blk-mq: Convert request->csd to
 call_single_data_t and reposition it
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 May 2023 17:15:11 -0300
In-Reply-To: <1c9a152e-fac1-ac9e-c871-bbec5f176bda@kernel.dk>
References: <20230511085836.579679-1-leobras@redhat.com>
         <1c9a152e-fac1-ac9e-c871-bbec5f176bda@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-12 at 09:01 -0600, Jens Axboe wrote:
> On 5/11/23 2:58?AM, Leonardo Bras wrote:
> > Currently, request->csd has type struct __call_single_data.
> >=20
> > call_single_data_t is defined in include/linux/smp.h :
> >=20
> > /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
> > typedef struct __call_single_data call_single_data_t
> > 	__aligned(sizeof(struct __call_single_data));
> >=20
> > As the comment above the typedef suggests, having this struct split bet=
ween
> > 2 cachelines causes the need to fetch / invalidate / bounce 2 cacheline=
s
> > instead of 1 when the cpu receiving the request gets to run the request=
ed
> > function. This is usually bad for performance, due to one extra memory
> > access and 1 extra cacheline usage.
> >=20
> > Changing request->csd was previously attempted in commit
> > 966a967116e6 ("smp: Avoid using two cache lines for struct call_single_=
data")
> > but at the time the union that contains csd was positioned near the top=
 of
> > struct request, only below a struct list_head, and this caused the issu=
e of
> > holes summing up 24 extra bytes in struct request.
> >=20
> > The struct size was restored back to normal by
> > commit 4ccafe032005 ("block: unalign call_single_data in struct request=
")
> > but it caused the csd to be possibly split in 2 cachelines again.
> >=20
> > As an example with a 64-bit machine with
> > CONFIG_BLK_RQ_ALLOC_TIME=3Dy
> > CONFIG_BLK_WBT=3Dy
> > CONFIG_BLK_DEV_INTEGRITY=3Dy
> > CONFIG_BLK_INLINE_ENCRYPTION=3Dy
> >=20
> > Will output pahole with:
> > struct request {
> > [...]
> > 	union {
> > 		struct __call_single_data csd;           /*   240    32 */
> > 		u64                fifo_time;            /*   240     8 */
> > 	};                                               /*   240    32 */
> > [...]
> > }
> >=20
> > At this config, and any cacheline size between 32 and 256, will cause c=
sd
> > to be split between 2 cachelines: csd->node (16 bytes) in the first
> > cacheline, and csd->func (8 bytes) & csd->info (8 bytes) in the second.
> >=20
> > During blk_mq_complete_send_ipi(), csd->func and csd->info are getting
> > changed, and when it calls __smp_call_single_queue() csd->node will get
> > changed.
> >=20
> > On the cpu which got the request, csd->func and csd->info get read by
> > __flush_smp_call_function_queue() and csd->node gets changed by
> > csd_unlock(), meaning the two cachelines containing csd will get access=
ed.
> >=20
> > To avoid this, it would be necessary to change request->csd back to
> > csd_single_data_t, which may end up increasing the struct size.
> > (In above example, it increased from 288 to 320 -> 32 bytes).
> >=20
> > In order to keep the csd_single_data_t and avoid the struct's size
> > increase, move request->csd to the end of the struct.
> > The rationale of this strategy is that for cachelines >=3D 32 bytes, th=
ere
> > will never be used an extra cacheline for struct request:
> >=20
> > - If request->csd is 32-byte aligned, there is no change in the object.
> > - If request->csd is not 32-byte aligned, and part of it is in a differ=
ent
> >   cacheline, the whole csd is moved to that cacheline.
> > - If request->csd is not 32-byte aligned, but it's all contained in the
> >   same cacheline (> 32 bytes), aligning it to 32 will just put it a few
> >   bytes forward in this cacheline.
> >=20
> > (In above example, the change kept the struct's size in 288 bytes).
> >=20
> > Convert request->csd to csd_single_data_t and move it to the end of
> > struct request, so csd is never split between cachelines and don't use =
any
> > extra cachelines.
>=20
> This is going the wrong way imho. It'd be nice to get struct request
> down to 256 bytes at some point, and then this would get in the way.

Hello Jens, thanks for reviewing!

I understand the idea, and I think we could have a way of rearranging the s=
truct
in a way this variable would be always aligned, so no hole would be introdu=
ced
by the alignment requirement.

>  The
> patch is also attempting to do two things at once, which is a bad idea.

By two things you mean rearranging the struct and switching the type to an
aligned typedef? I would be glad to send 2 patches on that.

>=20
> Why not just rearrange it a bit so that we don't split a cacheline with
> the csd?
>=20

Well, I thought that was exactly what I have done.
I mean, I was not aware of this future desire of shrinking it back to 256 b=
ytes,
and so I added it to the end of the struct, but I could rearrange it in a
different way so the change to the 32-byte aligned call_single_data_t would
never introduce any size increase.

The thing with using call_single_data_t is that adding another struct field
before csd would cause struct request to increase by 32 bytes, and possibly=
 grow
a hole, due to alignment.
This is good on the keeping the csd data in the same cacheline, but
this is bad because the struct would grow 32 bytes.

The other option, i.e. keeping 'struct __call_single_data', would cause the
struct to grow less if anything is added before, but would cause csd being
possibly shared between 2 cachelines.

I think the 1st option is 'better' because we could easily detect the 32-by=
te
increase in the struct request, but the 2-cachelines thing would probably g=
o
undetected.

What you think about this reorder: put the csd union after 'struct block_de=
vice
*part', but before any compile-time removable field ?

This would cause the csd union to be 32-byte aligned with any CONFIG_* (as =
it
comes before any compile-time field in struct request), and in both 32-bit =
and
64-bit kernels

The pahole for this on 64-bit kernels outputs:

struct request {                                                           =
   =20
        [...]
        struct block_device *      part;                 /*    88     8 */ =
   =20
        union {                                                            =
   =20
                call_single_data_t csd __attribute__((__aligned__(32)));=C2=
=A0
							 /*    96    32 */                                                  =
   =20
	[...]
        /* size: 288, cachelines: 5, members: 33 */                        =
   =20
        /* sum members: 282, holes: 2, sum holes: 6 */                     =
   =20
        /* forced alignments: 2 */                                         =
   =20
        /* last cacheline: 32 bytes */                                     =
   =20
} __attribute__((__aligned__(32)));                                        =
   =20

And for 32-bit kernels:

struct request {                                                           =
    =C2=A0
	[...]                                                                     =
   =20
        struct block_device *      part;                 /*    60     4 */ =
   =20
	union {                                                                   =
   =20
                call_single_data_t csd __attribute__((__aligned__(16)));=C2=
=A0
							 /*    64    16 */                                                  =
   =20
                u64                fifo_time;            /*    64     8 */ =
   =20
        } __attribute__((__aligned__(16)));              /*    64    16 */ =
   =20
	[...]                                                                     =
   =20
        /* size: 192, cachelines: 3, members: 33 */                        =
   =20
        /* sum members: 178, holes: 1, sum holes: 2 */                     =
   =20
        /* padding: 12 */                                                  =
   =20
        /* forced alignments: 2 */                                         =
   =20
} __attribute__((__aligned__(16))); =20

What do you think?

Thanks!
Leo





