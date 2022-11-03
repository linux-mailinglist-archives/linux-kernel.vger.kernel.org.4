Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5221618513
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKCQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiKCQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:47:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B845588
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:45:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m6so2184914pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Q73RkEXGpwlVMgdcSvOE2342Px4pupFTyXg529rpuk=;
        b=nPBTagfsWh5PCfDGGa4gUqPUFpCoINYmaHsa7x0COPkz3WOdiK7gPRNX9pElH5JX7P
         qH0Glsm7L3SUWwyutVQIWIUVW1lp/9mDibeE7ECoc/TVYmaxj+qSUk0LLbmto5ehN5Fe
         cFnAI4vNKsWoAnzu9V+zKypiNukN5G91URokjPgi+fqalgbgprlQMOdTcXrdPzF0vdzr
         1HiKeXr6Xke/26upD4AYxBylQKBokOnJJHerL/rrz3mqW7AlzwP2A+TcAZqJBnqVbfSl
         WnSltB98JLDuOt2RZVwfGZmVj1Tus3FCGjdi5E6EKDP7woeNWexi4JXnKYyCVAk42g6W
         Rudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Q73RkEXGpwlVMgdcSvOE2342Px4pupFTyXg529rpuk=;
        b=vkwHVEuFToSwDnbVFBCRDmCuc33/+h8BTOUppHnUjU/SfrKxspntWnkHnN3xHv35jz
         L+E4k/77uHVrXW4Upc1sdChyac2j+tweFAriFGMZCqCNx8GliEbqclusFHnMLJd/hvrl
         SW3QGs3eU6sQNnMD01C6H+VsWGyqYGzpxUSNkpvlS8ntLStqTUNVJnGwUvkQxCFn6Iby
         Ur6Jst96ngGQ41ZkkiWlg97nfWk9yF6UgoOam9+oi/5PKXrOqkG4Syuj8tRYGwZZW8ix
         WmI1Ja+u94yI4Yg3iyDIOLwGWAsA5u81b009KzECmfsM7jt7Kq3DRZxbBoUcxtyUA4hs
         +wfw==
X-Gm-Message-State: ACrzQf2+i2Y1RsxrY+0BsvuUZL/+BIg3KhA4uSOVdBqslzqg9Y9jA0L6
        S3MRnW3bcYdom6yypBsMj+GxKg==
X-Google-Smtp-Source: AMsMyM5vvhe+Kx85Esxx38cU1tyXTkW3o1jkPk5QA9r/5wITyj/PJTDC8TqRnSRRBmZDp/NS+KvDWw==
X-Received: by 2002:a63:ee4f:0:b0:46f:87a8:97ab with SMTP id n15-20020a63ee4f000000b0046f87a897abmr24233291pgk.349.1667493931474;
        Thu, 03 Nov 2022 09:45:31 -0700 (PDT)
Received: from [10.87.63.10] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id e16-20020a056a0000d000b0056c5aee2d6esm918409pfj.213.2022.11.03.09.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:45:31 -0700 (PDT)
Message-ID: <15d382af-512f-cb06-d8c2-cd9e16d870f6@bytedance.com>
Date:   Fri, 4 Nov 2022 00:45:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v4] kprobes,lib: kretprobe scalability improvement
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mattwu@163.com,
        kernel test robot <lkp@intel.com>
References: <20221101014346.150812-1-wuqiang.matt@bytedance.com>
 <20221102023012.6362-1-wuqiang.matt@bytedance.com>
 <20221103115133.753b878b0c5481600e054240@kernel.org>
From:   wuqiang <wuqiang.matt@bytedance.com>
In-Reply-To: <20221103115133.753b878b0c5481600e054240@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/3 10:51, Masami Hiramatsu (Google) wrote:
> Hi wuqiang (or Matt?),
> 
> Thanks for updating the patch! I have some comments below,

Thanks for your time :)

> On Wed,  2 Nov 2022 10:30:12 +0800
> wuqiang <wuqiang.matt@bytedance.com> wrote:
> 
...
>> Changes since V3:
>> 1) build warning: unused variable in fprobe_init_rethook
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Changes since V2:
>> 1) the percpu-extended version of the freelist replaced by new percpu-
>>     ring-array. freelist has data-contention in freelist_node (refs and
>>     next) even after node is removed from freelist and the node could
>>     be polluted easily (with freelist_node defined in union)
>> 2) routines split to objpool.h and objpool.c according to cold & hot
>>     pathes, and the latter moved to lib, as suggested by Masami
>> 3) test module (test_objpool.ko) added to lib for functional testings
>>
>> Changes since V1:
>> 1) reformat to a single patch as Masami Hiramatsu suggested
>> 2) use __vmalloc_node to replace vmalloc_node for vmalloc
>> 3) a few minor fixes: typo and coding-style issues
> 
> Recording change log is very good. But if it becomes too long,
> you can put a URL of the previous series on LKML instead of
> appending the change logs.
> You can get the URL (permlink) by "lkml.kernel.org/r/<your-message-id>"

Got it.

