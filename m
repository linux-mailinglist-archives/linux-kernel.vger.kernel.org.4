Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D5F735E40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjFSUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFSUOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C5D3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4183A60E99
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2D5C433C8;
        Mon, 19 Jun 2023 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687205658;
        bh=LxetqB1eFRX4wGu2zVQqDsDxwolvc4APmEuYLkFMCmE=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=cuIej+npfo3jZNQZFCrsF9g+OpDCyJwyFzShEHKiQJ0CGUn3ORRX/MyxVhNzVMlll
         WxEJxgYhvDx6nwiZR3ggLNrdFfUx3dX2WxsSyebm2apYAs+jGtCOHAdqnDyL4MmMsL
         P9O/yaGQs/vlVsB8r6Pp+NY9wMT+PabeSOAzklhQ=
Date:   Mon, 19 Jun 2023 13:14:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "buddy.zhang" <buddy.zhang@biscuitos.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Venkatesh Pallipadi <venki@google.com>,
        Suresh Siddha <sbsiddha@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: Re: [PATCH] mm: Keep memory type same on DEVMEM Page-Fault
Message-Id: <20230619131417.42d4e73d1b7669162ea44e29@linux-foundation.org>
In-Reply-To: <20230416113944.c9b50a76a98b9e7c974cfac9@linux-foundation.org>
References: <20230319033750.475200-1-buddy.zhang@biscuitos.cn>
        <20230412142236.407d6d0e6d90232da004980e@linux-foundation.org>
        <20230416113944.c9b50a76a98b9e7c974cfac9@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2023 11:39:44 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 12 Apr 2023 14:22:36 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Sun, 19 Mar 2023 11:37:50 +0800 "buddy.zhang" <buddy.zhang@biscuitos.cn> wrote:
> > 
> > > On X86 architecture, supports memory type on Page-table, such as
> > > PTE is PAT/PCD/PWD, which can setup up Memory Type as WC/WB/WT/UC etc.
> > > Then, Virtual address from userspace or kernel space can map to
> > > same physical page, if each page table has different memory type,
> > > then it's confused to have more memory type for same physical page.
> > 
> > Thanks.  Nobody has worked on this code for a long time.  I'll cc a few
> > folks who may be able to comment.
> > 
> 
> Well that didn't go very well.
> 
> Buddy, can you please explain what are the user-visible effects of the
> bug?  Does the kernel crash?  Memory corruption, etc?  Thanks.
> 

Anyone?
