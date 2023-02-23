Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978926A1245
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBWVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBWVs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:48:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097E3F77B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:48:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D8F7B81AB7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 21:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDD0C4339B;
        Thu, 23 Feb 2023 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677188898;
        bh=1uH85J31wjCE9rL1eHDJcDdPRwd1mAfcvOY7PpzaXhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RHcaiN3JsUZSzsIP2ayAeBgme88GgyvBlUvl0ZbYCuBbNuIma5h2ZOQVGyqgbXC1j
         IYyIsvoRtTWiULtvg282Daxu5yXOzQxCJ2sAwv4dLHb1LJ33BHjm2XoHtaQTdWcnPs
         IEhKjJiSWByyqKinXGpBZ23XhK/ikeg6phmKoFgo=
Date:   Thu, 23 Feb 2023 13:48:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Alexander Halbuer <halbuer@sra.uni-hannover.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, page_alloc: batch cma update on pcp buffer refill
Message-Id: <20230223134817.dc1669b51a9c39850a6f86cb@linux-foundation.org>
In-Reply-To: <89778da7-74a3-2f2a-1668-afe7b15487dc@suse.cz>
References: <20230217120504.87043-1-halbuer@sra.uni-hannover.de>
        <89778da7-74a3-2f2a-1668-afe7b15487dc@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 11:27:14 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> 
> > The tables below compare this patch with the initial one using a
> > parallel allocation benchmark. The used kernel config is based on the default
> > debian config but with CONFIG_INIT_ON_ALLOC_DEFAULT_ON=FALSE and
> > CONFIG_CMA=TRUE. The benchmarks have been performed with the default sanity
> > checks enabled as the patch "mm, page_alloc: reduce page alloc/free sanity
> > checks" [2] was not enabled on my test branch.
> > The given times are average allocation times. The improvement is not
> > significant, but the general trend is visible.
> 
> Yeah there's some improvement, but if [2] is accepted, then keeping two
> loops there just for the cma update (as there will be no more checking in
> the second loop) will almost certainly stop being a win. And with the risk
> of inaccuracy you pointed out, on top.
> 
> ...
>
> > [2] https://lore.kernel.org/linux-mm/20230216095131.17336-1-vbabka@suse.cz/

I've just added "mm, page_alloc: reduce page alloc/free sanity checks"
to mm-unstable.  
