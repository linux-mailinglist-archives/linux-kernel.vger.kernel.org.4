Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF29D5F9F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJJNEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJJNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA21D2BFD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665407076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EKUr7eRGSpHO08SnSJlFsYYLyW7vfd3DLTPqPH/Gog=;
        b=QNwWTs/MfUy2Ain8+c9ws+IVzxXxjqBP35c1YCIE0rzcJgC5IXiQjKKgGq+hdqP9sCwO7F
        zTHXLU58sh8F8xl1m0tb1O6saBNHZqHCqAgk6cbQVkxVJPTYh+POI5WfpyiETco9shamod
        Jad3c96xHkLgZD7q9Xg05ew/VdZ0xaw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-pcK5r2phP4KyPBixilkzJw-1; Mon, 10 Oct 2022 09:04:35 -0400
X-MC-Unique: pcK5r2phP4KyPBixilkzJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6C30101CC6B;
        Mon, 10 Oct 2022 13:04:34 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D60D42157F41;
        Mon, 10 Oct 2022 13:04:30 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v4 00/25] RSEQ node id and virtual cpu id extensions
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
Date:   Mon, 10 Oct 2022 15:04:29 +0200
In-Reply-To: <20220922105941.237830-1-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Thu, 22 Sep 2022 06:59:15 -0400")
Message-ID: <8735bv25k2.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Extend the rseq ABI to expose a NUMA node ID and a vm_vcpu_id field.
>
> The NUMA node ID field allows implementing a faster getcpu(2) in libc.
>
> The virtual cpu id allows ideal scaling (down or up) of user-space
> per-cpu data structures. The virtual cpu ids allocated within a memory
> space are tracked by the scheduler, which takes into account the number
> of concurrently running threads, thus implicitly considering the number
> of threads, the cpu affinity, the cpusets applying to those threads, and
> the number of logical cores on the system.

Do you have some code that shows how the userspace application handshake
is supposed to work with the existing three __rseq_* symbols?  Maybe I'm
missing something.

From an application perspective, it would be best to add 8 more shared
bytes in use, to push the new feature size over 32.  This would be
clearly visible in __rseq_size, helping applications a lot.

Alternatively, we could sacrifice a bit to indicate that the this round
of extensions is present.  But we'll need another bit to indicate that
the last remaining 4 bytes are in use, for consistency.  Or come up with
something to put their today.  The TID seems like an obvious choice.

If we want to the 8 more bytes route, TID and PID should be
uncontroversal?  The PID cache is clearly something that userspace
likes, not just as a defeat device for the old BYTE benchmark.

Thanks,
Florian

