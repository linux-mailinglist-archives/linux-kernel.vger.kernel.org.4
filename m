Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED8B714874
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjE2LUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjE2LUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B784DD8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685359205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKtwwKgdOHzbmoD1T/tHoH3aQvqf/6iMtVklqd9So0E=;
        b=hU9T1WEY4Og5ZjjkmmJQ6nv+DDmeSjIxB4e3Skb/HxrmN4BU/OvK84GMlMA2rw8GrP1ejy
        /F+drlBRm+mx3eGOMU3veWhm0OqsvMMMlaauxVrmY9DCst2zH6Nt6BC/eb5kjYV+BI7hJb
        wYyxtZu3ynR80CD2qRHNqpkr33VvtD4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-RwJkRKDPN2qUEFaFuOyK3Q-1; Mon, 29 May 2023 07:20:02 -0400
X-MC-Unique: RwJkRKDPN2qUEFaFuOyK3Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05FFA185A78F;
        Mon, 29 May 2023 11:20:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.99])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64375492B00;
        Mon, 29 May 2023 11:19:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 May 2023 13:19:43 +0200 (CEST)
Date:   Mon, 29 May 2023 13:19:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Christie <michael.christie@oracle.com>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230529111859.GA15193@redhat.com>
References: <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27, Eric W. Biederman wrote:
>
> Looking forward I don't see not asking the worker threads to stop
> for the coredump right now causing any problems in the future.
> So I think we can use this to resolve the coredump issue I spotted.

But we have almost the same problem with exec.

Execing thread will wait for vhost_worker() while vhost_worker will wait for
.release -> vhost_task_stop().

And even O_CLOEXEC won't help, do_close_on_exec() is called after de_thread().

Or suppose that vhost_worker's sub-thread forks a child with CLONE_FILES...

If we want CLONE_THREAD, I think vhost_worker() should exit after get_signal()
returns SIGKILL. Perhaps it should "disable" vhost_work_queue() somehow and
flush the pending works on ->work_list before exit, I dunno. But imo it should
not wait for the final fput().

Oleg.

