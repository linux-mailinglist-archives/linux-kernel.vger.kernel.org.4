Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1406E7005
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjDRXoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRXom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC73C1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681861434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95IpKdJ2kg9KlzNkeT0HkrK8mW9zXchxjdpYGfWrZng=;
        b=OOf5sSQjgWhmtS6iuDEFTCVRp2CXyMNxhaeM2NWBJKbHqfr0+axdEKHtnX1RobZciAZ/1I
        B+6/rIp9c0PVsFsjgo5dWmtbRCKaCEhRXK72Pg+P4Bc/JtQfmZeIPqPUGZZ/kCwCTHrPOz
        jxZdoShGF8sezoaNlx1qr4GVrmw9Tx4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-ECWknCGRNTmLuL68kXq2gw-1; Tue, 18 Apr 2023 19:43:51 -0400
X-MC-Unique: ECWknCGRNTmLuL68kXq2gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9991A800047;
        Tue, 18 Apr 2023 23:43:50 +0000 (UTC)
Received: from [10.22.16.74] (unknown [10.22.16.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1897F5AB7A;
        Tue, 18 Apr 2023 23:43:49 +0000 (UTC)
Message-ID: <e3f9c399a6ef26a145a9fcc53201bbd98d9428ee.camel@redhat.com>
Subject: Re: [PATCH] locking/rtmutex: Flush the plug before entering the
 slowpath.
From:   Crystal Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date:   Tue, 18 Apr 2023 18:43:48 -0500
In-Reply-To: <20230418151838.jNcnnDqL@linutronix.de>
References: <20230322162719.wYG1N0hh@linutronix.de>
         <20230418151838.jNcnnDqL@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-18 at 17:18 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-03-22 17:27:21 [+0100], To Thomas Gleixner wrote:
> > blk_flush_plug() is invoked on schedule() to flush out the IO progress
> > that has been made so far so that it is globally visible. This is
> > important to avoid deadlocks because a lock owner can wait for IO.
> > Therefore the IO must be first flushed before a thread can block on a
> > lock.
> >=20
> > The plug flush routine can acquire a sleeping lock which is contended.
> > Blocking on a lock requires an assignment to task_struct::pi_blocked_on=
.
> > If blk_flush_plug() is invoked from the slow path on schedule() then th=
e
> > variable is already set and will be overwritten by the lock in
> > blk_flush_plug().
> > Therefore it is needed to invoke blk_flush_plug() (and block on
> > potential locks in the process) before the blocking on the actual lock.
> >=20
> > Invoke blk_flush_plug() before blocking on a sleeping lock. The
> > PREEMPT_RT only sleeping locks (spinlock_t and rwlock_t) are excluded
> > because their slow path does not invoke blk_flush_plug().
> >=20
> > Fixes: e17ba59b7e8e1 ("locking/rtmutex: Guard regular sleeping locks
> > specific functions")
> > Reported-by: Crystal Wood <swood@redhat.com>
> > Link:
> > https://lore.kernel.org/4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@=
redhat.com
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> polite ping.

Sorry, got distracted.  It does appear to make the asserts go away but I ra=
n
into other possibly related stalls when running rteval -- but if I remove
both the asserts and your patch it hangs in a different way, so I need to
investigate some more.

-Crystal

