Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B650715366
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjE3CGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjE3CGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0082FC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90512629A5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA2AC433D2;
        Tue, 30 May 2023 02:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685412328;
        bh=lpVRrInRkjIGpIbSn0aKpHVNrVrO5AVlH73S71R1cP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LoQFyMLX+LQC91JJ+5QDDiRckZX21cHd2N1Hl5468z4gFEB9k9J/5ovLViOQB9Guc
         jDuUkN8DIdfYsH7W9WzYs3PKlX5XwAECb+JdZB0vQK1c0/xrJr5rjPMN+4Y/O8TDL0
         wvOBk5QFXw60Z024AOVn1QqszdlmEXB+tFg7hKSrO2vTaqb2Fm5T99mtclSk9dTvej
         dc348u+kR76BWnoWRq8+Fk95J8XUIgUzwESowEcdb3z4UMSqlwHUrPKmncnyAUtcb+
         HoNSLieOubVsVw3DOP0g3mI9JBZwhEFq0Pdy+4gZP6kDHTOVoKjSIE+g2hfzQjEJTH
         y0qmVfB1/4YRQ==
Date:   Mon, 29 May 2023 19:05:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ref_tracker: add stack_depot_save() failure handling to
 ref_tracker_alloc()
Message-ID: <20230529190526.65d13658@kernel.org>
In-Reply-To: <5fa8dfeb-8eb6-0de0-a335-e0b4336c29e0@I-love.SAKURA.ne.jp>
References: <5fa8dfeb-8eb6-0de0-a335-e0b4336c29e0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2023 20:04:11 +0900 Tetsuo Handa wrote:
> stack_depot_save() cannot accept __GFP_NOFAIL flag because
> __stack_depot_save() drops gfp flags which are not in
> GFP_KERNEL | GFP_ATOMIC | __GFP_NOWARN. Also, changing
> __stack_depot_save() to accept __GFP_NOFAIL is not possible
> because rmqueue() does not want __GFP_NOFAIL flag for
> order == DEPOT_POOL_ORDER allocation request.
> 
> Therefore, assume that stack_depot_save(GFP_KERNEL | __GFP_NOFAIL) from
> ref_tracker_alloc() can silently fail, and emit "unreliable refcount
> tracker." message.

It's probably a good idea to CC netdev@vger. I'm not sure if anyone
will pick this up from LKML. 

For the patch itself - I'm not sure it's needed, even if we don't
record the stack we'll have a tracker object and still detect the leak.
So printing the "unreliable refcount" message is not very precise. 
At least to me; Eric's opinion matters most.
