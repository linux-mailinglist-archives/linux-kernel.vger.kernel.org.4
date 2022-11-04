Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB78618DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiKDB2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKDB2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD82023BC0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8841AB82B4C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79393C433D6;
        Fri,  4 Nov 2022 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667525295;
        bh=7bbIkLo0I6rAm9GCrSIapnVMQhnRgYyMLtnNKKqZzzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mgx9RdkDsnfx6RfPfS6jhLjKRygPXDo1vric8T5VnXr1vdvoO/+q3qSKQVn+LxlDz
         41SL5FX5FSgJGK1EGN1wJbBCzbGCTv1iS+mX1pdobcF+pHECDLV5/nGiV4FWIB1jRD
         ISnQ3KX4WdbrJevzdPXsvmOqG5TAj5kFL7kfiJcozx4ySzbkxSfeUG0H+TZViAgZLU
         LDSoC0KQ0vn2jC0ohsyAZLxH6AYfqesvbw1xm5Qg+JWNcBbyQTsXT4whiL9di+Bn6j
         MswC62mjN8Ah6ZPerat2cM8BTr94nC6uYvZEkxw7txkk7bKN1w6/qOwbPMlBAhlct4
         0HS2aEQsXb3RA==
Date:   Fri, 4 Nov 2022 10:28:10 +0900
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
Message-Id: <20221104102810.b2c10d3334483eb0b3a2ef42@kernel.org>
In-Reply-To: <15d382af-512f-cb06-d8c2-cd9e16d870f6@bytedance.com>
References: <20221101014346.150812-1-wuqiang.matt@bytedance.com>
        <20221102023012.6362-1-wuqiang.matt@bytedance.com>
        <20221103115133.753b878b0c5481600e054240@kernel.org>
        <15d382af-512f-cb06-d8c2-cd9e16d870f6@bytedance.com>
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

On Fri, 4 Nov 2022 00:45:19 +0800
wuqiang <wuqiang.matt@bytedance.com> wrote:

