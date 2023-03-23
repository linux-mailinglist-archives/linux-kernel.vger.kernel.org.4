Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8936C65BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCWKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCWKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:52:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26993644F;
        Thu, 23 Mar 2023 03:51:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8508F33AFE;
        Thu, 23 Mar 2023 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679568686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4T01aO7KrwJ0o9dCCBrYUuu0XOrAxnj5hVsRfD+YWc=;
        b=0ehM7twXp1X7rd9GU+Iyh80/5EQuIvKw6OjeYVs/ByMwL1jDgQzFI9WSyUcjePnRMy3Xu4
        WrZyHdNkl62xeUXvDukS8j1B0I0UBSVwA523fvmb+XenMYLM8FAIKgxCTMniTDtLVczlg5
        o52I6tO+FcfJCe1+QXW6Aenjv+p/1N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679568686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4T01aO7KrwJ0o9dCCBrYUuu0XOrAxnj5hVsRfD+YWc=;
        b=acUMaQsh+rlfmQorvDijoAeW614fAQfU/swbT9KWY8FcrlDls58uc6WKHkwXQJ8JkTXSwv
        xpLWEL9oRRGI6cAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6440013596;
        Thu, 23 Mar 2023 10:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h59wGC0vHGQVeAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 10:51:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5E0DCA071C; Thu, 23 Mar 2023 11:51:20 +0100 (CET)
Date:   Thu, 23 Mar 2023 11:51:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>,
        hch@infradead.org, axboe@kernel.dk, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Xiao Ni <xni@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Message-ID: <20230323105120.jrhgjfbj3jlgw2h6@quack3>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <ZBq1K90+9ASVbdTu@ovpn-8-17.pek2.redhat.com>
 <20230322094707.7xsexupiijmxxlom@quack3>
 <ZBrnxrQ8csN/xkRG@ovpn-8-17.pek2.redhat.com>
 <20230322130709.7zp7spmhcmjbfjvm@quack3>
 <ZBsoE677zEuAm23E@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsoE677zEuAm23E@ovpn-8-17.pek2.redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-03-23 00:08:51, Ming Lei wrote:
> On Wed, Mar 22, 2023 at 02:07:09PM +0100, Jan Kara wrote:
> > On Wed 22-03-23 19:34:30, Ming Lei wrote:
> > > On Wed, Mar 22, 2023 at 10:47:07AM +0100, Jan Kara wrote:
> > > > On Wed 22-03-23 15:58:35, Ming Lei wrote:
> > > > > On Wed, Mar 22, 2023 at 11:59:26AM +0800, Yu Kuai wrote:
> > > > > > From: Yu Kuai <yukuai3@huawei.com>
> > > > > > 
> > > > > > Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
> > > > > > set, and partition scan will be proceed again when blkdev_get_by_dev()
> > > > > > is called. However, this will cause a problem that re-assemble partitioned
> > > > > > raid device will creat partition for underlying disk.
> > > > > > 
> > > > > > Test procedure:
> > > > > > 
> > > > > > mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> > > > > > sgdisk -n 0:0:+100MiB /dev/md0
> > > > > > blockdev --rereadpt /dev/sda
> > > > > > blockdev --rereadpt /dev/sdb
> > > > > > mdadm -S /dev/md0
> > > > > > mdadm -A /dev/md0 /dev/sda /dev/sdb
> > > > > > 
> > > > > > Test result: underlying disk partition and raid partition can be
> > > > > > observed at the same time
> > > > > > 
> > > > > > Note that this can still happen in come corner cases that
> > > > > > GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
> > > > > > device.
> > > > > > 
> > > > > > Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
> > > > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > > > 
> > > > > The issue still can't be avoided completely, such as, after rebooting,
> > > > > /dev/sda1 & /dev/md0p1 can be observed at the same time. And this one
> > > > > should be underlying partitions scanned before re-assembling raid, I
> > > > > guess it may not be easy to avoid.
> > > > 
> > > > So this was always happening (before my patches, after my patches, and now
> > > > after Yu's patches) and kernel does not have enough information to know
> > > > that sda will become part of md0 device in the future. But mdadm actually
> > > > deals with this as far as I remember and deletes partitions for all devices
> > > > it is assembling the array from (and quick tracing experiment I did
> > > > supports this).
> > > 
> > > I am testing on Fedora 37, so mdadm v4.2 doesn't delete underlying
> > > partitions before re-assemble.
> > 
> > Strange, I'm on openSUSE Leap 15.4 and mdadm v4.1 deletes these partitions
> > (at least I can see mdadm do BLKPG_DEL_PARTITION ioctls). And checking
> > mdadm sources I can see calls to remove_partitions() from start_array()
> > function in Assemble.c so I'm not sure why this is not working for you...
> 
> I added dump_stack() in delete_partition() for partition 1, not observe
> stack trace during booting.
> 
> > 
> > > Also given mdadm or related userspace has to change for avoiding
> > > to scan underlying partitions, just wondering why not let userspace
> > > to tell kernel not do it explicitly?
> > 
> > Well, those userspace changes are long deployed, now you would introduce
> > new API that needs to proliferate again. Not very nice. Also how would that
> > exactly work? I mean once mdadm has underlying device open, the current
> > logic makes sure we do not create partitions anymore. But there's no way
> > how mdadm could possibly prevent creation of partitions for devices it
> > doesn't know about yet so it still has to delete existing partitions...
> 
> I meant if mdadm has to change to delete existed partitions, why not add
> one ioctl to disable partition scan for this disk when deleting
> partitions/re-assemble, and re-enable scan after stopping array.
> 
> But looks it isn't so, since you mentioned that remove_partitions is
> supposed to be called before starting array, however I didn't observe this
> behavior.

Yeah, not sure what's happening on your system.

> I am worrying if the current approach may cause regression, one concern is
> that ioctl(BLKRRPART) needs exclusive open now, such as:
> 
> 1) mount /dev/vdb1 /mnt
> 
> 2) ioctl(BLKRRPART) may fail after removing /dev/vdb3

Well, but we always had some variant of:

        if (disk->open_partitions)
                return -EBUSY;

in disk_scan_partitions(). So as long as any partition on the disk is used,
EBUSY is the correct return value from BLKRRPART.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
