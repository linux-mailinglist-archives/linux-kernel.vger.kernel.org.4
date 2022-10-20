Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAF6067F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJTSKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJTSKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:10:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71A16F74E;
        Thu, 20 Oct 2022 11:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90483B8274A;
        Thu, 20 Oct 2022 18:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA72C433D7;
        Thu, 20 Oct 2022 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666289379;
        bh=PBunTa7rce9oPUHewe2pTnhit7GvQJqymuWwU3QKUXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T6KODpSujSMwgSBYn8ps6OsFiGEP+mFua+xq2LF7eTAmVCFXap2zrS/xQskdZRnE3
         sX6muDQriwpDR8ycL/2J8aoBIPcJnM5F8FT3aZD2wmh0qRgH8TE2NhYpZ8XQowTc4R
         AFilFdujps4dudONDLufhK52DdFGHp5Kse+jkrtu1+fhYLGsoLLo9o3B3NUfXN39cj
         bp65K+KJzSANN87wy8wz/IDYYuG2lN3Isu/JdpCHHbkAaYIngamdyqJiUsz+kRsyWi
         0spb8hQKhsmznSY1j0NmKbNbcm9+G2EkHxv5sW5r8cvyfB8i6yuaQq0ADtV1rx1hKj
         ePH7bGJEhpV6Q==
Received: by mail-ej1-f48.google.com with SMTP id a26so1465070ejc.4;
        Thu, 20 Oct 2022 11:09:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf3g+BfHcZ9ADJSVA4HOcQcdAMBNAar4ttqM6haFPZQnlCgjPmxh
        tvpX5g6Txwm+6FnscNco6iImT/ms//bGSK9yaiA=
X-Google-Smtp-Source: AMsMyM6dBHethUPJpGWt/pGXdbIIfVcM3sIT6J9dz+n7IuFyddVg1deCn3XF+9udYMoHeEpl4tupoWZ4gVhAZEyiJik=
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id
 wu1-20020a170906eec100b00782638476bemr12134290ejb.756.1666289377447; Thu, 20
 Oct 2022 11:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221020155104.9485-1-ubizjak@gmail.com>
In-Reply-To: <20221020155104.9485-1-ubizjak@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 20 Oct 2022 11:09:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4z+ttCn6zUWwz+QB_+Ddfo0YDDqLxWeTHLLuXHSDoeEQ@mail.gmail.com>
Message-ID: <CAPhsuW4z+ttCn6zUWwz+QB_+Ddfo0YDDqLxWeTHLLuXHSDoeEQ@mail.gmail.com>
Subject: Re: [PATCH v2] raid5-cache: use try_cmpxchg in r5l_wake_reclaim
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 8:51 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> r5l_wake_reclaim. 86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg (and related move instruction in
> front of cmpxchg).
>
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
>
> Note that the value from *ptr should be read using READ_ONCE to prevent
> the compiler from merging, refetching or reordering the read.
>
> No functional change intended.
>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Applied to md-next. Thanks!

Song

> ---
> v2: Fix garbled subject line
> ---
>  drivers/md/raid5-cache.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index 832d8566e165..a63023aae21e 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -1565,11 +1565,12 @@ void r5l_wake_reclaim(struct r5l_log *log, sector_t space)
>
>         if (!log)
>                 return;
> +
> +       target = READ_ONCE(log->reclaim_target);
>         do {
> -               target = log->reclaim_target;
>                 if (new < target)
>                         return;
> -       } while (cmpxchg(&log->reclaim_target, target, new) != target);
> +       } while (!try_cmpxchg(&log->reclaim_target, &target, new));
>         md_wakeup_thread(log->reclaim_thread);
>  }
>
> --
> 2.37.3
>
