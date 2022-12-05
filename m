Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38065643659
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiLEVFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiLEVEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:04:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5072B191
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:04:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C483261405
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 21:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C2C433C1;
        Mon,  5 Dec 2022 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670274240;
        bh=ZBUbOusq+sm0P5pmZB0m0ci+m3HFcOugwkBsLM2PR5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AbQoFTmRgLa+Lw57I/LL4SEMpmqg3FDZ1M7SQgVL2DDh/3hBNeuSWcf+7L2HL8kUf
         xb8bnASaAmnMSGIP58Ti6mu11cKV2jtrhYJzgdvBiQ5Hw9Y0vpvBepZ+oSOfbCie82
         R1EbPOfzdBXhbcjDIDMOgf3Bp+IWRk2nhSHuXeV8=
Date:   Mon, 5 Dec 2022 13:03:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <xialonglong1@huawei.com>
Subject: Re: [PATCH] mm: add cond_resched() in swapin_walk_pmd_entry()
Message-Id: <20221205130359.2c81c5df0fb777cf55495a02@linux-foundation.org>
In-Reply-To: <20221205140327.72304-1-wangkefeng.wang@huawei.com>
References: <20221205140327.72304-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 22:03:27 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> When handle MADV_WILLNEED in madvise(), the soflockup may be occurred
> in swapin_walk_pmd_entry() if swapin lots of memory on slow device,
> add a cond_resched() into it to avoid the possible softlockup.
> 
> ...
>
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -226,6 +226,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
>  			put_page(page);
>  	}
>  	swap_read_unplug(splug);
> +	cond_resched();
>  
>  	return 0;
>  }

I wonder if this would be better in walk_pmd_range(), to address other
very large walk attempts.

