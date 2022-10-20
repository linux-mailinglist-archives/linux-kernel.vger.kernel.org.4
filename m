Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53D605A51
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJTIyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJTIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:54:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8791318E712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:54:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92BEF226EA;
        Thu, 20 Oct 2022 08:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666256048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWCwYL0F5/rgcYBecBCS8oPEbaLRdpIuDHctO7ZfYl8=;
        b=GTh6VhaVjqnhUatMl0CFQhzs+Rs5HnYmmqYEJHaZjgtym5vZi8mi84uYRl8vE59zfgEd+W
        pKdCTagw22LmdpzKcnqz4LFzm65jS99oEbyEx27FUeDIrb4WvI8UNYmT8wxxlHpLrIN0j6
        zhchcSf80XGqZpbiROnAY40lLPtnNCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666256048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWCwYL0F5/rgcYBecBCS8oPEbaLRdpIuDHctO7ZfYl8=;
        b=MUaCjTF03TVHchgmaHxwuzvquE6CP4BoDlGu+ou/e6mffn1Kmm550fHBOql/9fd4J4mdIE
        hHGiRaD/7jCSIbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82B9413AF5;
        Thu, 20 Oct 2022 08:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S3HiH7AMUWMQKwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 20 Oct 2022 08:54:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1C168A06F2; Thu, 20 Oct 2022 10:54:08 +0200 (CEST)
Date:   Thu, 20 Oct 2022 10:54:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+7f3f0e8b232d8c69dac1@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 dquot_add_space
Message-ID: <20221020085408.ebvapvm722t62c7q@quack3>
References: <000000000000cb197c05eb718fe5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cb197c05eb718fe5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-10-22 23:37:39, syzbot wrote:
> HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=12890b76880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3f0e8b232d8c69dac1
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7f3f0e8b232d8c69dac1@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address 0000000100000117

Hum, this looks very much like some memory corruption because the where we
expect a pointer, there is (u32)-1 value... Let's wait if syzbot finds some
reproducer.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
