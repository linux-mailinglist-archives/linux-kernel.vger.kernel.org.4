Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E37700E27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbjELR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbjELR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:56:15 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CBC6E89
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:56:14 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so15249710276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683914174; x=1686506174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQww6Fi7QUJi5WxNtDxlfQ6yHhJmf2IufSD5ztVsVEY=;
        b=p0UtMgu0LIqMr71Nwp5NPRIREUO0EEHHW2NpNTuMKoj43YHmCrh6S/uFmBQgh7B17v
         0JGsNtyPNP2hJmZUymW9XD2yvxyakzIHtm5lh4Ee6nZVqYLpBkX97VN2v17feBWgHK0B
         FCU/9C54xzRFuWWV26No+PsYl4c8RehRgf8P+a5Jbh2REKlRD0MfQhF8J5jf+kg6p73L
         t6fVjU/bRAntDSjaI9hCUlXY2gzn1DSm3OT+PAVhqxMUZFlGzXLhmSltqprwuMLcqHiW
         BBBSpjUf3+1LQ6h3zUqp8+QAOOmSi57W/IPEw5rkFfCHIqBU6kic907q0CMhwQLFN4fM
         qyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683914174; x=1686506174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQww6Fi7QUJi5WxNtDxlfQ6yHhJmf2IufSD5ztVsVEY=;
        b=LWi+rKefUdqQo1Z0bQf7gsn7tzvsxQrX3n20BjcRk3japB/riYSZuW5bYcgCL7vFud
         Zc6anyMzp1bVolI1ans5rwovmijviJ1L4jwM9Kyy0DoKcbBLnGwiwCP0O5yk5Hm1eVPI
         oICRShGrTCSRmCdlNGpWQPkwaW2pUMTphko+DIfETpSqxZhXnUMh3rKQBa236YTh0773
         dTfO4jv4B60LEbXmcay1XlwZ2nOSufyAVItT4/35mUhEgvp2BK2zYzzi4WcfHqaJRyT/
         Rc/cliG4cp8dSzXq04C2HeO9VrrW81FjyggmnQrKdX+dxu7lSEvp5i9JDD/WkL2uq2DS
         EX2g==
X-Gm-Message-State: AC+VfDzlJLb/BbiHeWawwmx6LfsHpaOL0KywEHxUMx1vYqdnV6Runsat
        eJoKacdIG8RG/wbHn6I7TSXFrZAnkiYKHGJdnaD//A==
X-Google-Smtp-Source: ACHHUZ5JXU/WdCwcyg9XzMejryOZpz5zNYgNFU5onT4gzZKdapNSVzhnlGkV7+aye+7BKGJpXJieqFaZwrTxlrCyzJU=
X-Received: by 2002:a05:6902:1247:b0:b9d:b6cd:2dfb with SMTP id
 t7-20020a056902124700b00b9db6cd2dfbmr25660547ybu.21.1683914173646; Fri, 12
 May 2023 10:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <202305121642367753446@zte.com.cn>
In-Reply-To: <202305121642367753446@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 12 May 2023 10:56:02 -0700
Message-ID: <CAJuCfpEC67SBGFSCOD9TykwE_BR2ax5+T4XUKhq_U=qBJttMgw@mail.gmail.com>
Subject: Re: [RESEND PATCH linux-next] sched/psi: avoid resetting the min
 update period when it is unnecessary
To:     peterz@infradead.org, yang.yang29@zte.com.cn
Cc:     mingo@redhat.com, axboe@kernel.dk, tj@kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
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

On Fri, May 12, 2023 at 1:42=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Psi_group's poll_min_period is determined by the minimum window size of
> psi_trigger when creating new triggers. While destroying a psi_trigger, t=
here
> is no need to reset poll_min_period if the psi_trigger being destroyed di=
d not
> have the minimum window size, since in this condition poll_min_period wil=
l
> remain the same as before.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Acked-by: Suren Baghdasaryan <surenb@google.com>

Hi Peter,
This is another psi-related patch that slipped through the cracks.
Could you please take it into your tree? The original one [1] had a
different title but the same code.
Thanks,
Suren.

[1] https://lore.kernel.org/all/202304171611545861530@zte.com.cn/


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
