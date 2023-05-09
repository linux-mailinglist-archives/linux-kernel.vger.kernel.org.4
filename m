Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ADB6FBE7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjEIE6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEIE6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:58:21 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4568558D;
        Mon,  8 May 2023 21:58:18 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1aae5c2423dso53058155ad.3;
        Mon, 08 May 2023 21:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683608298; x=1686200298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//ImHbS+prnCv0z9ZkC0yFOD4796yFiX9w312WKCHmU=;
        b=lpKbPKKYWlUqKvg3a+BbXzro4kdVTQ+jZPHqhTnvepIOraP/1gl+npMe1YpcuAJz2g
         2azqsM7ZO8hDHfFgjehaJLuJG4wKzUz7DTLeuP/YBbPk+8s8VHTU/Uv1XrcF3TmEDH/p
         w7s8sRwRHBpSJ2ozrBSihCGd55S8QsT3HVQNgITnXQ8jG0/JaZZZiFtuPIkvVpBsW84/
         7vQDHthArfrmMCTjZKdkYHTuzc+lCbj7BYbHL/tpIM9WkFY2I9yHSnUoBDv3M2V0tSGd
         HMQm/igYFzewV7w5jzjhGzMUwEEgrOQp9jZRESQZQCyaP92LD80xnfNb8kgbdOrcyte/
         r2DA==
X-Gm-Message-State: AC+VfDy0zfhl28qHF8M9bk4cKkfdb6I9HUKnPxfTzmmeOoRJvjqfqjKx
        9TW/zO8MSsxBR0e8/YJvSdzjAYnE8vpuFhbN1gm1/mHlxs4=
X-Google-Smtp-Source: ACHHUZ5mOThUlddoUQWby4/bUPdG/QEpsHRAURbSP5KnLKZkoeh1+DarxzEqIfHypuQmURRamZqMFtL7HnS48uWs0s0=
X-Received: by 2002:a17:902:cecf:b0:1ac:96e7:e97d with SMTP id
 d15-20020a170902cecf00b001ac96e7e97dmr1040851plg.67.1683608297910; Mon, 08
 May 2023 21:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr> <20230508-sprint-cause-80b4172d5a5a-mkl@pengutronix.de>
