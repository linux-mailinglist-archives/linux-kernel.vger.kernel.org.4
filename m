Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA986D5864
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjDDGE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjDDGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:04:24 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BEE1BC7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:04:22 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dw2so5594881qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680588261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubgV9hV0Yhsb6l5Ks66gGmhukuZ1NafV2435hbdgAVE=;
        b=CBWpykirvUIJpCeg68XRsCGwC1j5vDbWu/AKjSp2TIT77S5BsfqfGvTTyrNZWp14b5
         s9iQDm+QTIvsB7s1icRkXbeXhDr/MHGJVWMcNTpxPns7EpCGsBN0PbmmmfnvC7FI9QiI
         EirMRZYMiVrRqZlfaOmkBipD2npb90RBA28XhVVQiRRqztt3bttHDX7/B69OG62g9eId
         hE3hEmSxwXkRz2yyevPASJqEOeJ5whBsTiy1W4/h4rBYDEwr/PzZMO9TIZfbGZAjXWf8
         nVy+mgEEhm5dwxTs43V2nEPWUiynXOu2o5HKxe24abawKdkaiBVLo61JfQCwTKAD7z4j
         Egwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680588261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubgV9hV0Yhsb6l5Ks66gGmhukuZ1NafV2435hbdgAVE=;
        b=kNWjMA6iqtQZrksAa4RmxEV+FjjJO4txAh/TCrwDqx8g2UXx8MOnNboPv29ukjHHSh
         xnRygC3aJAukHa1neXdXLSIOj3TK3db/xB+NWuzUWuo8W60wkJboJ9pt/cWAZKYv8qry
         WmAykvZMmZYjcmCvH7y03oAIr29bFeUU+2o3udND5O1NeoKraHYqkl3Av/0TO7lzpT7B
         BDg0YzwGAzlMP7rj8HNBXm9fDie/LldupE9wYepqWmGWuaS5PkJE6mK01k7llNHBouZ4
         2oh3GbwJt49X34i/8Kd3NmTakQI5WZnn7qYgVMSRaLptdrZwf/mIoGee+KOCHua502Ow
         1zsA==
X-Gm-Message-State: AAQBX9dZ6YAyU9tV0Dqz5TO6p2nDK4+/kraOCqzfmyAHF20V3x11CMe8
        4NWWrN4x8/VhEPdtzkijoFM2z2+ZAAcWIhNXVmfBA3ULX/n8/w==
X-Google-Smtp-Source: AKy350b5p70ecznUdiF2eptg+UR86P6LTGHJFrQF8CN08WaqRYOblhWPCa8c3yKaawtyRdDKCBAr92+VcqF7AzbEOYE=
X-Received: by 2002:a05:6214:192e:b0:5a9:5b2d:cd57 with SMTP id
 es14-20020a056214192e00b005a95b2dcd57mr254115qvb.3.1680588260768; Mon, 03 Apr
 2023 23:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230228161426.4508-1-ubizjak@gmail.com>
In-Reply-To: <20230228161426.4508-1-ubizjak@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 4 Apr 2023 08:04:09 +0200
Message-ID: <CAFULd4YYFNfN7uQeutP94j69LXwZQ-utveTFv3MVfZ9nt681rg@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Use do-while instead of for loop in set_nr_if_polling
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to ping for the patch below. The patch normalizes
try_cmpxchg loop to a more readable "while" instead of "for (;;)"
loop, otherwise it is a nop.

https://lore.kernel.org/lkml/20230228161426.4508-1-ubizjak@gmail.com/

Uros.



On Tue, Feb 28, 2023 at 5:14=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> Use equivalent do-while loop instead of infinite for loop.
>
> There are no asm code changes.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/sched/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index af017e038b48..349c018eaf09 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -899,14 +899,13 @@ static bool set_nr_if_polling(struct task_struct *p=
)
>         struct thread_info *ti =3D task_thread_info(p);
>         typeof(ti->flags) val =3D READ_ONCE(ti->flags);
>
> -       for (;;) {
> +       do {
>                 if (!(val & _TIF_POLLING_NRFLAG))
>                         return false;
>                 if (val & _TIF_NEED_RESCHED)
>                         return true;
> -               if (try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED=
))
> -                       break;
> -       }
> +       } while (!try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED))=
;
> +
>         return true;
>  }
>
> --
> 2.39.2
>
