Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73683744566
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjF3XyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3XyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E52210FD;
        Fri, 30 Jun 2023 16:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D0A261827;
        Fri, 30 Jun 2023 23:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3E2C433D9;
        Fri, 30 Jun 2023 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688169251;
        bh=xrwVcDX9L8eaALUgbs0aVbqWRPeL0HRDNOPHzI3NtJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e8EnqAWnIfGF7QiwyMVM6qJReJfRyU6ewN3eTcdAHwax9nkZQsbhpBlAYtcJHppxL
         XPMY8vw8FBkOMXhFqnHUXONrBXyx0HAsGWMoWlB67nqfjzr89snFTMPh7+RCU/IFKt
         PJ2p+kXu1VzvUQaccfIBoN/4ZGAvN+fzJTNfR/6CO3SPqJJU6J15FVyxUnOB19M3xv
         oQc4+ox3Xxk8HwNC6QT/XAlis9lmGtjKGRUPE1anpsbGsrP4/VjIquMcTqXXmFOE+6
         WNRIclzCE0cwfg35z8MEJpab9ZMtAx/Rq0gh1IwZ8KvCvgOYn4EnAZm8lj1Ic+n1TF
         4dJNCjYntvqqA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f766777605so3974749e87.1;
        Fri, 30 Jun 2023 16:54:11 -0700 (PDT)
X-Gm-Message-State: ABy/qLZvI+IL8tPzzSHwTuydd+OMpwy1pO0S53r9yEJ8DZbhMGVWRgY3
        Vmc2DvuvEfQVsHBOEDyb2ViNZ87vZtmpKhYpDxQ=
X-Google-Smtp-Source: APBJJlELO/cVYQ/uUHhzfJvlB8i+wRjpwUllMRk9u63KBo/HrYQwuMvvlsAd5fQGuMN2JK6pLedxn535VxgvEjI1jtU=
X-Received: by 2002:a05:6512:158b:b0:4f8:69f8:47a0 with SMTP id
 bp11-20020a056512158b00b004f869f847a0mr3936260lfb.29.1688169249599; Fri, 30
 Jun 2023 16:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230628015752.102267-1-linan666@huaweicloud.com> <20230628015752.102267-3-linan666@huaweicloud.com>
In-Reply-To: <20230628015752.102267-3-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 30 Jun 2023 16:53:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ySGEQtSHg0jxvRRDQWumF7DsVF8fro6MYCc_bY6Ssew@mail.gmail.com>
Message-ID: <CAPhsuW7ySGEQtSHg0jxvRRDQWumF7DsVF8fro6MYCc_bY6Ssew@mail.gmail.com>
Subject: Re: [PATCH 2/3] md/raid10: factor out get_rdev_repl_from_mirror()
To:     linan666@huaweicloud.com
Cc:     guoqing.jiang@cloud.ionos.com, colyli@suse.de, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 6:58=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
[...]

>
> +static void get_rdev_repl_from_mirror(struct raid10_info *mirror,
> +                                struct md_rdev **prdev,
> +                                struct md_rdev **prrdev)
> +{
> +       struct md_rdev *rdev, *rrdev;
> +
> +       rrdev =3D rcu_dereference(mirror->replacement);
> +       /*
> +        * Read replacement first to prevent reading both rdev and
> +        * replacement as NULL during replacement replace rdev.
> +        */
> +       smp_mb();
> +       rdev =3D rcu_dereference(mirror->rdev);
> +       if (rdev =3D=3D rrdev)
> +               rrdev =3D NULL;
> +
> +       *prrdev =3D rrdev;
> +       *prdev =3D rdev;

I don't think the reduction in duplicated code justifies two output argumen=
ts.

How about

static struct md_rdev *dereference_rdev_and_rrdev(struct raid10_info *mirro=
r,
                               struct md_rdev **prrdev)
{
    ...
    *prrdev =3D xxx;
    return rdev;
}

So we only have one argument for output.

Also, "from_mirror" in the function name doesn't really add more value.

Thanks,
Song
