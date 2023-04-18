Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADC6E6B50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjDRRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDRRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:44:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA87AAC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681839874; x=1713375874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6qbNqbkC5sAe3IO2jo5u4p0ONmYkpo1JHbsKLgdse4=;
  b=edsTB8wfcgcXgaRRmJvnWkTamnW+oVD8najDca/uuelN2auOPPetBcY/
   RzJp66h5ob1Hoc3I+Hs/AIXs8744wmMI0pvSLEd4P4uS3i1QjIG83lzUE
   pnkDhcRNfKION0zc+SzR59Z1ZlqcIAgZLevTm7kafvkc2WWLH1fHaZWda
   uX0QewWIc83RwDbem8jL3prmzA1pb8PHYabBZShJkiBLTwlGzbaobGElF
   eEBH0IhHNtUZms2zHTYnHIcMFs48/ttaQnWuSWVJC7lIrbORxKhbRW1cW
   zen5jq6kkcvnWuNsGxrH/M7Qo5FSyEv2QMTUJQSTTmyyBKtraDqpo9CYt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410471698"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410471698"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="668650554"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="668650554"
Received: from ashfaqur-mobl1.ger.corp.intel.com (HELO intel.com) ([10.251.213.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:44:29 -0700
Date:   Tue, 18 Apr 2023 19:44:05 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniil Dulov <d.dulov@aladdin.ru>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        lvc-project@linuxtesting.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Oak Zeng <oak.zeng@intel.com>,
        Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix potential deallocation of previously
 deallocated memory.
Message-ID: <ZD7W5aaslOXLg707@ashyti-mobl2.lan>
References: <20230418065521.453001-1-d.dulov@aladdin.ru>
 <ZD5ZFoEk92MNQpqD@ashyti-mobl2.lan>
 <d41669a1-9e18-defb-d0cc-d43d7be7d23e@kernel.org>
 <ZD7MgL619KVYKeTV@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD7MgL619KVYKeTV@ashyti-mobl2.lan>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Daniil will you look into this?

and, because this is a bug fix, if you do want to send a real
fix, plase add to the commit message:

Fixes: d1f8f0d17d40 ("drm/amdkfd: Move non-sdma mqd allocation out of init_mqd")
Cc: Oak Zeng <oak.zeng@intel.com>
Cc: <stable@vger.kernel.org> # v5.3+

Andi

PS: please note that Oak's e-mail has changed.
