Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72230649B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiLLJ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiLLJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:27:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5907D111F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:27:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id f18so11397027wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n14Qp7bvZz4xqyR48Rh0IbAbnDSJAzA4A7nydUQ+ajg=;
        b=Z950nXBBkoH+Pf5+RcXPRfyTg9W7VPejvg0QaFLA3zpPx4767eSRVXW+GAM7vxw3cl
         LZKmtENuwEjZimXtE6Wor+k6iTCytH/sJObsD32xm/+YBOT77KB06vunlRY58OwANC1Y
         2tJn7Z31qFqqUCvtys73ZVKP8zgTxV6buC/1zq+MB9L8+hZ7mqo12/jYXvSnVgHtTCtI
         +xJpFEePXQGVSQq8plaIk5TJhU1UatdEYQLeZQa2AmITTCjIikDJoVQy48X6l+DfyBf8
         mvIf1TXbqDArbAE1Q8XBAzsICso1BDvyGT5o2+wGZw69r94gkjfRgHMUoaIvWhJAQWyt
         NrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n14Qp7bvZz4xqyR48Rh0IbAbnDSJAzA4A7nydUQ+ajg=;
        b=beESFhmmsue7c7wVVZFNI8dxDb6Y25ewf/VJlzpfLoqRHhVUqmDBVoDVNCJZz7YbZb
         9TwqOVE52R91S6n5fMxlV27Y85fIT3rtANxalQNd5SacjwRFRYLdVsKENJL0DcuYYY53
         z0e98kyk3/fsD/SdIoiNO31EvoeI3MiT4AWwbvz0u8g0KvN66li1p47ykRecn5NzNR8R
         yh6GutGvgPC4or9M4ko98KTDl+lii30ptRS6j5RsNvg0Nb/kmNFPH3cjjDOA/Lb9rTQm
         fCEH+zaZJxY5E38SR3tvQNOlJYIxYVdBMT/ATr/Yqi8NAoL7hJAKkX8OL28o5ZdGSu2k
         Em6Q==
X-Gm-Message-State: ANoB5pkzs6d7x6XPTqrDTSATkEEKpmAE0LT99jtyNwnXApXMEsuRvNpN
        O+Zbsu7uK4l4XeY7BHhOpxBO1oMIMqynWUZ/eKijbLiWY+g=
X-Google-Smtp-Source: AA0mqf7r9EvDGMb7nvUqMat+P4oTPtDVJSLM1basa08arMRiBc4Asz+PivJ/16mS3hAwzygnsqH1CU+dVoisCsl4SGI=
X-Received: by 2002:adf:ebc7:0:b0:242:359d:ea96 with SMTP id
 v7-20020adfebc7000000b00242359dea96mr19934622wrn.35.1670837228828; Mon, 12
 Dec 2022 01:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20221212061836.3620-1-richard.xnu.clark@gmail.com>
 <Y5bI9ZbjpzNFpk/8@slm.duckdns.org> <CAJhGHyA=qGtktv6BPavo5HRrDkcORqpkD3C7nhnxyFtt8WNJMg@mail.gmail.com>
In-Reply-To: <CAJhGHyA=qGtktv6BPavo5HRrDkcORqpkD3C7nhnxyFtt8WNJMg@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Mon, 12 Dec 2022 17:26:57 +0800
Message-ID: <CAJNi4rMYkOM5S7-TAPRdTFVEOcvXTQY-13TrgQBzAYRVNMNW1w@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Prevent a new work item from queueing into a
 destruction wq
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 2:48 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Mon, Dec 12, 2022 at 2:23 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Mon, Dec 12, 2022 at 02:18:36PM +0800, Richard Clark wrote:
> > > Currently the __WQ_DRAINING is used to prevent a new work item from queueing
> > > to a draining workqueue, but this flag will be cleared before the end of a
> > > RCU grace period. Because the workqueue instance is actually freed after
> > > the RCU grace period, this fact results in an opening window in which a new
> > > work item can be queued into a destorying workqueue and be scheduled
> > > consequently, for instance, the below code snippet demos this accident:
> >
> > I mean, this is just use-after-free. The same scenario can happen with
> > non-RCU frees or if there happens to be an RCU grace period inbetween. I'm
> > not sure what's being protected here.
>
> I think it is a kind of debugging facility with no overhead in the
> fast path.

Agree...

>
> It is indeed the caller's responsibility not to do use-after-free.
>
> For non-RCU free, the freed workqueue's state can be arbitrary soon and
> the caller might get a complaint. And if there are some kinds of debugging
> facilities for freed memory, the system can notice the problem earlier.

This case will trigger a noticeable kernel BUG

>
> But now is RCU free for the workqueue, and the workqueue has nothing
> different between before and after destroy_workqueue() unless the
> grace period ends and the memory-allocation subsystem takes charge of
> the memory.
>

    destroy_workqueue(wq0);
    schedule_timeout_interruptible(msecs_to_jiffies(1000));
    queue_work_on(1, wq0, &w0);

Sleep 1s to guarantee the RCU grace period completes, then the same
result with non-RCU free

Thanks

>
>
> Thanks
> Lai
