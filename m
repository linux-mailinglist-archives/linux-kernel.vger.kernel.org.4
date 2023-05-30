Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC8716376
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjE3OQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjE3OQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C591B1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EBE460C42
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CF1C433D2;
        Tue, 30 May 2023 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685456122;
        bh=xCnJV3dFLGFMxD2Qs7Vv/2tAqVA96nJWJLnUK+aey9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIfk5k7Zqt3aa/HxjTCTw2uHBSxXoY5ft8Xh30n/ie9uFURdSS1TdTVET2kckeloe
         YivV3D+MHXKXDqV5rr74KKH5glmrKv5t0GjUk2+9VS9zqVDp2FK31GafTPWA7nL0On
         VKkqinBXPdUDHf+bKKaSZ+OeYe2v6YqyrGOy5lmp7YwNmV/RfV+CzYn5KF9D5CE/Fo
         HhJE47Iy7rcl3DkKQ8kWFGEbNpl6WZvlee/bcI1fqG3F3oRtZ23SktPjrc1Go1HMUW
         pALUuRfl/papz3acXrzmFgQxe1ZnF85CqaRuTA7R2y+fnvjCu+/uE9wCa4/qhWHuOx
         JZlvI9+W4Vmmg==
Date:   Tue, 30 May 2023 16:15:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Christie <michael.christie@oracle.com>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230530-autor-faxnummer-01e0a31c0fb8@brauner>
References: <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230529111859.GA15193@redhat.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 01:19:39PM +0200, Oleg Nesterov wrote:
> On 05/27, Eric W. Biederman wrote:
> >
> > Looking forward I don't see not asking the worker threads to stop
> > for the coredump right now causing any problems in the future.
> > So I think we can use this to resolve the coredump issue I spotted.
> 
> But we have almost the same problem with exec.
> 
> Execing thread will wait for vhost_worker() while vhost_worker will wait for
> .release -> vhost_task_stop().
> 
> And even O_CLOEXEC won't help, do_close_on_exec() is called after de_thread().
> 
> Or suppose that vhost_worker's sub-thread forks a child with CLONE_FILES...
> 
> If we want CLONE_THREAD, I think vhost_worker() should exit after get_signal()
> returns SIGKILL. Perhaps it should "disable" vhost_work_queue() somehow and

Yes, and that's what I proposed at the beginning of this tread. We want
to have similar behavior as io_uring and cancel any oustanding work
instead of trying to finish it. But Mike was concerned because this
might be a change in behavior. Which I think is fine though. And it
complicates the code if we want to finish any outstanding work.
