Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D647D617485
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKCCxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKCCwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8EE167C4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 840FE61CE8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87135C433D6;
        Thu,  3 Nov 2022 02:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667443897;
        bh=gxSv06ZuNti0iu4L59Xi2M/bAXLqwzJCtmr3+D03VFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PCUzfrMPwZ2zUy8+zouvrUnyXB++j0n3VPiFQpH02f94Ucc5SQ3V76+5fC6Kx5aqq
         4c14CyXMYZJjBQymkC7aMjNws4ln78hjL9sXQbTNNC5oXsukgyIQ0aty7k3a0iQlcR
         SBq9lcg0A4LankEkxQuJOkMLecdMlGAx5M5f6w2KZcLgR76H/TBjTQenn57PuA2Jqh
         KQAEba13CRnW133Vu/xeVTQ2FAdzD/ADeKwf1Y482rOok/hUi4v9Kj8ROQIc7U3J3z
         Cslbmvqbv3MuWOCqf7TxyOs/RLIGO6ZxBJwyIWN1F5vpmIWwdotpQCzVKEQbJeOYUP
         zCZ/1nYrFvoCA==
Date:   Thu, 3 Nov 2022 11:51:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     wuqiang <wuqiang.matt@bytedance.com>
Cc:     davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mattwu@163.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] kprobes,lib: kretprobe scalability improvement
Message-Id: <20221103115133.753b878b0c5481600e054240@kernel.org>
In-Reply-To: <20221102023012.6362-1-wuqiang.matt@bytedance.com>
References: <20221101014346.150812-1-wuqiang.matt@bytedance.com>
        <20221102023012.6362-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi wuqiang (or Matt?),

Thanks for updating the patch! I have some comments below,

On Wed,  2 Nov 2022 10:30:12 +0800
wuqiang <wuqiang.matt@bytedance.com> wrote:

> kretprobe is using freelist to manage return-instances, but freelist,
> as LIFO queue based on singly linked list, scales badly and reduces
> the overall throughput of kretprobed routines, especially for high
> contention scenarios.
> 
> Here's a typical throughput test of sys_flock (counts in 10 seconds,
> measured with perf stat -a -I 10000 -e syscalls:sys_enter_flock):
> 
> OS: Debian 10 X86_64, Linux 6.1rc2
> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
> 
>       1X       2X       4X       6X       8X      12X      16X
> 34762430 36546920 17949900 13101899 12569595 12646601 14729195
>      24X      32X      48X      64X      72X      96X     128X
> 19263546 10102064  8985418 11936495 11493980  7127789  9330985
> 
> This patch implements a scalable, lock-less and numa-aware object pool,
> which brings near-linear scalability to kretprobed routines. Tests of
> kretprobe throughput show the biggest ratio as 333.9x of the original
> freelist. Here's the comparison:
> 
>                   1X         2X         4X         8X        16X
> freelist:   34762430   36546920   17949900   12569595   14729195
> objpool:    35627544   72182095  144068494  287564688  576903916
>                  32X        48X        64X        96X       128X
> freelist:   10102064    8985418   11936495    7127789    9330985
> objpool:  1158876372 1737828164 2324371724 2380310472 2463182819
> 
> Tests on 96-core ARM64 system output similarly, but with the biggest
> ratio up to 642.2x:
> 
> OS: Debian 10 AARCH64, Linux 6.1rc2
> HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s
> 
>                   1X         2X         4X         8X        16X
> freelist:   17498299   10887037   10224710    8499132    6421751
> objpool:    18715726   35549845   71615884  144258971  283707220
>                  24X        32X        48X        64X        96X
> freelist:    5339868    4819116    3593919    3121575    2687167
> objpool:   419830913  571609748  877456139 1143316315 1725668029
> 
> The object pool, leveraging percpu ring-array to mitigate hot spots
> of memory contention, could deliver near-linear scalability for high
> parallel scenarios. The ring-array is compactly managed in a single
> cacheline (64 bytes) to benefit from warmed L1 cache for most cases
> (<= 4 instances per core) and objects are managed in the continuous
> cachelines just after ring-array.
> 
> Changes since V3:
> 1) build warning: unused variable in fprobe_init_rethook
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Changes since V2:
> 1) the percpu-extended version of the freelist replaced by new percpu-
>    ring-array. freelist has data-contention in freelist_node (refs and
>    next) even after node is removed from freelist and the node could
>    be polluted easily (with freelist_node defined in union)
> 2) routines split to objpool.h and objpool.c according to cold & hot
>    pathes, and the latter moved to lib, as suggested by Masami
> 3) test module (test_objpool.ko) added to lib for functional testings
> 
> Changes since V1:
> 1) reformat to a single patch as Masami Hiramatsu suggested
> 2) use __vmalloc_node to replace vmalloc_node for vmalloc
> 3) a few minor fixes: typo and coding-style issues

