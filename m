Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B645471FE3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjFBJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjFBJuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC051C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 836E46498A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5853C4339C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685699406;
        bh=ml+OtQ6gScit3HvDHenHLPajGbsiR/AkLIHrw7hr7tA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HRwISgR/mFFyIga3EdpZvGkg3jSA0uOWkufKHH7A3UNc99l2fchlSeJnk883ahqbn
         jT8a27uYSGk1NxKGjbykDIguak61lTALWGQBItSGyguA9cp33hpvlTWrUoGKcFvO7q
         Y4RA8Swc+TSyev03IKPhTl/tCJu/EdAEb8Rg2kqYoVNK5vXRTO9o78iuVurU9g04ax
         9IxMNzDdmZn7HYB6E1UuEoLMZYOjQL4KeN44q/spK2vTSsX1EEFKfJP0thPq/d5GDr
         3uwZ4qKJe9y8KBUDZo220vmimSWVCBv/IrH3At7wKrNsvKSOylOiTDsmsO47wfjJfr
         HeRG2lwupG2Qw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b1ac373c9eso6621511fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:50:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDx52qbnwc9ef7a5QyumV02APU2SHK3G/Zfnqz+GQovhP2WYF9iW
        lMF/6Jx19bchQzZCOFyKJqFGoEO9itqu2aBpJc8=
X-Google-Smtp-Source: ACHHUZ7glhe0f52XYxjB5lz/ekUDyMjbJIr8UzeMHEk+AbSm14q/Xto4kYaKeA29PFIuLgT+5+lORhOvbxTMn1/WfM0=
X-Received: by 2002:a2e:8e8a:0:b0:2ad:bedc:995b with SMTP id
 z10-20020a2e8e8a000000b002adbedc995bmr1431723ljk.16.1685699404991; Fri, 02
 Jun 2023 02:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
 <20210529034138.83384-2-wangkefeng.wang@huawei.com> <20210601143125.GB30436@shell.armlinux.org.uk>
In-Reply-To: <20210601143125.GB30436@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Jun 2023 11:49:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF9crOKFaGfzcj9T4n58XAr7n85YZO0x7J1DcRG2JrfcQ@mail.gmail.com>
Message-ID: <CAMj1kXF9crOKFaGfzcj9T4n58XAr7n85YZO0x7J1DcRG2JrfcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: mm: Refactor __do_page_fault()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 at 16:32, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Sat, May 29, 2021 at 11:41:37AM +0800, Kefeng Wang wrote:
> > 1. cleanup access_error(), make vma flags set and check into
> >    __do_page_fault() and do_page_fault() directly.
> >
> > 2. drop fsr and task argument, instead, using vm_flags in
> >    __do_page_fault().
> >
> > 3. cleans up the multiple goto statements in __do_page_fault().
> >
> > 4. use current->mm directly in do_page_fault().
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> This patch is a really good example of something that is very difficult
> to review and see that there are no unintended changes.
>
> Many people have complained about my patches, where I create a series of
> many patches where each patch does exactly _one_ simple transformation to
> the code. This is a good example _why_ I do that - a step by step single
> transformation approach is way easier to review.
>
> Sorry, but I'm not able to sensibly review this patch, and therefore
> I won't apply it. Please split it into smaller changes.
>

Agreed. If your commit message contains an enumeration of things the
patch does, it is a very strong hint that each of those things needs
to be a separate patch if at all possible.
