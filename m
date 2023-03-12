Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8006B6441
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCLJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:50:33 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86928D00
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 01:50:31 -0800 (PST)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32C9oOjR082880;
        Sun, 12 Mar 2023 18:50:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sun, 12 Mar 2023 18:50:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32C9oO5Q082877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 12 Mar 2023 18:50:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <34eaf9cf-42ff-52b6-1c2d-798c52cce54e@I-love.SAKURA.ne.jp>
Date:   Sun, 12 Mar 2023 18:50:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [syzbot] [kernel?] WARNING in c_start (2)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+96cae094d90877641f32@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000004d318a05f6810a9f@google.com>
 <c1f4cc16-feea-b83c-82cf-1a1f007b7eb9@I-love.SAKURA.ne.jp>
 <CAHk-=wgMMYE+vs-ZhxnAC_7NMw601xMOZOBqL1NR4kQYDDcK_A@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wgMMYE+vs-ZhxnAC_7NMw601xMOZOBqL1NR4kQYDDcK_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/03/12 16:43, Linus Torvalds wrote:
> On Sat, Mar 11, 2023 at 6:57 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> syzbot is unable to test kernels due to hitting WARN_ON_ONCE(cpu >= bits) upon
>> "cat /proc/cpuinfo" request.
>>
>> Since commit 596ff4a09b898179 ("cpumask: re-introduce constant-sized cpumask optimizations")
>> changed to pass "small_cpumask_bits" instead of "nr_cpumask_bits" to find_next_bit(),
>> find_next_bit() returning small_cpumask_bits causes c_next() to go beyond nr_cpumask_bits.
>> I think that we need to make sure that cpumask_next() and friends would not return cpu id
>> beyond nr_cpumask_bits.
> 
> Ahh. yes.
> 
> It's the same old "cpumask scanning should be testing >= nr_cpu_ids"
> thing, but c_start() does
> 
>         *pos = cpumask_next(*pos - 1, cpu_online_mask);
> 
> and basically assumes that it is "== nr_cpu_ids" for the end
> condition, and uses the value next time around.
> 
> And if it is *exactly* nr_cpu_ids, then the next time it gets called,
> the "*pos - 1" means that it's all ok.
> 
> But if it's > nr_cpu_ids, then next time the "-1" doesn't do anything
> useful and the input is still larger than the number of CPU ids.
> 
> The core *works* correctly, but it triggers that warning because it is
> not doing that test properly.

Right. The fix that works for "cat /procc/cpuinfo" case is

Subject: cpumask: adjust valid cpu range check in cpumask_next()

Since commit 596ff4a09b89 ("cpumask: re-introduce constant-sized cpumask
optimizations") changed to pass "small_cpumask_bits" (which is a build-time
constant if NR_CPUS <= BITS_PER_LONG) instead of "nr_cpumask_bits" (which
is not a build-time constant) when cpumask_next() calls find_next_bit(),
the caller of cpumask_next() started observing core id which is beyond
number of available cores.

If all callers of cpumask_next() are prepared for observing core id which
is beyond nr_cpumask_bits, we can preserve optimization introduced by that
commit.

But we need to treat small_cpumask_bits - 1 (which happens when
cpumask_next() is called after cpumask_next() returned small_cpumask_bits)
as well as -1 (which happens when cpumask_next() is called for the first
time while reading /proc/cpuinfo).

Reported-by: syzbot <syzbot+96cae094d90877641f32@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=96cae094d90877641f32
Fixes: 596ff4a09b89 ("cpumask: re-introduce constant-sized cpumask optimizations")
---
 include/linux/cpumask.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 63d637d18e79..f96f46326e32 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -207,8 +207,8 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 static inline
 unsigned int cpumask_next(int n, const struct cpumask *srcp)
 {
-	/* -1 is a legal arg here. */
-	if (n != -1)
+	/* -1 and small_cpumask_bits-1 are legal here. */
+	if (n != -1 && n != small_cpumask_bits - 1)
 		cpumask_check(n);
 	return find_next_bit(cpumask_bits(srcp), small_cpumask_bits, n + 1);
 }
-- 
2.34.1

but we need to audit all cpumask_next*() users. That would take for a while
waiting for responses.

