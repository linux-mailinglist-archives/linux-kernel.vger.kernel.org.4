Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA7665A16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjAKL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjAKL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:27:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDEE140B3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673436374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=P26DOOQFzqNeAWOv5m+Y0df/LIVzCBSEjc0esr8v7WM=;
        b=C7fh3cBfPZmFQBc43gT/qaqrBzG6nrskD9lUqSj/hMX3K9j/6QkrPLSQ+E9LFu1Y4FtVP1
        jwoak6Wluyr52y/O+gzgdwlR/4++jovnhlr1WxQyfzdlZsUNSu3d0AynZeg0Sy5kr0qBBx
        fS5VSDseQu/PWfM5DgHmAI3r2rNzdYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-9j7wO3_EPBmW4mvMbHkoBg-1; Wed, 11 Jan 2023 06:26:11 -0500
X-MC-Unique: 9j7wO3_EPBmW4mvMbHkoBg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07D08858F09;
        Wed, 11 Jan 2023 11:26:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A058492C14;
        Wed, 11 Jan 2023 11:26:10 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        libc-alpha@sourceware.org
Subject: rseq CPU ID not correct on 6.0 kernels for pinned threads
Date:   Wed, 11 Jan 2023 12:26:08 +0100
Message-ID: <87lem9cnxr.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The glibc test suite contains a test that verifies that sched_getcpu
returns the expected CPU number for a thread that is pinned (via
sched_setaffinity) to a specific CPU.  There are other threads running
which attempt to de-schedule the pinned thread from its CPU.  I believe
the test is correctly doing what it is expected to do; it is invalid
only if one believes that it is okay for the kernel to disregard the
affinity mask for scheduling decisions.

These days, we use the cpu_id rseq field as the return value of
sched_getcpu if the kernel has rseq support (which it has in these
cases).

This test has started failing sporadically for us, some time around
kernel 6.0.  I see failure occasionally on a Fedora builder, it runs:

Linux buildvm-x86-26.iad2.fedoraproject.org 6.0.15-300.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Dec 21 18:33:23 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

I think I've seen it on the x86-64 builder only, but that might just be
an accident.

The failing tests log this output:

=====FAIL: nptl/tst-thread-affinity-pthread.out=====
info: Detected CPU set size (in bits): 64
info: Maximum test CPU: 5
error: Pinned thread 1 ran on impossible cpu 0
error: Pinned thread 0 ran on impossible cpu 0
info: Main thread ran on 4 CPU(s) of 6 available CPU(s)
info: Other threads ran on 6 CPU(s)
=====FAIL: nptl/tst-thread-affinity-pthread2.out=====
info: Detected CPU set size (in bits): 64
info: Maximum test CPU: 5
error: Pinned thread 1 ran on impossible cpu 1
error: Pinned thread 2 ran on impossible cpu 0
error: Pinned thread 3 ran on impossible cpu 3
info: Main thread ran on 5 CPU(s) of 6 available CPU(s)
info: Other threads ran on 6 CPU(s)

But I also encountered one local failure, but it is rare.  Maybe it's
load-related.  There shouldn't be any CPU unplug or anything like that
involved here.

I am not entirely sure if something is changing CPU affinities from
outside the process (which would be quite wrong, but not a kernel bug).
But in the past, our glibc test has detected real rseq cpu_id
brokenness, so I'm leaning towards that as the cause this time, too.

Thanks,
Florian

