Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1D5EF87E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiI2PRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiI2PRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:17:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA914F2B7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664464657; x=1696000657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XmiiWPRnuUVwiFQSk+HyHXdfQVUcXM170If6HYOLDE0=;
  b=NeNTBI/3nu5nXbIb1c9CvcfaPeietQeC34tDuJEiheYk0jyqqd7saZAd
   szoG3DSIHxUh7AD5EolfYMvwQYRE8th66cHJKh3SVYVZYslaohFzPYWH7
   0Tvx1OWb5uGo2/ZRdugVM72O1oCL16gVaVLtGnHzi6CAp59z30awlg8h6
   uDb914a9yFsNlYLpxB61kZbvdu5ngPWU7wZfrb1uXWws2n+sFpx8ehVLk
   mtIcGxlgiXO0MxtZszq89jisWlSe3ftgWyQdmJCwA1Url+dg4qez3PT1c
   13J45Qzm29cgl8RD8e6SUOogLLfdW1hhZjOSLaWwDqQPK2FKDSm8FIxpb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="281637682"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="281637682"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 08:17:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="600036427"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="600036427"
Received: from ticela-or-324.amr.corp.intel.com (HELO [10.251.13.128]) ([10.251.13.128])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 08:17:07 -0700
Message-ID: <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
Date:   Thu, 29 Sep 2022 08:17:07 -0700
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1c742ae1-98cb-a5c1-ba3f-5e79b8861f0b@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 07:57, Guilherme G. Piccoli wrote:
> On 28/09/2022 18:50, Dave Hansen wrote:
>> [...]
>> It boils down to either:
>>  * The misery is good and we keep it as-is, or
>>  * The misery is bad and we kill it
>>
>> My gut says we should keep the warnings and kill the misery.  The folks
>> who are going to be able to fix the issues are probably also the ones
>> looking at dmesg and don't need the extra hint from the misery.  The
>> folks running Windows games don't look at dmesg and just want to play
>> their game without misery.
>>
> Hi Dave, thanks for your response. I really appreciated your reasoning,
> and I think it's a good argument. In the end, adding misery would harm
> the users that are unlikely to be able to fix (or at least, fix quickly)
> the split lock situation, like games or legacy/proprietary code.
> 
> I have a revert removing the misery ready and tested, let me know if I
> should submit it.

I'm a bit of a late arrival to the split lock party, so I'm a bit
hesitant to merge any changes immediately.

How about we give it a few weeks and see if the current behavior impacts
anyone else?  Maybe the best route will be more clear then.
