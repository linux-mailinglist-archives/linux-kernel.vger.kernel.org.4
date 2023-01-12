Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED506667E4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjALAiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjALAhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:37:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A021321B5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673483838; x=1705019838;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uvTtI0+JLwbZwSZxGjTtYzW69JAatAaXwTfluvqaRes=;
  b=cmWvtN0G5KK4gkvI+rt60lE9WxRIsmuMFo5zutFS+fC/7yG7CiaggPEM
   WM1n/lY0jJS9rJzi0XqnFDLyHSjh/7MR8bz2JbgTvhvvERVp3ttVx1vkv
   +sS/3ObkXlq3xZ9BzB38rc99CtojgXALyfZLQr0YybN0r7dAUTrP6oS3u
   /kBvo4GSt+TeJcCisUUPE9PNoVvcAO3Xe48Zfm/bdxmTF7ddQ5MhOOhip
   CDgrJihwlPIFHCdpfi+OF8O6scyduZtpYiXH4nzgNS+ehBVQCRafE1RcT
   Nw5AFZgj0OOjBketXKYJJfe972WBKsmy6PwneXnzNsGwxEarEAeRzFhoq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="388044178"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="388044178"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:37:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="650928855"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="650928855"
Received: from pchoi7-mobl1.amr.corp.intel.com (HELO [10.212.194.225]) ([10.212.194.225])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:37:17 -0800
Message-ID: <b9e73d06-bd95-7c54-3ff1-f9e43c9967a4@intel.com>
Date:   Wed, 11 Jan 2023 16:37:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Content-Language: en-US
To:     "Chen, Yian" <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
 <ad2da884-c8c8-bc57-e21f-452a08cb10cc@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ad2da884-c8c8-bc57-e21f-452a08cb10cc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 16:27, Chen, Yian wrote:
>> It seems we are implicitly relying on the on stac() and clac()
>> calls that are added for SMAP. Have you tried running with SMAP
>> disabled i.e "clearcpuid=smap"?
>> 
> Yes, I tested with clearcpuid=smap.
It works by accident, then.

clearcpuid=smap means that the kernel should be running as if
CPUID.(EAX=07H,ECX=0H):EBX.SMAP[bit 20]==0.  STAC/CLAC should #UD in
that case.

The only reason that it happens to work is that STAC/CLAC apparently
actually continue to work even if CR4.SMAP==0.

I'm actually a _bit_ surprised by this, but I bet there's a good reason
for it.

In any case, please just make LASS dependent on SMAP.  It's the right
thing to do on several levels.
