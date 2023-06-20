Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9959973729C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjFTRSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjFTRSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29889E65;
        Tue, 20 Jun 2023 10:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59F56133F;
        Tue, 20 Jun 2023 17:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169EAC433CB;
        Tue, 20 Jun 2023 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687281483;
        bh=Xe49NstVNbQxwJ+wnptLy8rhubUuN1/2wGDj4qVwxbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GmKcM4R9nPynfVUeLwl46ZdmAmAXqyWWX4dM8qj4kK4JHzk+4jYCedVBAK/R7Kv1q
         gWqx3MK7Qzsn8mh8eXNm0l45y8O3h8jtdP15Y9XdfXniTsMXWxYc9tW3ACfDX4rZGH
         u+x2hFjby2cEiyDqT+sznhWMLk8Ugk6AypH5jR8XC1EN0MLv+16qYpKCm6qxeUcTWr
         7E2C6ZbAlhoGGAg9mvFxp/nixQTGVi/WaYnZ5R8smVQAeTi9Uot83zhoJbetXKJ/DN
         /4OOFVcxigmcLDeHR8aoYED4FyuMMdgt6AHJ71YWm0bBVFDFwxBceXDHZZKI/9VE8F
         exhypxX0hr7TA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so6652118e87.2;
        Tue, 20 Jun 2023 10:18:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDwRkaha0cUr6qDEcQFtjJhRXswuRhSb+hDBEicSvc+azs1MZZ8l
        BUxBGVvgVAQwvvNIdoTcTWYxaO7qF4KZ7p0xnrs=
X-Google-Smtp-Source: ACHHUZ6rvn8pdyE+U40fqAjk0Qv/U2Co0eHgq3xAfyqrNdxiTWVqMv+1EGg8UYsK+78kCPwuzJ9scotirx+WxrFsHd0=
X-Received: by 2002:a19:ab12:0:b0:4f8:cd67:88e6 with SMTP id
 u18-20020a19ab12000000b004f8cd6788e6mr1886971lfe.44.1687281481091; Tue, 20
 Jun 2023 10:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230618142520.14662-1-yukuai1@huaweicloud.com>
 <ac4c9d48-b8d2-b847-2721-11179fd922de@molgen.mpg.de> <4c729ee3-ad63-1928-0113-19b576b09b24@huaweicloud.com>
In-Reply-To: <4c729ee3-ad63-1928-0113-19b576b09b24@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 20 Jun 2023 10:17:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7=W4DRBOjeeJ5MSQR5ZWXZ6745FTd-Dj_qsP-KwxTUmQ@mail.gmail.com>
Message-ID: <CAPhsuW7=W4DRBOjeeJ5MSQR5ZWXZ6745FTd-Dj_qsP-KwxTUmQ@mail.gmail.com>
Subject: Re: [PATCH] raid10: avoid spin_lock from fastpath from raid10_unplug()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, aligrudi@gmail.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
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

On Mon, Jun 19, 2023 at 6:00=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/19 18:26, Paul Menzel =E5=86=99=E9=81=93:
> > Dear Yu,
> >
> >
> > Thank you for your patch. Some minor nits from my side, you can also
> > ignore.
> >
> > Am 18.06.23 um 16:25 schrieb Yu Kuai:
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Commit 0c0be98bbe67 ("md/raid10: prevent unnecessary calls to wake_up(=
)
> >> in fast path") missed one place, for example, while testing with:
> >
> > =E2=80=A6 one place. For example, with
> >
> >>
> >> fio -direct=3D1 -rw=3Dwrite/randwrite -iodepth=3D1 ...
> >>
> >> Then plug and unplug will be called for each io, then wake_up() from
> >
> > Maybe:
> >
> >      fio -direct=3D1 -rw=3Dwrite/randwrite -iodepth=3D1 ...
> >
> > plug und unplug are called for each io, then =E2=80=A6
> >
> >> raid10_unplug() will cause lock contention as well.
> >
> > Maybe paste the perf command and output?
>
> Related test and test result and perf result can be found in the below
> Link.

We don't need a lot of details of the test results in the commit log. But a
quick summary of the performance result can be really helpful here.
Something like: on array X, fio job Y, before the patch we got AAA, with
the patch, we got BBB.

Other than this, the patch looks good to me.

Thanks,
Song
