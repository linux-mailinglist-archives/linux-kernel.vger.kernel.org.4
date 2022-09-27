Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE21D5ECA33
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiI0Q4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiI0Q4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:56:00 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B456B96
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:55:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a20so6392619qtw.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OsRxyvAnPbJINHsqDJOAOdVVGQpFFWbztg0hEari6CQ=;
        b=og5ZIfxp2QlBMoHAcPkqgBIihTOf1EBA+NkwUg9jRwG0/tUPbAFVNJ8HijT0/UM7oj
         dGvAplq21ZBx+uJOM960gKWAdgWHmxR5YYAjQZ3fsz79cArLc0GF6KOxFedjxrsMorV3
         e6dKQVDNzpkHTgDEVsrq6f+P5s82tah2xLH3Q/iaBfBJCVXI9CnnBxn6Z9gi88IghX8v
         ZgE6v/kKD8TxVlam6SimXoRg3eOQGyKzJpXjJQLxYWrppidMa7PgFKCGbO/gl6yqWC06
         z+7547nthM+plmehFPhFtL/3+le1XXZMJoiLAGYnUVMu6Tx/PIf4dL1sVyW2r+DF7vs+
         ugag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OsRxyvAnPbJINHsqDJOAOdVVGQpFFWbztg0hEari6CQ=;
        b=dKOES1nIH8d0jX1kyQ684WPogBTHjtDh3JyzOUmj/iyeqwRNQH8psvC5069SCD+Zpy
         t30Rq2Nr4M9HD8gtxd9dlQyTCeB7vpJS8ixMO6a6MDB2NcAC4qmaCjVYbmEi035WmzJ4
         xEtPTXZ16cJbpTPvcwDDC4vu2s0Xx2ikyKC2h6AoBx71e4yZ+M9dZBbZiArQnll32A/t
         e4VO9kQSL4qEApuEcdtlEjfFaI8Xf2sO1cWmwuYx3gNfrEujldvuXn9sOwbX7ufgs78g
         LEcYjZSDnzxTLnoBpOT5e6HkRlC04jcEyQbWh5KxUu8uRVPtfltuCOv6Tef8tyUgrkIy
         go0A==
X-Gm-Message-State: ACrzQf226qWrnIockTMXcmDs06oM46XqAdm8jS6GD+qdqZnaj7r4ryQO
        VeT5xHeVTvL2d/9VR/NdOebFI2Q7Fk6B0YQYVvw=
X-Google-Smtp-Source: AMsMyM7hA8Exhfh3CZ2FJoEA7sAvQ9GkqDI0HE773roPJBf+1BZhZKoIkla5cTytXnL1fL8lzDrwPloJ89IImeJKeGA=
X-Received: by 2002:a05:622a:180d:b0:35b:d283:7e65 with SMTP id
 t13-20020a05622a180d00b0035bd2837e65mr23378318qtc.106.1664297733975; Tue, 27
 Sep 2022 09:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004387dc05e5888ae5@google.com> <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
 <YxdJ684ypgAy8k98@arm.com> <CACT4Y+YOnTpWT5NCNhsPY=kV=2gFfQkY=7xGdU_1k7AdGhQneg@mail.gmail.com>
 <YxdZXvsWr37RrFRk@arm.com> <CA+fCnZf-GOZpnBRLkRPrL7FUwYrAb-bu=PV0zMfbKOuNYrZ00A@mail.gmail.com>
 <Yxd0C7ndn+iPAGcj@arm.com>
In-Reply-To: <Yxd0C7ndn+iPAGcj@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 27 Sep 2022 18:55:23 +0200
Message-ID: <CA+fCnZcpba7qinx4DmuJPjRQj07uJ5H9Xq9Zhi8v1rw-AW_yWQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: invalid-access Read in copy_page
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tongtiangen@huawei.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        syzbot <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 6:23 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Sep 06, 2022 at 04:39:57PM +0200, Andrey Konovalov wrote:
> > On Tue, Sep 6, 2022 at 4:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > Does it take long to reproduce this kasan warning?
> > > >
> > > > syzbot finds several such cases every day (200 crashes for the past 35 days):
> > > > https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
> > > > So once it reaches the tested tree, we should have an answer within a day.
> >
> > To be specific, this syzkaller instance fuzzes the mainline, so the
> > patch with the WARN_ON needs to end up there.
> >
> > If this is unacceptable, perhaps, we could switch the MTE syzkaller
> > instance to the arm64 testing tree.
>
> It needs some more digging first. My first guess was that a PROT_MTE
> page was mapped into the user address space and the task repainted it
> but I don't think that's the case.

Hi Catalin,

syzkaller still keeps hitting this issue and I was wondering if you
have any ideas of what could be wrong here?

> Since I can't find the kernel boot log for these runs, is there any kind
> of swap enabled? I'm trying to narrow down where the problem may be.

I don't think there is.

Thanks!
