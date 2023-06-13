Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42D72E339
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbjFMMlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjFMMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B910E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686660025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHc7vP5zkhrUmujQoTt/giRPp5gmSgomrWcTeulO5hY=;
        b=A59kENLO/RTqarF1OmD4BDoQHX+rNpW90bCDtaB35C6i0iOIC5wSc9qAj7CA7aoouTKBfg
        vK6Ze0wmWPdmi92NIyTJ/Y5mpDETlElesdAMIPkrPdiBhbK67c5lJrC9cBcqdYYUx4F9fQ
        p8D/4kEmDoamcy10QF9F/uYDydPTUxo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-99RU4DhDOAGqHwPxLXJ64g-1; Tue, 13 Jun 2023 08:40:22 -0400
X-MC-Unique: 99RU4DhDOAGqHwPxLXJ64g-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b3b39e1468so15740515ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686660022; x=1689252022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHc7vP5zkhrUmujQoTt/giRPp5gmSgomrWcTeulO5hY=;
        b=Fau3Ve7N3yILdI6vKVcUfuXVhcVQw8iU38227mdu9leEwQ0ZkDtCmjZs+0QjcYoN21
         1qBI1KeHvccHLJUuE/OCJa4ZKdV1W2daLd1iMk6h5zkonRy5UQh8C3nALr4ZJ6sCriYG
         LEvGMly0PV2D5E3lfGS0kwCOqf/3G5AWNWRRqopKEq6G5j6tYqY2YDpEuVOSntAsfJyd
         dSoKuNzcNcorNAYE2f9KrpFOBpCGF7SvcmLFZ+YiMcwPV7iWoGz26fI6Za6oeeK9A+PI
         jl3/nT0v2l6f1mLiGSnZMdKfbK7TgMjhtrG4hFm4wR4hnrLuqm5u0AylLXflBu/mAYka
         5g/A==
X-Gm-Message-State: AC+VfDx46vFQ9uSgixMpEcaM8pF80sckYCGLwBMwvNhzKxRITb4oS48w
        KBV3/YZIt9jyc+futtDGaHwpGb+3CAxaUSkR+6Qq0SQ4rR9qKZAtnRNivgp/2XeW1KKglKlaecg
        jE4D5QPbQ+iheULiDFM2Flx+xW8iBWHwb6bBY5ugu
X-Received: by 2002:a17:902:f691:b0:1b1:93f9:4305 with SMTP id l17-20020a170902f69100b001b193f94305mr10848630plg.60.1686660021770;
        Tue, 13 Jun 2023 05:40:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Hp1AV+so40D6vobjase0i58jonjTTpJ10KQsC/eF3MECIIlrw38vj43vTRuKgo54y4DUsr0dFY21F9FS4bcQ=
X-Received: by 2002:a17:902:f691:b0:1b1:93f9:4305 with SMTP id
 l17-20020a170902f69100b001b193f94305mr10848604plg.60.1686660021441; Tue, 13
 Jun 2023 05:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230613030637.2934730-1-islituo@gmail.com>
In-Reply-To: <20230613030637.2934730-1-islituo@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 13 Jun 2023 14:40:08 +0200
Message-ID: <CAHc6FU5NdUpYRhu7NR=LDLtX6CKbXvtaM6MJbkaHAZb0Y5Eh2Q@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix possible data races in gfs2_show_options()
To:     Tuo Li <islituo@gmail.com>
Cc:     rpeterso@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        BassCheck <bass@buaa.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 5:07=E2=80=AFAM Tuo Li <islituo@gmail.com> wrote:
> Some fields such as gt_logd_secs of the struct gfs2_tune are accessed
> without holding the lock gt_spin in gfs2_show_options():
>
>   val =3D sdp->sd_tune.gt_logd_secs;
>   if (val !=3D 30)
>     seq_printf(s, ",commit=3D%d", val);
>
> And thus can cause data races when gfs2_show_options() and other function=
s
> such as gfs2_reconfigure() are concurrently executed:
>
>   spin_lock(&gt->gt_spin);
>   gt->gt_logd_secs =3D newargs->ar_commit;
>
> To fix these possible data races, the lock sdp->sd_tune.gt_spin is
> acquired before accessing the fields of gfs2_tune and released after thes=
e
> accesses.
>
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  fs/gfs2/super.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index a84bf6444bba..671adf38fe03 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1059,6 +1059,7 @@ static int gfs2_show_options(struct seq_file *s, st=
ruct dentry *root)
>         }
>         if (args->ar_discard)
>                 seq_puts(s, ",discard");
> +       spin_lock(&sdp->sd_tune.gt_spin);
>         val =3D sdp->sd_tune.gt_logd_secs;
>         if (val !=3D 30)
>                 seq_printf(s, ",commit=3D%d", val);
> @@ -1070,6 +1071,7 @@ static int gfs2_show_options(struct seq_file *s, st=
ruct dentry *root)
>         val =3D sdp->sd_tune.gt_quota_quantum;
>         if (val !=3D 60)
>                 seq_printf(s, ",quota_quantum=3D%d", val);
> +       spin_unlock(&sdp->sd_tune.gt_spin);
>         if (args->ar_statfs_percent)
>                 seq_printf(s, ",statfs_percent=3D%d", args->ar_statfs_per=
cent);
>         if (args->ar_errors !=3D GFS2_ERRORS_DEFAULT) {
> --
> 2.34.1
>

Added to for-next (with minor adjustments).

Thanks,
Andreas

