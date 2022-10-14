Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F75FE872
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJNFgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJNFgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:36:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86115382C;
        Thu, 13 Oct 2022 22:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665725759; x=1697261759;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MeBC7KQ4dcNYATtjeUW+dgkheCC9dPXK13v3hKgdWqM=;
  b=TWWOg2EMBJ7TB1r1X01B04MI84FJ1Y7mk8pmYH01KYI+jE4qKM6kLKo4
   nTWCf4ca2cZpNW0G8C41Hsfm3Iuyi2B00vuIKXq9cio08+vDng5Z0Gdtx
   n9Cw0f7GB1gcGeu4SDW4LwatJR0aTG1/oZgfr7ZlU0K+HWLG1gBLz4uo+
   1FDMyxu2QlC+MSCejUQhge2dAbYSv6XEs/bggQozrF4dJD3zwiu/UI6hT
   mWEa8X+a+YCbxEVpX/G+ChVLqpVtZFUqiFrqpS4u+URteu4rYYY6qtrGF
   8XGlv2PuxQA73AlSVtu4MAduOaPqrJBXginlpkBvtaI+FjWFRQF4CC0eL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="305278971"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="305278971"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 22:35:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="622427768"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="622427768"
Received: from keweilu-mobl.ccr.corp.intel.com ([10.254.208.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 22:35:54 -0700
Message-ID: <9af8ebab471273cd7a6d0af147efdc430a61a2be.camel@intel.com>
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, corbet@lwn.net, fenghua.yu@intel.com,
        jdelvare@suse.com, linux@roeck-us.net, len.brown@intel.com
Date:   Fri, 14 Oct 2022 13:35:51 +0800
In-Reply-To: <147a619e-e595-90c5-7a2a-ffbc2d20be7c@intel.com>
References: <20220922133800.12918-1-rui.zhang@intel.com>
         <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
         <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
         <CAJvTdKkYTQzY1UsH_o2QdN1bS4gVfT87bEwMvgUXYwd+VFD+=w@mail.gmail.com>
         <668e5126-f344-c30b-a743-877b1783cec7@intel.com>
         <0307a5881c875e0b104051792b0f5e7f0ff973c1.camel@intel.com>
         <147a619e-e595-90c5-7a2a-ffbc2d20be7c@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-13 at 20:19 -0700, Dave Hansen wrote:
> On 10/13/22 19:06, Zhang Rui wrote:
> > Patch 4/8 ~ 5/8 are real fixes and they depends on patch 2/8 and
> > 3/8 to
> > avoid possible regressions. So patch 2/8 ~ 5/8 should be stable
> > material.
> > 
> > patch 6/8 is also a bugfix, but we have not observed any
> > functionality
> > issues so far.
> 
> If you want to make this really easy on me, you could take the
> changelog
> and comment revisions that I made in that testing branch that I
> shared,
> integrate them, and send it out again, and *only* include the
> bugfixes.

Sure, will do this and resend.

thanks,
rui

