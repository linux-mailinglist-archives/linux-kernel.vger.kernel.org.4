Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7C706F14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjEQRK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748E198E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684343378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O77FUeBqVv09R6tDA90nsHnvloA7B+EnHXU7+4rYNQ0=;
        b=fPvpzaO2Gk6R4KtWGq9DCQNxCSK+V7Rz2DIt96VfJivyaN77ps4Z7pQrfiu8emViFPvvzK
        ng34wrILNepk+/dbOE45zyGaYvgzdc9GhAPOa/XcxkGiFlrcjpufQyzTChxEFWYIerRcqs
        zhLwhk2gI+gfJvtxj3KGteUHwPDiaNk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-3nq0b3zjNVGGhTxPrHkZdA-1; Wed, 17 May 2023 13:09:37 -0400
X-MC-Unique: 3nq0b3zjNVGGhTxPrHkZdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC7AB185A7A4;
        Wed, 17 May 2023 17:09:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 22B9EC15BA0;
        Wed, 17 May 2023 17:09:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 17 May 2023 19:09:22 +0200 (CEST)
Date:   Wed, 17 May 2023 19:09:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Christie <michael.christie@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230517170917.GA17016@redhat.com>
References: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
 <87cz30s20y.fsf@email.froward.int.ebiederm.org>
 <20230516183757.GA1286@redhat.com>
 <87mt24ox2d.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt24ox2d.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> >> There is this bit in complete_signal when SIGKILL is delivered to any
> >> thread in the process.
> >>
> >> 			t = p;
> >> 			do {
> >> 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> >> 				sigaddset(&t->pending.signal, SIGKILL);
> >> 				signal_wake_up(t, 1);
> >> 			} while_each_thread(p, t);
> >
> > That is why the latest version adds try_set_pending_sigkill(). No, no,
> > it is not that I think this is a good idea.
>
> I see that try_set_pending_sigkill in the patch now.
>
> That try_set_pending_sigkill just keeps the process from reporting
> that it has exited, and extend the process exit indefinitely.
>
> SIGNAL_GROUP_EXIT has already been set, so the KILL signal was
> already delivered and the process is exiting.

Agreed, that is why I said I don't think try_set_pending_sigkill() is
a good idea.

And again, the same is true for the threads created by
create_io_thread(). get_signal() from io_uring/ can dequeue a pending
SIGKILL and return, but that is all.

> >> For clarity that sigaddset(&t->pending.signal, SIGKILL);  Really isn't
> >> setting SIGKILL pending,
> >
> > Hmm. it does? Nevermind.
>
> The point is that what try_set_pending_sigkill in the patch is doing is
> keeping the "you are dead exit now" flag, from being set.
>
> That flag is what fatal_signal_pending always tests, because we can only
> know if a fatal signal is pending if we have performed short circuit
> delivery on the signal.
>
> The result is the effects of the change are mostly what people expect.
> The difference the semantics being changed aren't what people think they
> are.
>
> AKA process exit is being ignored for the thread, not that SIGKILL is
> being blocked.

Sorry, I don't understand. I just tried to say that
sigaddset(&t->pending.signal, SIGKILL) really sets SIGKILL pending.
Nevermind.

> > Although I never understood this logic.

I meant I never really liked how io-threads play with signals,

> I can't even understand the usage
> > of lower_32_bits() in create_io_thread().
>
> As far as I can tell lower_32_bits(flags) is just defensive programming

Cough. but this is ugly. Or I missed something.

> or have just populated .flags directly.

Exactly,

> Then .exit_signal
> could have been set to 0.

Exactly.

-------------------------------------------------------------------------------
OK. It doesn't matter. I tried to read the whole thread and got lost.

IIUC, Mike is going to send the next version? So I think we can delay
the further discussions until then.

Oleg.

