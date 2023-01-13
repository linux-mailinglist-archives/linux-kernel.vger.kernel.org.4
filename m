Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108B16695E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbjAMLva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbjAMLuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F122654D83;
        Fri, 13 Jan 2023 03:42:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3FF6B820EB;
        Fri, 13 Jan 2023 11:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A34C433D2;
        Fri, 13 Jan 2023 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673610130;
        bh=6Lfe7N21xmp2PaLBj7T6/NaGLveUWOWBEdH5DMP5Yz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hD/VbOhj9Xg/jJW5GA7uzLzzPCccw9OouNgpXhPlAgXLGIFKDyJwZCiC+Fv3GINtA
         9eBfODJrTKCkfKA+gvjr8Bznw9ui1L/NpKyc+pvopnrkQ5d1IAoT2cvjVxUamxWZr2
         Nj9tDFQmIKrT02QY0WVOIWEvQ5L3YBUR0rQQU4UA=
Date:   Fri, 13 Jan 2023 12:41:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        slipper.alive@gmail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "net/ulp: prevent ULP without clone op from entering the
 LISTEN status" has been added to the 5.4-stable tree
Message-ID: <Y8FDhdy3s1z/JxAi@kroah.com>
References: <16735310493146@kroah.com>
 <Y8AP6Lqo9sfX9Bb8@kroah.com>
 <20230112105731.0da81d58@kernel.org>
 <Y8BZboDOQ1I+VTAC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8BZboDOQ1I+VTAC@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:03:10PM +0100, Greg KH wrote:
> On Thu, Jan 12, 2023 at 10:57:31AM -0800, Jakub Kicinski wrote:
> > On Thu, 12 Jan 2023 14:49:28 +0100 Greg KH wrote:
> > > On Thu, Jan 12, 2023 at 02:44:09PM +0100, gregkh@linuxfoundation.org wrote:
> > > > 
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >     net/ulp: prevent ULP without clone op from entering the LISTEN status
> > > > 
> > > > to the 5.4-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary  
> > > 
> > > Oops, nope, this broke the build for 5.4 and older kernels, now
> > > dropping.
> > 
> > There's no clone op, right?
> 
> Correct.
> 
> > If you're willing to futz with it I think
> > you just need to remove the "and the ops don't have ->clone" part of
> > the conditions. Any presence of ops on older kernels should make us
> > bail.

Ok, I've queued up the following patch for 5.4. and older.  Let me know
if I've messed anything up here, but it at least builds for me :)

thanks,

greg k-h

------------

From 2c02d41d71f90a5168391b6a5f2954112ba2307c Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 3 Jan 2023 12:19:17 +0100
Subject: net/ulp: prevent ULP without clone op from entering the LISTEN status

From: Paolo Abeni <pabeni@redhat.com>

commit 2c02d41d71f90a5168391b6a5f2954112ba2307c upstream.

When an ULP-enabled socket enters the LISTEN status, the listener ULP data
pointer is copied inside the child/accepted sockets by sk_clone_lock().

The relevant ULP can take care of de-duplicating the context pointer via
the clone() operation, but only MPTCP and SMC implement such op.

Other ULPs may end-up with a double-free at socket disposal time.

We can't simply clear the ULP data at clone time, as TLS replaces the
socket ops with custom ones assuming a valid TLS ULP context is
available.

Instead completely prevent clone-less ULP sockets from entering the
LISTEN status.

Fixes: 734942cc4ea6 ("tcp: ULP infrastructure")
Reported-by: slipper <slipper.alive@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/4b80c3d1dbe3d0ab072f80450c202d9bc88b4b03.1672740602.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_connection_sock.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -902,11 +902,25 @@ void inet_csk_prepare_forced_close(struc
 }
 EXPORT_SYMBOL(inet_csk_prepare_forced_close);
 
+static int inet_ulp_can_listen(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	if (icsk->icsk_ulp_ops)
+		return -EINVAL;
+
+	return 0;
+}
+
 int inet_csk_listen_start(struct sock *sk, int backlog)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct inet_sock *inet = inet_sk(sk);
-	int err = -EADDRINUSE;
+	int err;
+
+	err = inet_ulp_can_listen(sk);
+	if (unlikely(err))
+		return err;
 
 	reqsk_queue_alloc(&icsk->icsk_accept_queue);
 
