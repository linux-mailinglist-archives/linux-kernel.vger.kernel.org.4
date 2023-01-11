Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17834665033
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjAKAD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjAKADv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:03:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58701E3CC;
        Tue, 10 Jan 2023 16:03:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 923C5B80F92;
        Wed, 11 Jan 2023 00:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D660CC433D2;
        Wed, 11 Jan 2023 00:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673395428;
        bh=+OnFk+nK2FJmejEzbeXpqhqfabYhGoHiq3T5ktvxINM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eImWOhdQkI/PtTOlc6FwsU5bJ5gZfkgokwiatUTAT5sSMZyzcc/5OG6Cj2FpYy0Ji
         uSo4fCT14oSdvWIMNNCrozckkzLwfFno3ogSovtwTkqsXEKV8vnqynwOIP0vQDdmZn
         N2/H0rokjq7tkxNGbfCUEYLaX6K/QD5d2SwopIR4=
Date:   Tue, 10 Jan 2023 16:03:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org, jgg@nvidia.com,
        logang@deltatee.com, hch@lst.de, alex.williamson@redhat.com,
        leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Message-Id: <20230110160347.c1d771e4ea21e4b95bfa8477@linux-foundation.org>
In-Reply-To: <f37f8e60-d580-0b7c-0fa5-a26ab49c9781@kernel.dk>
References: <20230109144701.83021-1-yishaih@nvidia.com>
        <f37f8e60-d580-0b7c-0fa5-a26ab49c9781@kernel.dk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 20:18:39 -0700 Jens Axboe <axboe@kernel.dk> wrote:

> On 1/9/23 7:47 AM, Yishai Hadas wrote:
> > The last_pg is wrong, it is actually the first page of the last
> > scatterlist element. To get the last page of the last scatterlist
> > element we have to add prv->length. So it is checking mergability
> > against the wrong page, Further, a SG element is not guaranteed to end
> > on a page boundary, so we have to check the sub page location also for
> > merge eligibility.
> > 
> > Fix the above by checking physical contiguity, compute the actual last
> > page and then call pages_are_mergable().
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 
> Andrew, can you pick this one up?

This patch is against Yishai's 

CommitDate: Thu Jan 5 16:01:05 2023 -0400

    lib/scatterlist: Fix to merge contiguous pages into the last SG properly
    

which is in -next, apparently via a tree of Jason's.  So I'll assume
that Jason will handleit?

