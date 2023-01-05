Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C765F0FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjAEQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjAEQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:19:46 -0500
Received: from albireo.enyo.de (albireo.enyo.de [37.24.231.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5825652756;
        Thu,  5 Jan 2023 08:19:43 -0800 (PST)
Received: from [172.17.203.2] (port=58125 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1pDSxr-009StN-7D; Thu, 05 Jan 2023 16:19:35 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1pDSxq-000GBT-P4; Thu, 05 Jan 2023 17:19:34 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH 05/30] selftests/rseq: Use ELF auxiliary vector for
 extensible rseq
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
        <20221122203932.231377-6-mathieu.desnoyers@efficios.com>
        <87a62yun6l.fsf@mid.deneb.enyo.de>
        <cce499bf-6083-558d-5431-9ceab05a98d6@efficios.com>
Date:   Thu, 05 Jan 2023 17:19:34 +0100
In-Reply-To: <cce499bf-6083-558d-5431-9ceab05a98d6@efficios.com> (Mathieu
        Desnoyers's message of "Wed, 4 Jan 2023 14:51:22 -0500")
Message-ID: <87tu15rm21.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> 2- Now about applications (and libc) use of rseq fields:
>
> Using both __rseq_size (from libc) and the result of
> getauxval(AT_RSEQ_FEATURE_SIZE), a rseq user can figure which rseq
> fields can indeed be used. The important part is how
> get_rseq_feature_size() is called in the rseq selftests:
>
>
>                  rseq_feature_size = get_rseq_feature_size();
>                  if (rseq_feature_size > rseq_size)
>                          rseq_feature_size = rseq_size;
>
> which basically sets rseq_feature_size to the feature size exposed
> by the kernel, except if libc's __rseq_size is smaller than the
> feature size exposed by the kernel, in which case it will truncate
> the rseq_feature_size to __rseq_size.

Ahh, this happens to work because we pass 32 today from glibc, and
there is nothing left to do in glibc to enable these new fields.

If true, that really argues in favor of this approach.

>> Maybe we should just skip the existing padding and use it only for
>> some vaguely kernel-internal purpose (say through a vDSO helper), so
>> that it is less of an issue how to communicate the presence of these
>> fields to userspace.
>
> The fact that libc's __rseq_size is included the original struct
> rseq padding is unfortunate, but I really see this as a purely
> userspace ABI concern, which should not dictate the layout of the
> kernel ABI exposed to user-space, especially given that all the
> information required to allow rseq users to know which fields can be
> used is readily available by combining the value loaded from
> __rseq_size and the result of getauxval(AT_RSEQ_FEATURE_SIZE).

But we must pass size 32 to the kernel today, otherwise rseq
registration fails.  It's a kernel-mandated value, not something
that's purely a userspace concern.
