Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3283D64C634
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiLNJpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbiLNJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:45:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039EA55BD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:45:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E287220E9;
        Wed, 14 Dec 2022 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671011102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSHBBGLgxRKBQUkS4kyHoe7XeZEUdZOiGeNsPiE4bYM=;
        b=vKKFHJq2c/Q7tXmESWMSFdTZWgMsaREN3rPU1/qtK1r2uP3W4HX8cQ09/MNpje5UWowhE9
        hbfwXukmB0NKFDLqfUQBBxDyvnx46LEhdhcZ6aH7QqdeKqIpkvWt+hKLHdxUHhdpj8IExt
        pnw0Yg7LSpqBvw95RjF6Al4D0guaYws=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72EB6138F6;
        Wed, 14 Dec 2022 09:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /pYyGR6bmWNVCQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 14 Dec 2022 09:45:02 +0000
Date:   Wed, 14 Dec 2022 10:45:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
Message-ID: <Y5mbHQSKuXY1Qojk@dhcp22.suse.cz>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
 <d2b75d22-0e13-95d3-4fb9-827f8cc15c89@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b75d22-0e13-95d3-4fb9-827f8cc15c89@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-12-22 14:26:42, Dave Hansen wrote:
> On 12/13/22 07:41, Michal Hocko wrote:
> > This makes sense but I suspect that this wasn't intended also for
> > memcg triggered reclaim. This would mean that a memory pressure in one
> > hierarchy could trigger paging out pages of a different hierarchy if the
> > demotion target is close to full.
> > 
> > I haven't really checked at the current kswapd wake up checks but I
> > suspect that kswapd would back off in most cases so this shouldn't
> > really cause any big problems. But I guess it would be better to simply
> > not wake kswapd up for the memcg reclaim. What do you think?
> 
> You're right that this wasn't really considering memcg-based reclaim.
> The entire original idea was that demotion allocations should fail fast,
> but it would be nice if they could kick kswapd so they would
> *eventually* succeed and just just fail fast forever.
> 
> Before we go trying to patch anything, I'd be really interested what it
> does in practice.  How much does it actually wake up kswapd?  Does
> kswapd cause any collateral damage?

I haven't seen any real problem so far. I was just trying to wrap my
head around consenquences of discussed memory.demote memcg interface
[1]. See my reply to Johannes about specific concerns.

[1] http://lkml.kernel.org/r/87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com
-- 
Michal Hocko
SUSE Labs
