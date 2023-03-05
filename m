Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE436AAE53
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 06:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCEFlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 00:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCEFlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 00:41:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEE411161
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 21:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677994816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93ewmt7hx/NarRr04m7o90fAGbJeWbKZNPS0BU4Q0G4=;
        b=M22+uPtNxcZ6xsRk0kc/DK7Uwjwh3RFLgQH7ChsD2WJLoU3dkZv+nmMS4ML+K89fuUzU/C
        nHI+39c7TjSPmUgWLnC+R+9xGXsFCOEQSHJ9GOuICZNyECFZX7q08WEqwhBtJwsgOHmwf/
        3pQyW5W4yDSWadbUiOhG8pxASb0byGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-J91x9EPvPnKdaPwFWwnw5A-1; Sun, 05 Mar 2023 00:40:00 -0500
X-MC-Unique: J91x9EPvPnKdaPwFWwnw5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C54FC833941;
        Sun,  5 Mar 2023 05:39:59 +0000 (UTC)
Received: from [10.22.17.193] (unknown [10.22.17.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5836B2166B29;
        Sun,  5 Mar 2023 05:39:58 +0000 (UTC)
Message-ID: <84c1de84ac129de7c7597c48d3ec19ccc0672492.camel@redhat.com>
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
From:   Crystal Wood <swood@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Keeping <john@metanate.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 04 Mar 2023 23:39:57 -0600
In-Reply-To: <874jrgqjsw.ffs@tglx>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
         <Y+47FVJ+hI+NA2In@linutronix.de> <87k00cr7ix.ffs@tglx>
         <Y/NT1/ynarp9cDlS@linutronix.de> <Y/NcnrwKr2u6tamQ@linutronix.de>
         <874jrgqjsw.ffs@tglx>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-02-20 at 19:21 +0100, Thomas Gleixner wrote:
> On Mon, Feb 20 2023 at 12:42, Sebastian Andrzej Siewior wrote:
> > On 2023-02-20 12:04:56 [+0100], To Thomas Gleixner wrote:
> > > The ->pi_blocked_on field is set by __rwbase_read_lock() before
> > > schedule() is invoked while blocking on the sleeping lock. By doing
> > > this
> > > we avoid __blk_flush_plug() and as such will may deadlock because we
> > > are
> > > going to sleep and made I/O progress earlier which is not globally
> > > visibly but might be (s/might be/is/ in the deadlock case) expected b=
y
> > > the owner of the lock.
>=20
> Fair enough.
>=20
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -1700,6 +1700,13 @@ static __always_inline int __rt_mutex_lock(struc=
t
> > rt_mutex_base *lock,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (likely(rt_mutex_cmp=
xchg_acquire(lock, NULL, current)))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state !=3D TASK_RTLOCK_W=
AIT) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * If we are going to sleep and we have plugged IO
> > queued,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * make sure to submit it to avoid deadlocks.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0blk_flush_plug(tsk->plug, true);
>=20
> This still leaves the problem vs. io_wq_worker_sleeping() and it's
> running() counterpart after schedule().

The closest thing I can see to a problem there is io_wqe_dec_running()->
io_queue_worker_create()->io_wq_cancel_tw_create()->kfree(), but that only
happens with func =3D=3D create_worker_cont(), and io_wqe_dec_running() use=
s=20
create_worker_cb().=20

Are there any workloads I could run to stress out that path (with my
asserts in place)?

-Scott

