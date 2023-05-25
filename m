Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC5711A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjEYXR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjEYXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:17:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA3E7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685056677; x=1716592677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VPWw9O82W/FBOm7sZpFMlL+/EB6gjl61BZ8UUpD5cUw=;
  b=AOLSd7MNuHYj1uZNgjrmcLcaIhSZdUq4DexbT+YHJWH4jNrcrvjni/Td
   YTPgPtYQWizQ69Lyd7GXLDNTbT26WDZZzQWjdS9yc4hwrUzv65Ce3su4u
   11BvtYVrflFe5Dn8utdR57KAaNWljuJC5k+ZHuHPsWeQS48uuTY0Um4MT
   PhC8iQMeQ73wwD/u4pYguu1do4iSmBL/LR3ROmKzJ5kmXzeEPGVQ/lige
   5nbRjVIDVJqS08wT8YIsvwRPVNMDe8J8Qy/fOH5TOPnEPk2FXy+zPjJYQ
   iahn0y0zpiuj0fYhLdOkY6GNZG4OaTRhvWqbyh4HYXyTCQCqVOuwy46AW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="419807902"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="419807902"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 16:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="817307267"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="817307267"
Received: from shuklaas-mobl1.amr.corp.intel.com (HELO [10.212.186.148]) ([10.212.186.148])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 16:17:55 -0700
Message-ID: <57e7b3df-5ca3-b400-d99a-a430bcc35a7a@intel.com>
Date:   Thu, 25 May 2023 16:17:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/head/64: Switch to KERNEL_CS as soon as new GDT is
 installed
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Joerg Roedel <jroedel@suse.de>
References: <6ff1f28af2829cc9aea357ebee285825f90a431f.1684340801.git.thomas.lendacky@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <6ff1f28af2829cc9aea357ebee285825f90a431f.1684340801.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 09:26, Tom Lendacky wrote:
> However, a recent patchset that looked to avoid using the legacy
> decompressor during an EFI boot exposed this bug. At entry to startup_64,
> the CS value is that of EFI and is not mapped in the new kernel GDT. So
> when a #VC exception occurs, the CS value used by IRETQ is not valid and
> the guest boot crashes.

This confused me a bit.  Nobody merged that patchset yet, right?  You
just happened across this issue when debugging a crash in that *other* set?

> Fix this issue by moving the block that switches to the KERNEL_CS value to
> be done immediately after returning from startup_64_setup_env().
> 
> Fixes: bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in boot")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Any thoughts on whether we want this in stable@?

I also wonder whether we need a comment in that little chunk of code
something along the lines of:

	/*
	 * Do not add anything which might take a fault or exception.
	 * IRET does not work here.
	 */

Michael, do you think you would have spotted something like this had it
been in the code when you were patching it?
