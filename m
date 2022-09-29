Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8989C5EFA74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiI2Q1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiI2Q1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:27:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AF8149D16
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664468801; x=1696004801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Omj4s+TYR9HP2Mo9RreV0sozGn4K2bgnUI3UDLk6NsI=;
  b=dylUSpaF4v2UO6L7bNUeCTv4aFJc/knrk04/qGVB1N1svNo+oRiHD4MD
   2AwnUgA/i5QwJQh97u+/rwe/Mb6E+vkSo3GHZXHjNNHDTjrCSPfVpwAA+
   tuDCtSgRBe1EMitpPXtnj5xTEtgBVDq9tqCbLGJxku8SVyRw8D3C1m/3J
   VLmWbhFs7YptPPKRvYHMOyqfySv/YSyg4lrXVdQ+Z6N+UCZrT34HMFT2g
   eTTe/byIEWxfEHzFIHhUDFWin6TUcEsnTmjBILKwELHLq5zD6S7GhxqOK
   wchoSLsYyeWJLTYfPdRsuPG5Q5PaPx108xdzL3qv85rA6/Hq2XYILR/Xi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="289112364"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="289112364"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 09:26:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="867455516"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="867455516"
Received: from ticela-or-324.amr.corp.intel.com (HELO [10.251.13.128]) ([10.251.13.128])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 09:26:39 -0700
Message-ID: <ecbc58bc-a250-cf39-dea6-9b0b1c3e6503@intel.com>
Date:   Thu, 29 Sep 2022 09:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, tony.luck@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
 <1c742ae1-98cb-a5c1-ba3f-5e79b8861f0b@igalia.com>
 <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
 <7917fde2-a381-5404-c5ae-6ffd433f85ec@igalia.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <7917fde2-a381-5404-c5ae-6ffd433f85ec@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 08:30, Guilherme G. Piccoli wrote:
>> How about we give it a few weeks and see if the current behavior impacts
>> anyone else?  Maybe the best route will be more clear then.
> ...I disagree in just letting it fly for weeks with all players of God
> of War 2 running modern Intel chips unable to play in 5.19+ because of
> this change.

Let's be precise here, though.  It isn't that folks can't play.  It's
that we *intentionally* put something in place that kept them from
playing.  They can play just fine after disabling split lock detection.

> Certainly we have more games/applications that are impacted, I just 
> don't think we should wait on having 3 userspace breakages reported,
> for example, to take an action - why should gamers live with this for
> an arbitrary amount of time, until others report more issues?
They don't have to live with it.  They can turn it off.  That's why the
command-line disable is there.

The real question in my head is whether the misery is intentional or
not.  Is breaking games what folks _intended_ with
split_lock_detect=warn?  Or, is this a more severe penalty than we
expected and maybe we should back off for the default?
