Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103A072701E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjFGVEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjFGVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE126B1;
        Wed,  7 Jun 2023 14:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2279A649C2;
        Wed,  7 Jun 2023 21:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337F0C433D2;
        Wed,  7 Jun 2023 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171838;
        bh=CXoOYQWfn/gfiuJeYsYil+eQ9GHgcNCLyTFZQPddJaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfzI45WHZru78wT2DapCBLR+jIFBLrX2COw7daYW5FkDpg09mKO4cM5n0YH3F7eJu
         5Cn7AnkMUT2qdTzUu10mxbIoAM8BD/SGIXQuEuIookOtlCC5lAhaW/2aOrRIYu7H8f
         sxotfEvjqHeQ1Ip9Ig0ZCJyta1D1l6Gbe8RgqdBg=
Date:   Wed, 7 Jun 2023 22:36:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     sfrench@samba.org, stable@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.4 0/2] Backport few dfs related fixes to cifs
Message-ID: <2023060752-trespass-hertz-32a4@gregkh>
References: <20230607185313.11363-1-risbhat@amazon.com>
 <2023060750-unpledged-effective-bd95@gregkh>
 <de36d593-5f1e-bb9b-6b70-8be0b783c5f4@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de36d593-5f1e-bb9b-6b70-8be0b783c5f4@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 01:20:23PM -0700, Bhatnagar, Rishabh wrote:
> 
> On 6/7/23 12:07 PM, Greg KH wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Wed, Jun 07, 2023 at 06:53:11PM +0000, Rishabh Bhatnagar wrote:
> > > Recently we have been seeing kernel panic in cifs_reconnect function
> > > while accessing tgt_list. Looks like tgt_list is not initialized
> > > correctly. There are fixes already present in 5.10 and later trees.
> > > Backporting them to 5.4
> > > 
> > >   CIFS VFS: \\172.30.1.14 cifs_reconnect: no target servers for DFS
> > >   failover
> > >   BUG: unable to handle page fault for address: fffffffffffffff8
> > >   #PF: supervisor read access in kernel mode
> > >   #PF: error_code(0x0000) - not-present page
> > >   PGD 260e067 P4D 260e067 PUD 2610067 PMD 0
> > >   Oops: 0000 [#1] SMP PTI
> > >   RIP: 0010:cifs_reconnect+0x51d/0xef0 [cifs]
> > >   RSP: 0018:ffffc90000693da0 EFLAGS: 00010282
> > >   RAX: fffffffffffffff8 RBX: ffff8887fa63b800 RCX: fffffffffffffff8
> > >   Call Trace:
> > >   cifs_handle_standard+0x18d/0x1b0 [cifs]
> > >   cifs_demultiplex_thread+0xa5c/0xc90 [cifs]
> > >   kthread+0x113/0x130
> > > 
> > > *** BLURB HERE ***
> > No blurb?
> > 
> > And this says 5.4, yet your patches say 5.10?
> > 
> > Totally confused...
> > 
> > greg k-h
> 
> These patches are applicable for 5.4. Will send another version with that
> fixed.
> Apologies for the mess.

Please resend both series, as this one I already dropped from my queue.

thanks,

greg k-h
