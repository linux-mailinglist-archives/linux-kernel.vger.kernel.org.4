Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA550645EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLGQcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiLGQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C534A18C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670430670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7y+cbEtPc+wlYtqLTRORNpayKs22fDZ4GcXhgFMixiA=;
        b=VvwdV43nL9rxgA97HaYAkOpstr+ogIJcfXZl4y1jRnsnB4GMWHG+uMnlEupndEkrMdYsB3
        vZjK+yrB8i8dh+hAytEk34Y/T7FtP/2z+fehPGkjk9CftYM17j69WTdhYMgeR7wWvnrKcn
        RSHbP1fNWOxpbM18r1KAUsPJJNMrR7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-CaHBLbYuM_6oJ-3n86cGvw-1; Wed, 07 Dec 2022 11:31:05 -0500
X-MC-Unique: CaHBLbYuM_6oJ-3n86cGvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B21C91C7FD;
        Wed,  7 Dec 2022 16:30:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DCE139D7C;
        Wed,  7 Dec 2022 16:30:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20221207134234.7879-1-hdanton@sina.com>
References: <20221207134234.7879-1-hdanton@sina.com> <20221207030740.7663-1-hdanton@sina.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com,
        syzbot+3538a6a72efa8b059c38@syzkaller.appspotmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in rxrpc_lookup_local
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1504896.1670430624.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Wed, 07 Dec 2022 16:30:41 +0000
Message-ID: <1504932.1670430641@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> > Hmmm...  That can't be the whole explanation.  As you say, the hlist_d=
el is
> > done under the mutex in rxrpc_destroy_local() - the same as the
> > hlist_add/hlist_replace and the search in rxrpc_lookup_local().
> =

> The uaf is simple and due to local ep freed without being deleted from
> rxnet->local_endpoints while the list walker in rxrpc_lookup_local() stu=
mbles
> on it. rxrpc_destroy_local() is irrelevant as per the syzbot report.

No, that's not the explanation.  We can't get that far unless the I/O thre=
ad
got started - kthread_run() has to wait for the task_struct pointer to bec=
ome
available - and the I/O thread should remove the link before it exits and
before the rxrpc_local object is deallocated.

I've tracked the problem down.  It's due to kthread(), specifically this b=
it:

	preempt_disable();
	complete(done);
	schedule_preempt_disabled();
	preempt_enable();

	ret =3D -EINTR;
	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
		cgroup_kthread_ready();
		__kthread_parkme(self);
		ret =3D threadfn(data);
	}

So the complete() is done before we've decided if we're going to call
threadfn() or return an error.  This permits kthread_run() to resume befor=
e
we've checked KTHREAD_SHOULD_STOP - thus if kthread_stop() is called quick=
ly
enough by the rxrpc socket being released, kthread() skips calling threadf=
n(),
but kthread_run() returns success.

The fact that the thread didn't start doesn't get seen until kthread_stop(=
) is
called.

I think the above code needs rearranging slightly.  KTHREAD_SHOULD_STOP sh=
ould
be tested and, if needed EINTR set, *before* complete(done).  That way
kthread_run() will return -EINTR in this case.

David

