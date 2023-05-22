Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBD70BFD6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjEVNb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjEVNbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF97B4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684762265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eVGdestM+Cnm6kFHfPIOnEQEMlw4AVJx205w2cJUeL0=;
        b=FXEaTAkW+LIZHpZgxB0QF7LZl+gKjpPEfsDjzxXIeUuELDUL8lMwgXMtz1Mfulb1QMF1kF
        ARPVGL84guWbUQo8Vd4hh6l0uVpBif1O3TDp3y9Pxj0Qi6HT/x0IbhHYoJu/c1FtD3Uo8q
        SUzUFoeRm8kR+oYqi/3X7cGcHZcxu5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266--2m89qsxNIu92Vw5yGFyfg-1; Mon, 22 May 2023 09:30:59 -0400
X-MC-Unique: -2m89qsxNIu92Vw5yGFyfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11301800BFF;
        Mon, 22 May 2023 13:30:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2ABD240D1B60;
        Mon, 22 May 2023 13:30:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 May 2023 15:30:42 +0200 (CEST)
Date:   Mon, 22 May 2023 15:30:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Message-ID: <20230522133038.GB22159@redhat.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
 <20230518162508.GB20779@redhat.com>
 <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
 <20230518170359.GC20779@redhat.com>
 <875y8ph4tj.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y8ph4tj.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18, Eric W. Biederman wrote:
>
>  void recalc_sigpending(void)
>  {
> -       if (!recalc_sigpending_tsk(current) && !freezing(current))
> +       if ((!recalc_sigpending_tsk(current) && !freezing(current)) ||
> +           ((current->signal->flags & SIGNAL_GROUP_EXIT) &&
> +                   !__fatal_signal_pending(current)))
>                 clear_thread_flag(TIF_SIGPENDING);
>  
>  }
> @@ -1043,6 +1045,13 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>                  * This signal will be fatal to the whole group.
>                  */
>                 if (!sig_kernel_coredump(sig)) {
> +                       /*
> +                        * The signal is being short circuit delivered
> +                        * don't it pending.
> +                        */
> +                       if (type != PIDTYPE_PID) {
> +                               sigdelset(&t->signal->shared_pending,  sig);
> +
>                         /*
>                          * Start a group exit and wake everybody up.
>                          * This way we don't have other threads

Eric, sorry. I fail to understand this patch.

How can it help? And whom?

Perhaps we can discuss it in the context of the new series from Mike?

Oleg.

