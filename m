Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8E0624C96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiKJVIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiKJVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:07:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99005985A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:07:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789DF61E5A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8C1C433D6;
        Thu, 10 Nov 2022 21:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668114469;
        bh=3N4nFb8IOZ7MdllbuDFTvEp565pQV4206TPWRcmmQuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLgFCZbB1FzMOEC99Bhh0vnmm1JLBdghWNY7ikCvZr7YgsiKSoXasFSDbQzFPjn5s
         0rX5UzP8SGyh2J1NHCFgU8QV7aZ2ub00AT3H6EGe88zL7Baeq9dSYlfjpI2We0JR5J
         xIPkxmONFxaTqU1achAe91oAIdlwesxQBXVc8UC+m4DGpgN7KZ69P08vHJrOX8G2H3
         MVE1JXB6884uDPAD/4YvkosB4DF/D75oM84p014yDLpJfriRtQtSIE3fIa3oK0xlWt
         5CCYoI2IWNiinmDItj5ZOaTHUcW6TA31+bZ4Pj5RnlkSI68R63mWVKW47WMpisR/P6
         7hJiTA++ep/aQ==
Date:   Thu, 10 Nov 2022 13:07:48 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: remove gc_urgent_high_remaining node
Message-ID: <Y21oJCFmHjXhncTd@google.com>
References: <Y1wQp4Z9sHEqfWV1@google.com>
 <20221110081948.31673-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110081948.31673-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10, Yangtao Li wrote:
> Hi Jaegeuk,
> 
> > Hi,
> 
> > I modified and integrated some patches as below. Could you please take a look?
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d34f1e7212c1965a409d4581a32a92a1c91495fc
> 
> I've looked at the relevant changes on the branch, looks good to me.
> 
> One small question, does the name need to be changed to gc_remaining_count?
> There are already controls based on the number of gcs, maybe we can add a
> gc_remaining_ms later? Control the gc mode based on the expected time. When
> the count is reduced to 0 or the gc ends and the expected value is reached,
> switch back to the normal mode.

Please check the latest patch which replaced it with gc_remaining_trials.

I think the time-based control can be managed by user side instead of kernel.


> 
> Thx,
> Yangtao
