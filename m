Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3A67B726
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjAYQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjAYQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2559E8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674665155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cIZWZHwWr/it1Ap7qgC7p4Cjw9SyMvAGdi9exT2yBFE=;
        b=R2Y2OVA1rtcwa/BTy72bV+TQgGHWBRfMYzd2BtBwIHIGEdg4yPdM8iXBHzeA0AzPdHUqZy
        YmQF0bdWoF7rPTjfUZE+TESNPpDqsywHEkTLlUQ6zrJ3OnzJrdwhWy7lKsWqyJwJNqiMo9
        Eb2+w6FrAy87FnPCNrye999IBoUsaBs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-_Dd014ylNHGYP0Dq4BLwSA-1; Wed, 25 Jan 2023 11:45:51 -0500
X-MC-Unique: _Dd014ylNHGYP0Dq4BLwSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 326D8801779;
        Wed, 25 Jan 2023 16:45:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-195-63.brq.redhat.com [10.40.195.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8612B14171BB;
        Wed, 25 Jan 2023 16:45:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Jan 2023 17:45:48 +0100 (CET)
Date:   Wed, 25 Jan 2023 17:45:46 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH v2] posix-timers: Support delivery of signals to the
 current thread
Message-ID: <20230125164546.GD13746@redhat.com>
References: <20221216171807.760147-1-dvyukov@google.com>
 <20230112112411.813356-1-dvyukov@google.com>
 <20230125124304.GA13746@redhat.com>
 <20230125151717.GB13746@redhat.com>
 <CACT4Y+YKy_4mBLYomr49+fTm31Y6Q_kXhJz8O-_RTjMe=B-6eg@mail.gmail.com>
 <20230125163137.GC13746@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125163137.GC13746@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25, Oleg Nesterov wrote:
>
> > 2. The signal is still queued into process shared_pending
>
> Yes. But just in case, please note that if this signal is not realtime
> (sigev_signo < SIGRTMIN) and it is already queued, it will be dropped.
> And I do not know if this can work for you.
>
> However this is what we already have with SIGEV_SIGNAL w/o SIGEV_THREAD_ID,
> and the same is true for SIGEV_THREAD_ID if the signal is already pending in
> target_task->pending.

Damn ;) please ignore. I forgot that send_sigqueue() doesn't check
legacy_queue().

Oleg.

