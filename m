Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE86674DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjATHPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjATHPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:15:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A84347C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:15:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E45D6B81A74
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E37C433EF;
        Fri, 20 Jan 2023 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674198918;
        bh=dGwXf0BmH8FB3+W1jC+RE4rVTDz4Q5BheAiK4UorBxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5/cD8+5/Qo1ZOqM50106fjf6hDtXPzyqTlRT7Fr7HckbdfcicUOztJa/efgae8nu
         sTND8M5DFHXarP+78nsVn8FvQn+cD0s0mZOtKkfTY8IRoTvsR24i1cNX+RFwHm886+
         rqlffC+0G3kHaQCIpDod0CZRivBH2YfmpVimDOaA=
Date:   Fri, 20 Jan 2023 08:15:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y8o/g9cDZCxmL6yR@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com>
 <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com>
 <87a62eqo4h.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a62eqo4h.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > Then you need to copy it out once, and then only deal with the local
> > copy.  Otherwise you have an incomplete snapshot.
> 
> Ok, would you be partial to something like this:
> 
> >From 1bc9bb84004154376c2a0cf643d53257da6d1cd7 Mon Sep 17 00:00:00 2001
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Date: Thu, 19 Jan 2023 21:59:02 +0200
> Subject: [PATCH] virtio console: Keep a local copy of the control structure
> 
> When handling control messages, instead of peeking at the device memory
> to obtain bits of the control structure, take a snapshot of it once and
> use it instead, to prevent it from changing under us. This avoids races
> between port id validation and control event decoding, which can lead
> to, for example, a NULL dereference in port removal of a nonexistent
> port.
> 
> The control structure is small enough (8 bytes) that it can be cached
> directly on the stack.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Amit Shah <amit@kernel.org>
> ---
>  drivers/char/virtio_console.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Yes, this looks much better, thanks!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
