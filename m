Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4766E38F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjAQQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjAQQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:29:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C6218173
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673972962; x=1705508962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J25ZO4Fo+CyEJQWifu6vL4gf36afFOMMlBdBWdwNLd4=;
  b=A/8x6Y1STH0WOkopHf/w7L6me7GnGgcmz2FI4DHp9KCAfHMasuYLnoLB
   mjNpQW+pxtbv6OxR/eXW4MPeeIPZuP+yTKWx0nmW2MN8EwOEwKMWQgCkx
   kucv1AI33xmjZVPks4gfSwRNxp30S2DKOem6O4vFWJX5yFQ3Y0J1u1/4X
   kq+qPFHTx7CyOzXQ3BrfPZeD8QEAI2qJVcIYca3k+nBzNGvFaZ4+rDk27
   +9+dbIHUHZoG3/ud04iH0AeltH1EyWSC9Geni4cJcAHxksjlQy1V4gKL9
   nICGQEgHYaaQsdINS6apoPWuLB512Sm78B487jkIqGqldnlUKCU7qbKKz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410978100"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="410978100"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:29:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="833230990"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="833230990"
Received: from youli-mobl1.amr.corp.intel.com (HELO [10.255.228.205]) ([10.255.228.205])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:29:21 -0800
Message-ID: <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
Date:   Tue, 17 Jan 2023 08:29:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com> <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 08:12, Ashok Raj wrote:
> On Sun, Jan 15, 2023 at 08:05:14PM +0100, Borislav Petkov wrote:
>> On Mon, Jan 09, 2023 at 07:35:55AM -0800, Ashok Raj wrote:
>>> Currently when early microcode loading fails there is no way for the
>>> user to know that the update failed.
>> Of course there is - there's no early update message in dmesg.
> Sorry Boris, didn't comprehend. 
> 
> Without user making some additional steps to check the revision in the
> default location and the current rev reported to find the update failed.
> 
> Maybe that's what you meant.

I think a better changelog might help here.  The original was a bit too
absolute.  There is, as Boris pointed out, a way to tell if a failure
occurred.  But, that method is a bit unfriendly to our users.

--

When early microcode loading succeeds, the kernel prints a message via
print_ucode_info() that starts with 'early update:'.  If loading fails,
apply_microcode_early() returns before that message is printed.  This
means that users must know to go looking for that message.  They can
infer a early microcode loading failure if they do not see the message.

That's not great for users.  Instead of expecting them to infer this, be
more explicit about it.  Instead of bailing out and returning from
apply_microcode_early(), stash the error code off and plumb it down to
print_ucode_info().

This ensures that a message of some kind is printed on all early loads:
successes *and* failures.  This should make it easier for our hapless
users to figure out when a failure occurred.
