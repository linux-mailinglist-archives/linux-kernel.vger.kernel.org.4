Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A72631E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKUK3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKUK3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:29:17 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E613D31
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:29:16 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3691e040abaso109045857b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yTWa2TxDwIxDHxGdCavaULiqNU91fmT1IvGC2ATR5w=;
        b=XJmCGjth33C3t+iYBi4qHEMC7VQDSmVksC8bqWnR2AP8GD8lVu9B+S4lbI3mt0HIhx
         BUZ+XvVE+baJxLz7LxISNo6km06oKbPyDA+Ia5EL1y7NUTEK/e8ONnFey/rdruWYbrq1
         siJ05rpVl9TfDUHGRbXWNV0uEVq0C2Dw83lrtGnV8YLi7fhuUkDTekUCS4OcFX2LD1pn
         7U95ZXR5kr+wP+TpozSw2lB+ZAT4EBVWb7MV60OwrsNmofvVAhoORIQTGmi0Cstxu+yc
         ydn1uiyUbaXcI/YQkUk+5DcY/WIS7qP8v0kUZux6Tknf2TTSda9F9YSgkR4JwZa60597
         fQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yTWa2TxDwIxDHxGdCavaULiqNU91fmT1IvGC2ATR5w=;
        b=f9iMhv9Y0G2Uz7HYwT9kDupwPdF1ncRDqNjnDofto2o9qTJmdpXs3+Bf8yp571s9ht
         VVO6VpSZJjE6PTvfdjNphpk34nc7aXflnWUGobjD8YXiUNEFEKH1dKmCTlw0E6IIdrhf
         d3jW7CWeR3OlCNTOUs+9jebqt5yxZoz2v6IwuRwgGQUB3+ptdouwQyxTGdstlHiMNKPI
         +W7yeqVmX0h+CQ2j4N+L/QGZx8SbokZEmFf6rKcrmNwz2TrV8lDDSFjjlif1FJnp1kik
         x6lUp16JffDDXet/cVy5xQdYqtYMMJ2D5hM3uVNQ+hDOBQtA/uftVTABVYwFaY72LGgl
         okEg==
X-Gm-Message-State: ANoB5pl1yHKwyAYUDsBqVoK8xACF9aNjJCKdo3zasO+JbRkLML3twJla
        mklDjXhjpzP4BT26FCIWbj07X9DZ0L3vqmRBYM7VSQ==
X-Google-Smtp-Source: AA0mqf7Cv0n4cnKw+fHfdATe7kP3oZrHDPPRxlCC6ZFH1aSvQbkVGr03/3eHkvbjXVyM/nn/ECYZTaCmBbmfUt5VWJA=
X-Received: by 2002:a81:a18e:0:b0:368:b923:b500 with SMTP id
 y136-20020a81a18e000000b00368b923b500mr678210ywg.10.1669026555620; Mon, 21
 Nov 2022 02:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20221118172305.3321253-1-glider@google.com> <Y3tRgGUKCxUoLeM8@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3tRgGUKCxUoLeM8@hirez.programming.kicks-ass.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 21 Nov 2022 11:28:39 +0100
Message-ID: <CAG_fn=Wpy8KA0cLBHapd7BdtnPHsRTpYip+z9TjfB1aUHUGH3g@mail.gmail.com>
Subject: Re: [PATCH] x86: suppress KMSAN reports in arch_within_stack_frames()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:23 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
> On Fri, Nov 18, 2022 at 06:23:05PM +0100, Alexander Potapenko wrote:
> > arch_within_stack_frames() performs stack walking and may confuse
> > KMSAN by stepping on stale shadow values. To prevent false positive
> > reports, disable KMSAN checks in this function.
> >
> > This fixes KMSAN's interoperability with CONFIG_HARDENED_USERCOPY.
> >
> > Link: https://github.com/google/kmsan/issues/89
> > Link: https://lore.kernel.org/lkml/Y3b9AAEKp2Vr3e6O@sol.localdomain/
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  arch/x86/include/asm/thread_info.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/=
thread_info.h
> > index f0cb881c1d690..f1cccba52eb97 100644
> > --- a/arch/x86/include/asm/thread_info.h
> > +++ b/arch/x86/include/asm/thread_info.h
> > @@ -163,7 +163,12 @@ struct thread_info {
> >   *   GOOD_FRAME      if within a frame
> >   *   BAD_STACK       if placed across a frame boundary (or outside sta=
ck)
> >   *   NOT_STACK       unable to determine (no frame pointers, etc)
> > + *
> > + * This function reads pointers from the stack and dereferences them. =
The
> > + * pointers may not have their KMSAN shadow set up properly, which may=
 result
> > + * in false positive reports. Disable instrumentation to avoid those.
> >   */
> > +__no_kmsan_checks
> >  static inline int arch_within_stack_frames(const void * const stack,
> >                                          const void * const stackend,
> >                                          const void *obj, unsigned long=
 len)
>
> Seems OK; but now I'm confused as to the exact distinction between
> __no_sanitize_memory and __no_kmsan_checks.
>
> The comments there about seem to suggest __no_sanitize_memory ensures no
> instrumentation at all, and __no_kmsan_checks some instrumentation but
> doesn't actually check anything -- so what's left then?

__no_sanitize_memory prohibits all instrumentation whatsoever, whereas
__no_kmsan_checks adds instrumentation that suppresses potential false
positives around this function.

Quoting include/linux/compiler-clang.h:

/*
 * The __no_kmsan_checks attribute ensures that a function does not produce
 * false positive reports by:
 *  - initializing all local variables and memory stores in this function;
 *  - skipping all shadow checks;
 *  - passing initialized arguments to this function's callees.
 */

Does this answer your question?

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
