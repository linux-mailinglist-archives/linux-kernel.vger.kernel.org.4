Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7AF717B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjEaJPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjEaJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33307E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685524500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ir4H/Z1/r0sZbaFI9Fc11zZLFNyyd0qULW+BtXwpIUM=;
        b=QVDqCTnuansOR9NJaxk8Z10XbP0Kt4b6hqtXNtgQBDlGEyT/rdjaJO2cTfmc0Fm5Ox3vAG
        B87sPDCqH1My8ms1mmQ8FwZZkpIEgrBdLTHwklBJ0acaKuIHjLIODcY0eQFLAFcRiB3jbr
        FLai8Qtc1kImxKsD2zakgLUXc5qRXfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-vhu6RDiDO0Ckd4-MKb7pKA-1; Wed, 31 May 2023 05:14:57 -0400
X-MC-Unique: vhu6RDiDO0Ckd4-MKb7pKA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94D77811E86;
        Wed, 31 May 2023 09:14:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7F606492B0A;
        Wed, 31 May 2023 09:14:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 May 2023 11:14:36 +0200 (CEST)
Date:   Wed, 31 May 2023 11:14:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230531091432.GB25046@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31, Jason Wang wrote:
>
> On Wed, May 31, 2023 at 3:25 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 05/31, Jason Wang wrote:
> > >
> > > 在 2023/5/23 20:15, Oleg Nesterov 写道:
> > > >
> > > >             /* make sure flag is seen after deletion */
> > > >             smp_wmb();
> > > >             llist_for_each_entry_safe(work, work_next, node, node) {
> > > >                     clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > > >
> > > >I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEUED,
> > > >vhost_work_queue() can add this work again and change work->node->next.
> > > >
> > > >That is why we use _safe, but we need to ensure that llist_for_each_safe()
> > > >completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.
> > >
> > > This should be fine since store is not speculated, so work->node->next needs
> > > to be loaded before VHOST_WORK_QUEUED is cleared to meet the loop condition.
> >
> > I don't understand you. OK, to simplify, suppose we have 2 global vars
> >
> >         void *PTR = something_non_null;
> >         unsigned long FLAGS = -1ul;
> >
> > Now I think this code
> >
> >         CPU_0                           CPU_1
> >
> >         void *ptr = PTR;                if (!test_and_set_bit(0, FLAGS))
> >         clear_bit(0, FLAGS);                    PTR = NULL;
> >         BUG_ON(!ptr);
> >
> > is racy and can hit the BUG_ON(!ptr).
>
> This seems different to the above case?

not sure,

> And you can hit BUG_ON with
> the following execution sequence:
>
> [cpu 0] clear_bit(0, FLAGS);
> [cpu 1] if (!test_and_set_bit(0, FLAGS))
> [cpu 1] PTR = NULL;
> [cpu 0] BUG_ON(!ptr)

I don't understand this part... yes, we can hit this BUG_ON() without mb in
between, this is what I tried to say.

> In vhost code, there's a condition before the clear_bit() which sits
> inside llist_for_each_entry_safe():
>
> #define llist_for_each_entry_safe(pos, n, node, member)                        \
>         for (pos = llist_entry((node), typeof(*pos), member);                  \
>              member_address_is_nonnull(pos, member) &&                         \
>                 (n = llist_entry(pos->member.next, typeof(*n), member), true); \
>              pos = n)
>
> The clear_bit() is a store which is not speculated, so there's a
> control dependency, the store can't be executed until the condition
> expression is evaluated which requires pos->member.next
> (work->node.next) to be loaded.

But llist_for_each_entry_safe() doesn't check "n", I mean, it is not that we have
something like

	n = llist_entry(...);
	if (n)
		clear_bit(...);

so I do not see how can we rely on the load-store control dependency.

Oleg.

