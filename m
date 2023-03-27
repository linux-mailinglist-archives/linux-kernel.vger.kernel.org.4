Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C826C9981
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjC0CHd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Mar 2023 22:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0CHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:07:31 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4204C38;
        Sun, 26 Mar 2023 19:07:26 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 723E31A00A7A;
        Mon, 27 Mar 2023 10:07:32 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T-yrv0qkjBf9; Mon, 27 Mar 2023 10:07:31 +0800 (CST)
Received: from 127.0.0.1 (unknown [127.0.0.1])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B108A1A009F3;
        Mon, 27 Mar 2023 10:07:31 +0800 (CST)
Date:   Mon, 27 Mar 2023 10:07:31 +0800 (CST)
From:   yuzhe <yuzhe@nfschina.com>
Reply-To: yuzhe@nfschina.com
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yu Zhe <yuzhe@nfschina.com>, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        liqiong <liqiong@nfschina.com>
Message-ID: <95083698.3076.1679882851720@127.0.0.1>
Subject: Re: Re: [PATCH] mmc: core: remove unnecessary (void*) conversions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-NFS-GUID: ssqreoDnzK1SiXj1Du7b
X-ISRICH: 0
Content-ID: 96d1d1a3-6230-4603-a0a4-48f60747430f
X-Mail-src: 21
X-Spam-Status: No, score=2.6 required=5.0 tests=RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<p><br /><br /><br />在 2023-03-24, 星期五, 23:47:08 ,Ulf Hansson 写到：</p>
<pre>On Fri, 24 Mar 2023 at 14:28, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 17.03.2023 07:47, Yu Zhe wrote:
> > Pointer variables of void * type do not require type cast.
> >
> > Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> > ---
> > drivers/mmc/core/debugfs.c | 2 +-
> > drivers/mmc/core/host.c | 2 +-
> > drivers/mmc/core/mmc_test.c | 6 +++---
> > 3 files changed, 5 insertions(+), 5 deletions(-)
> ...
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 096093f7be00..76900f67c782 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -590,7 +590,7 @@ EXPORT_SYMBOL(mmc_alloc_host);
> >
> > static void devm_mmc_host_release(struct device *dev, void *res)
> > {
> > - mmc_free_host(*(struct mmc_host **)res);
> > + mmc_free_host(res);
>
> The above chunk is wrong and causes following regression on today's
> Linux next-20230324:
>
> Unable to handle kernel paging request at virtual address 0000000000001020
> Mem abort info:
> meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
> ...
> [0000000000001020] user address but active_mm is swapper
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 3 PID: 10 Comm: kworker/u12:0 Not tainted 6.3.0-rc3-next-20230324+
> #13452
> Hardware name: Khadas VIM3 (DT)
> Workqueue: events_unbound async_run_entry_fn
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mmc_pwrseq_free+0x1c/0x38
> lr : devm_mmc_host_release+0x1c/0x34
> ...
> Call trace:
> mmc_pwrseq_free+0x1c/0x38
> devm_mmc_host_release+0x1c/0x34
> release_nodes+0x5c/0x90
> devres_release_all+0x8c/0xdc
> device_unbind_cleanup+0x18/0x68
> really_probe+0x11c/0x2b4
> __driver_probe_device+0x78/0xe0
> driver_probe_device+0xd8/0x160
> __device_attach_driver+0xb8/0x138
> bus_for_each_drv+0x84/0xe0
> __device_attach_async_helper+0xb0/0xd4
> async_run_entry_fn+0x34/0xe0
> process_one_work+0x288/0x5c0
> worker_thread+0x74/0x450
> kthread+0x124/0x128
> ret_from_fork+0x10/0x20
> Code: f9000bf3 aa0003f3 f9424c00 b4000080 (f9401000)
> ---[ end trace 0000000000000000 ]---
>
> Ulf: do You want me to send a partial revert or will you handle it by
> dropping this patch?

Thanks for the report, I will simply drop the patch!

Kind regards
Uffe
</pre>

sorry for making this mistake, I will check seriously next time.
