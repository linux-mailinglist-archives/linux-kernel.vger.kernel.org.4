Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C226CA9DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjC0QCe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjC0QCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:02:06 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976135FDC;
        Mon, 27 Mar 2023 09:01:37 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id i5so38460567eda.0;
        Mon, 27 Mar 2023 09:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Tc92jHKfzCM4jUDYAxaTKlNKg/5FTvfvoaAMWmN/OQ=;
        b=mb525LNVTuNpuaGSn7Xf1LNE/4/6BXVqvA5ibcQbKG2seFxUD/+ds2nzcVTi4k7AB8
         fGxMZ0xEm5NKf4onIaxNLdKywTDOk9yKKhVO9scNLGzEMRMETtH9YIL9BrNN42yON87e
         S/7VKcMvN4xxv0WEwpxVCWJGML8mlAqmTtSoOcO8ZWtwwUlFHyVgFK5TomvqdT0P6FBA
         CLQCjsT3XyLh70O0AuBjqcaqDc4i57lw4Z+22ZbGSKCua7Zr42nxOfgkquQYBiFKw3xh
         nKNV/Xq5cm5m6Vd37cqYM3zMESa7N+UMbD7peaQglwJMeIzP/CSXRlCVkWrEilDrWjPO
         wvLw==
X-Gm-Message-State: AAQBX9eJlLzl6xFDWSZ5w1rBKhBpDjEZFP2JC2+VcAsKtS7M8mXgpxIF
        GP7L65q8WeKeIGXpq3Oyl2ovPFcrJcKD+PDgbsQ=
X-Google-Smtp-Source: AKy350YgZX9In/W9hp5TUd0tJLk0yAccI5vepKK0RbxyNnymI8UpbQqZDC5h/S6zQjHHSL3PDL7hxoHUlXqvd8nfg8k=
X-Received: by 2002:a17:907:d02:b0:931:6921:bdbb with SMTP id
 gn2-20020a1709070d0200b009316921bdbbmr5766122ejc.2.1679932895870; Mon, 27 Mar
 2023 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230303055133.28752-1-luoxueqin@kylinos.cn>
In-Reply-To: <20230303055133.28752-1-luoxueqin@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:01:24 +0200
Message-ID: <CAJZ5v0jdCx3PB1JOgEc8ZhDvvXNBzcfYYsSy5PB4s29PfoQ8Rg@mail.gmail.com>
Subject: Re: [PATCH v2] PM/hibernation: set the default image size for large memory
To:     Xueqin Luo <luoxueqin@kylinos.cn>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 6:51 AM Xueqin Luo <luoxueqin@kylinos.cn> wrote:
>
> From: xueqin Luo <luoxueqin@kylinos.cn>
>
> As computers have more and more memory, they can store larger and
> larger images. This poses a problem. Let's take a 16GB computer as
> an example. When the number of pre-allocated pages is greater than
> 900,000 and smaller than image_size, the duration of S4 increases
> with the number of saved pages. When the number of pre-allocated
> pages reaches 1.2 million, the duration of S4 increases by 8-10s.

Well, I'm not quite sure what the problem is from the description
above.  Can you please explain?

> We found that the image size is generally more than 900,000 pages,
> so we set the default size of image_size for 16GB and above
> computers to 1 million pages, which can reduce the running time
> of S4 under certain conditions.
>
> This is the test data for 5 hours after the computer is turned on:
>
> Original kernel begin:
>
> [2023-02-24 19:16:56] [   46.105423][ 2] [ T3075] PM: hibernation entry
> [2023-02-24 19:16:59] [   47.632000][ 1] [ T3075] done (allocated
> 959239 pages)
> [2023-02-24 19:18:05] [   56.987043][ 2] [ T3075] PM: hibernation exit
>
> Five hours later:
>
> [2023-02-25 00:22:48] [18069.651640][ 4] [ T7590] PM: hibernation entry
> [2023-02-25 01:23:59] [21671.194049][ 0] [ T8563] done (allocated
> 1228878 pages)
> [2023-02-25 00:24:06] [18080.639889][ 2] [ T7590] PM: hibernation exit
>
> After 5h, you can see that the S4 takes 8s more time.
>
> Five hours later, the modified kernel test data:
>
> [2023-02-24 15:52:08] [18190.171183][ 7] [T11151] PM: hibernation entry
> [2023-02-24 15:52:11] [18191.677021][ 7] [T11151] done (allocated
> 792597 pages)
> [2023-02-24 15:53:15] [18201.028488][ 2] [T11151] PM: hibernation exit
>
> You can see that after five hours, the time has changed little compared
> to the initial test data.
>
> Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
> ---
>
> v3: modify some comments
>
> v2: add test data
>
>  kernel/power/snapshot.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index cd8b7b35f1e8..fa3950b19849 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -136,7 +136,14 @@ unsigned long image_size;
>
>  void __init hibernate_image_size_init(void)
>  {
> -       image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> +       /* The totalram pages() for a computer of 16 memory size is
> +        * equal to 4032990 pages. And according to our observation,
> +        * the average image size is less than 1 million pages.
> +        */
> +       if (totalram_pages() < 4032990)
> +               image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> +       else
> +               image_size = 1000000 * PAGE_SIZE;
>  }
>
>  /*
> --
> 2.25.1
>
