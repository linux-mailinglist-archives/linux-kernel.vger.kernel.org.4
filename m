Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16081698ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBPIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBPIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:37:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4923F367DA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:37:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0504121F53;
        Thu, 16 Feb 2023 08:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676536655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4CCLPR51y3yHN6YwtMOG4JMBdiFnLbz6AWl2eLi+1c=;
        b=R+4cxp4ZawyHb+84pmMw2htlDCb8+OqzyWl6j1Yg3GNKtjSaFMs7o+Rhp2Gv5waH4wr1Ae
        T+BZmT+wHSnO8RK/nIwcJbrFxh828eULul0ZWKFYVKGC6xI3W47Ryx5i19uLLrP0bkUHiM
        3/q9uANkRJ9CkztM+aiOkKJ2yZBApw4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9D2E13484;
        Thu, 16 Feb 2023 08:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i28/Mk7r7WO5EQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 16 Feb 2023 08:37:34 +0000
Date:   Thu, 16 Feb 2023 09:37:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 0/2] handle memoryless nodes more appropriately
Message-ID: <Y+3rTq9lBhHnJZ19@dhcp22.suse.cz>
References: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
 <Y+0KKnN8BU6ky6oP@dhcp22.suse.cz>
 <3426457c-99bf-9f7c-f663-c29474d9fa73@bytedance.com>
 <Y+3gb/blCDJnQ0Ik@dhcp22.suse.cz>
 <767893ef-f8c2-c478-f1a0-e785bbf2da09@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767893ef-f8c2-c478-f1a0-e785bbf2da09@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-02-23 16:21:54, Qi Zheng wrote:
> 
> 
> On 2023/2/16 15:51, Michal Hocko wrote:
> > On Thu 16-02-23 07:11:19, Qi Zheng wrote:
> > > 
> > > 
> > > On 2023/2/16 00:36, Michal Hocko wrote:
> > > > On Wed 15-02-23 23:24:10, Qi Zheng wrote:
> > > > > Hi all,
> > > > > 
> > > > > Currently, in the process of initialization or offline memory, memoryless
> > > > > nodes will still be built into the fallback list of itself or other nodes.
> > > > > 
> > > > > This is not what we expected, so this patch series removes memoryless
> > > > > nodes from the fallback list entirely.
> > > > > 
> > > > > Comments and suggestions are welcome.
> > > 
> > > Hi Michal,
> > > 
> > > > 
> > > > This is a tricky area full of surprises and it is really easy to
> > > 
> > > Would you mind giving an example of a "new problem"?
> > 
> > The initialization is spread over several places and it is quite easy to
> > introduce bugs because it is hard to review this area. Been there done
> > that. Just look into the git log.
> 
> I understand your concern, but should we therefore reject all revisions
> to this?

No, but either somebode is willing to invest a non-trivial amount of
time and unify the NUMA initialization code that is spread over arch
specific code in different places or we should just focus on addressing
bugs.

> > > > introduce new problems. What kind of problem/issue are you trying to
> > > > solve/handle by these changes?
> > > 
> > > IIUC, I think there are two reasons:
> > > 
> > > Firstly, as mentioned in commit message, the memoryless node has no
> > > memory to allocate (If it can be allocated, it may also cause the panic
> > > I mentioned in [1]), so we should not continue to traverse it when
> > > allocating memory at runtime, which will have a certain overhead.
> > 
> > Sure that is not the most optimal implementation but does this matter in
> > practice? Can you observe any actual measurable performance penalty?
> 
> No, and the original reason for noticing this place was the panic I
> mentioned in [1] (< NODE_MIN_SIZE). And if we had handled the memoryless
> node's zonelist correctly before, we wouldn't have had that panic at
> all.

Yes, this is another good example of how subtle the code is. Mike has
posted a patch that simply drops the NODE_MIN_SIZE constrain and I
believe that is the right thing to do at this stage. There is a non-zero
risk of regression but at least we will be forced to fix the original
problem properly or at least document is properly.

> > Currently we are just sacrificing some tiny performance for a
> > simplicity.
> Hmm, I don't think my modification complicates the code.
> 
> > > Secondly, from the perspective of semantic correctness, why do we remove
> > > the memoryless node from the fallback list of other normal nodes
> > > (N_MEMORY), but not from its own fallback list (PATCH[1/2])? Why should
> > > an upcoming memoryless node continue exist in the fallback list of
> > > itself and other normal nodes (PATCH[2/2])?
> > 
> > I am not sure I follow. What is the semantic correctness issue?
> 
> Sorry for the ambiguity, what I meant was that memoryless nodes should
> never have been built into any fallback list, not just for performance
> optimizations.

Well, I am not 100% sure I agree with you here. The performance would be
the only reason why to drop those nodes from zonelists. Other than that
zonelists are a useful abstraction for the node distance ordering. Even
if those nodes do not have any memory at all in principle there is no
big difference from depleted nodes.
-- 
Michal Hocko
SUSE Labs
