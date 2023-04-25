Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E06ED94E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 02:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjDYAYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 20:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDYAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 20:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF95585;
        Mon, 24 Apr 2023 17:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29ABA62A6D;
        Tue, 25 Apr 2023 00:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D11C433D2;
        Tue, 25 Apr 2023 00:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682382239;
        bh=Iiq2gb1MMxnJ3LJdqdqD0CqhoCtzfULA8cDXsPZwt+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nbdOZoa0BrOYY2nnu2UzjE+4vgzszYOOQeTEnHgC10sUcH5ZmLRs9rfcMw78jqLIJ
         ejasczN0E3JAwPWxSIg+hX9QgfWhbG2nVwnBJ3WVkOTHE5OMNprHZAQROzzkGZvZKR
         2vBXJq6WygSVbXmofY0Lfi/SFxrwMXJF1lVCxSX9l0ITXwo9t1T0JdM7oW3b/Nuq/F
         lNPR0gwVppnDZS2HT0rvPItJOtLYni7f6JggVrYTCtBQqn1vguZQjXihhjHxNdwsG2
         GYejV4Wjlf9AjAybkAFQi7A+boXTUoZPk2HIPAfNtLKUXEej4bLI9ErqKYACjCQgoq
         8n7OSBusApmhA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so48214861fa.2;
        Mon, 24 Apr 2023 17:23:59 -0700 (PDT)
X-Gm-Message-State: AAQBX9eaHzgPH4PI9WIyS0H55k0clVKV0yDmv6vStB5pvZ0ojFh6ajpO
        7n+a+GvuniwxFz16f1lAa6Lw/fUiegOLJWfh2XU=
X-Google-Smtp-Source: AKy350YkR5niEhpMiQQT0dxBIyGNumGUYY7iSNti+fTHjUck5U67IV/tE8hu/yiQim7FsbzVEEIpZ6xd5fqgox2DRQc=
X-Received: by 2002:a2e:9dc6:0:b0:2a7:adf7:1781 with SMTP id
 x6-20020a2e9dc6000000b002a7adf71781mr2801803ljj.2.1682382237457; Mon, 24 Apr
 2023 17:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com> <20230420112946.2869956-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230420112946.2869956-2-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Apr 2023 17:23:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ifaGc47-vJWwbRyjgJHr3CJy+_zZ1wAL=FNxPOk-0WQ@mail.gmail.com>
Message-ID: <CAPhsuW5ifaGc47-vJWwbRyjgJHr3CJy+_zZ1wAL=FNxPOk-0WQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/8] md/raid10: prevent soft lockup while flush writes
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@osdl.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 4:31=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently, there is no limit for raid1/raid10 plugged bio. While flushing
> writes, raid1 has cond_resched() while raid10 doesn't, and too many
> writes can cause soft lockup.
>
> Follow up soft lockup can be triggered easily with writeback test for
> raid10 with ramdisks:
>
> watchdog: BUG: soft lockup - CPU#10 stuck for 27s! [md0_raid10:1293]
> Call Trace:
>  <TASK>
>  call_rcu+0x16/0x20
>  put_object+0x41/0x80
>  __delete_object+0x50/0x90
>  delete_object_full+0x2b/0x40
>  kmemleak_free+0x46/0xa0
>  slab_free_freelist_hook.constprop.0+0xed/0x1a0
>  kmem_cache_free+0xfd/0x300
>  mempool_free_slab+0x1f/0x30
>  mempool_free+0x3a/0x100
>  bio_free+0x59/0x80
>  bio_put+0xcf/0x2c0
>  free_r10bio+0xbf/0xf0
>  raid_end_bio_io+0x78/0xb0
>  one_write_done+0x8a/0xa0
>  raid10_end_write_request+0x1b4/0x430
>  bio_endio+0x175/0x320
>  brd_submit_bio+0x3b9/0x9b7 [brd]
>  __submit_bio+0x69/0xe0
>  submit_bio_noacct_nocheck+0x1e6/0x5a0
>  submit_bio_noacct+0x38c/0x7e0
>  flush_pending_writes+0xf0/0x240
>  raid10d+0xac/0x1ed0

Is it possible to trigger this with a mdadm test?

Thanks,
Song

>
> This patch fix the problem by adding cond_resched() to raid10 like what
> raid1 did.
>
> Note that unlimited plugged bio still need to be optimized because in
> the case of writeback lots of dirty pages, this will take lots of memory
> and io latecy is quite bad.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid10.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 6590aa49598c..a116b7c9d9f3 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -921,6 +921,7 @@ static void flush_pending_writes(struct r10conf *conf=
)
>                         else
>                                 submit_bio_noacct(bio);
>                         bio =3D next;
> +                       cond_resched();
>                 }
>                 blk_finish_plug(&plug);
>         } else
> @@ -1140,6 +1141,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, b=
ool from_schedule)
>                 else
>                         submit_bio_noacct(bio);
>                 bio =3D next;
> +               cond_resched();
>         }
>         kfree(plug);
>  }
> --
> 2.39.2
>
