Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB162564E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiKKJMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiKKJMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:12:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64345A0A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:12:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF50B61F0B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FEAC433C1;
        Fri, 11 Nov 2022 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668157919;
        bh=nWF/LUpmIzCoLlSE9IWrM8CZh5pW6RJDYoO5gbGF3QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipSXYwkcFWUAPXfy/V/09L1fjvZkjZgPBnhQGRvI0SQl/g8csBkktYZOkgTUdSPIM
         v/KC4EF80V7HLN8YjyEGIt0QtWA1pvzlIaimzbNJHJG21n5UmPF+mOyVzZvabsB5e6
         wKN0SkrP6pyGoG4fwTdu9GTFrwqqb02vig9sGuno=
Date:   Fri, 11 Nov 2022 10:11:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: hide illegible sysfs warning of kobject_del()
Message-ID: <Y24R3M8d2HHAu4DS@kroah.com>
References: <20221111065807.3278713-1-liushixin2@huawei.com>
 <Y23rC0N1cL2LQpyF@kroah.com>
 <d89eb156-3db2-df72-d21c-357baba3d377@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89eb156-3db2-df72-d21c-357baba3d377@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 04:27:03PM +0800, Liu Shixin wrote:
> 
> 
> On 2022/11/11 14:26, Greg Kroah-Hartman wrote:
> > On Fri, Nov 11, 2022 at 02:58:07PM +0800, Liu Shixin wrote:
> >> Some consumers do not care whether kobject_add() succeed or failed such as
> >> irqdesc. They call kobject_del() all the time even if kobject_add() failed.
> >> Then kernel will report some illegible sysfs warning like this:
> >>
> >>  kernfs: can not remove 'actions', no directory
> >>  WARNING: CPU: 0 PID: 277 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0
> > Why not fix the caller here?  Is that somehow not possible?
> The caller should be freed by kobject_put() if kobject_add() failed. But in fact, the failure does not affect
> the function of the caller. So the caller do not call kobject_put() Immediately.
> If want to fix the caller, we can check konj->state_in_sysfs before call kobject_del(). This way has no difference
> with check kobj->state_in_sysfs in kobject_del().

No, no code should ever be checking the state_in_sysfs flag before
calling this function.

When a kobject is done with, by the creator of it, then it can call
kobject_del().  It can NOT call that function multiple times, as that is
just wrong and goes against the whole way the kobject should be used.

So there is something very wrong with the caller code here, THAT should
be fixed.

> By the way, I'm not sure how many callers have this problem. So I think it's better to fix in kobject_del().

As we have never had this report before, I don't know of many problem
users.

Let's fix the root of the problem here please, do not paper over it by
allowing this function to be called multiple times, as that is an
indication that the reference counting logic of the caller is very
wrong.

thanks,

greg k-h
