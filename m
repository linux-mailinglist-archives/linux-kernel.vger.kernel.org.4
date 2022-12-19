Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABA1650E22
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiLSO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiLSO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:58:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E295F49
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:54:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE19BB80DF2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EDCC433EF;
        Mon, 19 Dec 2022 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671461683;
        bh=wOJC6lzxLzI4/rdLQoX0fj3Ksu94I8e0ImMBtduC86U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKeIoCzOzLDSDGz8TK0g93ZGEpDjeOoqy1+37bMZ+6z1ZvGd3SSHWe0Pa2AstHKTR
         kFzDZ8YIZn6l3A6+SajUK3if1OhDH/+BlBoSeFBw6hzIQg6ZwQlfdw/MY5bPjntKeu
         8zLAMrbmhD5FcxlQd7jeitlZ7pkWh98yMcOnqkC8=
Date:   Mon, 19 Dec 2022 15:54:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Hai <wanghai38@huawei.com>,
        Alice Chao <alice.chao@mediatek.com>
Cc:     rafael@kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Fix slab-out-of-bounds in fill_kobj_path()
Message-ID: <Y6B7MKZxjaoQlpgf@kroah.com>
References: <20221219144103.34789-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219144103.34789-1-wanghai38@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 10:41:03PM +0800, Wang Hai wrote:
> In kobject_get_path(), if kobj->name is changed between calls
> get_kobj_path_length() and fill_kobj_path() and the length becomes
> longer, then fill_kobj_path() will have an out-of-bounds bug.
> 
> The actual current problem occurs when the ixgbe probe.
> 
> In ixgbe_mii_bus_init(), if the length of netdev->dev.kobj.name
> length becomes longer, out-of-bounds will occur.
> 
> cpu0                                         cpu1
> ixgbe_probe
>  register_netdev(netdev)
>   netdev_register_kobject
>    device_add
>     kobject_uevent // Sending ADD events
>                                              systemd-udevd // rename netdev
>                                               dev_change_name
>                                                device_rename
>                                                 kobject_rename
>                                                 |
>  ixgbe_mii_bus_init                             |
>   mdiobus_register                              |
>    __mdiobus_register                           |
>     device_register                             |
>      device_add                                 |
>       kobject_uevent                            |
>        kobject_get_path                         |
>         len = get_kobj_path_length // old name  |
>         path = kzalloc(len, gfp_mask);          |
>                                                 kobj->name = name;
>                                                 /* name length becomes
>                                                  * longer
>                                                  */
>         fill_kobj_path /* kobj path length is
>                         * longer than path,
>                         * resulting in out of
>                         * bounds when filling path
>                         */
> 
> This is the kasan report:
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in fill_kobj_path+0x50/0xc0
> Write of size 7 at addr ff1100090573d1fd by task kworker/28:1/673
> 
>  Workqueue: events work_for_cpu_fn
>  Call Trace:
>  <TASK>
>  dump_stack_lvl+0x34/0x48
>  print_address_description.constprop.0+0x86/0x1e7
>  print_report+0x36/0x4f
>  kasan_report+0xad/0x130
>  kasan_check_range+0x35/0x1c0
>  memcpy+0x39/0x60
>  fill_kobj_path+0x50/0xc0
>  kobject_get_path+0x5a/0xc0
>  kobject_uevent_env+0x140/0x460
>  device_add+0x5c7/0x910
>  __mdiobus_register+0x14e/0x490
>  ixgbe_probe.cold+0x441/0x574 [ixgbe]
>  local_pci_probe+0x78/0xc0
>  work_for_cpu_fn+0x26/0x40
>  process_one_work+0x3b6/0x6a0
>  worker_thread+0x368/0x520
>  kthread+0x165/0x1a0
>  ret_from_fork+0x1f/0x30
> 
> This reproducer triggers that bug:
> 
> while:
> do
>     rmmod ixgbe
>     sleep 0.5
>     modprobe ixgbe
>     sleep 0.5
> 
> When calling fill_kobj_path() to fill path, if the name length of
> kobj becomes longer, return failure and retry.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  lib/kobject.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Nice find, and a much better description than was reported here:
	https://lore.kernel.org/all/20221216031320.2634-1-alice.chao@mediatek.com/

Alice, does this patch resolve your problem as well?

> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index a0b2dbfcfa23..d129f437b200 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -112,7 +112,7 @@ static int get_kobj_path_length(struct kobject *kobj)
>  	return length;
>  }
>  
> -static void fill_kobj_path(struct kobject *kobj, char *path, int length)
> +static bool fill_kobj_path(struct kobject *kobj, char *path, int length)

Just return an int and an error value, bool isn't a normal return value,
right?

>  {
>  	struct kobject *parent;
>  
> @@ -121,12 +121,16 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
>  		int cur = strlen(kobject_name(parent));
>  		/* back up enough to print this name with '/' */
>  		length -= cur;
> +		if (length < 0)
> +			return false;

Return -EINVAL or something?

What if length ends up 0 here, is that going to be ok?


>  		memcpy(path + length, kobject_name(parent), cur);
>  		*(path + --length) = '/';
>  	}
>  
>  	pr_debug("kobject: '%s' (%p): %s: path = '%s'\n", kobject_name(kobj),
>  		 kobj, __func__, path);
> +
> +	return true;

return 0;

>  }
>  
>  /**
> @@ -140,14 +144,20 @@ char *kobject_get_path(struct kobject *kobj, gfp_t gfp_mask)
>  {
>  	char *path;
>  	int len;
> +	bool ret;

No need for this variable

>  
> +retry:
>  	len = get_kobj_path_length(kobj);
>  	if (len == 0)
>  		return NULL;
>  	path = kzalloc(len, gfp_mask);
>  	if (!path)
>  		return NULL;
> -	fill_kobj_path(kobj, path, len);
> +	ret = fill_kobj_path(kobj, path, len);
> +	if (!ret) {

Make this one line:

	if (fill_kobj_path(kobj, path, len)) {

But, you now have a loop, what guarantees that you can get out of it?

thanks,

greg k-h
