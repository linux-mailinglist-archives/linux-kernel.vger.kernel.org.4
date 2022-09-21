Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0C25BF952
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiIUId3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIUId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:33:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92076951
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BQY3kXc4ueeRGueLzvrGWIjEfP0K1rYjQhp95afVKX0=; b=I8SsuHFAZvVGOWoSZben2GqDWF
        5EOCfI7iv6QgflSnNcl+apqj0fQj/ew3n+EzRxFyh52KhpeWOct00BB6ocUcsHTnSECHh0JNsZNqX
        6MtH85Q+BTZwlSg8U+koZ4PaDP81uwXMx9JTk5bLg1fsHDcAEkhlDRLtz4huRYapZ3lceJ3qBIL2U
        VpTsBUQIpIsa1o/ygDgrBAWXi3YaXYMGcYGYDvksaBWww+WA2WVifFV1RAQJndFo7SaRR6md/8wUT
        Qe2kMZO58Qkviznm0hVNMZ6UUILEA3WO+7hErh9EKe5+m0Iv1WMemYU+5y/0KWIJv3XacpcbxoTlM
        UbNbkt7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oavAU-00EZ6p-I5; Wed, 21 Sep 2022 08:33:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACCE3300074;
        Wed, 21 Sep 2022 10:33:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91CBA203BFCFD; Wed, 21 Sep 2022 10:33:17 +0200 (CEST)
Date:   Wed, 21 Sep 2022 10:33:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/qspinlock: Do spin-wait in slowpath if
 preemptible
Message-ID: <YyrMTcL5uSftPej7@hirez.programming.kicks-ass.net>
References: <20220920195542.1548164-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920195542.1548164-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:55:42PM -0400, Waiman Long wrote:
> There are some code paths in the kernel where arch_spin_lock() will be
> called directly when the lock isn't expected to be contended and critical
> section is short. For example, tracing_saved_cmdlines_size_read()
> in kernel/trace/trace.c does that.
> 
> In most cases, preemption is also not disabled. This creates a problem
> for the qspinlock slowpath which expects preemption to be disabled

Using arch_spin_lock() without disabling preemption is a straight up
bug. Don't work around that.