> On 2022/11/3 10:51, Masami Hiramatsu (Google) wrote:
> > Hi wuqiang (or Matt?),
> > 
> > Thanks for updating the patch! I have some comments below,
> 
> Thanks for your time :)
> 
> > On Wed,  2 Nov 2022 10:30:12 +0800
> > wuqiang <wuqiang.matt@bytedance.com> wrote:
> > 
> ...
> >> Changes since V3:
> >> 1) build warning: unused variable in fprobe_init_rethook
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> Changes since V2:
> >> 1) the percpu-extended version of the freelist replaced by new percpu-
> >>     ring-array. freelist has data-contention in freelist_node (refs and
> >>     next) even after node is removed from freelist and the node could
> >>     be polluted easily (with freelist_node defined in union)
> >> 2) routines split to objpool.h and objpool.c according to cold & hot
> >>     pathes, and the latter moved to lib, as suggested by Masami
> >> 3) test module (test_objpool.ko) added to lib for functional testings
> >>
> >> Changes since V1:
> >> 1) reformat to a single patch as Masami Hiramatsu suggested
> >> 2) use __vmalloc_node to replace vmalloc_node for vmalloc
> >> 3) a few minor fixes: typo and coding-style issues
> > 
> > Recording change log is very good. But if it becomes too long,
> > you can put a URL of the previous series on LKML instead of
> > appending the change logs.
> > You can get the URL (permlink) by "lkml.kernel.org/r/<your-message-id>"
> 
> Got it.
> 
> >>
> >> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
> >> ---
> >>   include/linux/freelist.h |  129 -----
> >>   include/linux/kprobes.h  |    9 +-
> >>   include/linux/objpool.h  |  151 ++++++
> >>   include/linux/rethook.h  |   15 +-
> >>   kernel/kprobes.c         |   95 ++--
> >>   kernel/trace/fprobe.c    |   17 +-
> >>   kernel/trace/rethook.c   |   80 +--
> >>   lib/Kconfig.debug        |   11 +
> >>   lib/Makefile             |    4 +-
> >>   lib/objpool.c            |  480 ++++++++++++++++++
> >>   lib/test_objpool.c       | 1031 ++++++++++++++++++++++++++++++++++++++
> >>   11 files changed, 1772 insertions(+), 250 deletions(-)
> > 
> > Hmm, this does too much things in 1 patch.
> > Can you split this in below 5 patches? This also makes clear that who
> > needs to review which part.
> 
> I was ever considering of splitting, but finally decided to mix them in a big 
> one mostly because it's only for kretprobe improvement.
> 
> Next version I'll split to smaller patches. Thank you for the advice.
> 
> > 
> > - Add generic scalable objpool
> > - Add objpool test
> > - Use objpool in kretprobe
> > - Use objpool in fprobe and rethook
> > - Remove unused freelist
> > 
> >>   delete mode 100644 include/linux/freelist.h
> >>   create mode 100644 include/linux/objpool.h
> >>   create mode 100644 lib/objpool.c
> >>   create mode 100644 lib/test_objpool.c
> >>
> > [...]
> >> +
> >> +struct objpool_slot {
> >> +	uint32_t                os_head;	/* head of ring array */
> > 
> > If all fields have "os_" prefix, it is meaningless.
> > 
> >> +	uint32_t                os_tail;	/* tail of ring array */
> >> +	uint32_t                os_size;	/* max item slots, pow of 2 */
> >> +	uint32_t                os_mask;	/* os_size - 1 */
> >> +/*
> >> + *	uint32_t                os_ages[];	// ring epoch id
> >> + *	void                   *os_ents[];	// objects array
> > 
> > "entries[]"
> 
> I'll refine the comments here to better explain the memory layout.
> 
> > 
> >> + */
> >> +};
> >> +
> >> +/* caller-specified object initial callback to setup each object, only called once */
> >> +typedef int (*objpool_init_node_cb)(void *context, void *obj);
> >> +
> >> +/* caller-specified cleanup callback for private objects/pool/context */
> >> +typedef int (*objpool_release_cb)(void *context, void *ptr, uint32_t flags);
> >> +
> >> +/* called for object releasing: ptr points to an object */
> >> +#define OBJPOOL_FLAG_NODE        (0x00000001)
> >> +/* for user pool and context releasing, ptr could be NULL */
> >> +#define OBJPOOL_FLAG_POOL        (0x00001000)
> >> +/* the object or pool to be released is user-managed */
> >> +#define OBJPOOL_FLAG_USER        (0x00008000)
> >> +
> >> +/*
> >> + * objpool_head: object pooling metadata
> >> + */
> >> +
> >> +struct objpool_head {
> >> +	uint32_t                oh_objsz;	/* object & element size */
> >> +	uint32_t                oh_nobjs;	/* total objs (pre-allocated) */
> >> +	uint32_t                oh_nents;	/* max objects per cpuslot */
> >> +	uint32_t                oh_ncpus;	/* num of possible cpus */
> > 
> > If all fields have "oh_" prefix, it is meaningless.
> > Also, if there is no reason to be 32bit (like align the structure size
> > for cache, or pack the structure for streaming etc.) use appropriate types.
> > 
> > And please do not align the length of field name unnaturally. e.g.
> 
> Kind of obsessive-compulsive symptom, haha :) The struct size of objpool_head 
> doesn't matter. The size of objpool_slot does matter, as managed in a single 
> cache-line.

Yeah, so objpool_slot is good to use uint32_t. You may also need __packed and
__cacheline_aligned for objpool_slot ;)

Thank you!

> 
> > 
> > size_t obj_size; /* size_t or unsigned int, I don't care. */
> > int nr_objs; /* I think just 'int' is enough because the value should be
> >                 checked and limited under INT_MAX */
> > int max_entries;
> > unsigned int nr_cpus;
> > 
> > (BTW why we need to limit the nr_cpus here? we have num_possible_cpus())
> 
> You are right that nr_cpus is unnecessary. num_possible_cpus() just keeps the 
> same even with new hot-plugged cpus.
> 
> > 
> >> +	uint32_t                oh_in_user:1;	/* user-specified buffer */
> >> +	uint32_t                oh_in_slot:1;	/* objs alloced with slots */
> >> +	uint32_t                oh_vmalloc:1;	/* alloc from vmalloc zone */
> > 
> > Please use "bool" or "unsigned long flags" with flag bits.
> > 
> >> +	gfp_t                   oh_gfp;		/* k/vmalloc gfp flags */
> >> +	uint32_t                oh_sz_pool;	/* user pool size in byes */
> > 
> > size_t pool_size
> > 
> >> +	void                   *oh_pool;	/* user managed memory pool */
> >> +	struct objpool_slot   **oh_slots;	/* array of percpu slots */
> >> +	uint32_t               *oh_sz_slots;	/* size in bytes of slots */
> > 
> > size_t slot_size
> > 
> 
> Will apply these changes in next version.
> 
> >> +	objpool_release_cb      oh_release;	/* resource cleanup callback */
> >> +	void                   *oh_context;	/* caller-provided context */
> >> +};
> > 
> > Thank you,
> > 
> 
> Best regards,
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
