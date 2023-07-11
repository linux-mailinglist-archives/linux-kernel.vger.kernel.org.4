Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80674F0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjGKNzp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 09:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjGKNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:55:42 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E594;
        Tue, 11 Jul 2023 06:55:40 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-579ed2829a8so61177867b3.1;
        Tue, 11 Jul 2023 06:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083740; x=1691675740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXQMJc+mkFZtu2vLefW5Re8NpovkJxJKped5EUiUKOE=;
        b=BtAaeM1r57mlTwANqrQdgSLT/BQzCsFQlocFdyHWa89EhRx/Tske8E/0U75RZXV/s1
         vMyOFmR/2tI6KuRUXLHUKv4udaytrpPO6K3Fxy7kVfvnnBEFQMP1Ae5MfZuJKVuanSAl
         0WygyPjzqFgohifL9lHygDSKSTwS6dX8GALt0KV1Jyqo+hEGDwHMIQcAbMEyiApjeDzZ
         Q+mPxd6jF1+rjlyYvx06uYH7W3okrwsmfAtX0LGSuc/JGrlCBa7B4F2D8QXAgmHfKZz7
         DC5P65Erc4VsIyW0Zy0MZTg0+mK6947XvoiBOxjgASDtC0xBppxfVYAcDFpeFnr90Z1w
         Serw==
X-Gm-Message-State: ABy/qLaFdqm9/3UmzRWN9Mp+o8X9X/Eg2BvChVvN3stetv8wyVdYUq8z
        dp5K2aHCf1XZkRiXwGUur7aGl961CU8XjA==
X-Google-Smtp-Source: APBJJlG2SP6QbX+lb4Zp1K7VfQDqff8Wq2bAVPCyWAjRlgmsdN76O/U7mI3WXYO0nzlsMPEK4vnd5w==
X-Received: by 2002:a0d:d383:0:b0:561:b8a1:e7ef with SMTP id v125-20020a0dd383000000b00561b8a1e7efmr17947283ywd.41.1689083739787;
        Tue, 11 Jul 2023 06:55:39 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id l10-20020a81d54a000000b0056ffdec590csm569466ywj.41.2023.07.11.06.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 06:55:39 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-577497ec6c6so61279067b3.2;
        Tue, 11 Jul 2023 06:55:39 -0700 (PDT)
X-Received: by 2002:a81:6e8b:0:b0:570:85b2:e6dd with SMTP id
 j133-20020a816e8b000000b0057085b2e6ddmr17111816ywc.17.1689083738977; Tue, 11
 Jul 2023 06:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230511181931.869812-1-tj@kernel.org> <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org>
In-Reply-To: <ZF6WsSVGX3O1d0pL@slm.duckdns.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jul 2023 15:55:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
Message-ID: <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
Subject: Consider switching to WQ_UNBOUND messages (was: Re: [PATCH v2 6/7]
 workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism)
To:     Tejun Heo <tj@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Fri, May 12, 2023 at 9:54 PM Tejun Heo <tj@kernel.org> wrote:
> Workqueue now automatically marks per-cpu work items that hog CPU for too
> long as CPU_INTENSIVE, which excludes them from concurrency management and
> prevents stalling other concurrency-managed work items. If a work function
> keeps running over the thershold, it likely needs to be switched to use an
> unbound workqueue.
>
> This patch adds a debug mechanism which tracks the work functions which
> trigger the automatic CPU_INTENSIVE mechanism and report them using
> pr_warn() with exponential backoff.
>
> v2: Drop bouncing through kthread_worker for printing messages. It was to
>     avoid introducing circular locking dependency but wasn't effective as it
>     still had pool lock -> wci_lock -> printk -> pool lock loop. Let's just
>     print directly using printk_deferred().
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Thanks for your patch, which is now commit 6363845005202148
("workqueue: Report work funcs that trigger automatic CPU_INTENSIVE
mechanism") in v6.5-rc1.

I guess you are interested to know where this triggers.
I enabled CONFIG_WQ_CPU_INTENSIVE_REPORT=y, and tested
the result on various machines...

SH/R-Mobile:

  workqueue: genpd_power_off_work_fn hogged CPU for >10000us 4 times,
consider switching to WQ_UNBOUND

Atmark Techno Armadillo800-EVA with shmob_drm:

  workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 16
times, consider switching to WQ_UNBOUND

R-Car Gen2:

  workqueue: rtc_timer_do_work hogged CPU for >10000us 4 times,
consider switching to WQ_UNBOUND

R-Car Gen2/Gen3:

  workqueue: pm_runtime_work hogged CPU for >10000us 4 times, consider
switching to WQ_UNBOUND

R-Car Gen3:

  workqueue: kfree_rcu_work hogged CPU for >10000us 4 times, consider
switching to WQ_UNBOUND

OrangeCrab/Linux-on-LiteX-VexRiscV with ht16k33 14-seg display and ssd130xdrmfb:

  workqueue: check_lifetime hogged CPU for >10000us 4 times, consider
switching to WQ_UNBOUND
  workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 1024
times, consider switching to WQ_UNBOUND
  workqueue: fb_flashcursor hogged CPU for >10000us 128 times,
consider switching to WQ_UNBOUND
  workqueue: ht16k33_seg14_update hogged CPU for >10000us 128 times,
consider switching to WQ_UNBOUND
  workqueue: mmc_rescan hogged CPU for >10000us 128 times, consider
switching to WQ_UNBOUND

Atari (ARAnyM):

  workqueue: ata_sff_pio_task hogged CPU for >10000us 64 times,
consider switching to WQ_UNBOUND

The OrangeCrab is a slow machine, so it's not that surprising to see these
messages...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
