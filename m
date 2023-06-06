Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A04724D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjFFTkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbjFFTkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E8110D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686080377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JwoXBtrJnmo+pBf7jYnvlWnPa+tCBA8O3lKlFGoTwY8=;
        b=Bm9K8c3US0dyHrDSx9t+9VTwL/V/CFp/leE1rv//v/lN8e3lHsptDRbmZJUQ03LesXIj1s
        Ul8zJ3zen3aeaDpzt2c69HDystk9RVq8dmCs4evafSdZeLOpR5OJtsH696ODO8KcA9r9eE
        T4L9oxaaTDVdR7mEjyPdqR4jLIrjmqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-evnAV1KsO8-Q6sc1uO10KA-1; Tue, 06 Jun 2023 15:39:34 -0400
X-MC-Unique: evnAV1KsO8-Q6sc1uO10KA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42EE3801224;
        Tue,  6 Jun 2023 19:39:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2F0FB140E954;
        Tue,  6 Jun 2023 19:39:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Jun 2023 21:39:11 +0200 (CEST)
Date:   Tue, 6 Jun 2023 21:39:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230606193907.GB18866@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06, Mike Christie wrote:
>
> On 6/6/23 7:16 AM, Oleg Nesterov wrote:
> > On 06/05, Mike Christie wrote:
> >
> >> So it works like if we were using a kthread still:
> >>
> >> 1. Userapce thread0 opens /dev/vhost-$something.
> >> 2. thread0 does VHOST_SET_OWNER ioctl. This calls vhost_task_create() to
> >> create the task_struct which runs the vhost_worker() function which handles
> >> the work->fns.
> >> 3. If userspace now does a SIGKILL or just exits without doing a close() on
> >> /dev/vhost-$something, then when thread0 does exit_files() that will do the
> >> fput that does vhost-$something's file_operations->release.
> >
> > So, at least in this simple case vhost_worker() can just exit after SIGKILL,
> > and thread0 can flush the outstanding commands when it calls vhost_dev_flush()
> > rather than wait for vhost_worker().
> >
> > Right?
>
> With the current code, the answer is no. We would hang like I mentioned here:
>
> https://lore.kernel.org/lkml/ae250076-7d55-c407-1066-86b37014c69c@oracle.com/

If only I could fully understand this email ;)

Could you spell to explain why this can't work (again, in this simple case) ?

My current (and I know, very poor) understanding is that .release() should
roughly do the following:

	1. Ensure that vhost_work_queue() can't add the new callbacks

	2. Call vhost_dev_flush() to ensure that worker->work_list is empty

	3. Call vhost_task_stop()

so why this sequence can't work if we turn vhost_dev_flush() into something like

	void vhost_dev_flush(struct vhost_dev *dev)
	{
		struct vhost_flush_struct flush;

		if (dev->worker) {
			// this assumes that vhost_task_create() uses CLONE_THREAD
			if (same_thread_group(current, dev->worker->vtsk->task)) {
				... run the pending callbacks ...
				return;
			}


			// this is what we currently have

			init_completion(&flush.wait_event);
			vhost_work_init(&flush.work, vhost_flush_work);

			vhost_work_queue(dev, &flush.work);
			wait_for_completion(&flush.wait_event);
		}
	}

?

Mike, I am just trying to understand what exactly vhost_worker() should do.

> We need to add code like I mentioned in that reply because we don't have a
> way to call into the layers below us to flush those commands.

This tells me nothing, but this is my fault, not yours. Again, again, I know
nothing about drivers/vhost.

Oleg.

