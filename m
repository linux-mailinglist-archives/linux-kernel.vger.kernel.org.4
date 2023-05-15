Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB0703EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbjEOUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjEOUk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57F2D66
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11DEA61F72
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D815AC433D2;
        Mon, 15 May 2023 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684183255;
        bh=Ycz5x4xauJooEI45uTwxsWwrEMcDCoaMGoPeFzflJMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBJ5GpTz5XrO2mUy/fQYFQ0hyJ+XYysi2gQscEI7GUVjouJ47/DIBlzXpp1lzgG7V
         kTfQvrpBvA141MPGgm85yIQC5z+sZTqS1cwPanWA7oqDoiZUTlJRfHy140WZ1m9Bp7
         mKTBgYLNqL/DHMbM2714lhYV9RuP6SNC7efBpyAJl2pChTSX30KLHkOr8k7B4XXqQH
         bnoIE1c9JPp7V+RPG1yHOe94aSbAam3bFAQYq4WpCtiR7NKijOvnBE6WQHVQM9hWjC
         +VxDlZAQV6H0oGx4BZnfNZmzEcnt2u4CvJkD7JEmIhL7DOpTJSjyZogvhyFFyAn/kZ
         HBx5z+AllSHkQ==
Date:   Mon, 15 May 2023 14:40:52 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     jiweisun126@126.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me, ahuang12@lenovo.com,
        sunjw10@lenovo.com
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <ZGKY1A1q5Px64v9h@kbusch-mbp>
References: <20230502125412.65633-1-jiweisun126@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502125412.65633-1-jiweisun126@126.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> A soft lockup issue will be triggered when do fio test on a 448-core
> server, such as the following warning:

...

> According to the above two logs, we can know the nvme_irq() cost too much
> time, in the above case, about 4.8 second. And we can also know that the
> main bottlenecks is in the competition for the spin lock pool->lock.

The most recent 6.4-rc has included a significant changeset to the pool
allocator that may show a considerable difference in pool->lock timing.
It would be interesting to hear if it changes your observation with your
448-core setup. Would you be able to re-run your experiements that
produced the soft lockup with this kernel on that machine?
