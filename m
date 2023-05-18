Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6FC707B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjERIIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjERIIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:08:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C110D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4093646D4
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B69C433EF;
        Thu, 18 May 2023 08:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684397291;
        bh=OusTxtMih9zGfuMMoLAh2SZdg8oLmDX4HvuyhNv4jy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lvnw4djm+PjEeQwlFuEWvQm/nZ2O+gA2ugLE2x8w/0jKG1VqeO1aMvDlWKWXSqjG8
         IcOaRZjApWHhk7yU4FyADQWm9AKQKVG0BPVrWB2AUhCR+x8TIT4CtKinnH1pLKUQV4
         0qgnlKNeBfgcBOkwbPUB7jHN9DuXlhBcv+bssjKIEHiLqWETgfTrfz/Sp/cRXXCwQc
         Fd+mECneSSDyQ/aCcCNfAA7hr6b+Y2W7OOXUfRjKjGnaC3RAB7p4W08wW5MC/2Ugbt
         vTnEhAnFj1e8JBBoIaDrk5W72eEWoOiEEW9PSRLVSm1jFcwPY1Alq0XW//deu4rTjQ
         tuMEkcT+OkzIA==
Date:   Thu, 18 May 2023 10:08:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Message-ID: <20230518-kontakt-geduckt-25bab595f503@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518000920.191583-2-michael.christie@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 07:09:13PM -0500, Mike Christie wrote:
> This has us deqeue SIGKILL even if SIGNAL_GROUP_EXIT/group_exec_task is
> set when we are dealing with PF_USER_WORKER tasks.
> 
> When a vhost_task gets a SIGKILL, we could have outstanding IO in flight.
> We can easily stop new work/IO from being queued to the vhost_task, but
> for IO that's already been sent to something like the block layer we
> need to wait for the response then process it. These type of IO
> completions use the vhost_task to process the completion so we can't
> exit immediately.
> 
> We need to handle wait for then handle those completions from the
> vhost_task, but when we have a SIGKLL pending, functions like
> schedule() return immediately so we can't wait like normal. Functions
> like vhost_worker() degrade to just a while(1); loop.
> 
> This patch has get_signal drop down to the normal code path when
> SIGNAL_GROUP_EXIT/group_exec_task is set so the caller can still detect
> there is a SIGKILL but still perform some blocking cleanup.
> 
> Note that in that chunk I'm now bypassing that does:
> 
> sigdelset(&current->pending.signal, SIGKILL);
> 
> we look to be ok, because in the places we set SIGNAL_GROUP_EXIT/
> group_exec_task we are already doing that on the threads in the
> group.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---

I think you just got confused by the original discussion that was split
into two separate threads:

(1) The discussion based on your original proposal to adjust the signal
    handling logic to accommodate vhost workers as they are right now.
    That's where Oleg jumped in.
(2) My request - which you did in this series - of rewriting vhost
    workers to behave more like io_uring workers.

Both problems are orthogonal. The gist of my proposal is to avoid (1) by
doing (2). So the only change that's needed is
s/PF_IO_WORKER/PF_USER_WORKER/ which is pretty obvious as io_uring
workers and vhost workers no almost fully collapse into the same
concept.

So forget (1). If additional signal patches are needed as discussed in
(1) then it must be because of a bug that would affect io_uring workers
today.
