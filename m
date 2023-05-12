Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718E6701292
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbjELXof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239656AbjELXo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEAA2101;
        Fri, 12 May 2023 16:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5734660C53;
        Fri, 12 May 2023 23:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B5BC433EF;
        Fri, 12 May 2023 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683935065;
        bh=2czeN+szhGqQEbAPsO/hg6SMlJY1aN6WI4RZJU274vE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iPst+k+uujlSeJkrSXsSTphDq6H5xvOLn92+AZSylYg1tFmc8sD1lDcsWn3ITIZtb
         uoj8k7qzz9w1lQM6NprAT2J1b3nXLwA+icPHqALEYHt9/DhiKQalBxraub7cGa4V2R
         C+BigRBTJfy57+DusM5+UuO4Gk+PHojdnJUY8Rns=
Date:   Fri, 12 May 2023 16:44:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+78d4495558999f55d1da@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nilfs2: fix use-after-free bug of nilfs_root in
 nilfs_evict_inode()
Message-Id: <20230512164424.865d7929600ed070824764e6@linux-foundation.org>
In-Reply-To: <20230509152956.8313-1-konishi.ryusuke@gmail.com>
References: <00000000000099e5ac05fb1c3b85@google.com>
        <20230509152956.8313-1-konishi.ryusuke@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 00:29:56 +0900 Ryusuke Konishi <konishi.ryusuke@gmail.com> wrote:

> During unmount process of nilfs2, nothing holds nilfs_root structure after
> nilfs2 detaches its writer in nilfs_detach_log_writer().  However, since
> nilfs_evict_inode() uses nilfs_root for some cleanup operations, it may
> cause use-after-free read if inodes are left in "garbage_list" and
> released by nilfs_dispose_list() at the end of nilfs_detach_log_writer().
> 
> Fix this issue by modifying nilfs_evict_inode() to only clear inode
> without additional metadata changes that use nilfs_root if the file system
> is degraded to read-only or the writer is detached.
> 
> ...
>
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -917,6 +917,7 @@ void nilfs_evict_inode(struct inode *inode)
>  	struct nilfs_transaction_info ti;
>  	struct super_block *sb = inode->i_sb;
>  	struct nilfs_inode_info *ii = NILFS_I(inode);
> +	struct the_nilfs *nilfs;
>  	int ret;

`the_nilfs' is unused - I'll zap it.


