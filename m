Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14AC738FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjFUTRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjFUTQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:16:58 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F56199E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:16:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34207e81c98so30435485ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374998; x=1689966998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4yDK3apM1izDT0cLLYrUN8q998jyQn5sT5zUG3gz6E=;
        b=VgxVIHC+B3BaDo0HS8AgvrP4ASYhEntLBRLHvK8GFSQ7sq9Hdy610WPKyG6jCmlqv3
         3zVQZ0HRK9CtZ48RSlahXiiEIfIPpGJ4Wx3E+eOcAyPlLhZe01gmeTV3o9238e/XjGPL
         80vHuE0yZ0aZrWr4bAAFWHhkLisGMECfpJbNyWNAEi68pzOpiwzIgI4fDuXn7DiYtxLl
         MeiGdglzorgdtXqVc2rhaTbaqLr2sJncs3VlDt9BlntVgIChgE+8IFOLD4y8p3nUOSaT
         ePl9rvgbkbkrKtw9R/15x+p1sj4IxnHwHrT+84bE/oHlj3yV8SFDIH3oqPhyoNhS0Dkz
         c5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374998; x=1689966998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4yDK3apM1izDT0cLLYrUN8q998jyQn5sT5zUG3gz6E=;
        b=PSQgdKhFfjpYr2kGK6nvuiUEtRxaAIBJPJCP7VFdx/eHjBWhBDguPSAmpb4P/xT/Vr
         nkEjIkCxzaA8fWSG5tTShueVQCVfTosC71R9Ij6FxFIB9Q6ZrFTtKIPFsSEnG1LMUsa5
         VuidKc+iBGqGxsVJ5z+pMi1u886g2VzTwit8eB2YunG0nAy6cRHHIky2AmRYbsiXpPJC
         Ghj2LrR4BWBNW+9K1owr7K2JIoRtrHacizi/Xd2cXHLOdSWz7LqFBF47mrv4jfZhCtm4
         VYCxOqgqClVxfI2y8MCvvE4gvqo9MjAik0A1lBtHH0CgFoh/H7DugcrMaRExjMCaCN8i
         LgJg==
X-Gm-Message-State: AC+VfDwtpGH2KKIw1XybswWw56qXnEh/pgZ0px3UdSxc0YeQXhdXGVZj
        bAk0enTawT/EervW5GEcJRkb4P//PKXCZA==
X-Google-Smtp-Source: ACHHUZ4ChdZGXdrQhmSJyCsimqGZg1jYbuejFzy2fXAbiXFg4scw0FsOUtCsgJikvUUqYFntVyVaAQ==
X-Received: by 2002:a05:6e02:5c5:b0:339:f011:77f5 with SMTP id l5-20020a056e0205c500b00339f01177f5mr16085986ils.12.1687374997909;
        Wed, 21 Jun 2023 12:16:37 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id c10-20020a92cf4a000000b0033e6414ec9bsm1500652ilr.62.2023.06.21.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:16:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 09:16:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, nhuck@google.com,
        agk@redhat.com, snitzer@kernel.org, void@manifault.com
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZJNMk9oSp1_IYXLU@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <ZIewlkGJJJUXPFL0@google.com>
 <ZIfY5zhhHU9IgOqx@slm.duckdns.org>
 <CAEXTbpconFReyAKxerNCQW5e51CMG=_RU9JHAquyEfSH1aqajA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXTbpconFReyAKxerNCQW5e51CMG=_RU9JHAquyEfSH1aqajA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Pin-yen.

On Tue, Jun 13, 2023 at 05:26:48PM +0800, Pin-yen Lin wrote:
...
> >  1. affinity_scope = cache, affinity_strict = 1
> >
> >  2. affinity_scope = cpu, affinity_strict = 0
> >
> >  3. affinity_scope = cpu, affinity_strict = 1
> 
> I pulled down v2 series and tried these settings on our 5.15 kernel.
> Unfortunately none of them showed significant improvement on the
> throughput. It's hard to tell which one is the best because of the
> noise, but the throughput is still all far from our 4.19 kernel or
> simply pinning everything to a single core.
> 
> All the 4 settings (3 settings listed above plus the default) yields
> results between 90 to 120 Mbps, while pinning tasks to a single core
> consistently reaches >250 Mbps.

I find that perplexing given that switching to a per-cpu workqueue remedies
the situation quite a bit, which is how this patchset came to be. #3 is the
same as per-cpu workqueue, so if you're seeing noticeably different
performance numbers between #3 and per-cpu workqueue, there's something
wrong with either the code or test setup.

Also, if you have to ping to a single or some subset of CPUs, you can just
set WQ_SYSFS for the workqueue and set affinities in its sysfs interface
instead of hard-coding the workaround for a specific hardware.

Thanks.

-- 
tejun
