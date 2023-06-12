Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD472BC29
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjFLJYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjFLJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2BD30F1;
        Mon, 12 Jun 2023 02:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A536616C9;
        Mon, 12 Jun 2023 09:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5B1C433D2;
        Mon, 12 Jun 2023 09:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686561490;
        bh=KxCRjozkEmNTEVpik04VLm/33kLity8Xed0mLWEvHXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cz1qnUE7tDYcXBQb3O0qUolN7bzyssoGPFNLqvbkXN9Cjh6wOgW3OhUtTWki+U5TC
         3gqC736BaJ4XZpVwYFV/OIvV0WnsB39eZVzZAlOHfcTNQDYx+bhcV9BG95cufcdxsq
         qNFvrYxGEE8meW5TcP6a0j8j+lyogwF660XEP2vc=
Date:   Mon, 12 Jun 2023 11:18:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Alcantara <pc@manguebit.com>
Cc:     Rishabh Bhatnagar <risbhat@amazon.com>, sfrench@amazon.com,
        stable@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5.4 0/2] Backport few dfs related fixes to cifs
Message-ID: <2023061203-skinning-guileless-0e13@gregkh>
References: <20230607203333.26669-1-risbhat@amazon.com>
 <a664029640828958e152e9a4c11c4b9a.pc@manguebit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a664029640828958e152e9a4c11c4b9a.pc@manguebit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:54:26PM -0300, Paulo Alcantara wrote:
> Rishabh Bhatnagar <risbhat@amazon.com> writes:
> 
> > Recently we have been seeing kernel panic in cifs_reconnect function
> > while accessing tgt_list. Looks like tgt_list is not initialized
> > correctly. There are fixes already present in 5.10 and later trees.
> > Backporting them to 5.4
> >
> >  CIFS VFS: \\172.30.1.14 cifs_reconnect: no target servers for DFS
> >  failover
> >  BUG: unable to handle page fault for address: fffffffffffffff8
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> >  PGD 260e067 P4D 260e067 PUD 2610067 PMD 0
> >  Oops: 0000 [#1] SMP PTI
> >  RIP: 0010:cifs_reconnect+0x51d/0xef0 [cifs]
> >  RSP: 0018:ffffc90000693da0 EFLAGS: 00010282
> >  RAX: fffffffffffffff8 RBX: ffff8887fa63b800 RCX: fffffffffffffff8
> >  Call Trace:
> >  cifs_handle_standard+0x18d/0x1b0 [cifs]
> >  cifs_demultiplex_thread+0xa5c/0xc90 [cifs]
> >  kthread+0x113/0x130
> >
> > Paulo Alcantara (2):
> >   cifs: get rid of unused parameter in reconn_setup_dfs_targets()
> >   cifs: handle empty list of targets in cifs_reconnect()
> >
> >  fs/cifs/connect.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Looks good.

Now queued up, thanks.

greg k-h
