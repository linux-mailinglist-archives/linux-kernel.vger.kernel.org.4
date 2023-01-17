Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7366D3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 02:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjAQBir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 20:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbjAQBi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 20:38:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03282887F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 17:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69136B810BD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04230C43392
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673919503;
        bh=6I6qWiZy6+VUHL/BjgqW5ooPHVYKqIo8pjsdpLzyhJM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uxp8WjQMOD1iV74W2WXYsEwNnKRGE0lhIviQY5FqQ7Mdw/vd5KD1zTKaC/MUyBbeD
         39N9VNrYjQh4awIY7UQpNiFPb03zjd+EQasCWKhTtKI5iMWQnx2ZVOzuccryhPs9tg
         oBOCUGok/coBej/8h+M8P/L+heGRslB68jIrvQgOdnvCZqOYuMI1AMQXgrgdO05LSQ
         3DMTvv6As2f1rFB8414m5OkdZ3ApipyrNzZyWrIU/lNgykeAaY97+hm9/0dsCvC9YL
         STEDKiZzkHOqBmFPtLlE4G4w59DEojLNKVkuqe6ylERUzozi0wFr3emkaNBpEa+GNp
         nt/ztCsuE5Rog==
Received: by mail-ej1-f48.google.com with SMTP id vm8so71898016ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 17:38:22 -0800 (PST)
X-Gm-Message-State: AFqh2kot3dBH7uz3kDX1wc8z+ZyYp/lYBqiXw5pIQS9m0gf4yphhMFNB
        uN5GH6RSLVkmLIdG+6Zg4ZzQK4Dkue3m6NMqNQg=
X-Google-Smtp-Source: AMrXdXsuy/+hu9YZJiwbj1ERS++KdqjNREl+w+fhFyyt/KJk1es4EKClr4/cdxR7/yu/s8nsvUMnoQ/MeClPnRlUkGk=
X-Received: by 2002:a17:906:a28a:b0:7c0:ff76:7866 with SMTP id
 i10-20020a170906a28a00b007c0ff767866mr58519ejz.272.1673919501199; Mon, 16 Jan
 2023 17:38:21 -0800 (PST)
MIME-Version: 1.0
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
 <1673255274-18238-2-git-send-email-tangyouling@loongson.cn>
 <6f1a1f3c-4569-c427-76ae-2f7093cb5e9f@loongson.cn> <CAAhV-H55Kj4gMnORHfQUYJ3KBueLv7j+ktkNP9cE-=32nEShzg@mail.gmail.com>
 <972e4d0c69dea4e9659eb9459072b2b7b2fd963b.camel@xry111.site>
In-Reply-To: <972e4d0c69dea4e9659eb9459072b2b7b2fd963b.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 17 Jan 2023 09:38:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7KpR3wKUYVR2mSfbCuwbONAmPwSB9oaLAE-4zGhx1r4g@mail.gmail.com>
Message-ID: <CAAhV-H7KpR3wKUYVR2mSfbCuwbONAmPwSB9oaLAE-4zGhx1r4g@mail.gmail.com>
Subject: Re: [PATCH 1/4] LoongArch: Use trampoline for exception handlers and
 kill la.abs
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 1:41 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Mon, 2023-01-16 at 09:30 +0800, Huacai Chen wrote:
> > On Sat, Jan 14, 2023 at 2:38 PM Jinyang He <hejinyang@loongson.cn>
> > wrote:
> > >
> > > Hi, Ruoyao and Youling,
> > >
> > > I care about the performance when NUMA enabled. We set CSR.EENTRY
> > > for each possible cpus where is NUMA-relative. So, I guess the more
> > > codes in NUMA-relative memory makes more performance. If we just set
> > > handler_trampoline as exception handler, the performance may be
> > > influenced.
> > So copying both the handlers and handler_trampoline can solve the
> > problem? If that is possible, please do that on top of the latest code
> > in
> > https://github.com/loongson/linux/commits/loongarch-next
>
> Hi folks,
>
> I just wrote the trampoline code as a PoC to show "relocatable kernel
> can work" and there must be some better way.  But I'm too sad to write
> any serious code in this month, and I don't have access to a LoongArch
> NUMA system.  So I think it's better to leave the job for you guys now
> :).
Hmm, I hope this series can be merged in 6.3. :)

Huacai
>
> Best regards
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
