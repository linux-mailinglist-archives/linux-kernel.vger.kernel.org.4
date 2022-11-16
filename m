Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F344262B6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiKPJoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKPJoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:44:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8DC35;
        Wed, 16 Nov 2022 01:44:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB0651F917;
        Wed, 16 Nov 2022 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668591855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bd1ed+hXkn5V0KAbqZOvNVfy2rS7WvVz5GEqvktKWWY=;
        b=X7MK3qsoKxTEpjWbFjE9xW0c2iyyPdjK7wws/FefVvJvW9CRT/hoRursX3YRl3h4gO/gln
        iWUy8RzwaPACPNE7Ka4m9J+lAieH4Z+Neuln6AnJPVivUFAoDvbEiBDBEAyHDtuKPtStIR
        VyMepZxN93/ysm6GILFefm67khV6+mU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAFE3134CE;
        Wed, 16 Nov 2022 09:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V5FhJ++wdGNKPQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 16 Nov 2022 09:44:15 +0000
Date:   Wed, 16 Nov 2022 10:44:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
Message-ID: <Y3Sw77bL/b6ePl3G@dhcp22.suse.cz>
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <87zgcrwfac.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0445de39-15a4-f645-b380-39f20abb6524@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0445de39-15a4-f645-b380-39f20abb6524@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-11-22 17:38:09, Zhongkun He wrote:
> Hi Ying, thanks for your replay and suggestions.
> 
> > 
> > I suggest to move the flags in "mode" parameter (MPOL_F_STATIC_NODES,
> > MPOL_F_RELATIVE_NODES, MPOL_F_NUMA_BALANCING, etc.) to "flags"
> > parameter, otherwise, why add it?
> 
> The "flags" is used for future extension if any, just like
> process_madvise() and set_mempolicy_home_node().
> Maybe it should be removed.

No, please! Even if there is no use for the flags now we are usually
terrible at predicting future and potential extensions. MPOL_F* is kinda
flags but for historical reasons it is a separate mode and we shouldn't
create a new confusion when this is treated differently for pidfd based
APIs.

> > And, how about add a "home_node" parameter?  I don't think that it's a
> > good idea to add another new syscall for pidfd_set_mempolicy_home_node()
> > in the future.

Why would this be a bad idea?

> Good idea, but "home_node" is used for vma policy, not task policy.
> It is possible to use it in pidfd_mbind() in the future.

I woould go with pidfd_set_mempolicy_home_node to counterpart an
existing syscall.

-- 
Michal Hocko
SUSE Labs
