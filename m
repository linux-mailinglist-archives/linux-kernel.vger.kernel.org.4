Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811A4606741
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJTRrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJTRrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF9198462;
        Thu, 20 Oct 2022 10:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC3E61B4B;
        Thu, 20 Oct 2022 17:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088C8C43470;
        Thu, 20 Oct 2022 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666288035;
        bh=R58SloSkZJNs2f+jMVp8OnePu6OrZOnezUSWXEqsdSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LNRZ8u+1uS7SqR6aYqxwSUzHahgXN7Jv59k+yzRPxbhkgrEKM91A4yRAxuF9c5KdU
         cuAu4qjkT3ki41W2HR3AjrpeRYilOSgMhSDdgWBxbxQYVHkJw0FZsIBm8A0geFDS3k
         psvmQGR9Cbi2ft6XXB68wlbvMN3yZDfh7FFBkxbnYmbYqyiOxbI+uWVxk5eowIDr0j
         NZm7UH2Xkxrd+hbGCjy3hZeeCBBpneBSnI7tfEqTIwFwK8xySl8Ib/bC7ECNaiyLW1
         d053pTrph2z8phwZvMD49tfI5CXqQ5VL1uAj1Oi+1zYmXYPAxQoW86fpu0XR7dhRnt
         YGzVXN9iGq5GA==
Received: by mail-ej1-f49.google.com with SMTP id d26so1231980eje.10;
        Thu, 20 Oct 2022 10:47:14 -0700 (PDT)
X-Gm-Message-State: ACrzQf171s3ZI+OLUt3mWMhb1TUdrlyubxmYOCM4dsVjq5VrxwW8xbeN
        g/4CD0Rwepy1SlKQqAcHMLnJ8beHMFAo8EDpPIA=
X-Google-Smtp-Source: AMsMyM5D+R4LuYsDY86sucPnjTGdvXhl9R6Bd6whGckMGXpbxicb2Yyd7qTB4DoNw2h7V82yV/a5ujl82rwIxMj74EI=
X-Received: by 2002:a17:906:58c6:b0:78d:b37f:5ce5 with SMTP id
 e6-20020a17090658c600b0078db37f5ce5mr12019188ejs.707.1666288033278; Thu, 20
 Oct 2022 10:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220909040936.2610780-1-floridsleeves@gmail.com>
In-Reply-To: <20220909040936.2610780-1-floridsleeves@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 20 Oct 2022 10:47:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6JJLsdcv2gQY6QEhbTSRiamTtGo4GBL1uSoUx8ZsdKgw@mail.gmail.com>
Message-ID: <CAPhsuW6JJLsdcv2gQY6QEhbTSRiamTtGo4GBL1uSoUx8ZsdKgw@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/md/md-bitmap: check the return value of md_bitmap_get_counter()
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 9:09 PM Li Zhong <floridsleeves@gmail.com> wrote:
>
> Check the return value of md_bitmap_get_counter() in case it returns
> NULL pointer, which will result in a null pointer dereference.
>
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>

Somehow I didn't get v2 of this in my inbox. So replying to v1:

Applied v2 to md-next.

Thanks,
Song

> ---
>  drivers/md/md-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index bf6dffadbe6f..06ab1098ff99 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -2195,7 +2195,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
>
>                 if (set) {
>                         bmc_new = md_bitmap_get_counter(&bitmap->counts, block, &new_blocks, 1);
> -                       if (*bmc_new == 0) {
> +                       if (bmc_new && *bmc_new == 0) {
>                                 /* need to set on-disk bits too. */
>                                 sector_t end = block + new_blocks;
>                                 sector_t start = block >> chunkshift;
> --
> 2.25.1
>
