Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23AC6E508A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDQTEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDQTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:04:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE98635BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:04:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t16so14244196ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681758260; x=1684350260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR141y3FdLwDgBYPcxQg2Choq6RyTsBHyE48LNOfBSA=;
        b=2U8w9KOgBX+tvZOqwRa1CCQm4z+g6XC0GndQ4yA8Gqyl6l9WIMtd2Y/loL49jaOigl
         WbI8eykqGhgNpGd9+CUd1aYgQZlrV6wvw40s+J3Qo9+LY186yBNiP8WL/UgrHV/e/CB3
         dy2XSv6YTF0FuaKuiDQUhtwGfMtskblPo/UZLmdAnMekOwu3bzPByYwyjwnbAXIzyrhW
         Vo3jpEItB6DNb1/z3xXCCY5vdwobrtwsZ8G1k6LET0nQ96WxbaZP6nd/1qRRoEqXQsS/
         BMyxGe3NAHOMuVXNjLwb89wYYJldsE+5ZBT3ReCgGrUBC9Ccc5ZYBln1SbVRdXlvKg6z
         A7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758260; x=1684350260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR141y3FdLwDgBYPcxQg2Choq6RyTsBHyE48LNOfBSA=;
        b=aYrprnP8iNGtE3j4m76QKqw1cgcwpzsTjr/DV5Spli1KvKBjMxZ3O+FOxIXGE4aly6
         ARiPkAPT53G633EiNKZB1M+dq9oNZQKp7vnR6nsod7pNTCKqbZnSspg2skpSSFUfKNHL
         A62rY6pCjQGeLxy3T0mD0zNg7ueQNDDq+6ti5jASxExe9fYNJQkfA0z3DX0nLTwbPpNF
         K7WHE5QIDJmcQNeOa7Szn5ZlW1JZagmEZIDybC/P76vh5F3TL9XunlF0hNo3mAKrqgXw
         2w4/e4Sk3izZ3mg29JUYU4L+4J96mWRPNK1fv6h30cXG7ElJIEKTg/FCFNyRvPSEOTgt
         AH0w==
X-Gm-Message-State: AAQBX9ffXDMC+lEzD1S2dEXQRkkklc8mBLpXZrjfoV9pewuT5Stx6hqS
        lJzumkqWxXjyGk8wZ4lUpNXCAZDcUSf5fAMIwm8vdjsqoWKVKSK9KlgNWA==
X-Google-Smtp-Source: AKy350ZO2A0FOMbC8bEDoIi3akCxCYzkZOKb5V5fFGTVRA1Ph0LxUn5AiKqvOhuR+ck4kmkvoUavdC4izpjmJJryCyM=
X-Received: by 2002:a25:d8d7:0:b0:b92:2c78:1481 with SMTP id
 p206-20020a25d8d7000000b00b922c781481mr5865812ybg.12.1681758259731; Mon, 17
 Apr 2023 12:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <202304171611545861530@zte.com.cn>
In-Reply-To: <202304171611545861530@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Apr 2023 12:04:08 -0700
Message-ID: <CAJuCfpFiW7z01FTC2q3hR+h=MhWLwKj96U+MF3s_FjX-9JEqfw@mail.gmail.com>
Subject: Re: [PATCH linux-next] sched/psi: avoid unnecessary resetting min
 update period when destroy trigger
To:     yang.yang29@zte.com.cn
Cc:     hannes@cmpxchg.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 1:12=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: Yang Yang <yang.yang19@zte.com.cn>
>
> Psi_group's poll_min_period is determined by the min window size of
> psi_trigger when creating new triggers. While destroying a psi_trigger,
> there is no need to reset poll_min_period if the destroying psi_trigger
> not had the min windows size, since in this condition poll_min_period
> will keep the same as before.

Nice optimization.

>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 02e011cabe91..12869585cf89 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1359,11 +1359,16 @@ void psi_trigger_destroy(struct psi_trigger *t)
>                 group->nr_triggers[t->state]--;
>                 if (!group->nr_triggers[t->state])
>                         group->poll_states &=3D ~(1 << t->state);
> -               /* reset min update period for the remaining triggers */
> -               list_for_each_entry(tmp, &group->triggers, node)
> -                       period =3D min(period, div_u64(tmp->win.size,
> -                                       UPDATES_PER_WINDOW));
> -               group->poll_min_period =3D period;
> +               /*
> +                * Reset min update period for the remaining triggers iff=
 the destroying
> +                * trigger had the min window size.
> +                */
> +               if (group->poll_min_period =3D=3D div_u64(t->win.size, UP=
DATES_PER_WINDOW)) {
> +                       list_for_each_entry(tmp, &group->triggers, node)
> +                               period =3D min(period, div_u64(tmp->win.s=
ize,
> +                                               UPDATES_PER_WINDOW));
> +                       group->poll_min_period =3D period;
> +               }
>                 /* Destroy poll_task when the last trigger is destroyed *=
/
>                 if (group->poll_states =3D=3D 0) {
>                         group->polling_until =3D 0;
> --
> 2.25.1
