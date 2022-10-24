Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD3B60B261
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiJXQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiJXQor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:44:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE4014138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C664B81B75
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1728C433C1;
        Mon, 24 Oct 2022 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666619524;
        bh=QIHnXVxCIGETsd0dywR9WOXQe2R85leBxjgt9psJDlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2H9OWmUuPXe1nsvDHzMz7pk28v9U01aePXWCqE/PYv8mU+b3XDQLri0CqGVaRsJz
         jDX3YxQNP/rC/SyUqCZ86yUqxIXbKkp05GDQaItPKZLX+Z/tQqtvt0HtDKDldCwU2Z
         RC0760eEL3DTVNddcLXXtAu1W45/R1VDk/n+VsGo=
Date:   Mon, 24 Oct 2022 15:52:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
        rafael@kernel.org, somlo@cmu.edu, mst@redhat.com,
        jaegeuk@kernel.org, chao@kernel.org, hsiangkao@linux.alibaba.com,
        huangjianan@oppo.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, akpm@linux-foundation.org,
        alexander.deucher@amd.com, luben.tuikov@amd.com, richard@nod.at,
        liushixin2@huawei.com
Subject: Re: [PATCH v2] kset: fix memory leak when kset_register() returns
 error
Message-ID: <Y1aYuLmlXBRvMP1Z@kroah.com>
References: <20221024121910.1169801-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024121910.1169801-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:19:10PM +0800, Yang Yingliang wrote:
> Inject fault while loading module, kset_register() may fail.
> If it fails, the name allocated by kobject_set_name() which
> is called before kset_register() is leaked, because refcount
> of kobject is hold in kset_init().
> 
> As a kset may be embedded in a larger structure which needs
> be freed in release() function or error path in callers, we
> can not call kset_put() in kset_register(), or it will cause
> double free, so just call kfree_const() to free the name and
> set it to NULL.
> 
> With this fix, the callers don't need to care about the name
> freeing and call an extra kset_put() if kset_register() fails.
> 
> Suggested-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>   Free name inside of kset_register() instead of calling kset_put()
>   in drivers.
> ---
>  lib/kobject.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index a0b2dbfcfa23..3409a89c81e5 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
>  /**
>   * kset_register() - Initialize and add a kset.
>   * @k: kset.
> + *
> + * NOTE: On error, the kset.kobj.name allocated by() kobj_set_name()
> + * which is called before kset_register() in caller need be freed.

This comment doesn't make any sense anymore.  No caller needs to worry
about this, right?

>   */
>  int kset_register(struct kset *k)
>  {
> @@ -844,8 +847,11 @@ int kset_register(struct kset *k)
>  
>  	kset_init(k);
>  	err = kobject_add_internal(&k->kobj);
> -	if (err)
> +	if (err) {
> +		kfree_const(k->kobj.name);
> +		k->kobj.name = NULL;

Why are you setting the name here to NULL?

thanks,

greg k-h
