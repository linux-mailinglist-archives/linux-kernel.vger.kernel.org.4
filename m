Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1D705624
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjEPSjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEPSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC98610F9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684262300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bR7XFUDwDwS2QCuwLOFs/PBnLvy7FY7D7eHZBo5Cn1w=;
        b=GWX6e1QLXUmS8XRGslSSnWAozRYrkSuB+E806Q3nEHdaTeQ/M1WLKNzaUTvW1m3k45/QXo
        1WqqMHzIgjnUQ4DdtpNYSD0gKcD8EG1mlEXuR/vYsVVvhgaF4VrWtkz0FB9eYwu23SAwnK
        h/C7JJg+xK6NRm/IabqXE+oloSJaEcg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-Qs50wazRPeS9HugWOpEC4A-1; Tue, 16 May 2023 14:38:16 -0400
X-MC-Unique: Qs50wazRPeS9HugWOpEC4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5D5D2802537;
        Tue, 16 May 2023 18:38:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id F1DD22166B31;
        Tue, 16 May 2023 18:38:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 16 May 2023 20:38:02 +0200 (CEST)
Date:   Tue, 16 May 2023 20:37:57 +0200
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
Message-ID: <20230516183757.GA1286@redhat.com>
References: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
 <87cz30s20y.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz30s20y.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16, Eric W. Biederman wrote:
>
> A kernel thread can block SIGKILL and that is supported.
>
> For a thread that is part of a process you can't block SIGKILL when the
> task is part of a user mode process.

Or SIGSTOP. Another thread can call do_signal_stop()->signal_wake_up/etc.

> There is this bit in complete_signal when SIGKILL is delivered to any
> thread in the process.
>
> 			t = p;
> 			do {
> 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> 				sigaddset(&t->pending.signal, SIGKILL);
> 				signal_wake_up(t, 1);
> 			} while_each_thread(p, t);

That is why the latest version adds try_set_pending_sigkill(). No, no,
it is not that I think this is a good idea.

> For clarity that sigaddset(&t->pending.signal, SIGKILL);  Really isn't
> setting SIGKILL pending,

Hmm. it does? Nevermind.

> The important part of that code is that SIGNAL_GROUP_EXIT gets set.
> That indicates the entire process is being torn down.

Yes. and the same is true for io-thread even if it calls get_signal()
and dequeues SIGKILL and clears TIF_SIGPENDING.

> but in that case the vhost logic needs to act like a process, just
> like io_uring does.

confused... create_io_thread() creates a sub-thread too?

Although I never understood this logic. I can't even understand the usage
of lower_32_bits() in create_io_thread().

Oleg.

