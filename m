Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD26B40A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCJNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCJNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:42:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E16111FBE;
        Fri, 10 Mar 2023 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678455766; x=1709991766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B7DzPLaV7PYb4CwSpTmT+8+euC7hqUSnfgzb906Ua98=;
  b=WdQ2vBt70GPXYXFZ0WbzXJ2qFSgU2LgdsMjPiuTk0wD2YG1lMjVsHN75
   cq6woPjW9MWilW6kXxOHc+0ow2Q1JHOtAb1nkPzDZWmQstLkXKuhyXWob
   +3Ta6rmkqFQefiA5UZmzU8OqDleBi4ALy6Y2iO6begFOgqtZPBhue24Q2
   Z5M///3CRGYcnG5CECvk0IvKm548a4frPUwy7bM6CGnaI3QpU5FjUpcsa
   N6k0wbw4mLhhjRd7wlf3pwskCFQAibI0plvHzcC6y15FlV7taxSZ1FJSQ
   5HjsTlFn0Y8kd9Cek45XNOpxDYbDIEg6H5dGXosgkDtr3wyDyQOvJTn2U
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338281408"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="338281408"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 05:42:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="627814390"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="627814390"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2023 05:42:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pad18-000tdW-1a;
        Fri, 10 Mar 2023 15:42:42 +0200
Date:   Fri, 10 Mar 2023 15:42:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] block: don't embed integrity_kobj into gendisk
Message-ID: <ZAsz0lvdS60nFwJx@smile.fi.intel.com>
References: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
 <d85ba503-d93c-3483-25e1-6043d4af444f@alu.unizg.hr>
 <0ac9777c-7586-494f-bbc5-87f14f645b12@t-8ch.de>
 <d10f18b4-56cf-8a55-b12f-79b1163d8841@alu.unizg.hr>
 <7f977a5d-8302-4a32-9dce-f6d7637b2555@t-8ch.de>
 <dc4f7684-2bec-ece2-17bd-ecaaaa5d5c69@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc4f7684-2bec-ece2-17bd-ecaaaa5d5c69@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:52:51AM +0100, Mirsad Todorovac wrote:
> Hi, Thomas,
> 
> The good news is that the
> 
> "kobject: 'integrity' (000000001aa7f87a): does not have a release() function"
> 
> is now removed:
> 
> https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/fix/20230310_082429.jpg
> 
> On 3/10/23 00:26, Thomas Weißschuh wrote:
> > On Thu, Mar 09, 2023 at 10:46:50PM +0100, Mirsad Goran Todorovac wrote:
> > > On 09. 03. 2023. 22:23, Thomas Weißschuh wrote:
> > > 
> > > Very well, but who then destroys the cache crated here:
> > > 
> > > security/integrity/iint.c:177-179
> > > > 177         iint_cache =
> > > > 178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
> > > > 179                               0, SLAB_PANIC, init_once);
> > > 
> > > I assumed that it must have been done from iint.c because iint_cache is
> > > static?
> > 
> > It doesn't seem like anything destroys this cache.
> > 
> > I'm not sure this is a problem though as iint.c can not be built as module.
> 
> Maybe I was just scolded when I relied on exit() to do the memory deallocation
> from heap automatically in userspace programs. :-/
> 
> I suppose this cache is destroyed when virtual Linux machine is shutdown.
> 
> Still, it might seem prudent for all of the objects to be destroyed before shutting
> down the kernel, assuring the call of proper destructors, and in the right order.
> 
> > At least it's not a problem with kobjects as those are not used here.
> 
> I begin to understand.
> 
> security/integrity/iint.c:
> 175 static int __init integrity_iintcache_init(void)
> 176 {
> 177         iint_cache =
> 178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
> 179                               0, SLAB_PANIC, init_once);
> 180         return 0;
> 181 }
> 182 DEFINE_LSM(integrity) = {
> 183         .name = "integrity",
> 184         .init = integrity_iintcache_init,
> 185 };
> 
> and struct lsm_info
> 
> include/linux/lsm_hooks.h:
> 1721 struct lsm_info {
> 1722         const char *name;       /* Required. */
> 1723         enum lsm_order order;   /* Optional: default is LSM_ORDER_MUTABLE */
> 1724         unsigned long flags;    /* Optional: flags describing LSM */
> 1725         int *enabled;           /* Optional: controlled by CONFIG_LSM */
> 1726         int (*init)(void);      /* Required. */
> 1727         struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
> 1728 };
> 
> Here a proper destructor might be prudent to add.
> 
> Naive try could be like this:
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 6e156d2acffc..d5a6ab9b5eb2 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1724,6 +1724,7 @@ struct lsm_info {
>         unsigned long flags;    /* Optional: flags describing LSM */
>         int *enabled;           /* Optional: controlled by CONFIG_LSM */
>         int (*init)(void);      /* Required. */
> +       int (*release)(void);   /* Release associated resources */
>         struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
>  };
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 8638976f7990..3f69eb702b2e 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -179,9 +179,16 @@ static int __init integrity_iintcache_init(void)
>                               0, SLAB_PANIC, init_once);
>         return 0;
>  }
> +
> +static int __exit integrity_iintcache_release(void)
> +{
> +       kmem_cache_destroy(iint_cache);
> +}
> +
>  DEFINE_LSM(integrity) = {
>         .name = "integrity",
>         .init = integrity_iintcache_init,
> +       .release = integrity_iintcache_release,
>  };
> 
> However, I lack insight of who should invoke .release() on 'integrity',
> in 10.7 million lines of *.c and *.h files. Obviously, now no one is
> expecting .release in LSM modules. But there might be a need for the
> proper cleanup.
> 
> For it is not a kobject as you already observed? :-/

I think you may prepare a formal patch and Cc to Greg KH, who knows
the kobject code well and this warning in particular.

I believe, even if a dead code, the destructor to have is a good code
behaviour, since it is might be called on the __exitcall.

-- 
With Best Regards,
Andy Shevchenko


