Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5646DD199
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjDKF1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKF1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5582118;
        Mon, 10 Apr 2023 22:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5758C62164;
        Tue, 11 Apr 2023 05:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4825C4339C;
        Tue, 11 Apr 2023 05:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681190831;
        bh=juqUx14jXbVE5rZmRH4YStnDhcyvxrgBYfHfpfe0lWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PyEf9r8GU2wQ5I1/7BESGnlE0cGcdfizAgrRccP3HrXIfNwMzMn8D0XNZztBSlco/
         kkG+VHqkHYfcanZ+EAe+wmQQeecVW2INKvDbHvB3oaxXPnuL2nO0sCjGUB9n6Netcx
         VtgwJVTKTk6t3oRAcFtkeYzx9bmRK52EZbLD6CEGFO86tSGODQ11BYvVqz6Mk/aoDV
         pd8F0xzaJfr1IBLSKPHbC6qQUig7sQGCi2GYaUvtdi2KR6DIVYcc8TWiYK2gMRgSXb
         CsKK/o/vAfBKn2xGRg1cHA7zZA34UQbJgpq6j174bjZIqpGa1o/Q7wJneLAYpFtle5
         HQs9ch6O7SuHg==
Received: by mail-lf1-f47.google.com with SMTP id c9so54582639lfb.1;
        Mon, 10 Apr 2023 22:27:11 -0700 (PDT)
X-Gm-Message-State: AAQBX9en0UO4iQnA3NV4YBhiwodIIS4UBpSJ2akW+nM4GfOxbdqnhwEE
        nUrG6+7GXTLAP0de4yT8tqt8u2fNNRle/uotc/U=
X-Google-Smtp-Source: AKy350YgSrZvppMXVsdXbh5e6Hr/IYimDt0egy9FTWdgODG27dkV7YTqIyp5qm46OM64qbqr4YwdjtX4otqgU9EBtqQ=
X-Received: by 2002:ac2:43dc:0:b0:4ec:7967:9e92 with SMTP id
 u28-20020ac243dc000000b004ec79679e92mr435204lfl.3.1681190829759; Mon, 10 Apr
 2023 22:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
 <20230410113559.1610455-2-yukuai1@huaweicloud.com> <CAPhsuW7rUQ9KFxCQw-iAAA64=x==b-Qu0nnp32TXn-85Okb00w@mail.gmail.com>
 <daa344fe-9d8d-16f9-aded-513f250928b9@huaweicloud.com>
In-Reply-To: <daa344fe-9d8d-16f9-aded-513f250928b9@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 10 Apr 2023 22:26:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7bBaVsneBHYqwN3yd5k3sg6ZUFqEJad3yOD0=N-e411g@mail.gmail.com>
Message-ID: <CAPhsuW7bBaVsneBHYqwN3yd5k3sg6ZUFqEJad3yOD0=N-e411g@mail.gmail.com>
Subject: Re: [PATCH -next v5 1/6] md: pass a md_thread pointer to md_register_thread()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 6:34=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/04/11 9:15, Song Liu =E5=86=99=E9=81=93:
> > On Mon, Apr 10, 2023 at 4:37=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Prepare to protect md_thread with rcu, there are no functional changes=
.
> >
> > Why do we need this change? To add __rcu later?
>
> Add __rcu is one reason, more importantly is to assign md_thread inside
> md_register_thread in patch 6:
>
> rcu_assign_pointer(*threadp, thread);

Got it.

> >
> > Can we do something like:
> >
> > struct md_thread __rcu *md_register_thread(void (*run) (struct md_threa=
d *),
> >                 struct mddev *mddev, const char *name)
>
> I think this is not necessary, if we don't want to change api, we must
> use rcu_assign_pointer for each caller to set md_thread.

I think it is better to use rcu_assign_pointer at the caller side.

Thanks,
Song
