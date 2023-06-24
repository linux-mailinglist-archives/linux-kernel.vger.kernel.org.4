Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798C473CB41
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjFXOKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFXOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 10:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA41BC2;
        Sat, 24 Jun 2023 07:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C133860670;
        Sat, 24 Jun 2023 14:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7558C433C8;
        Sat, 24 Jun 2023 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687615827;
        bh=guBS/pXFgHuNgM7sT8xh/zRfKmjGXRbCU6mtO94IDLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVmxZgBo6RyuOrNnSx3g61md/oL2lzI0LMfINwpy8f70Vcx+MxMs4wtdagqUwbrFg
         D7Z2PRiiBs3y7qDPFPdKYWGkEeJDCaFqGVNt0JplhqhzoNc4hyIyMJt3H69U5mbLBI
         BLpUq2zK2g5PtbBMZgvnWDBKJTKfPHMDOgzf1qag=
Date:   Sat, 24 Jun 2023 16:10:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Alcantara <pc@manguebit.com>
Cc:     Rishabh Bhatnagar <risbhat@amazon.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 5.4 0/5] CIFS DFS fixes for 5.4
Message-ID: <2023062419-smoking-buggy-ebbf@gregkh>
References: <20230623213406.5596-1-risbhat@amazon.com>
 <56200b7e7f5a8852869814ff1f9f0fa7.pc@manguebit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56200b7e7f5a8852869814ff1f9f0fa7.pc@manguebit.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:08:22PM -0300, Paulo Alcantara wrote:
> Rishabh Bhatnagar <risbhat@amazon.com> writes:
> 
> > We are seeing deadlock in cifs code while updating volume in
> > cifs_reconnect. There are few fixes available in stable trees
> > already. This series backports some patches back to 5.4 stable.
> >
> >  __schedule+0x268/0x6e0
> >  schedule+0x2f/0xa0
> >  schedule_preempt_disabled+0xa/0x10
> >  __mutex_lock.isra.7+0x20b/0x470
> >  ? dfs_cache_update_vol+0x45/0x2a0 [cifs]
> >  dfs_cache_update_vol+0x45/0x2a0 [cifs]
> >  cifs_reconnect+0x6f2/0xef0 [cifs]
> >  cifs_handle_standard+0x18d/0x1b0 [cifs]
> >  cifs_demultiplex_thread+0xa5c/0xc90 [cifs]
> >  ? cifs_handle_standard+0x1b0/0x1b0 [cifs]
> >
> > Paulo Alcantara (SUSE) (5):
> >   cifs: Clean up DFS referral cache
> >   cifs: Get rid of kstrdup_const()'d paths
> >   cifs: Introduce helpers for finding TCP connection
> >   cifs: Merge is_path_valid() into get_normalized_path()
> >   cifs: Fix potential deadlock when updating vol in cifs_reconnect()
> >
> >  fs/cifs/dfs_cache.c | 701 +++++++++++++++++++++++---------------------
> >  1 file changed, 372 insertions(+), 329 deletions(-)
> 
> Looks good, thanks.

All now queued up, thanks.

greg k-h
