Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA19628804
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiKNSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiKNSMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:12:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BBC2AC45;
        Mon, 14 Nov 2022 10:12:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A604420218;
        Mon, 14 Nov 2022 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668449558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVwKZGg3oMnijACqeL9ZqfKWMlak+iItXqazHisGzUI=;
        b=KwaGqHwZvP04jjBZ2aWenp9eV3RLzfnOBEyFCAKEexdk7lWNJLfJFxxJx4z0JsEeE1Nco+
        Ju6uiiftFCj8lEfY0d7dV45eZc7xcRTE735TdnINBD4Y0H8pIVqRcWgtUC4GpUFHKifhZ+
        OCjMRFMiaA/AykO14G7IXAPhw91uiRM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83A4113A8C;
        Mon, 14 Nov 2022 18:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FmRBHRaFcmPdcAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 14 Nov 2022 18:12:38 +0000
Date:   Mon, 14 Nov 2022 19:12:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
Message-ID: <Y3KFFfMFE55lVdNZ@dhcp22.suse.cz>
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
 <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
 <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-11-22 23:12:00, Zhongkun He wrote:
> Sorry,michal. I dont know if my expression is accurate.
> > 
> > We shouldn't really rely on mmap_sem for this IMO.
> 
>  Yes, We should rely on mmap_sem for vma->vm_policy,but not for
>  process context policy(task->mempolicy).

But the caller has no way to know which kind of policy is returned so
the locking cannot be conditional on the policy type.

> > There is alloc_lock
> > (aka task lock) that makes sure the policy is stable so that caller can
> > atomically take a reference and hold on the policy. And we do not do
> > that consistently and this should be fixed.
> 
> I saw some explanations in the doc("numa_memory_policy.rst") and
> comments(mempolcy.h) why not use locks and reference in page
> allocation:
> 
> In process context there is no locking because only the process accesses
> its own state.
> 
> During run-time "usage" of the policy, we attempt to minimize atomic
> operations on the reference count, as this can lead to cache lines
> bouncing between cpus and NUMA nodes.

Yes this is all understood but the level of the overhead is not really
clear. So the question is whether this will induce a visible overhead.
Because from the maintainability point of view it is much less costly to
have a clear life time model. Right now we have a mix of reference
counting and per-task requirements which is rather subtle and easy to
get wrong. In an ideal world we would have get_vma_policy always
returning a reference counted policy or NULL. If we really need to
optimize for cache line bouncing we can go with per cpu reference
counters (something that was not available at the time the mempolicy
code has been introduced).

So I am not saying that the task_work based solution is not possible I
just think that this looks like a good opportunity to get from the
existing subtle model.
-- 
Michal Hocko
SUSE Labs
