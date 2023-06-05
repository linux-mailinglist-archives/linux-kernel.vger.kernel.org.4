Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71437228B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjFEOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjFEOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCD0ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685974863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjyQfaah7kzAAP89Moz/93/MPg42FDVwN2Cl77zMEpo=;
        b=bFvKU4CCkO+sRyaQa6AH37WvE49CfeylwxGzBaKcNV6wAhLMl9HRf3MOF1yPzxpqoQFTgs
        t5WmPGcFC7yRjd26tIrHeKdp1Eg2q9HR0ueIjxofLuU4UT/kyCQAfTcmfDj98lt4OCiBDu
        pxUk/YsUA1RdUDNCvHgpq3i3ziFQDss=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-NLSdgJxbOI2ev26fbE6asw-1; Mon, 05 Jun 2023 10:21:01 -0400
X-MC-Unique: NLSdgJxbOI2ev26fbE6asw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CA2338025EA;
        Mon,  5 Jun 2023 14:21:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DD771121314;
        Mon,  5 Jun 2023 14:20:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  5 Jun 2023 16:20:39 +0200 (CEST)
Date:   Mon, 5 Jun 2023 16:20:35 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605142034.GD32275@redhat.com>
References: <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
 <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
 <20230601074315.GA13133@redhat.com>
 <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
 <20230602175846.GC555@redhat.com>
 <CAHk-=whKyWvzg=7_m1o_KLC3zb9FjTBHftc36-5M9X78AxwRXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whKyWvzg=7_m1o_KLC3zb9FjTBHftc36-5M9X78AxwRXg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02, Linus Torvalds wrote:
>
> On Fri, Jun 2, 2023 at 1:59 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > As I said from the very beginning, this code is fine on x86 because
> > atomic ops are fully serialised on x86.
>
> Yes. Other architectures require __smp_mb__{before,after}_atomic for
> the bit setting ops to actually be memory barriers.
>
> We *should* probably have acquire/release versions of the bit test/set
> helpers, but we don't, so they end up being full memory barriers with
> those things. Which isn't optimal, but I doubt it matters on most
> architectures.
>
> So maybe we'll some day have a "test_bit_acquire()" and a
> "set_bit_release()" etc.

In this particular case we need clear_bit_release() and iiuc it is
already here, just it is named clear_bit_unlock().

So do you agree that vhost_worker() needs smp_mb__before_atomic()
before clear_bit() or just clear_bit_unlock() to avoid the race with
vhost_work_queue() ?

Let me provide a simplified example:

	struct item {
		struct llist_node	llist;
		unsigned long		flags;
	};

	struct llist_head HEAD = {};	// global

	void queue(struct item *item)
	{
		// ensure this item was already flushed
		if (!test_and_set_bit(0, &item->flags))
			llist_add(item->llist, &HEAD);

	}

	void flush(void)
	{
		struct llist_node *head = llist_del_all(&HEAD);
		struct item *item, *next;

		llist_for_each_entry_safe(item, next, head, llist)
			clear_bit(0, &item->flags);
	}

I think this code is buggy in that flush() can race with queue(), the same
way as vhost_worker() and vhost_work_queue().

Once flush() clears bit 0, queue() can come on another CPU and re-queue
this item and change item->llist.next. We need a barrier before clear_bit()
to ensure that next = llist_entry(item->next) in llist_for_each_entry_safe()
completes before the result of clear_bit() is visible to queue().

And, I do not think we can rely on control dependency because... because
I fail to see the load-store control dependency in this code,
llist_for_each_entry_safe() loads item->llist.next but doesn't check the
result until the next iteration.

No?

Oleg.

