Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503FD64BF54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiLMW1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbiLMW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:26:54 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D262F0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670970409; x=1702506409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+0M8x5antrTH2ifdGS7p8lYXYju0a0wkVTDUblZnIpQ=;
  b=BCd4BZtk+W7/SUaU9qmJ9PRamVc6V0NXXuxV2FlG5fY6O/Az0F/Q7YXt
   3Th/PwfIgvwZgcUzuV+NalUo4vzgDYcdzrYB43Rhh6UAy9vqBVSuTC5ti
   qDob6CVagZfuAvfih0oLua5x2Wa0hAxX5VxM7wX3JdrjJtSnoP7wFSMNd
   b4zNeDGN9/tLFXxOsOWd0dBWix8k4VW1d3ooII8c4zmkf8j0eN+bKjUcq
   ScfDS8LizJBmUlG5DC0glwdPYbBv6rN8gB89SVmMPFdoweRdY/m132nwn
   R3ZeD+OYTlkNR9Tfxzfz8gqQWKXKyaTqW64z5DIcuSSwksIXbbwXqGqxr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="345320709"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="345320709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 14:26:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="791097910"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="791097910"
Received: from snjones-mobl1.amr.corp.intel.com (HELO [10.212.218.27]) ([10.212.218.27])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 14:26:43 -0800
Message-ID: <d2b75d22-0e13-95d3-4fb9-827f8cc15c89@intel.com>
Date:   Tue, 13 Dec 2022 14:26:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: memcg reclaim demotion wrt. isolation
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 07:41, Michal Hocko wrote:
> This makes sense but I suspect that this wasn't intended also for
> memcg triggered reclaim. This would mean that a memory pressure in one
> hierarchy could trigger paging out pages of a different hierarchy if the
> demotion target is close to full.
> 
> I haven't really checked at the current kswapd wake up checks but I
> suspect that kswapd would back off in most cases so this shouldn't
> really cause any big problems. But I guess it would be better to simply
> not wake kswapd up for the memcg reclaim. What do you think?

You're right that this wasn't really considering memcg-based reclaim.
The entire original idea was that demotion allocations should fail fast,
but it would be nice if they could kick kswapd so they would
*eventually* succeed and just just fail fast forever.

Before we go trying to patch anything, I'd be really interested what it
does in practice.  How much does it actually wake up kswapd?  Does
kswapd cause any collateral damage?

I don't have any fundamental objections to the patch, though.
