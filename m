Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15C6F03B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbjD0Jwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbjD0Jwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A092;
        Thu, 27 Apr 2023 02:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E698B63C25;
        Thu, 27 Apr 2023 09:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022C6C433EF;
        Thu, 27 Apr 2023 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682589153;
        bh=lDpLhb6oF6to7W+j3Bea839ZLvE12k39h5dsPWICeB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuX6BWDPYBtsbX8/2NU06aJrEdJZKJzgCLUP5duPvTh3xA6MHn5wjq4sY2c7y2eDM
         sMifHQnS9CBzV0TU4SncLFWx90ofXHC9uuSDf5J40GUkKzjRIavWLrTBNPl9VC8JnK
         EChbATmCfGQzWZHtoaYfxEwInABGzSJM+LHd8/Cs=
Date:   Thu, 27 Apr 2023 11:52:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     sangsup lee <k1rh4.lee@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: Fix a Use after-free-bug by race
 condition
Message-ID: <2023042702-shuffling-tweet-d9f6@gregkh>
References: <20230323013655.366-1-k1rh4.lee@gmail.com>
 <CAJkuJRjFCXkS+osc8ezpAw0E2W7WMAJnnxMt_cs4deqgm5OzHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJkuJRjFCXkS+osc8ezpAw0E2W7WMAJnnxMt_cs4deqgm5OzHw@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 06:29:16PM +0900, sangsup lee wrote:
> Is there any comment for this issue?

What issue?

> (reference: https://www.spinics.net/lists/kernel/msg4731408.html)

Please use lore.kernel.org links, we have no control over any other
random email archive .

And the above link just points to this proposed patch.

> 
> 
> 2023년 3월 23일 (목) 오전 10:37, Sangsup Lee <k1rh4.lee@gmail.com>님이 작성:
> >
> > From: Sangsup lee <k1rh4.lee@gmail.com>
> >
> > This patch adds mutex_lock for fixing an Use-after-free bug.
> > fastrpc_req_munmap_impl can be called concurrently in multi-threded environments.
> > The buf which is allocated by list_for_each_safe can be used after another thread frees it.

How was this tested?

> >
> > Signed-off-by: Sangsup lee <k1rh4.lee@gmail.com>
> > ---
> >  V1 -> V2: moving the locking to ioctl.
> >
> >  drivers/misc/fastrpc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index 93ebd174d848..aa1cf0e9f4ed 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -1901,7 +1901,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
> >                 err = fastrpc_req_mmap(fl, argp);
> >                 break;
> >         case FASTRPC_IOCTL_MUNMAP:
> > +               mutex_lock(&fl->mutex);
> >                 err = fastrpc_req_munmap(fl, argp);
> > +               mutex_unlock(&fl->mutex);

Are you sure you can call this function with the lock?  If so, why isn't
the mmap ioctl also locked?

thanks,

greg k-h
