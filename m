Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0AC6DFF80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDLUSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLUSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:18:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622FC5586
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:18:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0D4DB1F8AC;
        Wed, 12 Apr 2023 20:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681330716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mxn8DXo/4qyXdkUQU0wniedKr39aOTVft2br5abOQA0=;
        b=HXwGire4f1DXKtcn7Dbz3hF+AITbOEA3SjwhPrSm+dJHrGvV+eACP25CVquNtTAtYfXbYT
        lydX3e8DEqh7m6EIDFZEbXuCrL1aFjwbKzlL4nw4A13VtHg6YUj0WEVSJjLh0TbiWLlXgQ
        YgiwOYCYkESJCug4rViRniCHXJYdelg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBF1013498;
        Wed, 12 Apr 2023 20:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VKBjKxsSN2QSKAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Apr 2023 20:18:35 +0000
Date:   Wed, 12 Apr 2023 22:18:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
Message-ID: <ZDcSG2t3/sVuZc67@dhcp22.suse.cz>
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
 <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-04-23 13:13:02, Andrew Morton wrote:
> Lots of questions (ie, missing information!)
> 
> On Wed, 12 Apr 2023 19:59:39 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> 
> > HugeTLB pages have a struct page optimizations where struct pages for tail
> > pages are freed. However, when HugeTLB pages are destroyed, the memory for
> > struct pages (vmemmap) need to be allocated again.
> > 
> > Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
> > but given that this flag makes very little effort to actually reclaim
> > memory the returning of huge pages back to the system can be problem.
> 
> Are there any reports of this happening in the real world?
> 
> > Lets
> > use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> > reclaim without causing ooms, but at least it may perform a few retries,
> > and will fail only when there is genuinely little amount of unused memory
> > in the system.
> 
> If so, does this change help?
> 
> If the allocation attempt fails, what are the consequences?
> 
> What are the potential downsides to this change?  Why did we choose
> __GFP_NORETRY in the first place?
> 
> What happens if we try harder (eg, GFP_KERNEL)?

Mike was generous enough to make me remember
https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/.
GFP_KERNEL wouldn't make much difference becauset this is
__GFP_THISNODE. But I do agree that the changelog should go into more
details about why do we want to try harder now. I can imagine that
shrinking hugetlb pool by a large amount of hugetlb pages might become a
problem but is this really happening or is this a theoretical concern?

-- 
Michal Hocko
SUSE Labs
