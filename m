Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80BF6DF96F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDLPM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjDLPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:12:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AF4C12;
        Wed, 12 Apr 2023 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681312368; x=1712848368;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=x10ivT5rZHjB7u+rJn5L2DzCTA6oazecYo3P5OVb5Gg=;
  b=g0+V6srpzAKtYetSz/R6GRJ2S/rLjxxOTkwZKkK8dOlEfx/r3B8+6UVu
   2kNXc9jPTEO37fxnLLN74fIAyL2JBNWK2FSpEq5gd6ataYkN0I3NuFja7
   AbVan0RATX06b7fv1dbwjJ9qtk1dg6baCK+R62QHLQLpVrBecxtjKjK1H
   WIx0tADkJ+cJIz2neXjxO9/1AMzaeZOiyt9Q5vmkO6drqhLHALtIT6l06
   3Wy3F3/YR4WLCrw6jhhbL6JIHneAfOShJpkpmdA0cp6cPQGOLCYeNd9N7
   P/YBX9C/leAbjH4InBv03V/bf8NnG+z4fXHw1rtmEq4+eeKG2/iDCXuWk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="341419779"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="341419779"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682501720"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="682501720"
Received: from amurkovx-mobl.ger.corp.intel.com (HELO [10.213.229.123]) ([10.213.229.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 08:12:43 -0700
Message-ID: <625477ba-2f98-4137-7c96-dc54990c6963@linux.intel.com>
Date:   Wed, 12 Apr 2023 16:12:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/7] drm/i915: Switch to fdinfo helper
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
References: <20230411225725.2032862-1-robdclark@gmail.com>
 <20230411225725.2032862-5-robdclark@gmail.com>
 <292d10fe-3163-d282-6497-18c1d8621d72@linux.intel.com>
 <ZDa3U/k9orudzwL2@phenom.ffwll.local>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <ZDa3U/k9orudzwL2@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/04/2023 14:51, Daniel Vetter wrote:
> On Wed, Apr 12, 2023 at 01:32:43PM +0100, Tvrtko Ursulin wrote:
>>
>> On 11/04/2023 23:56, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>    drivers/gpu/drm/i915/i915_driver.c     |  3 ++-
>>>    drivers/gpu/drm/i915/i915_drm_client.c | 18 +++++-------------
>>>    drivers/gpu/drm/i915/i915_drm_client.h |  2 +-
>>>    3 files changed, 8 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
>>> index db7a86def7e2..37eacaa3064b 100644
>>> --- a/drivers/gpu/drm/i915/i915_driver.c
>>> +++ b/drivers/gpu/drm/i915/i915_driver.c
>>> @@ -1696,7 +1696,7 @@ static const struct file_operations i915_driver_fops = {
>>>    	.compat_ioctl = i915_ioc32_compat_ioctl,
>>>    	.llseek = noop_llseek,
>>>    #ifdef CONFIG_PROC_FS
>>> -	.show_fdinfo = i915_drm_client_fdinfo,
>>> +	.show_fdinfo = drm_fop_show_fdinfo,
>>>    #endif
>>>    };
>>> @@ -1796,6 +1796,7 @@ static const struct drm_driver i915_drm_driver = {
>>>    	.open = i915_driver_open,
>>>    	.lastclose = i915_driver_lastclose,
>>>    	.postclose = i915_driver_postclose,
>>> +	.show_fdinfo = i915_drm_client_fdinfo,
>>>    	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>>    	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>>> diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
>>> index b09d1d386574..4a77e5e47f79 100644
>>> --- a/drivers/gpu/drm/i915/i915_drm_client.c
>>> +++ b/drivers/gpu/drm/i915/i915_drm_client.c
>>> @@ -101,7 +101,7 @@ static u64 busy_add(struct i915_gem_context *ctx, unsigned int class)
>>>    }
>>>    static void
>>> -show_client_class(struct seq_file *m,
>>> +show_client_class(struct drm_printer *p,
>>>    		  struct i915_drm_client *client,
>>>    		  unsigned int class)
>>>    {
>>> @@ -117,22 +117,20 @@ show_client_class(struct seq_file *m,
>>>    	rcu_read_unlock();
>>>    	if (capacity)
>>> -		seq_printf(m, "drm-engine-%s:\t%llu ns\n",
>>> +		drm_printf(p, "drm-engine-%s:\t%llu ns\n",
>>>    			   uabi_class_names[class], total);
>>>    	if (capacity > 1)
>>> -		seq_printf(m, "drm-engine-capacity-%s:\t%u\n",
>>> +		drm_printf(p, "drm-engine-capacity-%s:\t%u\n",
>>>    			   uabi_class_names[class],
>>>    			   capacity);
>>>    }
>>> -void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
>>> +void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file)
>>>    {
>>> -	struct drm_file *file = f->private_data;
>>>    	struct drm_i915_file_private *file_priv = file->driver_priv;
>>>    	struct drm_i915_private *i915 = file_priv->dev_priv;
>>>    	struct i915_drm_client *client = file_priv->client;
>>> -	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>>>    	unsigned int i;
>>>    	/*
>>> @@ -141,12 +139,6 @@ void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
>>>    	 * ******************************************************************
>>>    	 */
>>> -	seq_printf(m, "drm-driver:\t%s\n", i915->drm.driver->name);
>>> -	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n",
>>> -		   pci_domain_nr(pdev->bus), pdev->bus->number,
>>> -		   PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>>> -	seq_printf(m, "drm-client-id:\t%u\n", client->id);
>>
>> As mentioned in my reply to the cover letter, I think the i915
>> implementation is the right one. At least the semantics of it.
>>
>> Granted it is a super set of the minimum required as documented by
>> drm-usage-stats.rst - not only 1:1 to current instances of struct file, but
>> also avoids immediate id recycling.
>>
>> Former could perhaps be achieved with a simple pointer hash, but latter
>> helps userspace detect when a client has exited and id re-allocated to a new
>> client within a single scanning period.
>>
>> Without this I don't think userspace can implement a fail safe method of
>> detecting which clients are new ones and so wouldn't be able to track
>> history correctly.
>>
>> I think we should rather extend the documented contract to include the
>> cyclical property than settle for a weaker common implementation.
> 
> atomic64_t never wraps, so you don't have any recycling issues?

Okay yes, with 64 bits there aren't any practical recycling issues.

> The other piece and imo much more important is that I really don't want
> the i915_drm_client design to spread, it conceptually makes no sense.
> drm_file is the uapi object, once that's gone userspace will never be able
> to look at anything, having a separate free-standing object that's
> essentially always dead is backwards.
> 
> I went a bit more in-depth in a different thread on scheduler fd_info
> stats, but essentially fd_info needs to pull stats, you should never push
> stats towards the drm_file (or i915_drm_client). That avoids all the
> refcounting issues and rcu needs and everything else like that.
> 
> Maybe you want to jump into that thread:
> https://lore.kernel.org/dri-devel/CAKMK7uE=m3sSTQrLCeDg0vG8viODOecUsYDK1oC++f5pQi0e8Q@mail.gmail.com/
> 
> So retiring i915_drm_client infrastructure is the right direction I think.

Hmmm.. it is a _mostly_ pull model that we have in i915 ie. data is 
pulled on fdinfo queries.

_Mostly_ because it cannot be fully pull based when you look at some 
internal flows. We have to save some data at runtime at times not driven 
by the fdinfo queries.

For instance context close needs to record the GPU utilisation against 
the client so that it is not lost. Also in the execlists backend we must 
transfer the hardware tracked runtime into the software state when hw 
contexts are switched out.

The fact i915_drm_client is detached from file_priv is a consequence of 
the fact i915 GEM contexts can outlive drm_file, and that when such 
contexts are closed, we need a to record their runtimes.

So I think there are three options: how it is now, fully krefed 
drm_file, or prohibit persistent contexts. Last one don't think we can 
do due ABI and 2nd felt heavy handed so I choose a lightweight 
i915_drm_client option.

Maybe there is a fourth option of somehow detecting during context 
destruction that drm_file is gone and skip the runtime recording, but 
avoiding races and all did not make me want to entertain it much. Is 
this actually what you are proposing?

Regards,

Tvrtko
