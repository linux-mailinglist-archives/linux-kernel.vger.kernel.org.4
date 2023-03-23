Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD86C679B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjCWMGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjCWMFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C19C176
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679573002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YJpp9T/+ednAJj+w3fWi+duh2iGOtuwVF4qb+qfOpY=;
        b=HXnyxbXtyFL5bYecBi7xTc5ZF2XTCdiyhfNkBhnpIke0kE/ZvtzkU1yTqk0uUnkpxNiAz9
        s/y91IHE4J9Yo8WBI5d/iVFsOa+hHvqt852ciKotigUDj7FQPRwOBcWimAPNo0c43ChbX6
        +KS+tdvmUTsj4H7GGNa/RjrXEu/f6us=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447--V8YO2rXMIShLOSYuAe9kQ-1; Thu, 23 Mar 2023 08:03:20 -0400
X-MC-Unique: -V8YO2rXMIShLOSYuAe9kQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A37C886065;
        Thu, 23 Mar 2023 12:03:16 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0145C463E03;
        Thu, 23 Mar 2023 12:03:08 +0000 (UTC)
Date:   Thu, 23 Mar 2023 20:03:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org,
        axboe@kernel.dk, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Xiao Ni <xni@redhat.com>,
        linux-raid@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Message-ID: <ZBw/91VUHR1KxeGW@ovpn-8-16.pek2.redhat.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <ZBq1K90+9ASVbdTu@ovpn-8-17.pek2.redhat.com>
 <20230322094707.7xsexupiijmxxlom@quack3>
 <ZBrnxrQ8csN/xkRG@ovpn-8-17.pek2.redhat.com>
 <20230322130709.7zp7spmhcmjbfjvm@quack3>
 <ZBsoE677zEuAm23E@ovpn-8-17.pek2.redhat.com>
 <20230323105120.jrhgjfbj3jlgw2h6@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323105120.jrhgjfbj3jlgw2h6@quack3>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:51:20AM +0100, Jan Kara wrote:
> On Thu 23-03-23 00:08:51, Ming Lei wrote:
> > On Wed, Mar 22, 2023 at 02:07:09PM +0100, Jan Kara wrote:
> > > On Wed 22-03-23 19:34:30, Ming Lei wrote:
> > > > On Wed, Mar 22, 2023 at 10:47:07AM +0100, Jan Kara wrote:
> > > > > On Wed 22-03-23 15:58:35, Ming Lei wrote:
> > > > > > On Wed, Mar 22, 2023 at 11:59:26AM +0800, Yu Kuai wrote:
> > > > > > > From: Yu Kuai <yukuai3@huawei.com>
> > > > > > > 
> > > > > > > Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
> > > > > > > set, and partition scan will be proceed again when blkdev_get_by_dev()
> > > > > > > is called. However, this will cause a problem that re-assemble partitioned
> > > > > > > raid device will creat partition for underlying disk.
> > > > > > > 
> > > > > > > Test procedure:
> > > > > > > 
> > > > > > > mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> > > > > > > sgdisk -n 0:0:+100MiB /dev/md0
> > > > > > > blockdev --rereadpt /dev/sda
> > > > > > > blockdev --rereadpt /dev/sdb
> > > > > > > mdadm -S /dev/md0
> > > > > > > mdadm -A /dev/md0 /dev/sda /dev/sdb
> > > > > > > 
> > > > > > > Test result: underlying disk partition and raid partition can be
> > > > > > > observed at the same time
> > > > > > > 
> > > > > > > Note that this can still happen in come corner cases that
> > > > > > > GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
> > > > > > > device.
> > > > > > > 
> > > > > > > Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
> > > > > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > > > > 
> > > > > > The issue still can't be avoided completely, such as, after rebooting,
> > > > > > /dev/sda1 & /dev/md0p1 can be observed at the same time. And this one
> > > > > > should be underlying partitions scanned before re-assembling raid, I
> > > > > > guess it may not be easy to avoid.
> > > > > 
> > > > > So this was always happening (before my patches, after my patches, and now
> > > > > after Yu's patches) and kernel does not have enough information to know
> > > > > that sda will become part of md0 device in the future. But mdadm actually
> > > > > deals with this as far as I remember and deletes partitions for all devices
> > > > > it is assembling the array from (and quick tracing experiment I did
> > > > > supports this).
> > > > 
> > > > I am testing on Fedora 37, so mdadm v4.2 doesn't delete underlying
> > > > partitions before re-assemble.
> > > 
> > > Strange, I'm on openSUSE Leap 15.4 and mdadm v4.1 deletes these partitions
> > > (at least I can see mdadm do BLKPG_DEL_PARTITION ioctls). And checking
> > > mdadm sources I can see calls to remove_partitions() from start_array()
> > > function in Assemble.c so I'm not sure why this is not working for you...
> > 
> > I added dump_stack() in delete_partition() for partition 1, not observe
> > stack trace during booting.
> > 
> > > 
> > > > Also given mdadm or related userspace has to change for avoiding
> > > > to scan underlying partitions, just wondering why not let userspace
> > > > to tell kernel not do it explicitly?
> > > 
> > > Well, those userspace changes are long deployed, now you would introduce
> > > new API that needs to proliferate again. Not very nice. Also how would that
> > > exactly work? I mean once mdadm has underlying device open, the current
> > > logic makes sure we do not create partitions anymore. But there's no way
> > > how mdadm could possibly prevent creation of partitions for devices it
> > > doesn't know about yet so it still has to delete existing partitions...
> > 
> > I meant if mdadm has to change to delete existed partitions, why not add
> > one ioctl to disable partition scan for this disk when deleting
> > partitions/re-assemble, and re-enable scan after stopping array.
> > 
> > But looks it isn't so, since you mentioned that remove_partitions is
> > supposed to be called before starting array, however I didn't observe this
> > behavior.
> 
> Yeah, not sure what's happening on your system.

Looks not see such issue on Fedora 38, but it does happen on Fedora 37.

> 
> > I am worrying if the current approach may cause regression, one concern is
> > that ioctl(BLKRRPART) needs exclusive open now, such as:
> > 
> > 1) mount /dev/vdb1 /mnt
> > 
> > 2) ioctl(BLKRRPART) may fail after removing /dev/vdb3
> 
> Well, but we always had some variant of:
> 
>         if (disk->open_partitions)
>                 return -EBUSY;
> 
> in disk_scan_partitions(). So as long as any partition on the disk is used,
> EBUSY is the correct return value from BLKRRPART.

OK, missing that check.

Then the change basically can be thought as ioctl(BLKRRPART) requiring O_EXCL,
One app just open(disk) with O_EXCL for a bit long, then ioctl(BLKRRPART) can't
be done from other process. Hope there isn't such case in practice.


Thanks,
Ming

