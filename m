Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60926744488
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjF3WJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjF3WJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:09:13 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBAC3C29;
        Fri, 30 Jun 2023 15:09:12 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b6a1fe5845so37731991fa.3;
        Fri, 30 Jun 2023 15:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688162951; x=1690754951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpqJH19rSqOKraQNxyu9nWl7wUw42mtJvdZSh688/dk=;
        b=E8xw9LddvZMtPrtnkhlHAl84UcJIyyViVzw+k4oCJ44+tpMxkaQ7HD8ycUycwBC6h+
         WZaI17krO3547DiTQyNVXtBBkpzRJFvlV7NXHDoryTqYxfUfFDSIHlPUQfINfZzH+zQ5
         rc60W3ERMAahCh6cnBDHYyKv/NU8FSxCBOClvLMzWfS8yb+QzarM07dUH6KsJuOETtlx
         l1T8xCn0YlZYInrv4Wk6YgXjBGnaLdAoF8SNFvqY8KxuaaVL8rpJRxt17XiPJsXQ4y1Q
         gzcfX8xeZPyR4tT6yUK55+TaeU/ZI7QGjLzC+VQTKmSLGVqdaLNOY7Kx5qZ0Zr0WQud9
         YBKw==
X-Gm-Message-State: ABy/qLYDzL3iG2lw1NJuCKC5mvqQ9GQfypOHu8CNoFuBnyhsA6uzm6WL
        eMXccd+p1Yjr0CwR8vZnvqpwkOeEkb/wpho8
X-Google-Smtp-Source: APBJJlGMQyOMI+Gbb5ZvKTJQq/qwfV9bwv/TfKvACqwlseDNOESn4Qu0pL9Rh5SKiBxME8GVec9VZA==
X-Received: by 2002:a2e:9d85:0:b0:2b4:491d:8d53 with SMTP id c5-20020a2e9d85000000b002b4491d8d53mr3073067ljj.45.1688162950310;
        Fri, 30 Jun 2023 15:09:10 -0700 (PDT)
Received: from snowbird (host86-179-242-79.range86-179.btcentralplus.com. [86.179.242.79])
        by smtp.gmail.com with ESMTPSA id gg18-20020a170906e29200b0098d2d219649sm8563889ejb.174.2023.06.30.15.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:09:09 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:09:07 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <ZJ9SgwDTp5LVZ/AE@snowbird>
References: <20230329202148.71107-1-dennis@kernel.org>
 <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAMuHMdVK2zPnyB9s0uYwoKj0xspa0CRzqPjhrj-YFqVNdXxEkg@mail.gmail.com>
 <CAPDyKFqtgCK5Wb_fZ9+VVK1F-LWYL+htMvQ9JPpp0zPjzBZ9gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqtgCK5Wb_fZ9+VVK1F-LWYL+htMvQ9JPpp0zPjzBZ9gw@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Fri, Jun 30, 2023 at 01:26:14PM +0200, Ulf Hansson wrote:
> On Tue, 27 Jun 2023 at 19:20, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Dennis,
> >
> > On Thu, Mar 30, 2023 at 1:48 AM Dennis Zhou <dennis@kernel.org> wrote:
> > > When using dm-verity with a data partition on an emmc device, dm-verity
> > > races with the discovery of attached emmc devices. This is because mmc's
> > > probing code sets up the host data structure then a work item is
> > > scheduled to do discovery afterwards. To prevent this race on init,
> > > let's inline the first call to detection, __mm_scan(), and let
> > > subsequent detect calls be handled via the workqueue.
> > >
> > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> >
> > Thanks for your patch, which is now commit 2cc83bf7d41113d9 ("mmc:
> > core: Allow mmc_start_host() synchronously detect a card") in
> > linux-next/master mmc/next next-20230614 next-20230615 next-20230616
> >
> > I have bisected the following failure on Renesas Salvator-XS with R-Car H3
> > ES2.0 to the above commit:
> >
> >     renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
> > hardware interrupt (CMD0)
> >     renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
> > hardware interrupt (CMD1)
> >     renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
> > hardware interrupt (CMD0)
> >     renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
> > hardware interrupt (CMD1)
> >     mmc0: Failed to initialize a non-removable card
> 
> Thanks for reporting!
> 
> After I had a closer look, I realize that all the renesas/tmio drivers
> are suffering from the similar problem. A host driver must not call
> mmc_add_host() before it's ready to serve requests.
> 
> Things like initializing an irq-handler must be done before
> mmc_add_host() is called, which is not the case for renesas/tmio. In
> fact, there seems to be a few other host drivers that have the similar
> pattern in their probe routines.
> 
> Note that, even if the offending commit below triggers this problem
> 100% of the cases (as the probe path has now becomes synchronous),
> there was a potential risk even before. Previously, mmc_add_host()
> ended up punting a work - and if that work ended up sending a request
> to the host driver, *before* the irq-handler would be ready, we would
> hit the similar problem. I bet adding an msleep(1000) immediately
> after mmc_add_host() in tmio_mmc_host_probe(), would then trigger this
> problem too. :-)
> 

I'm deeply appreciative that you're willing to get to the bottom of the
issue.

> That said, I am going to revert the offending commit to fix these
> problems, for now. Then I will try to help out and fixup the relevant
> host drivers  - and when that is done, we can give this whole thing a
> new try.
> 
> Any objections or other suggestions to this?
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

> Kind regards
> Uffe
> 