Recording change log is very good. But if it becomes too long,
you can put a URL of the previous series on LKML instead of
appending the change logs.
You can get the URL (permlink) by "lkml.kernel.org/r/<your-message-id>"

> 
> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
> ---
>  include/linux/freelist.h |  129 -----
>  include/linux/kprobes.h  |    9 +-
>  include/linux/objpool.h  |  151 ++++++
>  include/linux/rethook.h  |   15 +-
>  kernel/kprobes.c         |   95 ++--
>  kernel/trace/fprobe.c    |   17 +-
>  kernel/trace/rethook.c   |   80 +--
>  lib/Kconfig.debug        |   11 +
>  lib/Makefile             |    4 +-
>  lib/objpool.c            |  480 ++++++++++++++++++
>  lib/test_objpool.c       | 1031 ++++++++++++++++++++++++++++++++++++++
>  11 files changed, 1772 insertions(+), 250 deletions(-)

Hmm, this does too much things in 1 patch.
Can you split this in below 5 patches? This also makes clear that who
needs to review which part.

- Add generic scalable objpool
- Add objpool test
- Use objpool in kretprobe
- Use objpool in fprobe and rethook
- Remove unused freelist

>  delete mode 100644 include/linux/freelist.h
>  create mode 100644 include/linux/objpool.h
>  create mode 100644 lib/objpool.c
>  create mode 100644 lib/test_objpool.c
> 
[...]
> +
> +struct objpool_slot {
> +	uint32_t                os_head;	/* head of ring array */

If all fields have "os_" prefix, it is meaningless.

> +	uint32_t                os_tail;	/* tail of ring array */
> +	uint32_t                os_size;	/* max item slots, pow of 2 */
> +	uint32_t                os_mask;	/* os_size - 1 */
> +/*
> + *	uint32_t                os_ages[];	// ring epoch id
> + *	void                   *os_ents[];	// objects array

"entries[]"

> + */
> +};
> +
> +/* caller-specified object initial callback to setup each object, only called once */
> +typedef int (*objpool_init_node_cb)(void *context, void *obj);
> +
> +/* caller-specified cleanup callback for private objects/pool/context */
> +typedef int (*objpool_release_cb)(void *context, void *ptr, uint32_t flags);
> +
> +/* called for object releasing: ptr points to an object */
> +#define OBJPOOL_FLAG_NODE        (0x00000001)
> +/* for user pool and context releasing, ptr could be NULL */
> +#define OBJPOOL_FLAG_POOL        (0x00001000)
> +/* the object or pool to be released is user-managed */
> +#define OBJPOOL_FLAG_USER        (0x00008000)
> +
> +/*
> + * objpool_head: object pooling metadata
> + */
> +
> +struct objpool_head {
> +	uint32_t                oh_objsz;	/* object & element size */
> +	uint32_t                oh_nobjs;	/* total objs (pre-allocated) */
> +	uint32_t                oh_nents;	/* max objects per cpuslot */
> +	uint32_t                oh_ncpus;	/* num of possible cpus */

If all fields have "oh_" prefix, it is meaningless.
Also, if there is no reason to be 32bit (like align the structure size
for cache, or pack the structure for streaming etc.) use appropriate types.

And please do not align the length of field name unnaturally. e.g.

size_t obj_size; /* size_t or unsigned int, I don't care. */
int nr_objs; /* I think just 'int' is enough because the value should be
               checked and limited under INT_MAX */
int max_entries;
unsigned int nr_cpus;

(BTW why we need to limit the nr_cpus here? we have num_possible_cpus())

> +	uint32_t                oh_in_user:1;	/* user-specified buffer */
> +	uint32_t                oh_in_slot:1;	/* objs alloced with slots */
> +	uint32_t                oh_vmalloc:1;	/* alloc from vmalloc zone */

Please use "bool" or "unsigned long flags" with flag bits.

> +	gfp_t                   oh_gfp;		/* k/vmalloc gfp flags */
> +	uint32_t                oh_sz_pool;	/* user pool size in byes */

size_t pool_size

> +	void                   *oh_pool;	/* user managed memory pool */
> +	struct objpool_slot   **oh_slots;	/* array of percpu slots */
> +	uint32_t               *oh_sz_slots;	/* size in bytes of slots */

size_t slot_size

> +	objpool_release_cb      oh_release;	/* resource cleanup callback */
> +	void                   *oh_context;	/* caller-provided context */
> +};

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
