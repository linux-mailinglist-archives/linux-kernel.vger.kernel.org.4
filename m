Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC94D745887
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGCJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGCJhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:37:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7C91;
        Mon,  3 Jul 2023 02:37:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6a152a933so63844031fa.1;
        Mon, 03 Jul 2023 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688377024; x=1690969024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRKx7iLrXB3ROQpIdqwxxhbgMJLBow+B6szAcdx+g8A=;
        b=nhfQmJzn+VpcTHIpPBE7RABFB9J2PRzyzxmbkai6nHDbcEQPUvQH+0E2KoAnUG/WNU
         8zYDkOkx8LTEdDgOeITVI/luL/RCOLSf3BMcVR9ILoNoP0NOkFKlXzJPPlByW8tMw4jU
         EctJg+pEfLxaPwKnVKDY6fmOVZ21aBLpGQJ3P9n3sxquKf2KaMoeUbtxrMyque2i86Ra
         tKxiV5TU+g7P3fK81uL4wRxLCD00PoUEEhnQIDGZrN7sua/Ie5IWc/Xh8uwjXDCniliQ
         B1JKW3IKc49g+iap1lfW46t8ceW9jHzJlE4ICDjm5V9KKv6ycI102MAxNKRgY3tr0yg/
         F0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377024; x=1690969024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRKx7iLrXB3ROQpIdqwxxhbgMJLBow+B6szAcdx+g8A=;
        b=gYq5zcbp9YizpiGvlxn7Ks4FaqSphbrsX9RuNfoc/h2nEKikVZICFnc4obCcuodGxJ
         ZaMCWb7CGqh245/Nh2gtgJqyDFsAobs07isIMFD8b3vn/ozgFTqIhWiFDwEgNhAfQHbZ
         6k8e0OGN5W3S1sK0MRCHy0ayOcRK7K5yp+irWCGXkjnWuwZE5adnroK13+ryRzaTP/3i
         Y0RjOJLPdK5sceOjbMQQyAuT9wc6uvGIi95pFObDX0brHQAWixcZIljYbsxsDrO+Fm6B
         /4WZ3Y/wIZHenNHPBxYAzEZ+KFvGvzBWYac1mQbfXwmi3EBNKl1JrLJqXQitBvyLgIcT
         loFA==
X-Gm-Message-State: ABy/qLYBR/5pDEUAeY/PzRAOpYikDiX8HSGse1ao1J6eLoMKo0ISbaYT
        2PjFZJdtzQDi/Hvhe0eoZb21Rr7gXhnccjgDN5A=
X-Google-Smtp-Source: APBJJlGBgSgcfhj7O/Y4ie3sWmhpWIBgyJ71LVuywlAfzsbvrN4chAdYJgn6KIV67Wy162olLTkv3OWO1FW0hPCmfpE=
X-Received: by 2002:a2e:9f4e:0:b0:2b6:e618:b5a0 with SMTP id
 v14-20020a2e9f4e000000b002b6e618b5a0mr2058295ljk.6.1688377024117; Mon, 03 Jul
 2023 02:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <ZJQXdFxoBNUdutYx@FVFF77S0Q05N>
 <CA+G9fYtAutjL3KpZsQyJuk4WqS=Ydi2iyVb5jdecZ-SOuzKCmA@mail.gmail.com> <CANk7y0h+oXNhUzTFQ_Wy-iySRdBi0ezu1Y_hOBtAxmK5AG4dgA@mail.gmail.com>
In-Reply-To: <CANk7y0h+oXNhUzTFQ_Wy-iySRdBi0ezu1Y_hOBtAxmK5AG4dgA@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 3 Jul 2023 11:36:53 +0200
Message-ID: <CANk7y0gi4o+4U6c9QmnDCJDRXNM_98or_4tO-dHOEwZ4fj3gkw@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Mon, Jun 26, 2023 at 11:04=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> Hi Naresh,
>
> On Thu, Jun 22, 2023 at 2:35=E2=80=AFPM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Hi Mark,
> >
> > On Thu, 22 Jun 2023 at 15:12, Mark Rutland <mark.rutland@arm.com> wrote=
:
> > >
> > > On Wed, Jun 21, 2023 at 01:57:21PM +0100, Mark Rutland wrote:
> > > > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > > > Following boot warnings and crashes noticed on arm64 Rpi4 device =
running
> > > > > Linux next-20230621 kernel.
> > > > >
> > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > >
> > > > > boot log:
> > > > >
> > > > > [   22.331748] Kernel text patching generated an invalid instruct=
ion
> > > > > at 0xffff8000835d6580!
> > > > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1]=
 PREEMPT SMP
> > > >
> > > > This indicates execution of AARCH64_BREAK_FAULT.
> > > >
> > > > That could be from dodgy arguments to aarch64_insn_gen_*(), or else=
where, and
> > > > given this is in the networking code I suspect this'll be related t=
o BPF.
> > > >
> > > > Looking at next-20230621 I see commit:
> > > >
> > > >   49703aa2adfaff28 ("bpf, arm64: use bpf_jit_binary_pack_alloc")
> > > >
> > > > ... which changed the way BPF allocates memory, and has code that p=
ads memory
> > > > with a bunch of AARCH64_BREAK_FAULT, so it looks like that *might* =
be related.
> > >
> > > For the benefit of those just looknig at this thread, there has been =
some
> > > discussion in the original thread for this commit. Summary and links =
below.
> > >
> > > We identified a potential issue with missing cache maintenance:
> > >
> > >   https://lore.kernel.org/linux-arm-kernel/ZJMXqTffB22LSOkd@FVFF77S0Q=
05N/
> > >
> > > Puranjay verified that was causing the problem seen here:
> > >
> > >   https://lore.kernel.org/linux-arm-kernel/CANk7y0h5ucxmMz4K8sGx7qogF=
yx6PRxYxmFtwTRO7=3D0Y=3DB4ugw@mail.gmail.com/
> > >
> > > Alexei has dropped this commit for now:
> > >
> > >   https://lore.kernel.org/linux-arm-kernel/CAADnVQJqDOMABEx8JuU6r_Deh=
yf=3DSkDfRNChx1oNfqPoo7pSrw@mail.gmail.com/
> >
> > Thanks for the detailed information.
> > I am happy to test any proposed fix patches.
>
> I have sent the v4 of the patch series:
> https://lore.kernel.org/bpf/20230626085811.3192402-1-puranjay12@gmail.com=
/T/#t
> This works on my raspberry pi 4 setup. If possible can you test this
> on the similar setup where it was failing earlier?

I think my previous email was missed.
Can you test the V4 series in the same setup?
This is still not applied to the bpf-next tree.

Thanks,
Puranjay.
