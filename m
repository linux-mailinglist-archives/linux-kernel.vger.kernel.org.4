Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF29D66E704
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjAQTcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjAQTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:21:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A12E5D129
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673980363; x=1705516363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N58e/v7loHKbImA92TI8pyQ0RszEtaQrbld3LocqpQk=;
  b=PhYEa+2gvy49IX1sQtOoRcZB9IgZM3yv/zk7vGjIwf5eP4x9aB0xn2+X
   mtQ5NNXbU3UkaeXoziJSXwvfzP6rz1zSdDO2Kfdx/cE9a9UTisjkqLOHY
   qSrmjtANw3mRe4v2qPn2vz222YrJUunCmu0Q5IKIF+P3ehMJI09/TK2OM
   WdogtXjOdOUjqaD6ZP85plAAH5j45I24c2z1UbIw2vE83qhiJzc7SlHa/
   TvYaMPXnIg80rp1Y4E3zJyxlfUrjm5DlnxDSy2MEK+myD2VXtW5PrePdD
   RTp5GJYETJ985vbuKEQDKDMUxLA3ZA9SdCo0b/RxUGlzZ9B1yL/WTBahQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="389278014"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="389278014"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:32:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="636956882"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="636956882"
Received: from youli-mobl1.amr.corp.intel.com (HELO [10.255.228.205]) ([10.255.228.205])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:32:41 -0800
Message-ID: <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
Date:   Tue, 17 Jan 2023 10:32:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com> <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com> <Y8bnEgP6iXCL+QmX@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y8bnEgP6iXCL+QmX@zn.tnic>
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

On 1/17/23 10:21, Borislav Petkov wrote:
> On Tue, Jan 17, 2023 at 08:29:28AM -0800, Dave Hansen wrote:
>> This ensures that a message of some kind is printed on all early loads:
>> successes *and* failures.  This should make it easier for our hapless
>> users to figure out when a failure occurred.
> I'm still not convinced. When something doesn't happen in the kernel, we don't
> always say "It didn't happen". We don't say anything.

Well, we have an awful lot of pr_warn()'s in the kernel that talk about
something that was tried and failed.

> So I don't like all those talkative drivers for no good reason. If there wasn't
> an update message, then no update happened. That's it.

I actually kinda like the inverse.

The common (boring) case where an update was needed and was successful.
It's the one we don't need to tell users about at all.  It barely
deserves a message.  Users expect that if there's an early update
available, it'll get attempted, it will be successful and the kernel
won't say much.

The time we need to spam dmesg is when something upends user
expectations and they might need to go do something.  An early loading
failure is exactly the place where they want to know.  They want to know
if they're running with known CPU bugs that would have been fixed by the
early update, or if they somehow have a botched early loading image.

So, if I had to pick either:

 * Print on failure
or
 * Print on success

I'd pick failure.  But, considering that we're already printing on
success, I'm OK doing both.
