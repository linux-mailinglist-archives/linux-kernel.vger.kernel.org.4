Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A545B319C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiIIIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIIIY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B22980B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662711897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLgBFhbjWgsxc9dWG54TSxsLPfsBKw+Wx4DaHZWpGNc=;
        b=bvu5VZxPCUBBlVT7o27Xgihi1lvB0GBGeS6ZiuGPO3DOSQXNDHeRf8QzY7WRHeHJIIrnzX
        2H9dYgEAfsotqGQS3QUDSDsuqtc++haKrrib14UZns4dUJg5zSYtBpqADol2K1KKP5HU1I
        n0WEyIYlTVrbkeWZs13M7GTMeLygues=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-xfWXhLT0N96_XNj2orK8-g-1; Fri, 09 Sep 2022 04:24:54 -0400
X-MC-Unique: xfWXhLT0N96_XNj2orK8-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6EAE185A7B2;
        Fri,  9 Sep 2022 08:24:53 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 444422026D4C;
        Fri,  9 Sep 2022 08:24:47 +0000 (UTC)
Date:   Fri, 9 Sep 2022 16:24:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dusty Mabe <dusty@dustymabe.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <Yxr4SD4d0rZ9TZik@T590>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590>
 <20220907073324.GB23826@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907073324.GB23826@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
> > It is a bit hard to associate the above commit with reported issue.
> 
> So the messages clearly are about something trying to open a device
> that went away at the block layer, but somehow does not get removed
> in time by udev (which seems to be a userspace bug in CoreOS).  But
> even with that we really should not hang.

Xiao Ni provides one script[1] which can reproduce the issue more or less.

- create raid
#./imsm.sh imsm /dev/md/test 1 /dev/sda /dev/sdb
#ls /dev/md/
[root@ktest-36 md]# ls -l /dev/md/
total 0
lrwxrwxrwx. 1 root root 8 Sep  9 08:10 imsm -> ../md127
lrwxrwxrwx. 1 root root 8 Sep  9 08:10 test -> ../md126

- destroy the two raid devices
# mdadm --stop /dev/md/test /dev/md/imsm
mdadm: stopped /dev/md/test
mdadm: stopped /dev/md/imsm

# lsblk
...
md126     9:126  0    0B  0 md
md127     9:127  0    0B  0 md

md126 is actually added after it is deleted, and with the log of "block
device autoloading is deprecated and will be removed.", and bcc stack trace
shows that the device is added by mdadm.

08:20:03 456     456     kworker/6:2     del_gendisk      disk b'md126'
        b'del_gendisk+0x1 [kernel]'
        b'md_kobj_release+0x34 [kernel]'
        b'kobject_put+0x87 [kernel]'
        b'process_one_work+0x1c4 [kernel]'
        b'worker_thread+0x4d [kernel]'
        b'kthread+0xe6 [kernel]'
        b'ret_from_fork+0x1f [kernel]'

08:20:03 2476    2476    mdadm           device_add_disk  disk b'md126'
        b'device_add_disk+0x1 [kernel]'
        b'md_alloc+0x3ba [kernel]'
        b'md_probe+0x25 [kernel]'
        b'blk_request_module+0x5f [kernel]'
        b'blkdev_get_no_open+0x5c [kernel]'
        b'blkdev_get_by_dev.part.0+0x1e [kernel]'
        b'blkdev_open+0x52 [kernel]'
        b'do_dentry_open+0x1ce [kernel]'
        b'path_openat+0xc43 [kernel]'
        b'do_filp_open+0xa1 [kernel]'
        b'do_sys_openat2+0x7c [kernel]'
        b'__x64_sys_openat+0x5c [kernel]'
        b'do_syscall_64+0x37 [kernel]'
        b'entry_SYSCALL_64_after_hwframe+0x63 [kernel]'


Also the md device is delayed to remove by scheduling wq, and it is
actually deleted in mddev's release handler:

mddev_delayed_delete():
	kobject_put(&mddev->kobj)

...

md_kobj_release():
	del_gendisk(mddev->gendisk);

> 
> Now that fact that it did hang before and this now becomes reproducible
> also makes me assume the change is not the root cause.  It might still
> be a good vehicle to fix the issue for real, but it really broadens
> the scope.
> 

[1] create one imsm raid1 

./imsm.sh imsm /dev/md/test 1 /dev/sda /dev/sdb

#!/bin/bash
export IMSM_NO_PLATFORM=1
export IMSM_DEVNAME_AS_SERIAL=1

echo ""
echo "==========================================================="
echo "./test.sh container raid devlist level devnum"
echo "example: ./test.sh imsm /dev/md/test 1 /dev/loop0 /dev/loop1"
echo "==========================================================="
echo ""

container=$1
raid=$2
level=$3

shift 3
dev_num=$#
dev_list=$@

mdadm -CR $container -e imsm -n $dev_num $dev_list
mdadm -CR $raid -l $level -n $dev_num $dev_list

[2] destroy created raid devices
mdadm --stop /dev/md/test /dev/md/imsm

Thanks,
Ming

