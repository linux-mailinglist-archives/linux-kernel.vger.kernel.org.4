Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1236262C19E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiKPO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiKPO5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:57:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DCFADF;
        Wed, 16 Nov 2022 06:57:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98D361F94F;
        Wed, 16 Nov 2022 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668610635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3vl4NdpO4irC1eRJoV821C0JFp7+4A15d5hSm1FQvTo=;
        b=eqaB6EP2GKiw5QP6JiW0cWOM1NG4anZRyh1calWKdEwUX95RbEKck+SxlKqWruwGYlnjRW
        InAsn8C+8XCSZZ23Mcg3b7PsV6E7utY9JOJX4lXDMQlPNUCOIwlxjZtQp2QRMW+DkxU1bQ
        lzj7mbU+Msd0KWWV5/hZ7unfoL4q6B4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A24113480;
        Wed, 16 Nov 2022 14:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qwJoG0v6dGOYYgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 16 Nov 2022 14:57:15 +0000
Date:   Wed, 16 Nov 2022 15:57:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
Message-ID: <Y3T6SqZvAmSG5I6W@dhcp22.suse.cz>
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
 <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
 <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
 <Y3KFFfMFE55lVdNZ@dhcp22.suse.cz>
 <82c9c89c-aee2-08a3-e562-359631bb0137@bytedance.com>
 <0bd0b744-3d97-b4c3-a4fb-6040f8f8024a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd0b744-3d97-b4c3-a4fb-6040f8f8024a@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-11-22 19:28:10, Zhongkun He wrote:
> Hi Michal, I've done the performance testing, please check it out.
> 
> > > Yes this is all understood but the level of the overhead is not really
> > > clear. So the question is whether this will induce a visible overhead.
> > > Because from the maintainability point of view it is much less costly to
> > > have a clear life time model. Right now we have a mix of reference
> > > counting and per-task requirements which is rather subtle and easy to
> > > get wrong. In an ideal world we would have get_vma_policy always
> > > returning a reference counted policy or NULL. If we really need to
> > > optimize for cache line bouncing we can go with per cpu reference
> > > counters (something that was not available at the time the mempolicy
> > > code has been introduced).
> > > 
> > > So I am not saying that the task_work based solution is not possible I
> > > just think that this looks like a good opportunity to get from the
> > > existing subtle model.
> 
> Test tools:
> numactl -m 0-3 ./run-mmtests.sh -n -c configs/config-workload-
> aim9-pagealloc  test_name
> 
> Modification:
> Get_vma_policy(), get_task_policy() always returning a reference
> counted policy, except for the static policy(default_policy and
> preferred_node_policy[nid]).

It would be better to add the patch that has been tested.

> All vma manipulation is protected by a down_read, so mpol_get()
> can be called directly to take a refcount on the mpol. but there
> is no lock in task->mempolicy context.
> so task->mempolicy should be protected by task_lock.
> 
> struct mempolicy *get_task_policy(struct task_struct *p)
> {
> 	struct mempolicy *pol;
> 	int node;
> 
> 	if (p->mempolicy) {
> 		task_lock(p);
> 		pol = p->mempolicy;
> 		mpol_get(pol);
> 		task_unlock(p);
> 		if (pol)
> 			return pol;
> 	}


One way to deal with that would be to use a similar model as css_tryget

Btw. have you tried to profile those slowdowns to identify hotspots?

Thanks
-- 
Michal Hocko
SUSE Labs
