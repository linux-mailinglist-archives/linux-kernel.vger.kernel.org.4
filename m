Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B797194BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjFAHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFAHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49A91981
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685605423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvJ0J/2Ad97d0Y3oIleyJnXlsfA2gT2V2y9NzKFld6k=;
        b=W33fsJRyfQFpaZvvCI3q98ntjxaqCffNyvLEViNombKeJ3G4iydrHk41kddWcH3YWajEAt
        0tNjud6y2jYzA+zl5VM+C+t2ptvnT6jSuZQ8pngLKt92GUMmQ0SBEuOXsr76OTxwMUUE8x
        56qLnOos1Gc2/4IcCb/cJrjaTtU1aJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-qCUySRT8PqyLHtBT12q-rA-1; Thu, 01 Jun 2023 03:43:40 -0400
X-MC-Unique: qCUySRT8PqyLHtBT12q-rA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56EA885A5BB;
        Thu,  1 Jun 2023 07:43:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5C07B2166B25;
        Thu,  1 Jun 2023 07:43:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Jun 2023 09:43:20 +0200 (CEST)
Date:   Thu, 1 Jun 2023 09:43:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230601074315.GA13133@redhat.com>
References: <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
 <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Jason Wang wrote:
>
> On Wed, May 31, 2023 at 5:14 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > > I don't understand you. OK, to simplify, suppose we have 2 global vars
> > > >
> > > >         void *PTR = something_non_null;
> > > >         unsigned long FLAGS = -1ul;
> > > >
> > > > Now I think this code
> > > >
> > > >         CPU_0                           CPU_1
> > > >
> > > >         void *ptr = PTR;                if (!test_and_set_bit(0, FLAGS))
> > > >         clear_bit(0, FLAGS);                    PTR = NULL;
> > > >         BUG_ON(!ptr);
> > > >
> > > > is racy and can hit the BUG_ON(!ptr).
> > >
> > > This seems different to the above case?
> >
> > not sure,
> >
> > > And you can hit BUG_ON with
> > > the following execution sequence:
> > >
> > > [cpu 0] clear_bit(0, FLAGS);
> > > [cpu 1] if (!test_and_set_bit(0, FLAGS))
> > > [cpu 1] PTR = NULL;
> > > [cpu 0] BUG_ON(!ptr)
> >
> > I don't understand this part... yes, we can hit this BUG_ON() without mb in
> > between, this is what I tried to say.
>
> I may miss something,

Or me... note that CPU_0 loads the global "PTR" into the local "ptr" before clear_bit.
Since you have mentioned the program order: yes this lacks READ_ONCE() or barrier(),
but the same is true for the code in vhost_worker(). So I still don't understand.

> but the above is the sequence that is executed
> by the processor (for each CPU, it's just the program order). So where
> do you expect to place an mb can help?

before clear_bit:

	CPU_0

	void *ptr = PTR;
	mb();			// implies compiler barrier as well
	clear_bit(0, FLAGS);
	BUG_ON(!ptr);

just in case... mb() in the code above is only for illustration, we can use
smp_mb__before_atomic() + clear_bit(). Or just clear_bit_unlock(), iiuc the
one-way barrier is fine in this case.


> > > In vhost code, there's a condition before the clear_bit() which sits
> > > inside llist_for_each_entry_safe():
> > >
> > > #define llist_for_each_entry_safe(pos, n, node, member)                        \
> > >         for (pos = llist_entry((node), typeof(*pos), member);                  \
> > >              member_address_is_nonnull(pos, member) &&                         \
> > >                 (n = llist_entry(pos->member.next, typeof(*n), member), true); \
> > >              pos = n)
> > >
> > > The clear_bit() is a store which is not speculated, so there's a
> > > control dependency, the store can't be executed until the condition
> > > expression is evaluated which requires pos->member.next
> > > (work->node.next) to be loaded.
> >
> > But llist_for_each_entry_safe() doesn't check "n", I mean, it is not that we have
> > something like
> >
> >         n = llist_entry(...);
> >         if (n)
> >                 clear_bit(...);
> >
> > so I do not see how can we rely on the load-store control dependency.
>
> Just to make sure we are on the same page, the condition expression is
>
> member_address_is_nonnull(pos, member) && (n =
> llist_entry(pos->member.next, typeof(*n), member), true)
>
> So it's something like:
>
> if (work->node && (work_next = work->node->next, true))
>     clear_bit(&work->flags);
>
> So two loads from both work->node and work->node->next, and there's a
> store which is clear_bit, then it's a load-store control dependencies?

I guess you missed the comma expression... Let me rewrite your pseudo-code
above, it is equivalent to

	if (work->node) {
		if ((work_next = work->node->next, true))
			clear_bit(&work->flags);
	}

another rewrite:
	
	if (work->node) {
		work_next = work->node->next;
		if ((work, true))
			clear_bit(&work->flags);
	}

and the final rewrite:

	if (work->node) {
		work_next = work->node->next;
		if (true)
			clear_bit(&work->flags);
	}

so again, I do not see the load-store control dependency. Not to mention this
code lacks READ_ONCE().


If we had something like

	if (work->node) {
		work_next = READ_ONCE(work->node->next);
		if (work_next)
			clear_bit(&work->flags);
	}

instead, then yes, we could rely on the LOAD-STORE dependency.

Oleg.

