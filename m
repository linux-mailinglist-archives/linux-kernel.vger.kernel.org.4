Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466E75EB75D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiI0CHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiI0CHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:07:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469A11458
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:07:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v2so10475306edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=djZjJ++BdboNZBu1adzoMI1VqVS9hW31+FcTORNEPRk=;
        b=MhXrprj+bLb1K769Slk+fGd4f9e9ryoN1WTb5ZM7zmoKyKth6m2M1GMnfKJNhdhhA0
         hVTKrXHu/8BSeD5o7eJVWpobB8LvCCRsLga5D5qTDvFc1kFJBewBExpeqlWaRVlqAEhy
         IDE8wo2zHUY6N9RvPiBi/oEgsS1CLfz7BUGobsSlY4yC+BNlgtzuj9oYB9TmUtmm81sc
         rLdSywjHKgAWrh+Gqj83TobS1W/XGhcGNoi/x6rU9pQx5pPuzyQG+tQZPTffK+x6yPBX
         kDp1+qtraf3ZAVUiMS+UCB6R3IoIfE6+HRJE0l9R4++6uou5iz8trJfwD8xMqOGujuEX
         1BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=djZjJ++BdboNZBu1adzoMI1VqVS9hW31+FcTORNEPRk=;
        b=MwD9a6xqJCxmC3itTkj7o1n9gVKPzUw7GYH/q4pFGFIRDptJM+RlL9jVnFjgdn8ZpA
         3h1P7oFzaJPTEbxsaALEWvLAKfLlu5ijJF5gQM1p6sOyd1omiIUWjdMvkqhdWEbvCU8Z
         7B6BPYm3koZBCOhTJ9BpUfswUfTxgr1AwZ7JFj/2rVa29LNYWuisv/haI9EfjYCOBEzZ
         8kiqfLoSbUJOBGku9x8dPTVQfX0e5fwiEkMgVw1Qdfh4rAG7K9qubp6Ewz8OHiJjYKDX
         Z7CUF037svwIdECniFlm17EXhjGEfkRnq5KYc06CeEtKb/Du86RPzGnqxBKeUHd56YMu
         ispg==
X-Gm-Message-State: ACrzQf3ETHkVc7onaggVkK8lm2N4GHVNMxAJRxMEVasMJ5uHAkzg2RuV
        B85bX+Aseq6r3MuEFybpS5UhsUhb0+wHiqvUYpE=
X-Google-Smtp-Source: AMsMyM7bci9oh2xXQh0hZlPDGXvMixpdyzRi7Sx8Fqy79gk5P7E0T2PLTdzlDZ/gs3vjaBvkhHdPD6FE8Za6uAXRJbg=
X-Received: by 2002:aa7:cb0b:0:b0:456:e744:79e5 with SMTP id
 s11-20020aa7cb0b000000b00456e74479e5mr16970482edt.191.1664244459016; Mon, 26
 Sep 2022 19:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220902155820.34755-1-liq3ea@163.com>
In-Reply-To: <20220902155820.34755-1-liq3ea@163.com>
From:   Li Qiang <liq3ea@gmail.com>
Date:   Tue, 27 Sep 2022 10:07:02 +0800
Message-ID: <CAKXe6SJQ6VtjkrernnyuUwT-UoA7+FFKhYA5AQdem-4CUDQVzA@mail.gmail.com>
Subject: Re: [PATCH] kprobe: reverse kp->flags when arm_kprobe failed
To:     Li Qiang <liq3ea@163.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

What's the status of this patch?

Li Qiang <liq3ea@163.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=883=E6=97=A5=E5=91=
=A8=E5=85=AD 00:00=E5=86=99=E9=81=93=EF=BC=9A
>
> In aggregate kprobe case, when arm_kprobe failed,
> we need set the kp->flags with KPROBE_FLAG_DISABLED again.
> If not, the 'kp' kprobe will been considered as enabled
> but it actually not enabled.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  kernel/kprobes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 08350e35a..333454df5 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2424,8 +2424,11 @@ int enable_kprobe(struct kprobe *kp)
>         if (!kprobes_all_disarmed && kprobe_disabled(p)) {
>                 p->flags &=3D ~KPROBE_FLAG_DISABLED;
>                 ret =3D arm_kprobe(p);
> -               if (ret)
> +               if (ret) {
>                         p->flags |=3D KPROBE_FLAG_DISABLED;
> +                       if (p !=3D kp)
> +                               kp->flags |=3D KPROBE_FLAG_DISABLED;
> +               }
>         }
>  out:
>         mutex_unlock(&kprobe_mutex);
> --
> 2.25.1
>
