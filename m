Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122A15E727E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiIWDhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIWDhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C0DF04E;
        Thu, 22 Sep 2022 20:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D57EC60FBC;
        Fri, 23 Sep 2022 03:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10E2C433C1;
        Fri, 23 Sep 2022 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663904230;
        bh=QmPpWXopgwAL7Zd/o9BkL4CFysr+ibZl4lTx3Cwj4jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4dbFjs1oyMJXwiwCltNONDBQKjZID3es7CHLiQ8jZF+fRgJ8CDpKbOQZ1O45BLCO
         MmNAChVSB5mmH1tr5QGDqkdQ9pqTlcawgEtYew3JClA0IUh2eEnT1oNSz0hkR98+JU
         A7OnpUAoy9jofoV/G3dUWAWnQdU5uwoQq9BdLYPYAcwt1BV7hTgPj/7Ry5F+bAfKnv
         sKkJnHbewEYUY85aITfJC6A1nnpxe7kUCXtehoB359a0HYqVm2dA+3N/kN0udxzpGL
         nfcbDcAl81OFcajInTCY9yDUUMubg/O35BjMi/AsZkzkqitpfpvLP2T2yrpYhyPy9Z
         LhLqbp70tiB3g==
Date:   Thu, 22 Sep 2022 20:37:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: Re: [PATCH v3 5/5] elevator: remove redundant code in
 elv_unregister_queue()
Message-ID: <Yy0p5O36yrnYCgH4@sol.localdomain>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922113558.1085314-6-yukuai3@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 07:35:58PM +0800, Yu Kuai wrote:
> "elevator_queue *e" is already declared and initialized in the beginning
> of elv_unregister_queue().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/elevator.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 7cb61820cfa0..0a72d6fbbdcc 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -524,8 +524,6 @@ void elv_unregister_queue(struct request_queue *q)
>  	lockdep_assert_held(&q->sysfs_lock);
>  
>  	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
> -		struct elevator_queue *e = q->elevator;
> -
>  		kobject_uevent(&e->kobj, KOBJ_REMOVE);
>  		kobject_del(&e->kobj);
>  	}
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
