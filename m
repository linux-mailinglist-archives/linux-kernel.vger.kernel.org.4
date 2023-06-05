Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B189C721DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFEGO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE7D3;
        Sun,  4 Jun 2023 23:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1515D61E5A;
        Mon,  5 Jun 2023 06:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71112C4339B;
        Mon,  5 Jun 2023 06:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685945664;
        bh=d0OhcA2rGOdVDKF2rdDgoapcxyC5qb5qQKl0LgpKoUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RV6tka3UG68hUKl8fxv256hzzD4UL5GOvvVkIWlPMNibuKKThHKdoTAVVVHQPr8Zj
         w77givxyoUmeAUw5pgJt6kJb5mE6cEbmtqp7lYkSnc8m6tOYKv0i0LcOY9uhlC8L4l
         cI2cdQJTlBKUgtwScm5nDVd8qZiQblZmN2S2YKIuV0I5TKV1aiYYvlULUc32mvHNtR
         Bljo3yepKArbpRwTHyvUdrbZiIGF7cbEdvg0dSA9vrMN1/M3yHsSOPBjTcpwMBSJ3O
         UIJEKYisxX7VOC0o+S0gIRGwb3iB79bgqYQrEXFXSYErUvQxq9Bi2nMulTdY99M2YC
         moksMd2FAYDBg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-55564892accso3057024eaf.2;
        Sun, 04 Jun 2023 23:14:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDy8cuI5/hxJCTjuzHDhlrW31i0BWLqZ+JItjQwR0rwwqqC/lP9e
        bKfeB5sS6DK8Mj/rDWyOV5Us2duyToUVm2O3nSQ=
X-Google-Smtp-Source: ACHHUZ5W/0BNLagax1j39qocfPmY+tRCTc7v+RQmA3oSK1975CHAeEttcz7BxvRw3cGdkfKJVICIf5DrsQ+KogFqkSY=
X-Received: by 2002:a4a:ca05:0:b0:558:c5b8:9575 with SMTP id
 w5-20020a4aca05000000b00558c5b89575mr1812805ooq.1.1685945663785; Sun, 04 Jun
 2023 23:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230603165949.1753326-1-masahiroy@kernel.org> <CAMGffEk-_dGmciH7ggsATVAHyCwLemkR_UX4ikRJmuC7w1ePrg@mail.gmail.com>
In-Reply-To: <CAMGffEk-_dGmciH7ggsATVAHyCwLemkR_UX4ikRJmuC7w1ePrg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 5 Jun 2023 15:13:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATopDDvV+aVsa_qc6FCkT9v6mRQcABnrKMdW4oMkQfd1g@mail.gmail.com>
Message-ID: <CAK7LNATopDDvV+aVsa_qc6FCkT9v6mRQcABnrKMdW4oMkQfd1g@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: fix mixed module-builtin object
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 1:47=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> wr=
ote:
>
> Hi Masahiro,
>
>
> On Sat, Jun 3, 2023 at 6:59=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > With CONFIG_BLK_DEV_RNBD_CLIENT=3Dm and CONFIG_BLK_DEV_RNBD_SERVER=3Dy
> > (or vice versa), rnbd-common.o is linked to a module and also to
> > vmlinux even though CFLAGS are different between builtins and modules.
> >
> > This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
> > Fixing mixed module-builtin objects").
> >
> > Turn rnbd_access_mode_str() into an inline function.
> Thx for you fix, but Guoqing has a slightly different patch in the queue:
>
> https://lore.kernel.org/linux-block/CAMGffEnDjAP3zqytmsYxacvUROLKZj+KhH6L=
OXicOoPhS9FJJQ@mail.gmail.com/
>

LGTM. Thank you.



--=20
Best Regards
Masahiro Yamada
