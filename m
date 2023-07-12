Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95B8750A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGLODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjGLODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:03:01 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B41724
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:02:22 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4468a772490so611140137.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689170535; x=1691762535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=82i+lPDRUWjMYrDUjEV5+AxPod6jf9a4aDAMoiRBdJo=;
        b=oLPyUA/QSJ6HkFlqSKGglLJot4f3BsouqPSBf6K79Wi5dfZ4g8euE4FQb5CiVc8Iqu
         xX8AS2Rlu5M2XAPzP/G2lV0svghkR54WpzYQy8tBl5jfysKQS/8um5VDrP2450IZ3HpJ
         Ta8Dn2QaVXFfT+CzJPtiSDOUwH4OXYKgoAsOHeGh5QOIe4ZnhA1HBt+fjIHY/sAqTN+U
         GIP4D1mjimmO58z05EUIfEX2tklsgp2zlWd5aiREJEAVeQosVS3B8VJErELrL0+Vz1MN
         XMGil3dE28DvR8SZ0GY+KOCokybBA8gyTvmdPnGWEu9+IoSTSN9IfYO6rmyuBCxjQy5X
         IJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170535; x=1691762535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82i+lPDRUWjMYrDUjEV5+AxPod6jf9a4aDAMoiRBdJo=;
        b=QSUIjmpjxIpuKroz94hfEYzuikHV8jBRHgcAHU5KOSu34kKt3Vrog9awpFI409BcQz
         gl3LErDht1i8VqVfJINLzNB3jh62m2csLlOszVWBGV9tghT95a5ooTn/pTthU1IpxK6D
         c0endFAPiCMRIcaNsr0K6Na3iEdgj89vyo96bGbJnCHOrWjkpho2VpzYbcw92QybAr62
         doqf8omZkqWCzpno8ncN9u9Ha22Lg3SMW9keNNPghLFxTdktCUGI04Vwq2yIGzwF6zDj
         FTaK/46z4klMEeGcqgBHtznWrJc/W5/zzv5KEp0tHCwk/lOh2pzr1yTscITes0jzrZAO
         dcdA==
X-Gm-Message-State: ABy/qLaW80WuBnH6WLiI2hbQUC/360m/7JnvAv18xAq9pEoH2RpzuAx1
        +EvUWmKTTAcuvKBQKjAv+KN7yCTeOFN3QxOqElg=
X-Google-Smtp-Source: APBJJlGKGrQTxQ8L+nRZqWjmIgBUAsRS07RvqE6ygbahXIpiYmu/HAphJ2AJZccRepne96AUgYfgrYqFXXV9awIq2Gs=
X-Received: by 2002:a05:6102:106:b0:446:8f41:f02d with SMTP id
 z6-20020a056102010600b004468f41f02dmr1871485vsq.10.1689170535312; Wed, 12 Jul
 2023 07:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
 <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
 <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com> <ZKgJIlqZk8cw4MBa@casper.infradead.org>
 <CAOuPNLiOO_Pa=J_-0RhDBQ0auL0rgCjmpCZHtH3ngv6D1OhW6Q@mail.gmail.com>
 <ZKgctnmuVbLvYb9d@casper.infradead.org> <CAOuPNLjcBe7iEdJUhLS-kJuCc-uxXarh6o=JiTirGixq+tj+jg@mail.gmail.com>
 <ZKgfkhOMNT1xDjk+@casper.infradead.org> <CAOuPNLgwRugBZg7UB+jvW5Q1K2Bk2cJwz1svUP7XscLW18ttFg@mail.gmail.com>
 <CAOuPNLi9zcLF_mpjxUR6fOjQ0q0BGoauaofpptuFi+mkkxXSKQ@mail.gmail.com>
In-Reply-To: <CAOuPNLi9zcLF_mpjxUR6fOjQ0q0BGoauaofpptuFi+mkkxXSKQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 12 Jul 2023 19:32:04 +0530
Message-ID: <CAOuPNLin6sEp7_KpwzNnvMt-jrsCr2cy2d2aHnr8R7qHX3YLpw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 at 12:22, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Fri, 7 Jul 2023 at 20:03, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > On Fri, 7 Jul 2023 at 19:52, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jul 07, 2023 at 07:46:31PM +0530, Pintu Agarwal wrote:
> > > > On Fri, 7 Jul 2023 at 19:40, Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > One more question from here:
> > > > > > pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> > > > > >                 (void *)cma, cma->name, count, align);
> > > > > >
> > > > > > Do we really need this "cma %p" printing ?
> > > > > > I hardly check it and simply rely on name and count.
> > > > >
> > > > > Printing pointers is almost always a bad idea.  Printing the base_pfn
> > > > > might be a good idea to distinguish CMAs which happen to have the
> > > > > same name?
> > > > >
> > > > No there is no name there, it's just a ptrval
> > > > cma: cma_alloc(cma (ptrval), name: reserved, count 64, align 6)
> > >
> > > You misunderstand me.  I don't know how CMAs get their name.  Is it not
> > > possible for two CMAs to have the same name as each other?
> > >
> > Oh yah that is possible, for example multiple players can use the same
> > global cma region.
>
> Yes, I think it's a good idea to include base_pfn instead of printing pointers.
> Let's complete the cma->name inclusion first.
> Later I will check about base_pfn and push in another patch.
> Thanks

I hope we are good with printing cma->name here ?
