Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A417A7241E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjFFMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjFFMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B919E54
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686053840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=74VXFziIGlb0EFirVt9UAam6d4dNRVT+zKk4op/B4kY=;
        b=hp9ZSm3sAX2xGSJUAB1Pd76jrMx2h0n7lheCLVM6m5NJXWHB0VHgI8cUhYy2NuLFYHbMcE
        HxQU4EsStf2FSRiannPCECej9jyFUC/NUN5rubEJX+Jh1RuRqUZLx+tSpo7hcFYJ1Uv9NP
        Qm6e+gIdyzePB7XfMgJSlAVGWFlnX8Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-LwxI2Q6ANXKrf3btlqee9g-1; Tue, 06 Jun 2023 08:17:16 -0400
X-MC-Unique: LwxI2Q6ANXKrf3btlqee9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C23938149A4;
        Tue,  6 Jun 2023 12:17:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9295E40CFD46;
        Tue,  6 Jun 2023 12:17:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Jun 2023 14:16:53 +0200 (CEST)
Date:   Tue, 6 Jun 2023 14:16:44 +0200
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
Message-ID: <20230606121643.GD7542@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05, Mike Christie wrote:
>
> On 6/5/23 10:10 AM, Oleg Nesterov wrote:
> > On 06/03, michael.christie@oracle.com wrote:
> >>
> >> On 6/2/23 11:15 PM, Eric W. Biederman wrote:
> >> The problem is that as part of the flush the drivers/vhost/scsi.c code
> >> will wait for outstanding commands, because we can't free the device and
> >> it's resources before the commands complete or we will hit the accessing
> >> freed memory bug.
> >
> > ignoring send-fd/clone issues, can we assume that the final fput/release
> > should always come from vhost_worker's sub-thread (which shares mm/etc) ?
>
> I think I'm misunderstanding the sub-thread term.
>
> - Is it the task_struct's context that we did the
> kernel/vhost_taskc.c:vhost_task_create() from? Below it would be the
> thread we did VHOST_SET_OWNER from.

Yes,

> So it works like if we were using a kthread still:
>
> 1. Userapce thread0 opens /dev/vhost-$something.
> 2. thread0 does VHOST_SET_OWNER ioctl. This calls vhost_task_create() to
> create the task_struct which runs the vhost_worker() function which handles
> the work->fns.
> 3. If userspace now does a SIGKILL or just exits without doing a close() on
> /dev/vhost-$something, then when thread0 does exit_files() that will do the
> fput that does vhost-$something's file_operations->release.

So, at least in this simple case vhost_worker() can just exit after SIGKILL,
and thread0 can flush the outstanding commands when it calls vhost_dev_flush()
rather than wait for vhost_worker().

Right?

not that I think this can help in the general case ...

Oleg.

