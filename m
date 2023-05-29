Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81C3714F02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjE2RsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE2RsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DDC7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685382434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQ6O0cE8673VatXWo3WOH4FGuXlirbmlPmU9z6UkWkA=;
        b=SH7J86rg2J+JooGeSeA50jLxV+R2xrsMijy9zPGyzIkZcOSjgNzWuhHTwgIecW59QIryl2
        aIdECBiNffFdnD6EhgogPr/WCiDq+IlhgE+YUtozrENYyQiXv1QRh42K31SCLoO+/lafi9
        CGOaQ5ZSpmFlm46Rpw4ZMypMkaSUu1g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-4R9wNrFdPXGWKDuWSBBpUA-1; Mon, 29 May 2023 13:47:09 -0400
X-MC-Unique: 4R9wNrFdPXGWKDuWSBBpUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BD912A59575;
        Mon, 29 May 2023 17:47:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.99])
        by smtp.corp.redhat.com (Postfix) with SMTP id 60EB217103;
        Mon, 29 May 2023 17:47:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 May 2023 19:46:50 +0200 (CEST)
Date:   Mon, 29 May 2023 19:46:46 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     michael.christie@oracle.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230529174646.GB15193@redhat.com>
References: <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike, sorry, I don't understand your email.

Just in case, let me remind I know nothing about drivers/vhost/

On 05/29, michael.christie@oracle.com wrote:
>
> On 5/29/23 6:19 AM, Oleg Nesterov wrote:
> > On 05/27, Eric W. Biederman wrote:
> >>
> >> Looking forward I don't see not asking the worker threads to stop
> >> for the coredump right now causing any problems in the future.
> >> So I think we can use this to resolve the coredump issue I spotted.
> >
> > But we have almost the same problem with exec.
> >
> > Execing thread will wait for vhost_worker() while vhost_worker will wait for
> > .release -> vhost_task_stop().
>
> For this type of case, what is the goal or correct behavior in the end?
>
> When get_signal returns true we can code things like you mention below

and you have mentioned in the next email that you have already coded something
like this, so perhaps we can delay the further discussions until you send the
new code?

> and
> clean up the task_struct.

Hmm... If we you CLONE_THREAD the exiting vhost_worker() will auto-reap itself,

> However, we now have a non-functioning vhost device
> open and just sitting around taking up memory and it can't do any IO.

can't comment, see above.

> For this type of case, do we expect just not to crash/hang, or was this new
> exec'd thread suppose to be able to use the vhost device?

I just tried to point out that (unless I missed something) there are more corner
cases, not just coredump.

> > Or suppose that vhost_worker's sub-thread forks a child with CLONE_FILES...
>
> You mean the vhost_task's task/thread doing a function that does a copy_process
> right?

I meant that the vhost_task's sub-thread can do sys_clone(CLONE_FILES) from
userspace. Yes, this implies copy_process() but I still can't understand you.

> That type of thing is not needed.

Do you mean that userspace should never do this? But this doesn't matter, the
kernel should handle this case anyway.

Or what?

In short let me repeat that I don't understand you and - of course! - quite
possibly I missed something.

Oleg.