> 
> That c_start() function is ugly, but the simplest patch is probably
> this one-liner (whitespace-damaged but hopefully really obvious):
> 
>   --- a/arch/x86/kernel/cpu/proc.c
>   +++ b/arch/x86/kernel/cpu/proc.c
>   @@ -156,6 +156,7 @@
>         *pos = cpumask_next(*pos - 1, cpu_online_mask);
>         if ((*pos) < nr_cpu_ids)
>                 return &cpu_data(*pos);
>   +     *pos = nr_cpu_ids;
>         return NULL;
>    }
> 
> 
> which just caps that ">= nr_cpu_ids" case down to nr_cpu_ids.
> 
> Does that fix your test-case for you?

Yes. But other architectures will need the same fix.

> 
> I'm not entirely convinced we shouldn't clean stuff up with a slightly
> bigger patch, though. Instead of capping the 'pos', just testing it
> seems the kind of more obvious thing. This code had similar problems
> before. So an alternative patch (still whitespace-damaged) would be
> something like
> 
>   --- a/arch/x86/kernel/cpu/proc.c
>   +++ b/arch/x86/kernel/cpu/proc.c
>   @@ -153,8 +153,12 @@
> 
>    static void *c_start(struct seq_file *m, loff_t *pos)
>    {
>   -     *pos = cpumask_next(*pos - 1, cpu_online_mask);
>   -     if ((*pos) < nr_cpu_ids)
>   +     loff_t prev = *pos;
>   +
>   +     if (prev >= nr_cpu_ids)
>   +             return NULL;
>   +     *pos = cpumask_next(prev - 1, cpu_online_mask);
>   +     if (*pos < nr_cpu_ids)
>                 return &cpu_data(*pos);
>         return NULL;
>    }
> 
> which is a few lines more of patch, but stops depending on that "pos
> has to end up exactly at nr_cpu_ids" thing.

More worrisome thing for me is subtle changes in other locations.
For example, arch/ia64/kernel/mca.c is comparing the result of cpumask_next()
in different ways; one with nr_cpu_ids and the other with NR_CPUS. Maybe simply
commit 5dd3c9949a3e ("cpumask: prepare for iterators to only go to
nr_cpu_ids/nr_cpumask_bits.: ia64") forgot to update ia64_mca_cpe_int_caller().
Until all callers are checked, I afraid suddenly changing cpumask_next() to
return from nr_cpu_ids to NR_CPUS might break something.

static irqreturn_t
ia64_mca_cmc_int_caller(int cmc_irq, void *arg)
{
        static int start_count = -1;
        unsigned int cpuid;

        cpuid = smp_processor_id();

        /* If first cpu, update count */
        if (start_count == -1)
                start_count = IA64_LOG_COUNT(SAL_INFO_TYPE_CMC);

        ia64_mca_cmc_int_handler(cmc_irq, arg);

        cpuid = cpumask_next(cpuid+1, cpu_online_mask);

        if (cpuid < nr_cpu_ids) {
                ia64_send_ipi(cpuid, IA64_CMCP_VECTOR, IA64_IPI_DM_INT, 0);
        } else {
                /* If no log record, switch out of polling mode */
(...snipped...)
}

static irqreturn_t
ia64_mca_cpe_int_caller(int cpe_irq, void *arg)
{
        static int start_count = -1;
        static int poll_time = MIN_CPE_POLL_INTERVAL;
        unsigned int cpuid;

        cpuid = smp_processor_id();

        /* If first cpu, update count */
        if (start_count == -1)
                start_count = IA64_LOG_COUNT(SAL_INFO_TYPE_CPE);

        ia64_mca_cpe_int_handler(cpe_irq, arg);

        cpuid = cpumask_next(cpuid+1, cpu_online_mask);

        if (cpuid < NR_CPUS) {
                ia64_send_ipi(cpuid, IA64_CPEP_VECTOR, IA64_IPI_DM_INT, 0);
        } else {
                /*
                 * If a log was recorded, increase our polling frequency,
(...snipped...)
}

> 
> Either patch should result in the same thing and hopefully fix your
> warning, so I guess it's just a matter of taste.
> 
>                 Linus
> 

Since currently 99% of syzbot crashes are this bug, I want to fix as soon as
possible. Thus, regarding this cycle, restoring old behavior seems the safer.

