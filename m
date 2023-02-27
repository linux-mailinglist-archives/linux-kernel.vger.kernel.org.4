Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CCD6A3E93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjB0JsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjB0JsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:48:11 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957F693C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:48:09 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.2.41.146])
        by gnuweeb.org (Postfix) with ESMTPSA id ECB51831E1;
        Mon, 27 Feb 2023 09:48:06 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677491289;
        bh=maqva3KmIGSvrzGF0ZVmIotmVZK7GapinSgxP0d0cfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyPRj0HOSF3tLAMCyr08zncVIS/Bo0Ljkkwa/8r7c6M9/8gPdLXqXu5cHqvhvlRWr
         Ys9LsEos2LKE/plt7C6IghGu5TnYkktiv4eoFd8uKLUbr2d6DB15gDKzkBOegPu0IE
         W3DzmYowSzPJR6FXLC7ZpUh2s6j9nzdF6mIPS2hP7c7yPT/w1BYsMhSdGdzgjMbOID
         ny8P49pxSbQHSwRDFjHZ/MrQpDU+cuilgPR+fV1i7IfEn2uc9FcLeb6GsjFuz9w5Sr
         O+Dg7sEdUVMUSr6ErIomEIyrrNv922gQIokkt65sz/GjN5FjvdZDEro/y5R6piQTku
         qcR4nGVdfybog==
Date:   Mon, 27 Feb 2023 16:48:03 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Filipe Manana <fdmanana@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Message-ID: <Y/x8U/Zcx+HQcjiI@biznet-home.integral.gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
 <20230227030438.3655-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227030438.3655-1-hdanton@sina.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:04:38AM +0800, Hillf Danton wrote:
> Are the sensitive user tasks likely also preempted by the kblockd_workqueue[1]
> for instance?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/blk-mq.c#n2258

I didn't see any kblockd_workqueue influence.

From my observation, the issue is btrfs-specific, especially for write
operations with high-level compression. It does not happen with ext4.

(Well, it doesn't compress the data with ext4, so no doubt it's lighter).

Seeing from htop, several kthreads consume CPU time:

   - kworker btrfs-dealloc

   - kworker btrfs-endio-write

   - kworker btrfs-worker-high

   - kworker btrfs-compressed-write

   - ... there are more, but all of them are btrfs workqueues.

They perform heavy work when there is an intensive writing operation.
However, for the read operation, there is no visible issue.

Increasing vm.dirty_ratio and vm.background_dirty_ratio, plus using

   -o commit=N (mount option)

where N is a large number helps a lot. But it slows my entire system
down when it starts syncing the dirty write to the disk. It freezes the
UI for 2 to 3 seconds and causes audio lag.

Isolating btrfs workqueues and UI tasks in a different set of CPUs, as
proposed in this series, solves the issue.

-- 
Ammar Faizi

