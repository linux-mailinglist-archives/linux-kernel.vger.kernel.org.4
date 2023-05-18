Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18F707BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjERIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjERIZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE52722
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7962560C1F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83B3C433D2;
        Thu, 18 May 2023 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684398310;
        bh=QJpMhH0TJiHzSerzZJVxxkzNu0w5DrjQrRF0GKGv91o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ov0jktHeTEfxsVqpwFx2dHtIeDnt3l2OKg2mm1lMx/LrKOY6/OiQ/Ti8jLOFY7Red
         +EgJ09imHKNglOL5wWEmBC67f81H5hf3rxuLHOXEy+k/6weler8mcrPnMiZZ9tqoni
         FQiaWGQjbmN7Zt8kWNPSLgcVMwfN5X5jbphW6Up0AvgQzhXmoJQHlBornFtcDcU4SW
         ggYuX1T0JAER6qMMVkeKzIgN0YEozmRCk8myK9UoUqLDZgWonsRbYdY1dlS+Y+1Y4N
         tXuWStt2LT2lhDPpw1GMgKtxdCENCCazPtzLCLoZq597iferaqeG7acL4DoEeyCtB5
         1DIX6+eZrEKRA==
Date:   Thu, 18 May 2023 10:25:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
Message-ID: <20230518-appetit-aufsicht-238e950b97d6@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 07:09:12PM -0500, Mike Christie wrote:
> This patch allows the vhost and vhost_task code to use CLONE_THREAD,
> CLONE_SIGHAND and CLONE_FILES. It's a RFC because I didn't do all the
> normal testing, haven't coverted vsock and vdpa, and I know you guys
> will not like the first patch. However, I think it better shows what

Just to summarize the core idea behind my proposal is that no signal
handling changes are needed unless there's a bug in the current way
io_uring workers already work. All that should be needed is
s/PF_IO_WORKER/PF_USER_WORKER/ in signal.c.

If you follow my proposal than vhost and io_uring workers should almost
collapse into the same concept. Specifically, io_uring workers and vhost
workers should behave the same when it comes ot handling signals.

See 
https://lore.kernel.org/lkml/20230518-kontakt-geduckt-25bab595f503@brauner


> we need from the signal code and how we can support signals in the
> vhost_task layer.
> 
> Note that I took the super simple route and kicked off some work to
> the system workqueue. We can do more invassive approaches:
> 1. Modify the vhost drivers so they can check for IO completions using
> a non-blocking interface. We then don't need to run from the system
> workqueue and can run from the vhost_task.
> 
> 2. We could drop patch 1 and just say we are doing a polling type
> of approach. We then modify the vhost layer similar to #1 where we
> can check for completions using a non-blocking interface and use
> the vhost_task task.

My preference would be to do whatever is the minimal thing now and has
the least bug potential and is the easiest to review for us non-vhost
experts. Then you can take all the time to rework and improve the vhost
infra based on the possibilities that using user workers offers. Plus,
that can easily happen in the next kernel cycle.

Remember, that we're trying to fix a regression here. A regression on an
unreleased kernel but still.
