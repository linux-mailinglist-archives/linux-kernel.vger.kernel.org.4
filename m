Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80336E0E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDMNHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDMNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:07:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6570A253;
        Thu, 13 Apr 2023 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681391261; x=1712927261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M2aUEW+IML2DV0GcrvR6z18+5jlp57gNIuCt5UccOMs=;
  b=Io6LFYx5B8KLzZicRD8Qin5xwnmBuxe5AF4rkF9sqN4Ir6Q1GcK9r68/
   fisDnJcoeWHs/a06O+EdhduUFyLkZh3XO8e+obHo2Z+Zb2sBxl4H/amrc
   gHK7yO7ofBJfQIF9rMeGkIHmLiwtliU8ofs6zvNvPPGMibm+N58/sdM9R
   Yq0M0g96+sqjCTShEkAVdqSudpxjHOEVxC4bm0K5mLJ8wB8lQiJLY0y2g
   2M3FndZHbdPIXhNbZj9aWBt8TAzG5ziI20DP6kuWURxrk87KB1qqCA0c9
   qeA7KAheNzv7D7GjjDIhkbmMBfDWMmBckSvaRqkBU0Txnx1YAirntuo77
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="342922394"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="342922394"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 06:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="639665454"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="639665454"
Received: from mmcgar2x-mobl1.ger.corp.intel.com (HELO [10.213.231.135]) ([10.213.231.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 06:07:37 -0700
Message-ID: <76c836a3-30a8-a46e-5a1a-0e3dc5967459@linux.intel.com>
Date:   Thu, 13 Apr 2023 14:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 4/6] drm/i915: Switch to fdinfo helper
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
References: <20230412224311.23511-1-robdclark@gmail.com>
 <20230412224311.23511-5-robdclark@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230412224311.23511-5-robdclark@gmail.com>
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


On 12/04/2023 23:42, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>

There is more do to here to remove my client->id fully (would now be 
dead code) so maybe easiest if you drop this patch and I do it after you 
land this and it propagates to our branches? I'd like to avoid pain with 
conflicts if possible..

Regards,

Tvrtko

> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/i915/i915_driver.c     |  3 ++-
>   drivers/gpu/drm/i915/i915_drm_client.c | 18 +++++-------------
>   drivers/gpu/drm/i915/i915_drm_client.h |  2 +-
>   3 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index db7a86def7e2..0d91f85f8b97 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1696,7 +1696,7 @@ static const struct file_operations i915_driver_fops = {
>   	.compat_ioctl = i915_ioc32_compat_ioctl,
>   	.llseek = noop_llseek,
>   #ifdef CONFIG_PROC_FS
> -	.show_fdinfo = i915_drm_client_fdinfo,
> +	.show_fdinfo = drm_show_fdinfo,
>   #endif
>   };
>   
> @@ -1796,6 +1796,7 @@ static const struct drm_driver i915_drm_driver = {
>   	.open = i915_driver_open,
>   	.lastclose = i915_driver_lastclose,
>   	.postclose = i915_driver_postclose,
> +	.show_fdinfo = i915_drm_client_fdinfo,
>   
>   	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>   	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
> index b09d1d386574..4a77e5e47f79 100644
> --- a/drivers/gpu/drm/i915/i915_drm_client.c
> +++ b/drivers/gpu/drm/i915/i915_drm_client.c
> @@ -101,7 +101,7 @@ static u64 busy_add(struct i915_gem_context *ctx, unsigned int class)
>   }
>   
>   static void
> -show_client_class(struct seq_file *m,
> +show_client_class(struct drm_printer *p,
>   		  struct i915_drm_client *client,
>   		  unsigned int class)
>   {
> @@ -117,22 +117,20 @@ show_client_class(struct seq_file *m,
>   	rcu_read_unlock();
>   
>   	if (capacity)
> -		seq_printf(m, "drm-engine-%s:\t%llu ns\n",
> +		drm_printf(p, "drm-engine-%s:\t%llu ns\n",
>   			   uabi_class_names[class], total);
>   
>   	if (capacity > 1)
> -		seq_printf(m, "drm-engine-capacity-%s:\t%u\n",
> +		drm_printf(p, "drm-engine-capacity-%s:\t%u\n",
>   			   uabi_class_names[class],
>   			   capacity);
>   }
>   
> -void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
> +void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file)
>   {
> -	struct drm_file *file = f->private_data;
>   	struct drm_i915_file_private *file_priv = file->driver_priv;
>   	struct drm_i915_private *i915 = file_priv->dev_priv;
>   	struct i915_drm_client *client = file_priv->client;
> -	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>   	unsigned int i;
>   
>   	/*
> @@ -141,12 +139,6 @@ void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
>   	 * ******************************************************************
>   	 */
>   
> -	seq_printf(m, "drm-driver:\t%s\n", i915->drm.driver->name);
> -	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n",
> -		   pci_domain_nr(pdev->bus), pdev->bus->number,
> -		   PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> -	seq_printf(m, "drm-client-id:\t%u\n", client->id);
> -
>   	/*
>   	 * Temporarily skip showing client engine information with GuC submission till
>   	 * fetching engine busyness is implemented in the GuC submission backend
> @@ -155,6 +147,6 @@ void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
>   		return;
>   
>   	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++)
> -		show_client_class(m, client, i);
> +		show_client_class(p, client, i);
>   }
>   #endif
> diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
> index 69496af996d9..ef85fef45de5 100644
> --- a/drivers/gpu/drm/i915/i915_drm_client.h
> +++ b/drivers/gpu/drm/i915/i915_drm_client.h
> @@ -60,7 +60,7 @@ static inline void i915_drm_client_put(struct i915_drm_client *client)
>   struct i915_drm_client *i915_drm_client_add(struct i915_drm_clients *clients);
>   
>   #ifdef CONFIG_PROC_FS
> -void i915_drm_client_fdinfo(struct seq_file *m, struct file *f);
> +void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file);
>   #endif
>   
>   void i915_drm_clients_fini(struct i915_drm_clients *clients);
