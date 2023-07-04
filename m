Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F84747991
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGDV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGDV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54123195
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 14:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE30261381
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 21:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6634C433C7;
        Tue,  4 Jul 2023 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688506127;
        bh=E8dNdMe+o/9ilV1rktIoejIV+3alMbAu3NTh8xMgTwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TdvrDHxu6v81wGlxPR7qp7Thm9ZHX4mhEdww0ympaj651vktXNup046lqWOb7b5H8
         u+MSXBfU9Va4D/dgtEN6/jJ3cw9hglPlIBJ+MVnO2q5VDdIaLI1ZeB/SqsGjgS/vUx
         eq3GNfQ4jhK+t1UHNj/w5cjGPwcRwCzIOKuBIvY8=
Date:   Tue, 4 Jul 2023 14:28:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Fwd: Memory corruption in multithreaded user space program
 while calling fork
Message-Id: <20230704142846.524daa14ff921ed7eb534594@linux-foundation.org>
In-Reply-To: <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
        <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
        <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
        <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
        <2023070359-evasive-regroup-f3b8@gregkh>
        <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
        <2023070453-plod-swipe-cfbf@gregkh>
        <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
        <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 13:22:54 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Tue, Jul 4, 2023 at 9:18 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 4 Jul 2023 09:00:19 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > > > > > > Thanks! I'll investigate this later today. After discussing with
> > > > > > > Andrew, we would like to disable CONFIG_PER_VMA_LOCK by default until
> > > > > > > the issue is fixed. I'll post a patch shortly.
> > > > > >
> > > > > > Posted at: https://lore.kernel.org/all/20230703182150.2193578-1-surenb@google.com/
> > > > >
> > > > > As that change fixes something in 6.4, why not cc: stable on it as well?
> > > >
> > > > Sorry, I thought since per-VMA locks were introduced in 6.4 and this
> > > > patch is fixing 6.4 I didn't need to send it to stable for older
> > > > versions. Did I miss something?
> > >
> > > 6.4.y is a stable kernel tree right now, so yes, it needs to be included
> > > there :)
> >
> > I'm in wait-a-few-days-mode on this.  To see if we have a backportable
> > fix rather than disabling the feature in -stable.
> 
> Ok, I think we have a fix posted at [2]  and it's cleanly applies to
> 6.4.y stable branch as well. However fork() performance might slightly
> regress, therefore disabling per-VMA locks by default for now seems to
> be preferable even with this fix (see discussion at
> https://lore.kernel.org/all/54cd9ffb-8f4b-003f-c2d6-3b6b0d2cb7d9@google.com/).
> IOW, both [1] and [2] should be applied to 6.4.y stable. Both apply
> cleanly and I CC'ed stable on [2]. Greg, should I send [1] separately
> to stable@vger?
> 
> [1] https://lore.kernel.org/all/20230703182150.2193578-1-surenb@google.com/

This one isn't sufficient for .configs which already have
PER_VMA_LOCK=y.  Using `depends on BROKEN' would be better.

> [2] https://lore.kernel.org/all/20230704200656.2526715-1-surenb@google.com/
> 

We're still awaiting tester input on this?

I think a clean new fully-changelogged two-patch series would be the
best way to handle this.  Please ensure that the [0/2] intro clearly
explains what we're proposing here, and why.

Also, "might slightly regress" is a bit weak.  These things are
measurable, no?  Because a better solution would be to fix 6.4.x and
mainline and leave it at that.

