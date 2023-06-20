Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C60A73730C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFTRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFTRih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:38:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FADC2;
        Tue, 20 Jun 2023 10:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF98761349;
        Tue, 20 Jun 2023 17:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC16C433CB;
        Tue, 20 Jun 2023 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687282714;
        bh=e9yjPMEvXGMuMF3eCOUmrOJNV6HNzxUChRL+KMCSvuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZczpbHWPA+p8159hvgRmoJ8TNjS/HFebfMvcpcDaUUJbN4JyZVW4A49qXX1XTHgeR
         owABYo7YbCKfx/lXjP3vcUmWb3aKGVyt1giSMlFktTk7aUE3r06kl96P8RjGSjr4DN
         0IDQ5h4aNqrswWtLw+Bql1qUKUXn+FK+1jN5w/D91vWPkTXUvgEwgMlcN8JBpx/2PE
         AjKcFh1mfjtJhvRDN4skBiAuOnHKl46xiXL0UGiAhygF9Vft11LRjEQZn6f3s7VN+9
         6slgYWQlV9N2gVEamkFm8MPFYeV+9mz/eI8C9tAT9O4N80x55NDxm6rqHlLa8eKPRk
         p9qkNE/F/UWRQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b46d270ea1so48515961fa.1;
        Tue, 20 Jun 2023 10:38:33 -0700 (PDT)
X-Gm-Message-State: AC+VfDzpdBsmmDtN4M2eeTAGKcmH5c9JAF9zT+NEM3v3TG18dynoAMIV
        0Z0MUZ3SosoOlsk8h8Ggjr5ZCfmdfKEbGZ9zT+Q=
X-Google-Smtp-Source: ACHHUZ6bplLmSkT8a18K4gbr6A19h/Mrfwsd42Ai2BkYQoShRPSgCVp3Hx6beN2ZP+irequT2AKXNhHzZn0ONkJSlC4=
X-Received: by 2002:ac2:5b05:0:b0:4f7:69ca:4e71 with SMTP id
 v5-20020ac25b05000000b004f769ca4e71mr7730001lfn.34.1687282712079; Tue, 20 Jun
 2023 10:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230618142520.14662-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230618142520.14662-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 20 Jun 2023 10:38:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ZE0wH7vFPtaEDy1S8ZRTFnJGJiKVHJLYwFXz3wWSHNA@mail.gmail.com>
Message-ID: <CAPhsuW5ZE0wH7vFPtaEDy1S8ZRTFnJGJiKVHJLYwFXz3wWSHNA@mail.gmail.com>
Subject: Re: [PATCH] raid10: avoid spin_lock from fastpath from raid10_unplug()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     aligrudi@gmail.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 11:26=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 0c0be98bbe67 ("md/raid10: prevent unnecessary calls to wake_up()
> in fast path") missed one place, for example, while testing with:
>
> fio -direct=3D1 -rw=3Dwrite/randwrite -iodepth=3D1 ...
>
> Then plug and unplug will be called for each io, then wake_up() from
> raid10_unplug() will cause lock contention as well.
>
> Avoid this contention by using wake_up_barrier() instead of wake_up(),
> where spin_lock is not held while waitqueue is empty.
>
> By the way, in this scenario, each blk_plug_cb() will be allocated and
> freed for each io, this seems need to be optimized as well.
>
> Reported-and-tested-by: Ali Gholami Rudi <aligrudi@gmail.com>
> Link: https://lore.kernel.org/all/20231606122233@laper.mirepesht/

I think ./scripts/checkpatch.pl would recommend using "Closes" instead of
"Link" after "Reported-by". Please follow this pattern.

Thanks,
Song

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid10.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index d0de8c9fb3cf..fbaaa5e05edc 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1118,7 +1118,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, b=
ool from_schedule)
>                 spin_lock_irq(&conf->device_lock);
>                 bio_list_merge(&conf->pending_bio_list, &plug->pending);
>                 spin_unlock_irq(&conf->device_lock);
> -               wake_up(&conf->wait_barrier);
> +               wake_up_barrier(conf);
>                 md_wakeup_thread(mddev->thread);
>                 kfree(plug);
>                 return;
> @@ -1127,7 +1127,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, b=
ool from_schedule)
>         /* we aren't scheduling, so we can do the write-out directly. */
>         bio =3D bio_list_get(&plug->pending);
>         raid1_prepare_flush_writes(mddev->bitmap);
> -       wake_up(&conf->wait_barrier);
> +       wake_up_barrier(conf);
>
>         while (bio) { /* submit pending writes */
>                 struct bio *next =3D bio->bi_next;
> --
> 2.39.2
>
