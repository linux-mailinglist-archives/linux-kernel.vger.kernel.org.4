Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B534A74F9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGKVjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGKVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:39:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9DC127;
        Tue, 11 Jul 2023 14:39:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b89d47ffb6so32097155ad.2;
        Tue, 11 Jul 2023 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689111560; x=1691703560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtT4gFz6TTEFRseSk+gcMtJFveuGAwBprTn2TmvM3QM=;
        b=qVGDef4XTDiy2pQQAH3Cwnbtqh8ZKWeDR0YpW5oBVmIf8Ft1FfiQFB9j/nigTkpw8I
         82vXU59i3SdogLeNz/ABKCqINgA4PTDr9/ZdUPp6ZUB83Z6MdD4YHZx6qWrTB/+YO5SG
         xt3gCozG7WIu1lWUXRr3EpK+TzZRAcw2ll3vth9VDJ1GAaRvrA2V8kIgGX9kdM2Wgg3l
         stzdpWOedBvZ0uhTUpLtvsrBCTVN9HRCFZfzCFKFQAEkzZQTdhvlZETvKEQOgCpBxb1y
         lgv7BtP9O20Qjyp/f7+CQeQ3LbV13czXSXJgwRbcUJP+TfmtuZqC2GkNl1o/MlSqRGEW
         v5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111560; x=1691703560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtT4gFz6TTEFRseSk+gcMtJFveuGAwBprTn2TmvM3QM=;
        b=hm8E4CWDWpbVZZ/+chXcJ7tdA4AR/wwkc6zVZU92wh0wHs5qBdenkc+UEB6mFSZ4XZ
         8SJ5UAwVhW5mwC6+OrNEvwivGpCBvhuDzKI4tId4ng9Yf8BzmutY01tDT7m0gnqOu+yg
         m4gMsrzsZj+OnXjDY/tAi1tuwoo2Vo420xOaPzZTe6yyrrR4a6eV/vF2zr0h0q6aB3pw
         xF6n9AtDZhrtv7gkZteIzebInWjRv6qvq8LQ5D3Yemyds4oLFwI3y9BBiiJ9H8tu51Ij
         OIsAk5FHDmvvpEKkrbWZET54CKfnJQisQEuxfcY0+Za2rbh1vSW1QW0WFRHkoO4+rLHG
         cQbw==
X-Gm-Message-State: ABy/qLY2MGoYPaQXvDgloKfTQQOhhNGNIDy5sCwAO/D0tbP/5sjIELhQ
        4P4dsfoJXbL45Ui7piOqFVc=
X-Google-Smtp-Source: APBJJlHvfrCF++DlafNT3B6O6EffAGKpXCrh8newwF9nz4kDCviiDR8GuVNpvkxYKklGu+rZ5VQk5Q==
X-Received: by 2002:a17:903:24e:b0:1b6:80f0:d969 with SMTP id j14-20020a170903024e00b001b680f0d969mr15429164plh.11.1689111559501;
        Tue, 11 Jul 2023 14:39:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001b8761c739csm2362090plb.271.2023.07.11.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:39:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Jul 2023 11:39:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Linux PM list <linux-pm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rtc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: Consider switching to WQ_UNBOUND messages (was: Re: [PATCH v2
 6/7] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE
 mechanism)
Message-ID: <ZK3MBfPS-3-tJgjO@slm.duckdns.org>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org>
 <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
 <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 11, 2023 at 04:06:22PM +0200, Geert Uytterhoeven wrote:
> On Tue, Jul 11, 2023 at 3:55 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Tejun,
> >
> > On Fri, May 12, 2023 at 9:54 PM Tejun Heo <tj@kernel.org> wrote:
> > > Workqueue now automatically marks per-cpu work items that hog CPU for too
> > > long as CPU_INTENSIVE, which excludes them from concurrency management and
> > > prevents stalling other concurrency-managed work items. If a work function
> > > keeps running over the thershold, it likely needs to be switched to use an
> > > unbound workqueue.
> > >
> > > This patch adds a debug mechanism which tracks the work functions which
> > > trigger the automatic CPU_INTENSIVE mechanism and report them using
> > > pr_warn() with exponential backoff.
> > >
> > > v2: Drop bouncing through kthread_worker for printing messages. It was to
> > >     avoid introducing circular locking dependency but wasn't effective as it
> > >     still had pool lock -> wci_lock -> printk -> pool lock loop. Let's just
> > >     print directly using printk_deferred().
> > >
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >
> > Thanks for your patch, which is now commit 6363845005202148
> > ("workqueue: Report work funcs that trigger automatic CPU_INTENSIVE
> > mechanism") in v6.5-rc1.
> >
> > I guess you are interested to know where this triggers.
> > I enabled CONFIG_WQ_CPU_INTENSIVE_REPORT=y, and tested
> > the result on various machines...
> 
> > OrangeCrab/Linux-on-LiteX-VexRiscV with ht16k33 14-seg display and ssd130xdrmfb:
> >
> >   workqueue: check_lifetime hogged CPU for >10000us 4 times, consider
> > switching to WQ_UNBOUND
> >   workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 1024
> > times, consider switching to WQ_UNBOUND
> >   workqueue: fb_flashcursor hogged CPU for >10000us 128 times,
> > consider switching to WQ_UNBOUND
> >   workqueue: ht16k33_seg14_update hogged CPU for >10000us 128 times,
> > consider switching to WQ_UNBOUND
> >   workqueue: mmc_rescan hogged CPU for >10000us 128 times, consider
> > switching to WQ_UNBOUND
> 
> Got one more after a while:
> 
> workqueue: neigh_managed_work hogged CPU for >10000us 4 times,
> consider switching to WQ_UNBOUND

I wonder whether the right thing to do here is somehow scaling the threshold
according to the relative processing power. It's difficult to come up with a
threshold which works well across the latest & fastest and really tiny CPUs.
I'll think about it some more but if you have some ideas, please feel free
to suggest.

Thanks.

-- 
tejun