In-Reply-To: <20230508-sprint-cause-80b4172d5a5a-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 May 2023 13:58:06 +0900
Message-ID: <CAMZ6RqKQw702HPjBTNJdBfL8yhkn5vDVDfn6dbrVMv7SX6NO2w@mail.gmail.com>
Subject: Re: [PATCH] can: length: add definitions for frame lengths in bits
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Thomas Kopp <thomas.kopp@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon. 8 May 2023 at 21:29, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 08.05.2023 00:55:06, Vincent Mailhol wrote:
> > When created in [1], frames length definitions were added to implement
> > byte queue limits (bql). Because bql expects lengths in bytes, bit
> > length definitions were not considered back then.
> >
> > Recently, a need to refer to the exact frame length in bits, with CAN
> > bit stuffing, appeared in [2].
> >
> > Add 9 frames length definitions:
> >
> >  - CAN_FRAME_OVERHEAD_SFF_BITS:
> >  - CAN_FRAME_OVERHEAD_EFF_BITS
> >  - CANFD_FRAME_OVERHEAD_SFF_BITS
> >  - CANFD_FRAME_OVERHEAD_EFF_BITS
> >  - CAN_BIT_STUFFING_OVERHEAD
> >  - CAN_FRAME_LEN_MAX_BITS_NO_STUFFING
> >  - CAN_FRAME_LEN_MAX_BITS_STUFFING
> >  - CANFD_FRAME_LEN_MAX_BITS_NO_STUFFING
> >  - CANFD_FRAME_LEN_MAX_BITS_STUFFING
> >
> > CAN_FRAME_LEN_MAX_BITS_STUFFING and CANFD_FRAME_LEN_MAX_BITS_STUFFING
> > define respectively the maximum number of bits in a classical CAN and
> > CAN-FD frame including bit stuffing. The other definitions are
> > intermediate values.
> >
> > In addition to the above:
> >
> >  - Include linux/bits.h and then replace the value 8 by BITS_PER_BYTE
> >    whenever relevant.
> >  - Include linux/math.h because of DIV_ROUND_UP(). N.B: the use of
> >    DIV_ROUND_UP() is not new to this patch, but the include was
> >    previously omitted.
> >  - Update the existing length definitions to use the newly defined values.
> >  - Add myself as copyright owner for 2020 (as coauthor of the initial
> >    version, c.f. [1]) and for 2023 (this patch).
> >
> > [1] commit 85d99c3e2a13 ("can: length: can_skb_get_frame_len(): introduce
> >     function to get data length of frame in data link layer")
> > Link: https://git.kernel.org/torvalds/c/85d99c3e2a13
> >
> > [2] RE: [PATCH] can: mcp251xfd: Increase poll timeout
> > Link: https://lore.kernel.org/linux-can/BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com/
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > As always, let me know if you have better inspiration than me for the
> > naming.
> > ---
> >  include/linux/can/length.h | 84 ++++++++++++++++++++++++++++++++------
> >  1 file changed, 72 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/can/length.h b/include/linux/can/length.h
> > index 6995092b774e..60492fcbe34d 100644
> > --- a/include/linux/can/length.h
> > +++ b/include/linux/can/length.h
> > @@ -1,13 +1,17 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  /* Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>
> >   * Copyright (C) 2020 Marc Kleine-Budde <kernel@pengutronix.de>
> > + * Copyright (C) 2020, 2023 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >   */
> >
> >  #ifndef _CAN_LENGTH_H
> >  #define _CAN_LENGTH_H
> >
> > +#include <linux/bits.h>
> > +#include <linux/math.h>
> > +
> >  /*
> > - * Size of a Classical CAN Standard Frame
> > + * Size of a Classical CAN Standard Frame in bits
> >   *
> >   * Name of Field                     Bits
> >   * ---------------------------------------------------------
> > @@ -25,12 +29,19 @@
> >   * End-of-frame (EOF)                        7
> >   * Inter frame spacing                       3
> >   *
> > - * rounded up and ignoring bitstuffing
> > + * ignoring bitstuffing
> >   */
> > -#define CAN_FRAME_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
> > +#define CAN_FRAME_OVERHEAD_SFF_BITS 47
> >
> >  /*
> > - * Size of a Classical CAN Extended Frame
> > + * Size of a Classical CAN Standard Frame
> > + * (rounded up and ignoring bitstuffing)
> > + */
> > +#define CAN_FRAME_OVERHEAD_SFF \
> > +     DIV_ROUND_UP(CAN_FRAME_OVERHEAD_SFF_BITS, BITS_PER_BYTE)
> > +
> > +/*
> > + * Size of a Classical CAN Extended Frame in bits
> >   *
> >   * Name of Field                     Bits
> >   * ---------------------------------------------------------
> > @@ -50,12 +61,19 @@
> >   * End-of-frame (EOF)                        7
> >   * Inter frame spacing                       3
> >   *
> > - * rounded up and ignoring bitstuffing
> > + * ignoring bitstuffing
> >   */
> > -#define CAN_FRAME_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
> > +#define CAN_FRAME_OVERHEAD_EFF_BITS 67
> >
> >  /*
> > - * Size of a CAN-FD Standard Frame
> > + * Size of a Classical CAN Extended Frame
> > + * (rounded up and ignoring bitstuffing)
> > + */
> > +#define CAN_FRAME_OVERHEAD_EFF \
> > +     DIV_ROUND_UP(CAN_FRAME_OVERHEAD_EFF_BITS, BITS_PER_BYTE)
> > +
> > +/*
> > + * Size of a CAN-FD Standard Frame in bits
> >   *
> >   * Name of Field                     Bits
> >   * ---------------------------------------------------------
> > @@ -77,12 +95,19 @@
> >   * End-of-frame (EOF)                        7
> >   * Inter frame spacing                       3
> >   *
> > - * assuming CRC21, rounded up and ignoring bitstuffing
> > + * assuming CRC21 and ignoring bitstuffing
> >   */
> > -#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
> > +#define CANFD_FRAME_OVERHEAD_SFF_BITS 61
> >
> >  /*
> > - * Size of a CAN-FD Extended Frame
> > + * Size of a CAN-FD Standard Frame
> > + * (assuming CRC21, rounded up and ignoring bitstuffing)
> > + */
> > +#define CANFD_FRAME_OVERHEAD_SFF \
> > +     DIV_ROUND_UP(CANFD_FRAME_OVERHEAD_SFF_BITS, BITS_PER_BYTE)
> > +
> > +/*
> > + * Size of a CAN-FD Extended Frame in bits
> >   *
> >   * Name of Field                     Bits
> >   * ---------------------------------------------------------
> > @@ -106,9 +131,32 @@
> >   * End-of-frame (EOF)                        7
> >   * Inter frame spacing                       3
> >   *
> > - * assuming CRC21, rounded up and ignoring bitstuffing
> > + * assuming CRC21 and ignoring bitstuffing
> > + */
> > +#define CANFD_FRAME_OVERHEAD_EFF_BITS 80
> > +
> > +/*
> > + * Size of a CAN-FD Extended Frame
> > + * (assuming CRC21, rounded up and ignoring bitstuffing)
> > + */
> > +#define CANFD_FRAME_OVERHEAD_EFF \
> > +     DIV_ROUND_UP(CANFD_FRAME_OVERHEAD_EFF_BITS, BITS_PER_BYTE)
> > +
> > +/* CAN bit stuffing overhead multiplication factor */
> > +#define CAN_BIT_STUFFING_OVERHEAD 1.2
> > +
> > +/*
> > + * Maximum size of a Classical CAN frame in bits, ignoring bitstuffing
> >   */
> > -#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
> > +#define CAN_FRAME_LEN_MAX_BITS_NO_STUFFING \
> > +     (CAN_FRAME_OVERHEAD_EFF_BITS + CAN_MAX_DLEN * BITS_PER_BYTE)
> > +
> > +/*
> > + * Maximum size of a Classical CAN frame in bits, including bitstuffing
> > + */
> > +#define CAN_FRAME_LEN_MAX_BITS_STUFFING                              \
> > +     ((unsigned int)(CAN_FRAME_LEN_MAX_BITS_NO_STUFFING *    \
> > +                     CAN_BIT_STUFFING_OVERHEAD))
>
> The 1.2 overhead doesn't apply to the whole frame, according to
> https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8338047.

You are right. In fact, I realized this mistake before reading your
message (while I was studying the standard to answer Thomas).

ISO 11898-1:2015 section 10.5 "Frame coding" says:

  the frame segment as SOF, arbitration field, control field,
  data field, and CRC sequence shall be coded by the method of
  bit stuffing.

and:

  The remaining bit fields of the DF or RF (CRC delimiter, ACK
  field and EOF) shall be of fixed form and not stuffed.

So, indeed, the bit stuffing does not apply to the last 10 bits (1 + 1 + 1 + 7).
Furthermore, for FD frames, the CRC field already contains the fixed
stuff bits. So the overhead shall not be applied again or else, stuff
bits would be counted twice. In conclusion, for FD frames, the
otherhead for dynamic bit stuffing overhead should apply to the SOF,
arbitration field, control field and data field segments.

After reading the standard, I thought again about the overhead ratio
and it is more complicated than we all thought.

Let's use below nomenclature in the following examples (borrowed from ISO):

  - "0": dominant bit
  - "o": dominant stuff bit
  - "1": recessive bit
  - "i": recessive stuff bit

We probably all though below example to be the worst case:

  Destuffed: 11111  11111  11111  11111
  Stuffed:   11111o 11111o 11111o 11111o

Here, indeed, one stuff bit is added every five bits giving us an
overhead of 6/5 = 1.2.

However, ISO 11898-1:2015 section 10.5 "Frame coding" also says:

  Whenever a transmitter detects five consecutive bits (*including
  stuff bits*) of identical value in the bit stream to be
  transmitted, it shall automatically insert a complementary
  bit (called stuff bit) ...

Pay attention to the *including stuff bits* part. The worst case is
actually a sequence in which dominant and recessive alternate every
four bits:

  Destuffed: 1 1111  0000  1111  0000  1111
  Stuffed:   1 1111o 0000i 1111o 0000i 1111o

Ignoring the first bit, one stuff bit is added every four bits giving
us an overhead of 5/4 = 1.25.

The exact formula taking in account the first bit we previously ignored then:

  Number of dynamic stuff bit = 1 + round_down((len(stream) - 5) / 4)
                              = round_down((len(stream) - 1) / 4)


Yours sincerely,
Vincent Mailhol
