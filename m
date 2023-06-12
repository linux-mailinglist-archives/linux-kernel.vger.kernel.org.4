Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB1B72C8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbjFLOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbjFLOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:40:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68687B2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:40:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14F5922786;
        Mon, 12 Jun 2023 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686580810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYLoOeOIQ8H4THh4mtox6bn85ZlcWEe8+m8shFZxDC4=;
        b=Ux4WD9Ql/nMB2yEjL3CdjFVODC6dY6wvZTHEZpANfrJo+dh6s8ZhBc/lK85Pw/mbd+x+Yc
        BfLsURVb6jO8yvMB8kaIJM63gSnn8Rg4LwM/Nk5LicmdbSYLUqtdtic1RbAeaPNCb+sYQw
        O3yrzEzU+lMrhhd6B0pWu5WQdrd9Q3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686580810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYLoOeOIQ8H4THh4mtox6bn85ZlcWEe8+m8shFZxDC4=;
        b=TmmcWXj90bSkYWykbMvKZpE1uLvxGxAQK3ZSUWl4TsAFJebnfwC9St3rr0KhjAhcVu68QK
        SyEmf6rz1+i2GzBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06F151357F;
        Mon, 12 Jun 2023 14:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lL6vAUouh2TWJQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 14:40:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7E987A0717; Mon, 12 Jun 2023 16:40:09 +0200 (CEST)
Date:   Mon, 12 Jun 2023 16:40:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH 0/2] Fix out-of-bound access if pagecache of udf device
 is corrupted
Message-ID: <20230612144009.s436o52pctxgctr2@quack3>
References: <20230613032254.1235752-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613032254.1235752-1-haowenchao2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-06-23 11:22:52, Wenchao Hao wrote:
> Following steps would cause out-of-bound access and even cause kernel
> panic when using udf:
> 
> dd if=/dev/zero of=udf.img bs=1M count=512
> mkfs.udf udf.img
> mount -o loop -t udf udf.img /mnt
> dd if=/dev/random of=/dev/loop0 bs=512 count=1 seek=128
> umount /mnt
> 
> [if /mnt is mounted on /dev/loop0]
> 
> It is because we did not check if udf_sb_info->s_lvid_bh is valid in
> udf_sb_lvidiu().
> 
> Although it's illegal to write backend device since filesystem has been
> mounted, but we should avoid kernel panic if it happened.

No, it is perfectly valid to crash the kernel if someone writes the buffer
cache of the device while the device is mounted (which your example above
does). There is no practical protection against this because someone could
overwrite the buffer just after the moment you verify its validity. The
only protection would be to lock the buffer for each access and fully
verify validity of the data after each locking but the performance and
maintenance overhead of this is too high to justify. So I'm sorry but I
will not take any patches that try to "fix" situations when someone writes
buffer cache while the filesystem is mounted.

I guess your work is motivated by some syzbot reproducer which was doing
this. Let me work on a kernel option which syzbot can use to not report
these issues.


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
