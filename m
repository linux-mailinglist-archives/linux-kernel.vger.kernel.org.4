Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1675FC29E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJLJDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJLJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2EBC458;
        Wed, 12 Oct 2022 02:02:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53D9721C70;
        Wed, 12 Oct 2022 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665565322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFWFfMheJTOOV1FrVwY0u7BLBhL6m9es6OGGtnPOeMc=;
        b=mXHifDq2GZMvQ6iVD5VGHOwsOzdg9MuIM0zk5KNI5VrSfjuqwmHaPHqbmmgNVyxDSdwLJf
        qmysYQdAxxc4NL6Z8MRgTkBh+T36W9hQcNi1e2zsAGWPsjDCj0bLEXNq3+pAzbuU3Ei6L+
        Jd7XLbyyLW0GrVhFiWndVsDMKZmSOL4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F381A13A5C;
        Wed, 12 Oct 2022 09:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YACKOYmCRmOxawAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Oct 2022 09:02:01 +0000
Date:   Wed, 12 Oct 2022 11:02:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Subject: Re: [External] Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
Message-ID: <Y0aCiYMQ4liL2azT@dhcp22.suse.cz>
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <Y0WEbCqJHjnqsg8n@dhcp22.suse.cz>
 <582cf257-bc0d-c96e-e72e-9164cff4fce1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582cf257-bc0d-c96e-e72e-9164cff4fce1@bytedance.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-10-22 15:55:44, Zhongkun He wrote:
> Hi  michal, thanks for your reply and suggestiones.
> 
> > Please add some explanation why the cpuset interface is not usable for
> > that usecase.
> OK.
> 
> > > To solve the issue, this patch introduces a new syscall
> > > pidfd_set_mempolicy(2).  it sets the NUMA memory policy of the thread
> > > specified in pidfd.
> > > 
> > > In current process context there is no locking because only the process
> > > accesses its own memory policy, so task_work is used in
> > > pidfd_set_mempolicy() to update the mempolicy of the process specified
> > > in pidfd, avoid using locks and race conditions.
> > 
> > Why cannot you alter kernel_set_mempolicy (and do_set_mempolicy) to
> > accept a task rather than operate on current?
> 
> I have tried it before this patch, but I found a problem.The allocation and
> update of mempolicy are in the current context, so it is not protected by
> any lock.But when the mempolicy is modified by other processes, the race
> condition appears.
> Say something like the following
> 
> 	pidfd_set_mempolicy	     target task stack
> 				       alloc_pages
> 					mpol = get_task_policy;
> 	 task_lock(task);
> 	 old = task->mempolicy;
> 	 task->mempolicy = new;
> 	 task_unlock(task);
> 	 mpol_put(old);			
> 					page = __alloc_pages(mpol);
> There is a situation that when the old mempolicy is released, the target
> task is still using the policy.It would be better if there are suggestions
> on this case.

Yes, this will require some refactoring and one potential way is to make
mpol ref counting unconditional. The conditional ref. counting has
already caused issues in the past and the code is rather hard to follow
anyway. I am not really sure this optimization is worth it.

Another option would be to block the pidfd side of things on completion
which would wake it up from the task_work context but I would rather
explore the ref counting approach first and only if this is proven to be
too expensive to go with hacks like this.
-- 
Michal Hocko
SUSE Labs
