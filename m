Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FF670DED3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbjEWOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbjEWOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:11:28 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782E6118;
        Tue, 23 May 2023 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684851033;
        bh=PDHlcbL/ejRZ6x1/yL0bJ5WxIRJfwNls+CNLgnDmnoc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CqOxg9u7+LhkH/4oJBHp8uQ6loDLQkuRwGE7kR8nuFhALbOo3p//YQhVB5GHYUf5C
         yqpgAoNf50tTrCWflYlTjPYY+l/ntso4hGewgyjsUo0KrnU55cem672vwdB4rL7tcg
         qdv+zJNA8EfKwNGBRh4wnZKaqhsaaosjSViNLTdqAUPPFl+UhBMhbjIfDtKyycVoOM
         eYAsA+3+qdQzBdjxUBzdiee1LFJj1RvPUUeKSSXXyKYFWOdDV+CKMD9XAJwBEK1Lkh
         xRwbHCqkT4+9FT663T9+/3VOguij/tQ0RWOiTi4Jr0OMiD8Ynx4hM0DD77OGIA337G
         sw+87KXXQMPFQ==
Received: from [172.16.0.117] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QQbnN6J69z13My;
        Tue, 23 May 2023 10:10:32 -0400 (EDT)
Message-ID: <18286958-df67-f5c8-157a-9b0e8764a299@efficios.com>
Date:   Tue, 23 May 2023 10:10:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/4] rseq: Add sched_state field to struct rseq
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Weimer <fweimer@redhat.com>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
 <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
 <ZGaddGcHw7nJE+Gh@boqun-archlinux>
 <06ee47e0-99e0-4b6a-ab67-239fccf2777d@efficios.com>
 <ZGevZxOjJLMO9zlM@boqun-archlinux>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZGevZxOjJLMO9zlM@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-19 13:18, Boqun Feng wrote:
[...]
> 
> The case in my mind is the opposite direction: the loads from other
> threads delay the stores to rseq_cs on the current thread, which I
> assume are usually a fast path. For example:

Yes, OK, you are correct. And I just validated on my end that busy-waiting
repeatedly loading from a cache line does slow down the concurrent stores
to other variables on that cache line significantly (at least on my
Intel(R) Core(TM) i7-8650U). Small reproducer provided at the end of
this email. Results:

compudj@thinkos:~/test$ time ./test-cacheline -d
thread id : 140242706274048, pid 16940
thread id : 140242697881344, pid 16940

real	0m4.145s
user	0m8.289s
sys	0m0.000s

compudj@thinkos:~/test$ time ./test-cacheline -s
thread id : 139741482387200, pid 16950
thread id : 139741473994496, pid 16950

real	0m4.573s
user	0m9.147s
sys	0m0.000s


> 
> 	CPU 1				CPU 2
> 
> 	lock(foo); // holding a lock
> 	rseq_start():
> 	  <CPU 1 own the cache line exclusively>
> 	  				lock(foo):
> 					  <fail to get foo>
> 					  <check whether the lock owner is on CPU>
> 					  <cache line becames shared>
> 	  ->rseq_cs = .. // Need to invalidate the cache line on other CPU
> 
> But as you mentioned, there is only one updater here (the current
> thread), so maybe it doesn't matter... but since it's a userspace ABI,
> so I cannot help thinking "what if there is another bit that has a
> different usage pattern introduced in the future", so..

Yes, however we have to be careful about how we introduce this considering
that the rseq feature extensions are "append only" to the structure feature
size exported by the kernel to userspace through getauxval(3).

So if we decide that we create a big hole right in the middle of the rseq_abi
for cacheline alignment, that's a possibility, but we'd really be wasting an
entire cacheline for a single bit.

Another possibility would be to add a level of indirection: we could have a field
in struct rseq which is either a pointer or offset from the thread_pointer() to
the on-cpu bit, which would sit in a different cache line. It would be up to
glibc to allocate space for it, possibly at the end of the rseq_abi field.

