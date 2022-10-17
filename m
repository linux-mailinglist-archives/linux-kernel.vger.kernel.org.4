Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5A60132E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJQQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJQQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:05:45 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A9C6A492;
        Mon, 17 Oct 2022 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1666022717;
        bh=Yiw7gSqlI3hHqY8j9RQbEVxPlTn0uq4K7BeOAcs30rY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N0zoDqFJ9uILwRgG3gkcQzo7FsigxD9IHxBwKN9F+ad7w5NsFHahgrohSe7X3kEDv
         gwF/5p0FyXWkvdlDLeHAWqHsXT80zg2vzjMsOS1mzpcWY9N/dKkMx8ypp7iCps/DMB
         qdbB/zxw/x7ofCAtX1mtZmXa7kbOuJGQzwreQPV/tdJwXYuAsvb0QVzVRkLPXZbrIV
         oR5ng3bccSIXO4z9qLVA4mv96tBnBXiWDpVjbutcPPayo6GPKZV+95rN8HjdNsY706
         8vLhjfxqoRYq8GnxERN6S1/lxlTyLt8H5m9BCZ9J2I0yN8vps3vri1a9zhn1q2lIC6
         tEArj3xQdRjZg==
Received: from [172.16.0.72] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MrhfN5HnszV0j;
        Mon, 17 Oct 2022 12:05:16 -0400 (EDT)
Message-ID: <55ade976-efac-3a89-f5e4-9008b7030388@efficios.com>
Date:   Mon, 17 Oct 2022 12:05:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 00/25] RSEQ node id and virtual cpu id extensions
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
 <8735bv25k2.fsf@oldenburg.str.redhat.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <8735bv25k2.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-10 09:04, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> Extend the rseq ABI to expose a NUMA node ID and a vm_vcpu_id field.
>>
>> The NUMA node ID field allows implementing a faster getcpu(2) in libc.
>>
>> The virtual cpu id allows ideal scaling (down or up) of user-space
>> per-cpu data structures. The virtual cpu ids allocated within a memory
>> space are tracked by the scheduler, which takes into account the number
>> of concurrently running threads, thus implicitly considering the number
>> of threads, the cpu affinity, the cpusets applying to those threads, and
>> the number of logical cores on the system.
> 
> Do you have some code that shows how the userspace application handshake
> is supposed to work with the existing three __rseq_* symbols?  Maybe I'm
> missing something.

see https://lore.kernel.org/lkml/20220922105941.237830-5-mathieu.desnoyers@efficios.com/

+static
+unsigned int get_rseq_feature_size(void)
+{
+	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
+
+	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
+	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+
+	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
+	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+	if (auxv_rseq_feature_size)
+		return auxv_rseq_feature_size;
+	else
+		return ORIG_RSEQ_FEATURE_SIZE;
+}

then in rseq_init():

+	rseq_feature_size = get_rseq_feature_size();
+	if (rseq_feature_size == ORIG_RSEQ_FEATURE_SIZE)
+		rseq_size = ORIG_RSEQ_ALLOC_SIZE;
+	else
+		rseq_size = RSEQ_THREAD_AREA_ALLOC_SIZE;

Then using it for e.g. node_id:

https://lore.kernel.org/lkml/20220922105941.237830-6-mathieu.desnoyers@efficios.com/

+#ifndef rseq_sizeof_field
+#define rseq_sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#endif
+
+#ifndef rseq_offsetofend
+#define rseq_offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ rseq_sizeof_field(TYPE, MEMBER))
+#endif

+static inline bool rseq_node_id_available(void)
+{
+	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, node_id);
+}
+
+/*
+ * Current NUMA node number.
+ */
+static inline uint32_t rseq_current_node_id(void)
+{
+	assert(rseq_node_id_available());
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id);
+}

> 
>  From an application perspective, it would be best to add 8 more shared
> bytes in use, to push the new feature size over 32.  This would be
> clearly visible in __rseq_size, helping applications a lot.

[ I guess you meant 12 bytes ]

The fool-proof approach here would be to skip the 12 bytes of padding
currently at the end of struct rseq.

Maybe this is something we should do in order to make sure the userspace
check is regular for all fields.

> 
> Alternatively, we could sacrifice a bit to indicate that the this round
> of extensions is present.  But we'll need another bit to indicate that
> the last remaining 4 bytes are in use, for consistency.  Or come up with
> something to put their today.  The TID seems like an obvious choice.

Whatever we add into those bits would need to be "special" and use
something like a flag check to validate whether the field is populated
or not. Perhaps keeping things simpler and skipping those 12 bytes
entirely is preferable.

> 
> If we want to the 8 more bytes route, TID and PID should be
> uncontroversal?  The PID cache is clearly something that userspace
> likes, not just as a defeat device for the old BYTE benchmark.

I agree that having the PID and TID there might be relevant, but I
would rather prefer to have all fields use a check that is regular
from the point of view of userspace. This minimizes the risk of user
errors.

Thoughts ?

Thanks,

Mathieu


> 
> Thanks,
> Florian
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

