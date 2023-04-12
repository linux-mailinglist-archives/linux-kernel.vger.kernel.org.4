Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82126DFFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjDLUdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDLUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27733C07
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7653162D67
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E27C433EF;
        Wed, 12 Apr 2023 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681331612;
        bh=hM0bwcDvgkAIjvvxpcJVRLkstfxzoDyPt2D7iUnvNG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fv32pv5Dou8qrSImdDNerwO5oykE51gQE6kk7ssw+dRnxB/fixTTy1oEQfGBMBcoI
         Pn9zy+xWWwvifEgqyoZdHHSZcILSKaEP9D/7qfcV+NdBU56EErN5+96HxSehklD/DM
         N17tP9ng9rOp2F5TF7dZuBSAYEY+n/qa6Ef4RL6k=
Date:   Wed, 12 Apr 2023 13:33:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     urezki@gmail.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, elver@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Subject: Re: [PATCH 2/2] mm: kmsan: handle alloc failures in
 kmsan_ioremap_page_range()
Message-Id: <20230412133331.e26920856ccf94edd057c1e0@linux-foundation.org>
In-Reply-To: <20230412145300.3651840-2-glider@google.com>
References: <20230412145300.3651840-1-glider@google.com>
        <20230412145300.3651840-2-glider@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 16:53:00 +0200 Alexander Potapenko <glider@google.com> wrote:

> Similarly to kmsan_vmap_pages_range_noflush(),
> kmsan_ioremap_page_range() must also properly handle allocation/mapping
> failures. In the case of such, it must clean up the already created
> metadata mappings and return an error code, so that the failure can be
> propagated to ioremap_page_range().

Unlike [1/2], this changelog doesn't describe the user-visible effects.
A bit of clicking takes me to

: kmsan's allocation of shadow or origin memory in
: kmsan_vmap_pages_range_noflush() fails silently due to fault injection
: (FI).  KMSAN sort of "swallows" the allocation failure, and moves on. 
: When either of them is later accessed while updating the metadata,
: there are no checks to test the validity of the respective pointers,
: which results in a page fault.

So I'll add that to the changelog and shall add cc:stable to both patches.

