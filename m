Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613646CC19A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjC1OAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjC1OAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:00:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F5CC26;
        Tue, 28 Mar 2023 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680011970; x=1711547970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2bpxXtg+8K5yT3Gb2/b1JBoxmrLCF2pbspOSjoZyEvE=;
  b=PbU8cH6OqjNzrlzkxfJ7i2lSGBCBBenfiFyspkuyikHRdkP8YQ0JbFM6
   Nuq4gWUBEcJT63GlwMfTttZThTLAwScHA37GVt+7Fqd/V99mm39/Z1Lqd
   WNSM29eXpsuw7WatFSQDUv+TdUnge7DOfpVVXR93klx7GUK+B1Bkyx0kZ
   URJJlxH/cjXAKSmsZx4xJz4IT+dyVXynD/IOlTlD3DA2950zCmBs+oS95
   Gr+VsqzJjMlTxItJv/Jt/oBf0zngf2C7Rnz4h0JHTAZuo19MZ4ISLF1AZ
   KZ4DAD3eS5gBUX76qh8x1XXLiNNGHihnx6GOWnX+CD0kWIKT2SSVS2KR8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="324463129"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324463129"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:57:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="716492675"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="716492675"
Received: from wheelerj-mobl.ger.corp.intel.com (HELO [10.213.213.242]) ([10.213.213.242])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:57:35 -0700
Message-ID: <f973f656-acdf-320f-95d5-3f79cc3ce95a@linux.intel.com>
Date:   Tue, 28 Mar 2023 14:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 07/15] dma-buf/sw_sync: Add fence deadline support
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Matt Turner <mattst88@gmail.com>,
        freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
References: <20230308155322.344664-1-robdclark@gmail.com>
 <20230308155322.344664-8-robdclark@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230308155322.344664-8-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/03/2023 15:52, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This consists of simply storing the most recent deadline, and adding an
