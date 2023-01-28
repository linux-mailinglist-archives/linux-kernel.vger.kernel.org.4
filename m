Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C906567F73C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjA1KpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjA1KpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:45:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B331E35;
        Sat, 28 Jan 2023 02:45:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D12E60BA3;
        Sat, 28 Jan 2023 10:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C12CC433EF;
        Sat, 28 Jan 2023 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674902717;
        bh=0AGK9C0cUXdptKna52kz+xJz3MRgne+mO2Ch25p5OaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+bHPwP5GbwPOqOELMOgzIrxZz6ev87RmOgo7T0Q0yP4eKrXQ5aXSSZTiagtxblk9
         xhMyEMLdctAkxZTf60Ica81WOeWd0D13Jt5vNojuXiAyp/QisiRadrRlYEuhC4NFWU
         8meBAXtQm2nTj0cin/u5xV2187jETigDJIbjGVfE=
Date:   Sat, 28 Jan 2023 11:45:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
        bvanassche@acm.org, emilne@redhat.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create block
 device
Message-ID: <Y9T8uQYEaGUZwpHO@kroah.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
 <20230128094146.205858-3-zhongjinghua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128094146.205858-3-zhongjinghua@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 05:41:46PM +0800, Zhong Jinghua wrote:
> When the three iscsi operations delete, logout, and rescan are concurrent
> at the same time, there is a probability of failure to add disk through
> device_add_disk(). The concurrent process is as follows:
> 
> T0: scan host // echo 1 > /sys/devices/platform/host1/scsi_host/host1/scan
> T1: delete target // echo 1 > /sys/devices/platform/host1/session1/target1:0:0/1:0:0:1/delete
> T2: logout // iscsiadm -m node --login
> T3: T2 scsi_queue_work
> T4: T0 bus_probe_device
> 
> T0                          T1                     T2                     T3
> scsi_scan_target
>  mutex_lock(&shost->scan_mutex);
>   __scsi_scan_target
>    scsi_report_lun_scan
>     scsi_add_lun
>      scsi_sysfs_add_sdev
>       device_add
>        kobject_add
>        //create session1/target1:0:0/1:0:0:1/
>        ...
>        bus_probe_device
>        // Create block asynchronously
>  mutex_unlock(&shost->scan_mutex);
>                        sdev_store_delete
>                         scsi_remove_device
>                          device_remove_file
>                           mutex_lock(scan_mutex)
>                            __scsi_remove_device
>                             res = scsi_device_set_state(sdev, SDEV_CANCEL)
>                                              iscsi_if_recv_msg
>                                               scsi_queue_work
>                                                                  __iscsi_unbind_session
>                                                                  session->target_id = ISCSI_MAX_TARGET
>                                                                    __scsi_remove_target
>                                                                    sdev->sdev_state == SDEV_CANCEL
>                                                                    continue;
>                                                                    // end, No delete kobject 1:0:0:1
>                                              iscsi_if_recv_msg
>                                               transport->destroy_session(session)
>                                                __iscsi_destroy_session
>                                                iscsi_session_teardown
>                                                 iscsi_remove_session
>                                                  __iscsi_unbind_session
>                                                   iscsi_session_event
>                                                  device_del
>                                                  // delete session
> T4:
> // create the block, its parent is 1:0:0:1
> // If kobject 1:0:0:1 does not exist, it won't go down
> __device_attach_async_helper
>  device_lock
>  ...
>  __device_attach_driver
>   driver_probe_device
>    really_probe
>     sd_probe
>      device_add_disk
>       register_disk
>        device_add
>       // error
> 
> The block is created after the seesion is deleted.
> When T2 deletes the session, it will mark block'parent 1:0:01 as unusable:
> T2
> device_del
>  kobject_del
>   sysfs_remove_dir
>    __kernfs_remove
>    // Mark the children under the session as unusable
>     while ((pos = kernfs_next_descendant_post(pos, kn)))
> 		if (kernfs_active(pos))
> 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
> 
> Then, create the block:
> T4
> device_add
>  kobject_add
>   kobject_add_varg
>    kobject_add_internal
>     create_dir
>      sysfs_create_dir_ns
>       kernfs_create_dir_ns
>        kernfs_add_one
>         if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active(parent))
> 		goto out_unlock;
> 		// return error
> 
> This error will cause a warning:
> kobject_add_internal failed for block (error: -2 parent: 1:0:0:1).
> In the lower version (such as 5.10), there is no corresponding error handling, continuing
> to go down will trigger a kernel panic, so cc stable.
> 
> Therefore, creating the block should not be done after deleting the session.
> More practically, we should ensure that the target under the session is deleted first,
> and then the session is deleted. In this way, there are two possibilities:
> 
> 1) if the process(T1) of deleting the target execute first, it will grab the device_lock(),
> and the process(T4) of creating the block will wait for the deletion to complete.
> Then, block's parent 1:0:0:1 has been deleted, it won't go down.
> 
> 2) if the process(T4) of creating block execute first, it will grab the device_lock(),
> and the process(T1) of deleting the target will wait for the creation block to complete.
> Then, the process(T2) of deleting the session should need wait for the deletion to complete.
> 
> Fix it by removing the judgment of state equal to SDEV_CANCEL in
> __scsi_remove_target() to ensure the order of deletion. Then, it will wait for
> T1's mutex_lock(scan_mutex) and device_del() in __scsi_remove_device() will wait for
> T4's device_lock(dev).
> But we found that such a fix would cause the previous problem:
> commit 81b6c9998979 ("scsi: core: check for device state in __scsi_remove_target()").
> So we use get_device_unless_zero() instead of get_devcie() to fix the previous problem.
> 
> Fixes: 81b6c9998979 ("scsi: core: check for device state in __scsi_remove_target()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>  drivers/scsi/scsi_sysfs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index cac7c902cf70..a22109cdb8ef 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1535,9 +1535,7 @@ static void __scsi_remove_target(struct scsi_target *starget)
>  		if (sdev->channel != starget->channel ||
>  		    sdev->id != starget->id)
>  			continue;
> -		if (sdev->sdev_state == SDEV_DEL ||
> -		    sdev->sdev_state == SDEV_CANCEL ||
> -		    !get_device(&sdev->sdev_gendev))
> +		if (!get_device_unless_zero(&sdev->sdev_gendev))

If sdev_gendev is 0 here, the object is gone and you are working with
memory that is already freed so something is _VERY_ wrong.

This isn't ok, sorry.

greg k-h
