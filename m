Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90564C278
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiLNC64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiLNC6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:58:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D313F7F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670986733; x=1702522733;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ExjfdK4PVXcQs1nDQm/OvoUCmX5LNXAjOgYPOUopzVo=;
  b=AM7H6Ht1urGG4xkKzHQ6s3MtKyzG5i1AMSL+cKHnLMberSlvxQk7xWgl
   arK62jFTIrvzSjtlrPUu5N/R/gfHt370Q7zN/O7XzqL37Ba2fg5J3FDin
   getatZph1T+2G99qVsgwBM9PsziwpUB9+OKkh9ypdj6IH2RHbrpq3IqT6
   PVuFqbOBOGmbUh71A/oLz9XZysUhN/C+eznbsN1Aqpm+K3oR0OTLJtNrR
   6wSdEqptpKWN7lzTuqHY5oes0cibJIBJQtOfGEKcEx8yQRMueOia5AVJN
   tk498DpXGr1WKHmoN1Zd/XpJTocf24d8EZp/2GmX53Nu/CFmgnmhdAVS+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="315935589"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="315935589"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 18:58:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="791155668"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="791155668"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 18:58:48 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: memcg reclaim demotion wrt. isolation
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
Date:   Wed, 14 Dec 2022 10:57:52 +0800
In-Reply-To: <Y5idFucjKVbjatqc@dhcp22.suse.cz> (Michal Hocko's message of
        "Tue, 13 Dec 2022 16:41:10 +0100")
Message-ID: <87o7s6g09b.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> Hi,
> I have just noticed that that pages allocated for demotion targets
> includes __GFP_KSWAPD_RECLAIM (through GFP_NOWAIT). This is the case
> since the code has been introduced by 26aa2d199d6f ("mm/migrate: demote
> pages during reclaim").

IIUC, the issue was introduced by commit 3f1509c57b1b ("Revert
"mm/vmscan: never demote for memcg reclaim"").  Before that, we will not
demote for memcg reclaim.

> I suspect the intention is to trigger the aging on the fallback node
> and either drop or further demote oldest pages.
>
> This makes sense but I suspect that this wasn't intended also for
> memcg triggered reclaim. This would mean that a memory pressure in one
> hierarchy could trigger paging out pages of a different hierarchy if the
> demotion target is close to full.

It seems that it's unnecessary to wake up kswapd of demotion target node
in most cases.  Because we will try to reclaim on the demotion target
nodes in the loop of do_try_to_free_pages().  It may be better to loop
the zonelist in the reverse order.  Because the demotion targets are
usually located at the latter of the zonelist.

Best Regards,
Huang, Ying
