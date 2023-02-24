Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3482C6A1BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBXLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:55:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9CB10426
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:55:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 866E738B8F;
        Fri, 24 Feb 2023 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677239710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trB2hoPi7bkN1LSstj7Hm3/romH47IEWODnFrZ0CXrw=;
        b=f2mFa2gXalNxYJ1uvjpDsdDGxKzRalczaEB0TGE9D8nrPsqopk7xyYZxO2DXOhT85z+kUQ
        sX0lJf/ALBWg0mSRMNqCj5i6Gt8sLjOiytYWhcs3f/PUNMpHJY3S/d5oP1vnALhlE+49KJ
        Ts3S5watdcFWQT5qdXOQCPKv1JkWPAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677239710;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trB2hoPi7bkN1LSstj7Hm3/romH47IEWODnFrZ0CXrw=;
        b=x0wxwzaJzQ9twtXls3XkmrBMsnR+nOcErsEH4mCr828wElnpZkc3q5GCFkE+Mtxxs48JvS
        Q1xIGBKFSxrz+vDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78C2913246;
        Fri, 24 Feb 2023 11:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rNmIHZ6l+GPHEAAAMHmgww
        (envelope-from <jwiesner@suse.de>); Fri, 24 Feb 2023 11:55:10 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 0EB7B4B005; Fri, 24 Feb 2023 12:55:10 +0100 (CET)
Date:   Fri, 24 Feb 2023 12:55:09 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, mingo@redhat.com,
        will@kernel.org, linux-kernel@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] locking/rwsem: Rework writer wakeup and handoff
Message-ID: <20230224115509.GA16087@incl>
References: <20230223122642.491637862@infradead.org>
 <55b63346-1445-30f6-3b8a-06068377bad6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b63346-1445-30f6-3b8a-06068377bad6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 08:19:46PM -0500, Waiman Long wrote:
> On 2/23/23 07:26, Peter Zijlstra wrote:
> > Hi,
> > 
> > these here few patches boot but are otherwise very much untested. Please test.
> 
> However, I got the following task hanging message when doing a kernel build:
> [ 2215.895252] INFO: task pahole:65220 blocked for more than 123 seconds.

I was running locktorture and ran into the same problem as Waiman. It's unrelated to the locktorture workload, though:

[ 1482.886856] INFO: task btrfs-transacti:1073 blocked for more than 491 seconds.
[ 1482.895755]       Tainted: G            E      6.2.0-pz1 #1
[ 1482.912382] task:btrfs-transacti state:D stack:0     pid:1073  ppid:2      flags:0x00004000
[ 1482.922544] Call Trace:
[ 1482.926074]  <TASK>
[ 1482.929211]  __schedule+0x3c0/0x1360
[ 1482.954121]  schedule+0x5c/0xc0
[ 1482.958428]  schedule_preempt_disabled+0x11/0x20
[ 1482.964396]  rwsem_down_write_slowpath+0x17c/0x580
[ 1482.975260]  down_write+0x57/0x60
[ 1482.979763]  __btrfs_tree_lock+0x17/0x90 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1482.989779]  btrfs_lock_root_node+0x3b/0x90 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.000082]  btrfs_search_slot+0x2b7/0xc70 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.010267]  btrfs_lookup_file_extent+0x4a/0x70 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.020949]  btrfs_drop_extents+0x12e/0xf20 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.031252]  insert_reserved_file_extent+0xec/0x2e0 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.053705]  insert_prealloc_file_extent+0xb9/0x1b0 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.064774]  __btrfs_prealloc_file_range+0x12c/0x420 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.075941]  cache_save_setup+0x26d/0x3d0 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.086052]  btrfs_setup_space_cache+0x9c/0xc0 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.096648]  commit_cowonly_roots+0xd9/0x279 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.107046]  btrfs_commit_transaction+0x8e2/0xe70 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.128221]  transaction_kthread+0x14e/0x1b0 [btrfs a6f0f85f39d8ec2ab376bf2ae3a09f935847037e]
[ 1483.149588]  kthread+0xd7/0x100
[ 1483.158891]  ret_from_fork+0x29/0x50
[ 1483.163689]  </TASK>

-- 
Jiri Wiesner
SUSE Labs
