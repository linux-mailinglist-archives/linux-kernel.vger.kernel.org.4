Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB84650EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiLSPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLSPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:39:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1553411178
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD9F60FF0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F583C433D2;
        Mon, 19 Dec 2022 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671464348;
        bh=abQAHntBQcTBqm2NuQ5VKUAc8kU4maN4os+8XBDoq/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CP5UoDATyz4FQuO5IiIX6XpSMv/2ikU14jWCB7LIFbSgZZ7jwOo/fnOFT/5hwvyQi
         rdqcUz7wfe9NETBSpwVtW++nz0XLfkp943GDb1tMXmOVXuuYa2LPKWOwIJy49L91bo
         naLxbREWQGiqzrMeHbvT6d/xyJG8sodX9eaYMGnM=
Date:   Mon, 19 Dec 2022 16:39:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     Alice Chao <alice.chao@mediatek.com>, rafael@kernel.org,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Fix slab-out-of-bounds in fill_kobj_path()
Message-ID: <Y6CFma6PPcvJDGje@kroah.com>
References: <20221219144103.34789-1-wanghai38@huawei.com>
 <Y6B7MKZxjaoQlpgf@kroah.com>
 <dd4d0619-8287-1650-aa43-5db2e86ff8cd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd4d0619-8287-1650-aa43-5db2e86ff8cd@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:27:58PM +0800, wanghai (M) wrote:
> Can I send v2 like this?
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index a0b2dbfcfa23..3f97d903266a 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -112,7 +112,7 @@ static int get_kobj_path_length(struct kobject *kobj)
>         return length;
>  }
> 
> -static void fill_kobj_path(struct kobject *kobj, char *path, int length)
> +static int fill_kobj_path(struct kobject *kobj, char *path, int length)
>  {
>         struct kobject *parent;
> 
> @@ -121,12 +121,16 @@ static void fill_kobj_path(struct kobject *kobj, char
> *path, int length)
>                 int cur = strlen(kobject_name(parent));
>                 /* back up enough to print this name with '/' */
>                 length -= cur;
> +               if (length <= 0)
> +                       return -EINVAL;
>                 memcpy(path + length, kobject_name(parent), cur);
>                 *(path + --length) = '/';
>         }
> 
>         pr_debug("kobject: '%s' (%p): %s: path = '%s'\n",
> kobject_name(kobj),
>                  kobj, __func__, path);
> +
> +       return 0;
>  }
> 
>  /**
> @@ -141,13 +145,17 @@ char *kobject_get_path(struct kobject *kobj, gfp_t
> gfp_mask)
>         char *path;
>         int len;
> 
> +retry:
>         len = get_kobj_path_length(kobj);
>         if (len == 0)
>                 return NULL;
>         path = kzalloc(len, gfp_mask);
>         if (!path)
>                 return NULL;
> -       fill_kobj_path(kobj, path, len);
> +       if (fill_kobj_path(kobj, path, len)) {
> +               kfree(path);
> +               goto retry;
> +       }

Much nicer, thanks!
