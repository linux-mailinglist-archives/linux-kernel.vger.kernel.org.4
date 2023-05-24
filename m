Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFB70F66E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjEXMap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEXMan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:30:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67D99
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:30:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75A0722207;
        Wed, 24 May 2023 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684931440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dtqj2Y7bITU/eAH7KTmViAOMma17b5fIdPwVyyaIEw=;
        b=dMxcxuAcAL3GRLFP6ZIzOmFZboR+KmnvzQ4xXKlv6stzCbf54wDAvfK64d1QJJBHAMiHtn
        MvaUbiIE8ATHXYNrfIWwHWdf4gQYcctqAhWrPDJt6PAkkBJPv+Lg3cG3Pq+WX6lqWp7f7e
        ud8FaC872BYkAtxNOmhJXuZAKjTHseI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 559D813425;
        Wed, 24 May 2023 12:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pGDLEnADbmT2aAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 24 May 2023 12:30:40 +0000
Date:   Wed, 24 May 2023 14:30:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
Message-ID: <ZG4Db1QSE1LZXEEP@dhcp22.suse.cz>
References: <20230511065607.37407-1-ying.huang@intel.com>
 <ZF0ET82ajDbFrIw/@dhcp22.suse.cz>
 <87r0rm8die.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZGIUEqhSydAdvRFN@dhcp22.suse.cz>
 <87jzx87h1d.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <3d77ca46-6256-7996-b0f5-67c414d2a8dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d77ca46-6256-7996-b0f5-67c414d2a8dc@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for late reply, conferencing last 2 weeks and now catching up]

On Tue 16-05-23 12:30:21, David Hildenbrand wrote:
[...]
> > And auto-tuning doesn't sound easy.  Do you have some idea of how to do
> > that?
> 
> If we could avoid instantiating more zones and rather improve existing
> mechanisms (PCP), that would be much more preferred IMHO. I'm sure it's not
> easy, but that shouldn't stop us from trying ;)

Absolutely agreed. Increasing the zone number sounds like a hack to me
TBH. It seems like an easier way but it allows more subtle problems
later on. E.g. hard to predict per-zone memory consumption and memory
reclaim disbalances.
-- 
Michal Hocko
SUSE Labs
