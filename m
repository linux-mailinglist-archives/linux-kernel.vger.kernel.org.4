Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52B3741C80
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjF1Xcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjF1Xcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:32:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D31BD1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:32:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso796265ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687995164; x=1690587164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3bTxuumwZmEpyajshGaw+wYCur5UAcozF0e23Xfj8P0=;
        b=DpqBZ3ylLqsAUkTeN+2t0neZqmBEP8mqOM0dY++zleaiP/cmN1rZLCQsA9h2MoPdaK
         bVjsMay9Vj1r7n/aNaDaA3K76I1HvDVss/M3bSjElBZDmYV4BCnu4Xbc26VyDApeWDBB
         gmiano+n+sfZ1+xVFICSoAabB7UVr/bshQf00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995164; x=1690587164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bTxuumwZmEpyajshGaw+wYCur5UAcozF0e23Xfj8P0=;
        b=HEWIcImwM6qHHNsCIo4BBns966DxbZlFFu8nMrEXD8nZRz9LACb0vzAicK5Jbs0ryI
         yBpv/cq5bWIRwVvq6RjuesB0vSVyUpo0DaWHKJvhbBfNUC6VZmj4OcWBIe65TEVSQGHO
         4IxXMZBIVnfPC/q/lZ1ef6/SBXTf2bJ8zbpjtisyqqO8//ftX2fRgYK1T9fquMgb3b51
         yGIUiqkH+gcFM2bXA9oal2UUkVGye7T6S4AkTxTNvBn9A7hd2mm8qgcwxdoElsZEZ0mp
         LN8IP8jyEGksaZwLeGOrjY5greCFPrcMcfghQkaQp9FTRHcSZq18hXBEmJPagUPEhbti
         6Oxw==
X-Gm-Message-State: AC+VfDyzH5aNq4XDqp2lpiaVinv3RCFNgkq3y1ax3D8vfpaYAGBRPRSX
        8/RHbyvxlktpgeqZwchKVJqZqmmKGKVMDHq3Z0g=
X-Google-Smtp-Source: ACHHUZ6i464rnjRi5eWKGZKYaR1j824hI1mk/wIJeWL2rnhu6VuB/6VB4kd9imOJrxAjoS9KA8XBsg==
X-Received: by 2002:a17:902:ce8a:b0:1b8:d4c:725 with SMTP id f10-20020a170902ce8a00b001b80d4c0725mr10217778plg.15.1687995164324;
        Wed, 28 Jun 2023 16:32:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jl23-20020a170903135700b001aafa2e212esm8143235plb.52.2023.06.28.16.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:32:43 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:32:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     Kees Cook <kees@kernel.org>, Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6 v5 RESEND] seccomp: add the synchronous mode for
 seccomp_unotify
Message-ID: <202306281630.504D1FC6@keescook>
References: <20230308073201.3102738-1-avagin@google.com>
 <20230327102715.GA7701@hirez.programming.kicks-ass.net>
 <CANaxB-wjNAuFGcNErnfz3gy1TG=W6XoJSb0hQM=TtB25YoGSqw@mail.gmail.com>
 <C7D9CFE1-0FEF-41F1-81CC-E3D5C4E61213@kernel.org>
 <CAEWA0a4gOpVejBEEsO=c5+wu_GwTGqO8cOAuKNAMdpqf0w_m1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a4gOpVejBEEsO=c5+wu_GwTGqO8cOAuKNAMdpqf0w_m1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:44:02AM -0700, Andrei Vagin wrote:
> On Wed, Apr 5, 2023 at 8:19 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On April 3, 2023 11:32:00 AM PDT, Andrei Vagin <avagin@gmail.com> wrote:
> > >On Mon, Mar 27, 2023 at 3:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >>
> > >> On Tue, Mar 07, 2023 at 11:31:55PM -0800, Andrei Vagin wrote:
> > >>
> > >> > Kees is ready to take this patch set, but wants to get Acks from the
> > >> > sched folks.
> > >> >
> > >>
> > >> > Andrei Vagin (4):
> > >> >   seccomp: don't use semaphore and wait_queue together
> > >> >   sched: add a few helpers to wake up tasks on the current cpu
> > >> >   seccomp: add the synchronous mode for seccomp_unotify
> > >> >   selftest/seccomp: add a new test for the sync mode of
> > >> >     seccomp_user_notify
> > >> >
> > >> > Peter Oskolkov (1):
> > >> >   sched: add WF_CURRENT_CPU and externise ttwu
> > >>
> > >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > >
> > >Kees,
> > >
> > >Could you look at this patch set? You wrote to one of the previous
> > >versions that you are ready to take it if sched maintainers approve it.
> > >Here is no major changes from that moment. The sched-related part has
> > >been cleaned up according with Peter's comments, and I moved the perf
> > >test to the perf tool.
> >
> > Hi!
> >
> > Yes, thanks for keeping this going! I'm catching up after some vacation, but this is on my TODO list. :)
> 
> Hi Kees. Do you have any updates on this series?

Apologies for the delay!

I've added this to the seccomp tree -- it should show up in -next soon.

-Kees

-- 
Kees Cook
