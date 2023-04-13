Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87E36E13ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDMSMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:12:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437009029
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:12:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD6291F45B;
        Thu, 13 Apr 2023 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681409537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvIUkicyd0SkqaB5uD6BHKFL2IXzKJbP500i8yNOqIo=;
        b=dUP4R9a/iS19V1cWqjLT2hvSSgdv457l3zqZYdcCb6eClfJbCbjkWpp3Ja4pkMRKOToTo3
        Yl+7+KMHwMc5mVkBJapeyR4CU7367nUelGOb1fW2173KkR06CqNL8Qt20Sy3j+B5MRz2fX
        txrfeXbE1KhZZrGOtaZ8HNLgyH7mGtQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC87F13421;
        Thu, 13 Apr 2023 18:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6IywKwFGOGQrKQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 13 Apr 2023 18:12:17 +0000
Date:   Thu, 13 Apr 2023 20:12:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
Message-ID: <ZDhGADdnbIAqdlrg@dhcp22.suse.cz>
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
 <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
 <ZDcSG2t3/sVuZc67@dhcp22.suse.cz>
 <CA+CK2bCZEKsocuwN4Na1+YyviERztGdGDoQgWhxQF-9WxVVW5Q@mail.gmail.com>
 <ZDge+eM67WzVzB9V@dhcp22.suse.cz>
 <CA+CK2bDCKUDJu+Vx1PF9hsBGzbrN05fkyw7AHAKd0YYfTkhp5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDCKUDJu+Vx1PF9hsBGzbrN05fkyw7AHAKd0YYfTkhp5g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-04-23 13:11:39, Pavel Tatashin wrote:
> On Thu, Apr 13, 2023 at 11:25 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 13-04-23 11:05:20, Pavel Tatashin wrote:
[...]
> > > This is a theoretical concern. Freeing a 1G page requires 16M of free
> > > memory. A machine might need to be reconfigured from one task to
> > > another, and release a large number of 1G pages back to the system if
> > > allocating 16M fails, the release won't work.
> >
> > This is really an important "detail" changelog should mention. While I
> > am not really against that change I would much rather see that as a
> > result of a real world fix rather than a theoretical concern. Mostly
> > because a real life scenario would allow us to test the
> > __GFP_RETRY_MAYFAIL effectivness. As that request might fail as well we
> > just end up with a theoretical fix for a theoretical problem. Something
> > that is easy to introduce but much harder to get rid of should we ever
> > need to change __GFP_RETRY_MAYFAIL implementation for example.
> 
> I will add this to changelog in v3. If  __GFP_RETRY_MAYFAIL is
> ineffective we will receive feedback once someone hits this problem.

I do not remember anybody hitting this with the current __GFP_NORETRY.
So arguably there is nothing to be fixed ATM.

> Otherwise, we will never hear about it. I think overall it is safer to
> keep this code with __GFP_RETRY_MAYFAIL flag.
> 
> >
> > > In an ideal scenario we should guarantee that this never fails: that
> > > we always can free HugeTLB pages back to the system. At the very least
> > > we could steal the memory for vmemmap from the page that is being
> > > released.
> >
> > Yes, this really bothered me when the concept was introduced initially.
> > I am always concerned when you need to allocate in order to free memory.
> > Practically speaking we haven't heard about bug reports so maybe this is
> > not such a big deal as I thought.
> 
> I suspect this is because at the moment it is not that frequent when a
> machine is reconfigured from having a lot of HugeTLB based workload to
> non-HugeTLB workload.

Yes, hugetlb workloads tend to be pretty static from my experience.
-- 
Michal Hocko
SUSE Labs
