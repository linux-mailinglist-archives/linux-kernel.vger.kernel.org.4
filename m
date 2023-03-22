Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7406C46E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCVJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCVJrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:47:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2BC5DCB3;
        Wed, 22 Mar 2023 02:47:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1802B20BFE;
        Wed, 22 Mar 2023 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679478428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUSPKszOsprQzpNqGZ3Sw62husTIX6UrodrjQqn4C/w=;
        b=UK2V9GCKM6sQbANP9S15oaNnvIm+M4kfXbyYwi9WF2JuggGNBZ9e6bNM/DUyNT2cX7HqMQ
        IgirpNBphhwzofGF1i9WUnpYX9RKi8iHT7HUA7P608ElgE03nuEqN//DCX/F4avJeTOrsm
        c9vFTgJmEpzVWF3xFFuKYSBY7pdh+0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679478428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUSPKszOsprQzpNqGZ3Sw62husTIX6UrodrjQqn4C/w=;
        b=RwWV54C6LMEW9rNi2aql+3gsLNEkvYGDzf9N/BzyEjIav5pR14gHW/KQ5tchzulGyLbx5s
        4589hry4URAO+GAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08B2813416;
        Wed, 22 Mar 2023 09:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PPgWApzOGmS8eAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 22 Mar 2023 09:47:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8C002A071C; Wed, 22 Mar 2023 10:47:07 +0100 (CET)
Date:   Wed, 22 Mar 2023 10:47:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@infradead.org,
        axboe@kernel.dk, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Message-ID: <20230322094707.7xsexupiijmxxlom@quack3>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <ZBq1K90+9ASVbdTu@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBq1K90+9ASVbdTu@ovpn-8-17.pek2.redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-03-23 15:58:35, Ming Lei wrote:
> On Wed, Mar 22, 2023 at 11:59:26AM +0800, Yu Kuai wrote:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
> > set, and partition scan will be proceed again when blkdev_get_by_dev()
> > is called. However, this will cause a problem that re-assemble partitioned
> > raid device will creat partition for underlying disk.
> > 
> > Test procedure:
> > 
> > mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> > sgdisk -n 0:0:+100MiB /dev/md0
> > blockdev --rereadpt /dev/sda
> > blockdev --rereadpt /dev/sdb
> > mdadm -S /dev/md0
> > mdadm -A /dev/md0 /dev/sda /dev/sdb
> > 
> > Test result: underlying disk partition and raid partition can be
> > observed at the same time
> > 
> > Note that this can still happen in come corner cases that
> > GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
> > device.
> > 
> > Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> The issue still can't be avoided completely, such as, after rebooting,
> /dev/sda1 & /dev/md0p1 can be observed at the same time. And this one
> should be underlying partitions scanned before re-assembling raid, I
> guess it may not be easy to avoid.

So this was always happening (before my patches, after my patches, and now
after Yu's patches) and kernel does not have enough information to know
that sda will become part of md0 device in the future. But mdadm actually
deals with this as far as I remember and deletes partitions for all devices
it is assembling the array from (and quick tracing experiment I did
supports this).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
