Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47D67FD2A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjA2GqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2GqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:46:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C497E1A49F;
        Sat, 28 Jan 2023 22:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66ECA60ADB;
        Sun, 29 Jan 2023 06:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D06C433D2;
        Sun, 29 Jan 2023 06:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674974771;
        bh=npeg3NdAXSeFh0nJBawtsSuBw3Sl9H1tdBZe7sl/pHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=063TiFkbbUmlduupGvA0jhdxoQ0fbyXEO+U/+4IbCRmy5rz5k1aluJvYJIe59E0cN
         qcCV+GpPIgwKVOqk0r4Du5TkdqeBM6sabKdRgAVJtB5wY9NdSYt9SD6SyDIOvtb+rk
         SiUZuf1ZU4Eka0NwbJxwnFAt7PBoPC7p++9msi7s=
Date:   Sun, 29 Jan 2023 07:46:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Zhong Jinghua <zhongjinghua@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        emilne@redhat.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create block
 device
Message-ID: <Y9YWMQ4TuJfuXAzL@kroah.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
 <20230128094146.205858-3-zhongjinghua@huawei.com>
 <Y9T8uQYEaGUZwpHO@kroah.com>
 <b4927ca9-7330-3f32-f68f-1a449473a0ce@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4927ca9-7330-3f32-f68f-1a449473a0ce@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 09:13:55AM +0800, Yu Kuai wrote:
> Hi, Greg
> 
> 在 2023/01/28 18:45, Greg KH 写道:
> > > diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> > > index cac7c902cf70..a22109cdb8ef 100644
> > > --- a/drivers/scsi/scsi_sysfs.c
> > > +++ b/drivers/scsi/scsi_sysfs.c
> > > @@ -1535,9 +1535,7 @@ static void __scsi_remove_target(struct scsi_target *starget)
> > >   		if (sdev->channel != starget->channel ||
> > >   		    sdev->id != starget->id)
> > >   			continue;
> > > -		if (sdev->sdev_state == SDEV_DEL ||
> > > -		    sdev->sdev_state == SDEV_CANCEL ||
> > > -		    !get_device(&sdev->sdev_gendev))
> > > +		if (!get_device_unless_zero(&sdev->sdev_gendev))
> > 
> > If sdev_gendev is 0 here, the object is gone and you are working with
> > memory that is already freed so something is _VERY_ wrong.
> 
> In fact, this patch will work:
> 
> In __scsi_remove_target(), 'host_lock' is held to protect iterating
> siblings, and object will wait for this lock in
> scsi_device_dev_release() to remove siblings. Hence sdev will not be
> freed untill the lock is released.

Then you got lucky, as that is not how a reference counted object should
be working (i.e. the reference dropped to 0 and it still be kept alive.)

Please fix up the scsi logic here, don't abuse the reference count code.

thanks,

greg k-h
