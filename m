Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28AE723754
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjFFGMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjFFGMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:12:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75B100;
        Mon,  5 Jun 2023 23:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686031919; x=1717567919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tPf1ULSmRXozNF6yiEjZqf/EHNf60rj4pld8Wlm3LKo=;
  b=cuINT2FcbhOIUb7GQ28Myz4542Exd0nS40KNNI49T7TCEqCZfHoQcE8T
   7fyFpqVfGP9pxLRW+Sh9Zmwl197X8U5UUlPLP4rZJujelMFUvGaOOJkjg
   whV2eaJkSYi7DUn5REIfQH9yX6/Dy9pS2UfCzj/cxFxja+h5Qc9PxzN/h
   dsia0kJqBIyDQoouGQqz3Ow4F+JosND117+cIbdbJnPnKdqOmWlqi7zZB
   w9ROwTY2f5vsnIpUoLHEhMFkvABMl+inId3ea+POJv/qfBKby/M3DVRHk
   cYLJmSJ/iJeFdNHdfo6RNCRiLO+no8M4EISmMSbIPyi1Rjw9WvQwr00Hv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384882747"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="384882747"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 23:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="686399007"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="686399007"
Received: from kchmiele-mobl.ger.corp.intel.com (HELO [10.213.21.8]) ([10.213.21.8])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 23:11:55 -0700
Message-ID: <af008d38-3492-3df4-1c1e-95c1bf3102d2@intel.com>
Date:   Tue, 6 Jun 2023 08:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v9 0/4] drm/i915: use ref_tracker library for tracking
 wakerefs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        netdev@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Andi Shyti <andi.shyti@linux.intel.com>
References: <20230224-track_gt-v9-0-5b47a33f55d1@intel.com>
 <20230605153353.029a57ce@kernel.org>
Content-Language: en-US
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230605153353.029a57ce@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.06.2023 00:33, Jakub Kicinski wrote:
> On Fri, 02 Jun 2023 12:21:32 +0200 Andrzej Hajda wrote:
>> This is reviewed series of ref_tracker patches, ready to merge
>> via network tree, rebased on net-next/main.
>> i915 patches will be merged later via intel-gfx tree.
> FWIW I'll try to merge these on top of the -rc4 tag so
> with a bit of luck you should be able to cross merge cleanly
> into another -next tree.

Thanks.

Regards
Andrzej
