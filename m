Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718B96C4B48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCVNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCVNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:07:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E406131C;
        Wed, 22 Mar 2023 06:07:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3303133B32;
        Wed, 22 Mar 2023 13:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679490430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDkF/xELuS/QQZ2kkBSDQXRvPDCI+RyGdaLORAtubb8=;
        b=EeVQ5OgMzTx4fWhho9EzS04VjGXxsL01vheKcBig2Mwo3dygzEDFvGLo7qiorpfklg+hgx
        OaKyYhZYjxEq65+rHZZR9SULusSXPRhzlf4E+tyllVmRKmSeWDtSulGstivA97PwUb8JsK
        I59QdttOkeSyFE4AqiIxbzGC6KXJU6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679490430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDkF/xELuS/QQZ2kkBSDQXRvPDCI+RyGdaLORAtubb8=;
        b=++jmMXgPBuZDPcvJIxOJ9hrhlQtwAyB96bS5pY6vCb16AL2udh1btBKasZNBRd6CFj9zh+
        lvmpCgHvQ4omZ7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24E01138E9;
        Wed, 22 Mar 2023 13:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZC8BCX79GmT2cgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 22 Mar 2023 13:07:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A839FA071C; Wed, 22 Mar 2023 14:07:09 +0100 (CET)
Date:   Wed, 22 Mar 2023 14:07:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>,
        hch@infradead.org, axboe@kernel.dk, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Xiao Ni <xni@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Message-ID: <20230322130709.7zp7spmhcmjbfjvm@quack3>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <ZBq1K90+9ASVbdTu@ovpn-8-17.pek2.redhat.com>
 <20230322094707.7xsexupiijmxxlom@quack3>
 <ZBrnxrQ8csN/xkRG@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBrnxrQ8csN/xkRG@ovpn-8-17.pek2.redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-03-23 19:34:30, Ming Lei wrote:
> On Wed, Mar 22, 2023 at 10:47:07AM +0100, Jan Kara wrote:
> > On Wed 22-03-23 15:58:35, Ming Lei wrote:
> > > On Wed, Mar 22, 2023 at 11:59:26AM +0800, Yu Kuai wrote:
> > > > From: Yu Kuai <yukuai3@huawei.com>
> > > > 
> > > > Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
> > > > set, and partition scan will be proceed again when blkdev_get_by_dev()
> > > > is called. However, this will cause a problem that re-assemble partitioned
> > > > raid device will creat partition for underlying disk.
> > > > 
> > > > Test procedure:
> > > > 
> > > > mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> > > > sgdisk -n 0:0:+100MiB /dev/md0
> > > > blockdev --rereadpt /dev/sda
> > > > blockdev --rereadpt /dev/sdb
> > > > mdadm -S /dev/md0
> > > > mdadm -A /dev/md0 /dev/sda /dev/sdb
> > > > 
> > > > Test result: underlying disk partition and raid partition can be
> > > > observed at the same time
> > > > 
> > > > Note that this can still happen in come corner cases that
> > > > GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
> > > > device.
> > > > 
> > > > Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
> > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > The issue still can't be avoided completely, such as, after rebooting,
> > > /dev/sda1 & /dev/md0p1 can be observed at the same time. And this one
> > > should be underlying partitions scanned before re-assembling raid, I
> > > guess it may not be easy to avoid.
> > 
> > So this was always happening (before my patches, after my patches, and now
> > after Yu's patches) and kernel does not have enough information to know
> > that sda will become part of md0 device in the future. But mdadm actually
> > deals with this as far as I remember and deletes partitions for all devices
> > it is assembling the array from (and quick tracing experiment I did
> > supports this).
> 
> I am testing on Fedora 37, so mdadm v4.2 doesn't delete underlying
> partitions before re-assemble.

Strange, I'm on openSUSE Leap 15.4 and mdadm v4.1 deletes these partitions
(at least I can see mdadm do BLKPG_DEL_PARTITION ioctls). And checking
mdadm sources I can see calls to remove_partitions() from start_array()
function in Assemble.c so I'm not sure why this is not working for you...

> Also given mdadm or related userspace has to change for avoiding
> to scan underlying partitions, just wondering why not let userspace
> to tell kernel not do it explicitly?

Well, those userspace changes are long deployed, now you would introduce
new API that needs to proliferate again. Not very nice. Also how would that
exactly work? I mean once mdadm has underlying device open, the current
logic makes sure we do not create partitions anymore. But there's no way
how mdadm could possibly prevent creation of partitions for devices it
doesn't know about yet so it still has to delete existing partitions...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