> ioctl to retrieve the deadline.  This can be used in conjunction with
> the SET_DEADLINE ioctl on a fence fd for testing.  Ie. create various
> sw_sync fences, merge them into a fence-array, set deadline on the
> fence-array and confirm that it is propagated properly to each fence.
> 
> v2: Switch UABI to express deadline as u64
> v3: More verbose UAPI docs, show how to convert from timespec
> v4: Better comments, track the soonest deadline, as a normal fence
>      implementation would, return an error if no deadline set.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> ---
>   drivers/dma-buf/sw_sync.c    | 81 ++++++++++++++++++++++++++++++++++++
>   drivers/dma-buf/sync_debug.h |  2 +
>   2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 348b3a9170fa..f53071bca3af 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -52,12 +52,33 @@ struct sw_sync_create_fence_data {
>   	__s32	fence; /* fd of new fence */
>   };
>   
> +/**
> + * struct sw_sync_get_deadline - get the deadline hint of a sw_sync fence
> + * @deadline_ns: absolute time of the deadline
> + * @pad:	must be zero
> + * @fence_fd:	the sw_sync fence fd (in)
> + *
> + * Return the earliest deadline set on the fence.  The timebase for the
> + * deadline is CLOCK_MONOTONIC (same as vblank).  If there is no deadline

Mentioning vblank reads odd since this is drivers/dma-buf/. Dunno.

> + * set on the fence, this ioctl will return -ENOENT.
> + */
> +struct sw_sync_get_deadline {
> +	__u64	deadline_ns;
> +	__u32	pad;
> +	__s32	fence_fd;
> +};
> +
>   #define SW_SYNC_IOC_MAGIC	'W'
>   
>   #define SW_SYNC_IOC_CREATE_FENCE	_IOWR(SW_SYNC_IOC_MAGIC, 0,\
>   		struct sw_sync_create_fence_data)
>   
>   #define SW_SYNC_IOC_INC			_IOW(SW_SYNC_IOC_MAGIC, 1, __u32)
> +#define SW_SYNC_GET_DEADLINE		_IOWR(SW_SYNC_IOC_MAGIC, 2, \
> +		struct sw_sync_get_deadline)
> +
> +
> +#define SW_SYNC_HAS_DEADLINE_BIT	DMA_FENCE_FLAG_USER_BITS
>   
>   static const struct dma_fence_ops timeline_fence_ops;
>   
> @@ -171,6 +192,22 @@ static void timeline_fence_timeline_value_str(struct dma_fence *fence,
>   	snprintf(str, size, "%d", parent->value);
>   }
>   
> +static void timeline_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
> +{
> +	struct sync_pt *pt = dma_fence_to_sync_pt(fence);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(fence->lock, flags);
> +	if (test_bit(SW_SYNC_HAS_DEADLINE_BIT, &fence->flags)) {
> +		if (ktime_before(deadline, pt->deadline))
> +			pt->deadline = deadline;
> +	} else {
> +		pt->deadline = deadline;
> +		set_bit(SW_SYNC_HAS_DEADLINE_BIT, &fence->flags);

FWIW could use __set_bit to avoid needless atomic under spinlock.

> +	}
> +	spin_unlock_irqrestore(fence->lock, flags);
> +}
> +
>   static const struct dma_fence_ops timeline_fence_ops = {
>   	.get_driver_name = timeline_fence_get_driver_name,
>   	.get_timeline_name = timeline_fence_get_timeline_name,
> @@ -179,6 +216,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
>   	.release = timeline_fence_release,
>   	.fence_value_str = timeline_fence_value_str,
>   	.timeline_value_str = timeline_fence_timeline_value_str,
> +	.set_deadline = timeline_fence_set_deadline,
>   };
>   
>   /**
> @@ -387,6 +425,46 @@ static long sw_sync_ioctl_inc(struct sync_timeline *obj, unsigned long arg)
>   	return 0;
>   }
>   
> +static int sw_sync_ioctl_get_deadline(struct sync_timeline *obj, unsigned long arg)
> +{
> +	struct sw_sync_get_deadline data;
> +	struct dma_fence *fence;
> +	struct sync_pt *pt;
> +	int ret = 0;
> +
> +	if (copy_from_user(&data, (void __user *)arg, sizeof(data)))
> +		return -EFAULT;
> +
> +	if (data.deadline_ns || data.pad)
> +		return -EINVAL;
> +
> +	fence = sync_file_get_fence(data.fence_fd);
> +	if (!fence)
> +		return -EINVAL;
> +
> +	pt = dma_fence_to_sync_pt(fence);
> +	if (!pt)
> +		return -EINVAL;
> +
> +	spin_lock(fence->lock);

This may need to be _irq.

> +	if (test_bit(SW_SYNC_HAS_DEADLINE_BIT, &fence->flags)) {
> +		data.deadline_ns = ktime_to_ns(pt->deadline);
> +	} else {
> +		ret = -ENOENT;
> +	}
> +	spin_unlock(fence->lock);
> +
> +	dma_fence_put(fence);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (copy_to_user((void __user *)arg, &data, sizeof(data)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   static long sw_sync_ioctl(struct file *file, unsigned int cmd,
>   			  unsigned long arg)
>   {
> @@ -399,6 +477,9 @@ static long sw_sync_ioctl(struct file *file, unsigned int cmd,
>   	case SW_SYNC_IOC_INC:
>   		return sw_sync_ioctl_inc(obj, arg);
>   
> +	case SW_SYNC_GET_DEADLINE:
> +		return sw_sync_ioctl_get_deadline(obj, arg);
> +
>   	default:
>   		return -ENOTTY;
>   	}
> diff --git a/drivers/dma-buf/sync_debug.h b/drivers/dma-buf/sync_debug.h
> index 6176e52ba2d7..a1bdd62efccd 100644
> --- a/drivers/dma-buf/sync_debug.h
> +++ b/drivers/dma-buf/sync_debug.h
> @@ -55,11 +55,13 @@ static inline struct sync_timeline *dma_fence_parent(struct dma_fence *fence)
>    * @base: base fence object
>    * @link: link on the sync timeline's list
>    * @node: node in the sync timeline's tree
> + * @deadline: the earliest fence deadline hint
>    */
>   struct sync_pt {
>   	struct dma_fence base;
>   	struct list_head link;
>   	struct rb_node node;
> +	ktime_t deadline;
>   };
>   
>   extern const struct file_operations sw_sync_debugfs_fops;

Regards,

Tvrtko
