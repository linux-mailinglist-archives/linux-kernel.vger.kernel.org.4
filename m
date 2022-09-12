Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D7D5B5D65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiILPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiILPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:40:02 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4810568
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:40:01 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-348b1838c2bso106192077b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ttNzZSx3jrxIILvBSZcQjyqPqH3ivzfPl2XmSy++hYo=;
        b=AVnaTeVxJrAoIl1A6oyE87dM71c4ZAaZ4OXrCj78m2W+gZcM9XgveEszn7AHepFTAe
         Ba/XydQZ7fc+db7lW6PBABCnNC+vg3UrxR77VZ+nortoDXxaHRWkMV6ix0HatVZi8CBw
         RCN6HsJsI0ma8QcVxGCVxkpZK/6q5D+ivRrEkCxoBiFh1Lrgb2Fh2QRpn/D/ffyXQbhy
         joraXV5Tsu6TL9y6kSt5WKefxIc+uRVkDD/FjGTZKRdLJuICtablcNsG4R+7DzOELXqJ
         JByOy8DQzVl2Xi6goMCLjpAyf9zTY5Q8IwbLvFiGFiP+zV+BPqMnLZ0vWQ5GWaJwuh2H
         EIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ttNzZSx3jrxIILvBSZcQjyqPqH3ivzfPl2XmSy++hYo=;
        b=bBa2TE7RUi9zONg6rFVmJCezWFRwSggyMzh4C+qKNv9J2hQF+zGeG1Kio1REnyWl5j
         5wR4NgW54YtUv0XsbBCAkwulj2ZrcFSGSbtXMxRT2niO2GTD1oPn4PA5VeL0ahmpkid2
         nARycFWWzjig9jP/+2LY4l5zww9+aqw4j8U2x9XWBoKiKlrl37TabkiYN59K8+5S39Jl
         UmWpfmIgAq88gY3SLALGLlP9yFGCw6TB4WZup5Ael/gudWiO+f5Svut8k5s+kAbMovL2
         FJnslg75KweQ6Te9dmt+t6fHdcBl7eDAkX/YmJ5L+dZX4bH6v0X3z5IK9kD1iZdtGa3f
         Y+nw==
X-Gm-Message-State: ACgBeo0hgMFW9AAqkgS4Gaopnzb9Y+E1w/6GPAl3bPiZSsxE2LeIpcMj
        HRtVbC8vI7jWGU1DYepaSRzL4bpBB2xKgmZRbt7JqQ==
X-Google-Smtp-Source: AA6agR5CLtqVB5u7RNICJte7KsMleC8P6MKKCnVbqly+PAhZT1A8DFxj+qg8uxPwuRrE/JLfk6nLSsQgINH6CGrwIYg=
X-Received: by 2002:a0d:d5d1:0:b0:345:31d1:89af with SMTP id
 x200-20020a0dd5d1000000b0034531d189afmr23022732ywd.456.1662997200368; Mon, 12
 Sep 2022 08:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220912152744.527438-1-senozhatsky@chromium.org>
In-Reply-To: <20220912152744.527438-1-senozhatsky@chromium.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 12 Sep 2022 11:39:05 -0400
Message-ID: <CADyq12z8ijE__cgxdMssoE6Ooz4zdazsZ-TeipLTNqqis2vSzA@mail.gmail.com>
Subject: Re: [PATCHv2] zram: do not waste zram_table_entry flags bits
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:29 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> zram_table_entry::flags stores object size in the lower bits and
> zram pageflags in the upper bits. However, for some reason, we
> use 24 lower bits, while maximum zram object size is PAGE_SIZE,
> which requires PAGE_SHIFT bits (up to 16 on arm64). This wastes
> 24 - PAGE_SHIFT bits that we can use for additional zram pageflags
> instead.
>
> Also add a BUILD_BUG_ON() to alert us should we run out of bits
> in zram_table_entry::flags.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c |  2 ++
>  drivers/block/zram/zram_drv.h | 15 +++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index f3948abce2f7..07913bcdb5c2 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2449,6 +2449,8 @@ static int __init zram_init(void)
>  {
>         int ret;
>
> +       BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);

Should this be >= BITS_PER_LONG?

> +
>         ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
>                                       zcomp_cpu_up_prepare, zcomp_cpu_dead);
>         if (ret < 0)
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index b4eecef2a11f..2b50f0521bd3 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -30,16 +30,15 @@
>
>
>  /*
> - * The lower ZRAM_FLAG_SHIFT bits of table.flags is for
> - * object size (excluding header), the higher bits is for
> - * zram_pageflags.
> + * ZRAM is mainly used for memory efficiency so we want to keep memory
> + * footprint small and thus squeeze size and zram pageflags into a flags
> + * member. The lower ZRAM_FLAG_SHIFT bits is for object size (excluding
> + * header), which cannot be larger than PAGE_SIZE (requiring PAGE_SHIFT
> + * bits), the higher bits are for zram_pageflags.
>   *
> - * zram is mainly used for memory efficiency so we want to keep memory
> - * footprint small so we can squeeze size and flags into a field.
> - * The lower ZRAM_FLAG_SHIFT bits is for object size (excluding header),
> - * the higher bits is for zram_pageflags.
> + * We use BUILD_BUG_ON() to make sure that zram pageflags don't overflow.
>   */
> -#define ZRAM_FLAG_SHIFT 24
> +#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
>
>  /* Flags for zram pages (table[page_no].flags) */
>  enum zram_pageflags {
> --
> 2.37.2.789.g6183377224-goog
>
