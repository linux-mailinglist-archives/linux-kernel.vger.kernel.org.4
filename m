Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF86079CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJUOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJUOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:41:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086583AE5B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 987C561E9B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018BEC43470
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666363306;
        bh=ropLClIeHzFRkVhJYXOsh1KnHR2hkSkJ7NM6ho2IP+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kN8e2I0x6jmgx9kop7mSITV8Rqm4QU+8c0Be7/Bb/5PC5JQ6zoN1hL/hIAOSqU4o1
         GSAAHt9qf0c9TVi6ksvMUh5ki00dahMuKNSmlO/bDY+0IErGYa3jPBmdPi0xT1D8sz
         0a002Vdep6v2Nl89ppHI3kiqyI9CW8iGERxdB4bJxQUp9ZUzunzGt04Inx8Fh57afD
         pXzsN1NSaSEDNxiWQcO2T8k2WvRDdyh3LWbG4HgO3RUlWwl4O09NzTLUkvM2REZTON
         UEEFZQg6GV7jzAXat4R3OinHjqQwKwTpQPMc4gqsinKcnavd/WlwQlS66K+KLEhsaJ
         FMqXcYT/zl6SQ==
Received: by mail-oi1-f180.google.com with SMTP id n130so3437789oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:41:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf20zNWeVyRnUYPNhsm+fq8AMFk+QEeC0WRXHj5AMbm8sMovy1K6
        D8RDmRWe+sUNw7kup2Z5cLnZqeD8GPAYVmrk3kM=
X-Google-Smtp-Source: AMsMyM6vmu+6l7PBPl70AuuJwzmJIjFT3lQyrGPa9CZ9CzkdkiEtFZNRG79H8ghNVYAPWvYYCNoj1G0z2mZ1h+SqLr4=
X-Received: by 2002:a05:6808:2222:b0:354:9c65:79ed with SMTP id
 bd34-20020a056808222200b003549c6579edmr23550708oib.19.1666363305134; Fri, 21
 Oct 2022 07:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221019154727.2395-1-jszhang@kernel.org> <Y1HZFcBo21SQzXVj@andrea>
 <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com>
 <Y1JaE/ot91Z0KXuC@andrea> <ed7c4027-8e15-245f-cdda-0551063761e7@huawei.com>
 <Y1KdKATQx16Xl/iL@andrea> <f1eb4756-e1e1-1f12-e767-a69a891786d6@huawei.com>
In-Reply-To: <f1eb4756-e1e1-1f12-e767-a69a891786d6@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Oct 2022 22:41:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRdtcpccL5W48O8VEXCMvxNAyyrKJzhwNJkc8js+H2iJg@mail.gmail.com>
Message-ID: <CAJF2gTRdtcpccL5W48O8VEXCMvxNAyyrKJzhwNJkc8js+H2iJg@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 9:46 PM Tong Tiangen <tongtiangen@huawei.com> wrote=
:
>
>
>
> =E5=9C=A8 2022/10/21 21:22, Andrea Parri =E5=86=99=E9=81=93:
> > Hi Tong,
> >
> >>>> I use atomic_set_release here, because I need earlier memory
> >>>> operations finished to make sure the sp is ready then set the spin
> >>>> flag.
> >
> >>      Consider this implementation:)
> >>
> >>      smp_store_mb(&spin_shadow_stack, 0);
> >
> > smp_store_mb() has "WRITE_ONCE(); smp_mb()" semantics; so it doesn't
> > guarantee that the store to spin_shadow_stack is ordered after program
> > -order earlier memory accesses.
> >
> >    Andrea
> > .
>
> Hi Andrea:
>
> IIUC, the earlier memory access amoswap.aqrl, here .aqrl guarantee it.
> But anyway, consider we don't care about performance here, using
> smp_store_release()(add barrier()) surely right.
We use smp_store_release() is for:
        //load per-cpu overflow stack
        REG_L sp, -8(sp)

Not amoswap.

Actually, amoswap.aqrl guarantees nothing because all instructions
depend on the sp register.

>
> Thanks,
> Tong.



--=20
Best Regards
 Guo Ren
