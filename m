Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175B274FC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGLAaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLAaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:30:05 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0108FDC;
        Tue, 11 Jul 2023 17:30:04 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a425ef874dso44082b6e.0;
        Tue, 11 Jul 2023 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689121804; x=1691713804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AywlaY7x3Z/gX6am2crBJ9gOzJzowq37abxtBtmocQo=;
        b=ghdEvDcr1IFDaQljt1dRUmu0HvE8cBRXow9dvmJIaaoVnpliy0H6io9/6jVjgOiCvp
         W8ARD6eHNeqfJ+cDPA0NJgPJBqbJKcZVgnHyOUyjNKE8bjkztkk4ySHLSiUBAuECvNvG
         mb/2DywJzkaoQruchWfaALw0QTZyIhkyMl6GdGEbXU96lEG1IIKslGtkOxNFHbPJlukV
         cU3AAipN+IhHQaj7foFoecZ/dEzkn+h7hzibqavkPSnM3iQjwT1oNRd+xdvy8XXbjmLV
         /C6WF+gR5Z+E29WVX3/x1rDq3OotadtwPkAl2sIQPRWVXcg0mMjVQCSxr6vu04KG1I6/
         7Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689121804; x=1691713804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AywlaY7x3Z/gX6am2crBJ9gOzJzowq37abxtBtmocQo=;
        b=bUKZe5EHmmMkMZQH/LEM14fmxXoevruRIHWM9SWwGZfoGW2awpqz8dq/NYVPX88Zcc
         AONvZ+G7txxkEwamT8jvKUUhHnUrRIKRYC29KXCvQaC4UIs/kf0Tx0kz46J8RqbtMnTB
         uv6hY2EsAS6sNPGZ7jamO8t5itytV0P+7yu4Sq6GDPvGAuivpxk1QtsisnDF/oDYLHld
         hfGJ8WNlfEgBoS9ZbR5KKvtwI1yiRclBkseOV5s15pwphBLo9cEy5NzYuSGC0p6nLlEH
         ve2y/35zk43I5r0GbrnpH58yBUFa93Nr4vlJoiow6AaAoMKI5fjr1JFo8OM8q7j4NPPv
         Z/Sw==
X-Gm-Message-State: ABy/qLYV8V/OOKnqnT0dEjpmCMSThclIX5eJ0HrbE2GxRert584F4GKD
        Yh9QKPN7L9VnbvdrYyB6aBs=
X-Google-Smtp-Source: APBJJlERzXloivjI5bk3/nTAyrXULoGFQYQ9HeldnM+GEDq5PgIauvtfIOYiM1H16bglc4CH0JAn3w==
X-Received: by 2002:a05:6808:1aa6:b0:3a3:78dc:8c4c with SMTP id bm38-20020a0568081aa600b003a378dc8c4cmr15877789oib.46.1689121804077;
        Tue, 11 Jul 2023 17:30:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id s10-20020a62e70a000000b006687b41c4dasm2285401pfh.110.2023.07.11.17.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 17:30:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Jul 2023 14:30:01 -1000
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
Message-ID: <ZK30CR196rs-OWLq@slm.duckdns.org>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org>
 <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
 <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
 <ZK3MBfPS-3-tJgjO@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZK3MBfPS-3-tJgjO@slm.duckdns.org>
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

On Tue, Jul 11, 2023 at 11:39:17AM -1000, Tejun Heo wrote:
> On Tue, Jul 11, 2023 at 04:06:22PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Jul 11, 2023 at 3:55 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
...
> > workqueue: neigh_managed_work hogged CPU for >10000us 4 times,
> > consider switching to WQ_UNBOUND
> 
> I wonder whether the right thing to do here is somehow scaling the threshold
> according to the relative processing power. It's difficult to come up with a
> threshold which works well across the latest & fastest and really tiny CPUs.
> I'll think about it some more but if you have some ideas, please feel free
> to suggest.

Geert, do you mind posting the full kernel logs for the affected machines?

Thanks.

-- 
tejun
