Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D564C644
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiLNJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbiLNJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:49:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9584FFCF3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:49:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 401F3220CD;
        Wed, 14 Dec 2022 09:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671011374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pHdWVKfeYZq6y/WmzLIRqkeKhdSpQQ7ZcE8kCD7Cabo=;
        b=WINsMeISNalOR9upZ+0zhqD+eZzA+K5UzPcgXbfrec5WJLpmu6F33xROuLt1RRVcU17Dm3
        XTLFJYVUZUPLWiGEFqHd6gf9kKA1i7QH2ouzh1B322Vn3xwNwLEcq8IjWKSbP1inLxoEX0
        wOklHx1ozM3ahD0HytipguTpTcVjw0M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2082E138F6;
        Wed, 14 Dec 2022 09:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vlxCBS6cmWPOCwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 14 Dec 2022 09:49:34 +0000
Date:   Wed, 14 Dec 2022 10:49:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: memcg reclaim demotion wrt. isolation
Message-ID: <Y5mcLdBioMG+G9WS@dhcp22.suse.cz>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
 <87o7s6g09b.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7s6g09b.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-12-22 10:57:52, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
[...]
> > This makes sense but I suspect that this wasn't intended also for
> > memcg triggered reclaim. This would mean that a memory pressure in one
> > hierarchy could trigger paging out pages of a different hierarchy if the
> > demotion target is close to full.
> 
> It seems that it's unnecessary to wake up kswapd of demotion target node
> in most cases.  Because we will try to reclaim on the demotion target
> nodes in the loop of do_try_to_free_pages().  It may be better to loop
> the zonelist in the reverse order.  Because the demotion targets are
> usually located at the latter of the zonelist.

Reclaiming from demotion targets first would deal with that as well.
Thanks! Let's establish whether this is something we really need/want
fix first.
-- 
Michal Hocko
SUSE Labs
