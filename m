Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBC1669E22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjAMQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjAMQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:28:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91897ECA5;
        Fri, 13 Jan 2023 08:22:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 823AB6BBA9;
        Fri, 13 Jan 2023 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673626963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFYXeQHB5mBEYDHWaUYTs7tQmOKRVt8dzinfneBzAwA=;
        b=aFZyL6L/H2u/JrlrEmotKR4SoE/eWsdutW6toqBDqmxlhbK/ZONAYVU75Hapted0dAHIjZ
        nC3D92R6XNevYUZ0CCPedkqLxpwyZUGsLE+8F+RSFgxhbb1mJMr7jqssSK33WljMceFiJs
        1H+u3To0piVwyxUxd4Yn14wXQyBejX4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64D2A1358A;
        Fri, 13 Jan 2023 16:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UAAyFlOFwWOkUwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 13 Jan 2023 16:22:43 +0000
Date:   Fri, 13 Jan 2023 17:22:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com
Subject: Re: [PATCH 0/3] mm: replace atomic_t with percpu_ref in mempolicy.
Message-ID: <Y8GFUiSih8f0mUoU@dhcp22.suse.cz>
References: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
 <Y8GE1r9/c1DHsHj0@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GE1r9/c1DHsHj0@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-01-23 17:20:39, Michal Hocko wrote:
> On Mon 05-12-22 00:14:29, Zhongkun He wrote:
> > All vma manipulation is somewhat protected by a down_read on
> > mmap_lock, so vma mempolicy is clear to obtain a reference.
> > But there is no locking in process context and have a mix
> > of reference counting and per-task requirements which is rather
> > subtle and easy to get wrong.
> > 
> > we would have get_vma_policy() always returning a reference
> > counted policy, except for static policy. For better performance,
> > we replace atomic_t ref with percpu_ref in mempolicy, which is
> > usually the performance bottleneck in hot path.
> > 
> > This series adjust the reference of mempolicy in process context,
> > which will be protected by RCU in read hot path. Besides,
> > task->mempolicy is also protected by task_lock(). Percpu_ref
> > is a good way to reduce cache line bouncing.
> > 
> > The mpol_get/put() can just increment or decrement the local
> > counter. Mpol_kill() must be called to initiate the destruction
> > of mempolicy. A mempolicy will be freed when the mpol_kill()
> > is called and the reference count decrese to zero.
> 
> This is really hard to follow. Without having the context from previous
> discussions I would be completely lost. Please structure your cover
> letter but also other patch in general in the form:
> - what is the problem you would like to deal with
> 	- want to introduce pidfd_set_mempolicy because XYZ
> - what stands in the way
> 	- mempolicy objects access constrains (reliance on operating in
> 	  the current context)
> 	- reference counting needs to be unconditional
> 	- why regular reference counting is not sufficient (performance)
> - what is this patchset proposing
> 	- per cpu reference counting
> 	- how is it implemented
> - how is the patch series structured
> 	- make the reference counting unconditional
> 	- special case static (never released) policies
> 	- replace standard ref counting by per-cpu reference counting

	- introduce pidfd_set_mempolicy
> - how has this been tested?
-- 
Michal Hocko
SUSE Labs
