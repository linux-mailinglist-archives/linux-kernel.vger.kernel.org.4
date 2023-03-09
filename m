Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADED6B2833
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjCIPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjCIPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:04:52 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753DC93CA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:02:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id d6so1228940pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvvFe6UE/AYXWScGr9mkG/95G71XHJDx0d83LjJ1ufA=;
        b=DGV9PtKUctpsFz094ALkkGzwPjnZ+iPH5p+KbK/pTLpKrg8EOlEs1M582z9aLqHXvG
         ZtQJJ/sqLkKIuYcoYpQeX3BedQg4/ZcO4klD/zpsNT5I5Vmu9G8p03ezEOhfsIkl8ayy
         2JvNykJW4XeO+HaR313gd2RYvIf1PMKOAPgY3b1LwBgALBJHfmm0ibPjzSp5ggchKo7b
         7KVmSzoV17NSAD6oGCJks3Yq26B4wEHMFdz/hS44vVgFQHX4wd1Ef60+yyy6JEaA+Tzv
         se2tL9KeBsdPEnhGUC1RL5hUyugCwl+9lQqiIjVrMqop7RwlhXN52pqG6sSrXbjeJEYd
         8P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvvFe6UE/AYXWScGr9mkG/95G71XHJDx0d83LjJ1ufA=;
        b=RLj3jnNCCLLBl3mg5CUNrGsbb0pLaBtm3pqvCye+sQWWY1s8KgKNNmxOBe9H/DD9oT
         r1VWk2P5fq1zV+bkp2LFLZUj0Kq9HQkz6oZ9SyViAwml2b2VH/e9pizvSbUkbExuqPnJ
         YQOy3wFvMPZHFEvd8SHbAeref1JIPvysn5gXGPHxAvtNyGzAOOFMSfA9S2be7gpXdNMC
         E0fPJ4NMgNRcXs26M4/Mpb+uqiYW45mruIv1rkxuA270Gha/7Px98Rz0k8Bd9wP2KVcd
         Sq5aVGOcl2mE89KAcbAKgEY8Wew5qCYBR0yrhxVQ36YezHaY0tCqnpt+7SmP2io/yUcr
         Biyg==
X-Gm-Message-State: AO0yUKUblWgqphVotKKO0EDPKuFatVe49wJnANOXehjmUE4kPxxCMlET
        /orT2oFOgtRhoYx7VahFaNJWwjBb5pSirfeVF7lyZA==
X-Google-Smtp-Source: AK7set8BvqTU8HcO89O4sLJTzLfcCTtLtR8RSfk0EY0PihdbgIh+Nawl1V6aNDZle+awq/RD+FaCggLV3wVTc0NL/pQ=
X-Received: by 2002:a63:7b4f:0:b0:503:ae1b:df3f with SMTP id
 k15-20020a637b4f000000b00503ae1bdf3fmr7927904pgn.5.1678374174636; Thu, 09 Mar
 2023 07:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20230307164338.1246287-1-zyytlz.wz@163.com>
In-Reply-To: <20230307164338.1246287-1-zyytlz.wz@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 16:02:18 +0100
Message-ID: <CAPDyKFoV9aZObZ5GBm0U_-UVeVkBN_rAG-kH3BKoP4EXdYM4bw@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: Fix UAF bug in r592_remove due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     maximlevitsky@gmail.com, oakad@yahoo.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 17:44, Zheng Wang <zyytlz.wz@163.com> wrote:
>
> In r592_probe, dev->detect_timer was bound with r592_detect_timer.
> In r592_irq function, the timer function will be invoked by mod_timer.
>
> If we remove the module which will call hantro_release to make cleanup,
> there may be a unfinished work. The possible sequence is as follows,
> which will cause a typical UAF bug.
>
> Fix it by canceling the work before cleanup in r592_remove.
>
> CPU0                  CPU1
>
>                     |r592_detect_timer
> r592_remove         |
>   memstick_free_host|
>   put_device;       |
>   kfree(host);      |
>                     |
>                     | queue_work
>                     |   &host->media_checker //use
>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/r592.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 1d35d147552d..2bfa7eaae80a 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -829,7 +829,7 @@ static void r592_remove(struct pci_dev *pdev)
>         /* Stop the processing thread.
>         That ensures that we won't take any more requests */
>         kthread_stop(dev->io_thread);
> -
> +       del_timer_sync(&dev->detect_timer);
>         r592_enable_device(dev, false);
>
>         while (!error && dev->req) {
> --
> 2.25.1
>
