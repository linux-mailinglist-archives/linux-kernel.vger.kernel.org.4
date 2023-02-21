Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7E69E12C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjBUNRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjBUNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:17:46 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7E298E1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:17:43 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id bh1so4977539plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wCFm0158ECAxcPIidxo91DV7xoYEzGpd/NMh2B76AU=;
        b=kwC0p8H18TiTw3HFhx2LbNYjLHWBvqNnQ3HREs8VySE8CSM9T2IaWlR+biiSbdqLQr
         CP60k7ngh7t+ggbbQ2sBpewvW/0u4DDzVp8yc5C7eLdDUaElZ/W4MODugpMyszou4GkR
         BKcczHbCJ16hPoX8NAYLcC6dCTJqfR6r2V3DYPsQnzdyDyJgqrVRLLfH47Gnqr3lDxCD
         xe25Z34x2h7IRgso/aVU61MaaifU0gbCQrWcmrSz6eZkO/Uwc6D8MP+KsJAc3MVzW4iU
         JQP56E+i9XkmGJrHtyVuhiELRpqlEEg0iIw5eIOPP1ZhMGkng6PDWParWCp1AHToO9c9
         7eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wCFm0158ECAxcPIidxo91DV7xoYEzGpd/NMh2B76AU=;
        b=C81Xuo+R6rN/jsdLrfR5pYBwxTQZJd8Qc8iyDNnlmw9p94FmGU8F8zj6hjBZd7p3Pj
         jGcXo7cZL05SeJJ1HhgHT5cNZ1jVQEkeUB53Rc4OE9vX6Z3zZ6CQlEktLpBt4HGAjjK8
         Zd3zTZQBV0kS5R1NuMJoVuluUJUhtcvg0IXLBG9ejV5aK8ESreCI5kLc5CaCEAE6zikP
         mAVdI8k5GgAEEc609s6ygfX5KJCYifetoBd+MF4Ke39VKTPZPG9rhlxdMzxcOp3LBN7F
         FuJE5AdVGPxEYd9FTLXg7f/FoKtzr8ZzEAISq7o+qvJOFrt46xy1Qzgr0Cf3Yl78SDbE
         RX0g==
X-Gm-Message-State: AO0yUKXyW2C4KaJ1IHc1Qy0R8ewQiT+/mwIQHRPW+Xuq6BqE4qAomsqg
        DnDWMWAHDcOIh5Z7jpo+NANERC/4IpM=
X-Google-Smtp-Source: AK7set8GvC47krzhVsBrpAUh7JvCuGNaGUFopvv4iezHG0nVTLTL8BkIeemRMMQEYBUwkEEG11xKGw==
X-Received: by 2002:a17:902:eccc:b0:19a:74c7:dcda with SMTP id a12-20020a170902eccc00b0019a74c7dcdamr6943342plh.15.1676985462533;
        Tue, 21 Feb 2023 05:17:42 -0800 (PST)
