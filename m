Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2570D5E94D2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiIYR1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYR1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019732EF19
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E8B61531
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 17:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB75C433D6;
        Sun, 25 Sep 2022 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664126865;
        bh=G8AhE091puvIfk84vjNGu05CrksOxdfRQxBTRO+WXFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kPiOzVKQqv88ISroT0CtAVeTceUlCEZDYjMaR/y2q8c3tysDNbGgJxGyNbnRhVeTp
         SUpdPz+Jfgivzbikfd0ojAA0i5MSLQIjEIHkfmlxlBhLkZ74ojoiEBMWfIjEHawxDl
         /O5jGbRNYjy48jftUhZLwfPMAz1GxsDe5TSGWBRg=
Date:   Sun, 25 Sep 2022 10:27:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] rapidio/tsi721: Replace flush_scheduled_work() with
 flush_work().
Message-Id: <20220925102742.84ccc07ce1e8e591e4d5ce0f@linux-foundation.org>
In-Reply-To: <0e8a2023-7526-f03a-f520-efafbb0ef45c@I-love.SAKURA.ne.jp>
References: <0e8a2023-7526-f03a-f520-efafbb0ef45c@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 14:11:25 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
> macro") says, flush_scheduled_work() is dangerous and will be forbidden.
> We are on the way for removing all flush_scheduled_work() callers from
> the kernel, and this patch is for removing flush_scheduled_work() call
>  from tsi721 driver.
> 
> Since "struct tsi721_device" is per a device struct, I assume that
> tsi721_remove() needs to wait for only two works associated with that
> device. Therefore, wait for only these works using flush_work().
> 
> --- a/drivers/rapidio/devices/tsi721.c
> +++ b/drivers/rapidio/devices/tsi721.c
> @@ -2941,7 +2941,8 @@ static void tsi721_remove(struct pci_dev *pdev)
>  
>  	tsi721_disable_ints(priv);
>  	tsi721_free_irq(priv);
> -	flush_scheduled_work();
> +	flush_work(&priv->idb_work);
> +	flush_work(&priv->pw_work);
>  	rio_unregister_mport(&priv->mport);

Why not use cancel_work[_sync](), as the flush_scheduled_work() comment
recommends?

