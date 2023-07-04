Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6279474764A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGDQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjGDQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9BDA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06EC612DC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59F5C433C7;
        Tue,  4 Jul 2023 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688487489;
        bh=plFnlH3PVa4WT7JKH0cCP1otEaPsygd1p/9DKGjnZlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DP+7MVF9vnt3bFNlQkpF4LExsXEbROYu+xuyqDpBQzN9EIZJgYMCQ3rRO3qj64/s5
         yd/IuW/oKpDL8zTX7u+j+d8QhVQkrxzzOdnvwaPICdLx+y4LQgCKjjqcZGrfHT6/zH
         arQfP+r/qWPUZQdOu9jZZCWHKufOwfpShgZOVKCM=
Date:   Tue, 4 Jul 2023 09:18:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
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
Message-Id: <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
In-Reply-To: <2023070453-plod-swipe-cfbf@gregkh>
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
        <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
        <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
        <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
        <2023070359-evasive-regroup-f3b8@gregkh>
        <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
        <2023070453-plod-swipe-cfbf@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 09:00:19 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> > > > > Thanks! I'll investigate this later today. After discussing with
> > > > > Andrew, we would like to disable CONFIG_PER_VMA_LOCK by default until
> > > > > the issue is fixed. I'll post a patch shortly.
> > > >
> > > > Posted at: https://lore.kernel.org/all/20230703182150.2193578-1-surenb@google.com/
> > >
> > > As that change fixes something in 6.4, why not cc: stable on it as well?
> > 
> > Sorry, I thought since per-VMA locks were introduced in 6.4 and this
> > patch is fixing 6.4 I didn't need to send it to stable for older
> > versions. Did I miss something?
> 
> 6.4.y is a stable kernel tree right now, so yes, it needs to be included
> there :)

I'm in wait-a-few-days-mode on this.  To see if we have a backportable
fix rather than disabling the feature in -stable.

