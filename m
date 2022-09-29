Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7265EFE37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiI2T4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI2T4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:56:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1461EC9AF;
        Thu, 29 Sep 2022 12:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 490F7B825AC;
        Thu, 29 Sep 2022 19:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53001C433D6;
        Thu, 29 Sep 2022 19:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664481394;
        bh=ueVyCyqKLOJheZs0NDcC8qb7bxKZZvsTV34Dzf1p6Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJhA0InpN9reJZOjC/TGDB/nLPtLV8JUGfVKgpQWMjtdBejJKtnZLI72bJWz+Sr3F
         CiakNlgJIa2xcSa/l868SpnL24xo8Q80fhB8ApxZ4S53BzJbaahI2FsTlK+n3WDfum
         XOZ38+HLc+YdG7BD4fr8nZEtfhLtBlHCRzTzM12A+VAcyq2qL012b76O81XTzDkfm+
         3T5NgiD63tY97CnkitXUuNEqBoZgzYSja+shvbJmCaoEsr+Xkn99m3qu+Mai6fO9bm
         QDGP+TGqxb6xwl6VbDVhDKrPYrd7ZtgBTN2d06hvggmYH6Leph1NTwvbEQnklS6128
         OjJ2Bz0lOeLGw==
Date:   Thu, 29 Sep 2022 13:56:30 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3] sbitmap: fix lockup while swapping
Message-ID: <YzX4brqWfvoa/ErM@kbusch-mbp.dhcp.thefacebook.com>
References: <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
 <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com>
 <20220926114416.t7t65u66ze76aiz7@quack3>
 <4539e48-417-edae-d42-9ef84602af0@google.com>
 <20220927103123.cvjbdx6lqv7jxa2w@quack3>
 <2b931ee7-1bc9-e389-9d9f-71eb778dcf1@google.com>
 <f975dddf-6ec-b3cb-3746-e91f61b22ea@google.com>
 <9f68731-e699-5679-6a71-77634767b8dd@google.com>
 <20220929083939.ioytch563qikyflz@quack3>
 <9c2038a7-cdc5-5ee-854c-fbc6168bf16@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2038a7-cdc5-5ee-854c-fbc6168bf16@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:50:12PM -0700, Hugh Dickins wrote:
> @@ -587,7 +587,7 @@ static struct sbq_wait_state *sbq_wake_p
>  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>  		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>  
> -		if (waitqueue_active(&ws->wait)) {
> +		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
>  			if (wake_index != atomic_read(&sbq->wake_index))
>  				atomic_set(&sbq->wake_index, wake_index);
>  			return ws;

This change makes sense and looks good. Thanks for the follow up.

Reviewed-by: Keith Busch <kbusch@kernel.org>
