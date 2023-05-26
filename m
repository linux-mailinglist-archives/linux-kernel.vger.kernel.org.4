Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4B712CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbjEZSyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjEZSyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE854135
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39EDD64D7D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E393BC433D2;
        Fri, 26 May 2023 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685127251;
        bh=E9e4N+V8UJ4IwjvpQTzUrpD+e3V9ExGL3fz9H07QHkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKYbKSi1W0epzrz/uZ+5uBAwbhXUDj60Xs69d9NzD/+WYBYXm7hc2FwoIwumvrcnV
         PLtGYGeHjQEn94LzxG5c+ckeveAO8T5XNmteMmvUKSf0l1FDYtM7FudRR6NvAHNQBx
         JHr00v9zeLs6P3/UsPDS3gFQ/1pfqCu9kOj5ntbPq4LXvh6FBsza/jr2stO1T+ztFI
         QHF4gKfc6jptIHM+u6mxdUmKv92Lie99oQeorBaI2TnNtseHJ4VYK0RXNje6OP2ixC
         q4Md4mDX2vybOzenMsvNqr+gJDrnf/w159SCvCE82A8tgDKi/2ku0W1AE4qg7MGTkU
         gFdB8GaOpInRw==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     syzbot <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [damon?] divide error in damon_set_attrs
Date:   Fri, 26 May 2023 18:54:09 +0000
Message-Id: <20230526185409.92039-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d127a181-b734-a6b1-5752-b8597f6adc92@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng and syzbot,

On Fri, 26 May 2023 20:59:12 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> 
> 
> On 2023/5/26 19:51, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    44c026a73be8 Linux 6.4-rc3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13a92b31280000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f389ffdf4e9ba3f0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=841a46899768ec7bec67
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: i386
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/35f16ee05df7/disk-44c026a7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/10399498a570/vmlinux-44c026a7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/5c72201ea4ba/bzImage-44c026a7.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
> > 
> > divide error: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 13527 Comm: syz-executor.1 Not tainted 6.4.0-rc3-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
> > RIP: 0010:damon_nr_accesses_to_accesses_bp mm/damon/core.c:491 [inline]
> > RIP: 0010:damon_nr_accesses_for_new_attrs mm/damon/core.c:497 [inline]
> > RIP: 0010:damon_update_monitoring_result mm/damon/core.c:506 [inline]
> > RIP: 0010:damon_update_monitoring_results mm/damon/core.c:534 [inline]
> > RIP: 0010:damon_set_attrs+0x224/0x460 mm/damon/core.c:555

Thank you for finding and reporting this bug!

The code of the problem is as below:

    /* convert nr_accesses to access ratio in bp (per 10,000) */
    static unsigned int damon_nr_accesses_to_accesses_bp(
                    unsigned int nr_accesses, struct damon_attrs *attrs)
    {
            unsigned int max_nr_accesses =
                    attrs->aggr_interval / attrs->sample_interval;
    
            return nr_accesses * 10000 / max_nr_accesses;
    }

The problem can happen when 'aggr_interval' is smaller than 'sample_interval',
because 'max_nr_accesses' becomes zero in the case, and resulting in divide by
zero.

Same problem is in damon_accesses_bp_to_nr_accesses().

> 
> make aggr_interval great than or equal sample_interval?
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d9ef62047bf5..6fe1960f3d6b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -525,8 +525,8 @@ static void damon_update_monitoring_results(struct 
> damon_ctx *ctx,
> 
>          /* if any interval is zero, simply forgive conversion */
>          if (!old_attrs->sample_interval || !old_attrs->aggr_interval ||
> -                       !new_attrs->sample_interval ||
> -                       !new_attrs->aggr_interval)
> +           !new_attrs->sample_interval || !new_attrs->aggr_interval ||
> +           new_attrs->aggr_interval < new_attrs->sample_interval)
>                  return;

Nice and effective fix!  Nevertheless, I think aggregation interval smaller
than sample interval is just a wrong input.  How about adding the check in
damon_set_attrs()'s already existing attributes validation, like below?

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -580,6 +580,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
                return -EINVAL;
        if (attrs->min_nr_regions > attrs->max_nr_regions)
                return -EINVAL;
+       if (attrs->aggr_interval < attrs->sample_interval)
+               return -EINVAL;

        damon_update_monitoring_results(ctx, attrs);
        ctx->attrs = *attrs;

Thanks,
SJ