>>
>> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
>> ---
>>   include/linux/freelist.h |  129 -----
>>   include/linux/kprobes.h  |    9 +-
>>   include/linux/objpool.h  |  151 ++++++
>>   include/linux/rethook.h  |   15 +-
>>   kernel/kprobes.c         |   95 ++--
>>   kernel/trace/fprobe.c    |   17 +-
>>   kernel/trace/rethook.c   |   80 +--
>>   lib/Kconfig.debug        |   11 +
>>   lib/Makefile             |    4 +-
>>   lib/objpool.c            |  480 ++++++++++++++++++
>>   lib/test_objpool.c       | 1031 ++++++++++++++++++++++++++++++++++++++
>>   11 files changed, 1772 insertions(+), 250 deletions(-)
> 
> Hmm, this does too much things in 1 patch.
> Can you split this in below 5 patches? This also makes clear that who
> needs to review which part.

I was ever considering of splitting, but finally decided to mix them in a big 
one mostly because it's only for kretprobe improvement.

Next version I'll split to smaller patches. Thank you for the advice.

> 
> - Add generic scalable objpool
> - Add objpool test
> - Use objpool in kretprobe
> - Use objpool in fprobe and rethook
> - Remove unused freelist
> 
>>   delete mode 100644 include/linux/freelist.h
>>   create mode 100644 include/linux/objpool.h
>>   create mode 100644 lib/objpool.c
>>   create mode 100644 lib/test_objpool.c
>>
> [...]
>> +
>> +struct objpool_slot {
>> +	uint32_t                os_head;	/* head of ring array */
> 
> If all fields have "os_" prefix, it is meaningless.
> 
>> +	uint32_t                os_tail;	/* tail of ring array */
>> +	uint32_t                os_size;	/* max item slots, pow of 2 */
>> +	uint32_t                os_mask;	/* os_size - 1 */
>> +/*
>> + *	uint32_t                os_ages[];	// ring epoch id
>> + *	void                   *os_ents[];	// objects array
> 
> "entries[]"

I'll refine the comments here to better explain the memory layout.

> 
>> + */
>> +};
>> +
>> +/* caller-specified object initial callback to setup each object, only called once */
>> +typedef int (*objpool_init_node_cb)(void *context, void *obj);
>> +
>> +/* caller-specified cleanup callback for private objects/pool/context */
>> +typedef int (*objpool_release_cb)(void *context, void *ptr, uint32_t flags);
>> +
>> +/* called for object releasing: ptr points to an object */
>> +#define OBJPOOL_FLAG_NODE        (0x00000001)
>> +/* for user pool and context releasing, ptr could be NULL */
>> +#define OBJPOOL_FLAG_POOL        (0x00001000)
>> +/* the object or pool to be released is user-managed */
>> +#define OBJPOOL_FLAG_USER        (0x00008000)
>> +
>> +/*
>> + * objpool_head: object pooling metadata
>> + */
>> +
>> +struct objpool_head {
>> +	uint32_t                oh_objsz;	/* object & element size */
>> +	uint32_t                oh_nobjs;	/* total objs (pre-allocated) */
>> +	uint32_t                oh_nents;	/* max objects per cpuslot */
>> +	uint32_t                oh_ncpus;	/* num of possible cpus */
> 
> If all fields have "oh_" prefix, it is meaningless.
> Also, if there is no reason to be 32bit (like align the structure size
> for cache, or pack the structure for streaming etc.) use appropriate types.
> 
> And please do not align the length of field name unnaturally. e.g.

Kind of obsessive-compulsive symptom, haha :) The struct size of objpool_head 
doesn't matter. The size of objpool_slot does matter, as managed in a single 
cache-line.

> 
> size_t obj_size; /* size_t or unsigned int, I don't care. */
> int nr_objs; /* I think just 'int' is enough because the value should be
>                 checked and limited under INT_MAX */
> int max_entries;
> unsigned int nr_cpus;
> 
> (BTW why we need to limit the nr_cpus here? we have num_possible_cpus())

You are right that nr_cpus is unnecessary. num_possible_cpus() just keeps the 
same even with new hot-plugged cpus.

> 
>> +	uint32_t                oh_in_user:1;	/* user-specified buffer */
>> +	uint32_t                oh_in_slot:1;	/* objs alloced with slots */
>> +	uint32_t                oh_vmalloc:1;	/* alloc from vmalloc zone */
> 
> Please use "bool" or "unsigned long flags" with flag bits.
> 
>> +	gfp_t                   oh_gfp;		/* k/vmalloc gfp flags */
>> +	uint32_t                oh_sz_pool;	/* user pool size in byes */
> 
> size_t pool_size
> 
>> +	void                   *oh_pool;	/* user managed memory pool */
>> +	struct objpool_slot   **oh_slots;	/* array of percpu slots */
>> +	uint32_t               *oh_sz_slots;	/* size in bytes of slots */
> 
> size_t slot_size
> 

Will apply these changes in next version.

>> +	objpool_release_cb      oh_release;	/* resource cleanup callback */
>> +	void                   *oh_context;	/* caller-provided context */
>> +};
> 
> Thank you,
> 

Best regards,