Received: from debian.me (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b0019aafc42328sm5061979plc.153.2023.02.21.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 05:17:41 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 455C71041A9; Tue, 21 Feb 2023 20:17:38 +0700 (WIB)
Date:   Tue, 21 Feb 2023 20:17:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     JaeJoon Jung <rgbi3307@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched/core.c: Modified prio_less().
Message-ID: <Y/TEcdIDqGjwH+2f@debian.me>
References: <CAHOvCC7yjceArav9Ps0v1EP4CjfkrxbfXFgABK54cdFKNoE8iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SfxW5uCGJuvZeCUQ"
Content-Disposition: inline
In-Reply-To: <CAHOvCC7yjceArav9Ps0v1EP4CjfkrxbfXFgABK54cdFKNoE8iw@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SfxW5uCGJuvZeCUQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 05:24:27PM +0900, JaeJoon Jung wrote:
> The sched_class structure is defined to be sorted by pointer size.
> You can see it in the macro definition like this:
>=20
> kernel/sched/sched.h
> #define DEFINE_SCHED_CLASS(name)
> const struct sched_class name##_sched_class \
>         __aligned(__alignof__(struct sched_class)) \
>         __section("__" #name "_sched_class")
>=20
> include/asm-generic/vmlinux.lds.h
> #define SCHED_DATA \
> STRUCT_ALIGN(); \
> __sched_class_highest =3D .; \
> *(__stop_sched_class) \
> *(__dl_sched_class) \
> *(__rt_sched_class) \
> *(__fair_sched_class) \
> *(__idle_sched_class) \
> __sched_class_lowest =3D .;
>=20
> And in the System.map file,
> you can see that they are arranged in memory address order.
>=20
> System.map
> ----------------------------------------------------------------
> ffffffff8260d520 R __sched_class_highest
> ffffffff8260d520 R stop_sched_class
> ffffffff8260d5f0 R dl_sched_class
> ffffffff8260d6c0 R rt_sched_class
> ffffffff8260d790 R fair_sched_class
> ffffffff8260d860 R idle_sched_class
> ffffffff8260d930 R __sched_class_lowest
> ----------------------------------------------------------------
>=20
> This matches the sched class priority.
> In the prio_less() function in kernel/sched/core.c,
> the less value can be determined by pointer operation as follows.
>=20
> If the prio_less() function is modified as follows,
> the __task_prio() function is not required.

By what?

>=20
> Thanks,
>=20
>=20
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> ---
>  kernel/sched/core.c | 42 +++++++++++-------------------------------
>  1 file changed, 11 insertions(+), 31 deletions(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2a4918a1faa9..75075d92a198 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -151,21 +151,6 @@ __read_mostly int scheduler_running;
>=20
>  DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
>=20
> -/* kernel prio, less is more */
> -static inline int __task_prio(struct task_struct *p)
> -{
> - if (p->sched_class =3D=3D &stop_sched_class) /* trumps deadline */
> - return -2;
> -
> - if (rt_prio(p->prio)) /* includes deadline */
> - return p->prio; /* [-1, 99] */
> -
> - if (p->sched_class =3D=3D &idle_sched_class)
> - return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
> -
> - return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
> -}
> -
>  /*
>   * l(a,b)
>   * le(a,b) :=3D !l(b,a)
> @@ -176,22 +161,17 @@ static inline int __task_prio(struct task_struct *p)
>  /* real prio, less is less */
>  static inline bool prio_less(struct task_struct *a, struct
> task_struct *b, bool in_fi)
>  {
> -
> - int pa =3D __task_prio(a), pb =3D __task_prio(b);
> -
> - if (-pa < -pb)
> - return true;
> -
> - if (-pb < -pa)
> - return false;
> -
> - if (pa =3D=3D -1) /* dl_prio() doesn't work because of stop_class above=
 */
> - return !dl_time_before(a->dl.deadline, b->dl.deadline);
> -
> - if (pa =3D=3D MAX_RT_PRIO + MAX_NICE) /* fair */
> - return cfs_prio_less(a, b, in_fi);
> -
> - return false;
> +        int less =3D a->sched_class - b->sched_class;
> +        if (less =3D=3D 0) {
> +                if (a->sched_class =3D=3D &dl_sched_class)
> +                        return !dl_time_before(a->dl.deadline, b->dl.dea=
dline);
> +
> +                else if (a->sched_class =3D=3D &fair_sched_class)
> +                        return cfs_prio_less(a, b, in_fi);
> +                else
> +                        return false;
> +        } else
> +                return (less > 0) ? true : false;
>  }

I smell indentation-corrupted patch here. Please use git-send-email(1)
to submit patches.

For the patch subject, I can't imagine what are you doing since you
wrote too generic subject ("Modified foo") without clearly describe in
the patch description what are you doing. How can maintainers accept
your patch if you don't take care of how to describe it?

Last but not least, don't top-post when replying; reply inline with
appropriate context instead.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--SfxW5uCGJuvZeCUQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/TEZgAKCRD2uYlJVVFO
o+fMAQC/3ATWN+WOiUcimMtb4VihrQnzFFGr8HM4t/JWWdoIUAD+PWSGWRpCYFrO
XF9AxUgDjMBO1eNWyY18ls4pLDYE5AM=
=LKrR
-----END PGP SIGNATURE-----

--SfxW5uCGJuvZeCUQ--
