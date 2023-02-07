Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F968DCFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjBGP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBGP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A55886BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675783585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zuNTMdpeyyo7RWFwyDdPan39yXLFh1xXiVOUrk19laU=;
        b=ME0ouczRsc3fanpaaI3qhRu6ySXeFLBFJdA8hX01jm9ozds7Nw1oFpnBDnx+pSpalfTt1e
        ScN0naGtHGPEtK9UbxQ5O3JHkeDtyy04BA7gAe8jDg80wN3KWTxo1NeOm3/zKnwg/bVVvT
        5KwhhqgBy7BryzF8yIlQXu+JGkQiXeI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-JOnuN8e2OKiDDddBaZr2Ng-1; Tue, 07 Feb 2023 10:26:22 -0500
X-MC-Unique: JOnuN8e2OKiDDddBaZr2Ng-1
Received: by mail-pj1-f69.google.com with SMTP id a10-20020a17090a740a00b002307faf7db2so4236621pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuNTMdpeyyo7RWFwyDdPan39yXLFh1xXiVOUrk19laU=;
        b=PEBlmHInNML5gSlMJpJywpXDOewNK02A8BQDjBb7Tmw4J7LFpryYFzKCSkYGL3V+bF
         OIQxDRb3gwwjYBdrxlXvrGalGGT2DogtjDZNHKkv7AMpdJ8SrpbFEByn6VVR4a/1q3kq
         OpcQLFwBfRPtPLTCcIH9MN8v1vhd2Ilagqql8NhutLZjIQOiWbqKGQFMZzXF4FpeePpb
         GA9NMAoA287Ir32ClMXnoA4mPYn5rHxiBqQqWI49tqcstV0vbcvuJWsyUyMg5eKJe9vA
         S4SZ6xQFbvyeQjy+hwcDNDu19hyhlhOratrHTo0IK3cGZuLoZHkBdQxUerVUaLRUJFgQ
         UoFA==
X-Gm-Message-State: AO0yUKWtLgRTmp3/ksJLm3SgcNcm3yiZwZQZBa65Nn1j9Suwt422GWHr
        8qIl/FC0U0sdwqSwwJClV5frdviWefAAf93iaNaOQzVlTOPZ+Tcba30s6xzCf4BPph4gUFPND9z
        yobgFKu5PRiXSl0Mg3Gq29in5cK83aIkQ7Bis8xGC
X-Received: by 2002:a62:19c3:0:b0:593:fe33:fa85 with SMTP id 186-20020a6219c3000000b00593fe33fa85mr929307pfz.12.1675783581672;
        Tue, 07 Feb 2023 07:26:21 -0800 (PST)
X-Google-Smtp-Source: AK7set83d4wRrvgEYP1o1rrLCeYjVO3+hdfhQWT5wt+S8E8ksTH3A6sNC2O7SU/pfrDA5eaIZBm5kaw/LvRp3vwLCEM=
X-Received: by 2002:a62:19c3:0:b0:593:fe33:fa85 with SMTP id
 186-20020a6219c3000000b00593fe33fa85mr929300pfz.12.1675783581426; Tue, 07 Feb
 2023 07:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20230206130449.41360-1-wander@redhat.com> <20230206170927.9d5afee653dfa0738983dbfa@linux-foundation.org>
In-Reply-To: <20230206170927.9d5afee653dfa0738983dbfa@linux-foundation.org>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Tue, 7 Feb 2023 12:26:10 -0300
Message-ID: <CAAq0SU=NumR_c2YynwM6ch+SkP9Gu5Y5qcZ6Lsxaq5OS9MhcXw@mail.gmail.com>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling context
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 10:09 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon,  6 Feb 2023 10:04:47 -0300 Wander Lairson Costa <wander@redhat.com> wrote:
>
> > Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
> > locks. Therefore, it can't be cala from a non-preemptible context.
>
> Well that's regrettable. Especially if non-preempt kernels don't do
> this.
>
> Why does PREEMPT_RT do this and can it be fixed?
>

Under PREEMPT_RT, spin_lock becomes a wrapper around rtmutex, which is
a sleeping lock. This is necessary because of the deterministic
scheduling requirements of the RT kernel. Most of the places that run
in atomic context in the stock kernel, become process context in the
RT kernel, so the change spin_lock -> rtmutex is safe. However, there
are always exceptions.

In this particular case, __put_task_struct calls kcache_mem_free,
which refill_obj_stock. refill_obj_stock acquires a local_lock, that
is implemented using a spin_lock.

> If it cannot be fixed then we should have a might_sleep() in
> __put_task_struct() for all kernel configurations, along with an
> apologetic comment explaining why.
>

This patch is supposed to be the fix.