> 
>> Note that the heavy cache-line bouncing in my test-case happens on the lock
>> structure (cmpxchg expecting NULL, setting the current thread rseq_get_abi()
>> pointer on success). There are probably better ways to implement that part,
>> it is currently just a simple prototype showcasing the approach.
>>
> 
> Yeah.. that's a little strange, I guess you can just read the lock
> owner's rseq_abi, for example:
> 
> 	rseq_lock_slowpath() {
> 		struct rseq_abi *other_rseq = lock->owner;
> 
> 		if (RSEQ_ACCESS_ONCE(other_rseq->sched_state)) {
> 			...
> 		}
> 	}

Yes, I don't think the load of the owner pointer needs to be part of the
cmpxchg per se. It could be done from a load on the slow-path.

This way we would not require that the owner id and the lock state be the
same content, and this would allow much more freedom for the fast-path
semantic.

Thanks,

Mathieu

> 
> ?
> 
> Regards,
> Boqun
> 
>> Thanks,
>>
>> Mathieu
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

Reproducer:

/*
  * cacheline testing (exclusive vs shared store speed)
  *
  * build with gcc -O2 -pthread -o test-cacheline test-cacheline.c
  *
  * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  * License: MIT
  */

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <rseq/rseq.h>

#define NR_THREADS 2

struct test {
	int a;
	int b;
} __attribute__((aligned(256)));

enum testcase {
	TEST_SAME_CACHELINE,
	TEST_OTHER_CACHELINE,
};

static enum testcase testcase;
static int test_stop, test_go;
static struct test test, test2;

static
void *testthread(void *arg)
{
	long nr = (long)arg;

         printf("thread id : %lu, pid %lu\n", pthread_self(), getpid());

	__atomic_add_fetch(&test_go, 1, __ATOMIC_RELAXED);
	while (RSEQ_READ_ONCE(test_go) < NR_THREADS)
		rseq_barrier();
	if (nr == 0) {
		switch (testcase) {
		case TEST_SAME_CACHELINE:
			while (!RSEQ_READ_ONCE(test_stop))
				(void) RSEQ_READ_ONCE(test.a);
			break;
		case TEST_OTHER_CACHELINE:
			while (!RSEQ_READ_ONCE(test_stop))
				(void) RSEQ_READ_ONCE(test2.a);
			break;
		}
	} else if (nr == 1) {
		unsigned long long i;

		for (i = 0; i < 16000000000UL; i++)
			RSEQ_WRITE_ONCE(test.b, i);
		RSEQ_WRITE_ONCE(test_stop, 1);
	}
         return ((void*)0);
}

static
void show_usage(char **argv)
{
	fprintf(stderr, "Usage: %s <OPTIONS>\n", argv[0]);
	fprintf(stderr, "OPTIONS:\n");
	fprintf(stderr, "	[-s] Same cacheline\n");
	fprintf(stderr, "	[-d] Different cacheline\n");
}

static
int parse_args(int argc, char **argv)
{
	if (argc != 2 || argv[1][0] != '-') {
		show_usage(argv);
		return -1;
	}
	switch (argv[1][1]) {
	case 's':
		testcase = TEST_SAME_CACHELINE;
		break;
	case 'd':
		testcase = TEST_OTHER_CACHELINE;
		break;
	default:
		show_usage(argv);
		return -1;
	}
	return 0;
}

int main(int argc, char **argv)
{
         pthread_t testid[NR_THREADS];
         void *tret;
         int i, err;

	if (parse_args(argc, argv))
		exit(1);

         for (i = 0; i < NR_THREADS; i++) {
                 err = pthread_create(&testid[i], NULL, testthread,
                         (void *)(long)i);
                 if (err != 0)
                         exit(1);
         }

         for (i = 0; i < NR_THREADS; i++) {
                 err = pthread_join(testid[i], &tret);
                 if (err != 0)
                         exit(1);
         }

         return 0;
}



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

