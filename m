Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC98D670D09
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjAQXQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAQXNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FEF301AD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673989248; x=1705525248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cqHJkJdGuPBVqZ0MII/dnJaUDPod5YB4Qm9m2ObDDQM=;
  b=HaPT6q4gOt7gUbXH3/bj/6RxiSNkF7rcQEMUTfn7SFkjC2mr8Gv99Wcb
   b/jF8MNE9HYrE4SHIiyKtjVX4x5es6zcX5Bfa86sjQpielx40iqA9IZP5
   YgA85G/JvKdjZsI7PfomfXr76fEQUZZGXncMRSoG4v+qPLziCFbHuvKLj
   0V6NACPFhClQ2U3TmtJJtDQ8VXqffpvyMm1fl9Brzbft8I9UA4T+UZkJe
   xJACuV5kerxoRjnwNXl1ZVd51R8orVw89338QNBbHEkZRkaQQctiYM3aF
   V9S6OhBt+aWxzIwklW3Ir/aSa8ukGJOL0HqSxqIHUR4s1RS5gFycCO+nr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="305191297"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="305191297"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 13:00:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="988277039"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="988277039"
Received: from youli-mobl1.amr.corp.intel.com (HELO [10.255.228.205]) ([10.255.228.205])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 13:00:46 -0800
Message-ID: <85249a7f-26a7-c20c-e5e5-5f85aaf611f6@intel.com>
Date:   Tue, 17 Jan 2023 13:00:54 -0800
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
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com> <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com> <Y8brnyIltcgtUvPn@zn.tnic>
 <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
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

On 1/17/23 12:40, Ashok Raj wrote:
> We just agreed to show both failed and success for late-load. Doing this is
> consistent with that isn't it?

Well, I kinda proposed that and you agreed.  I don't think Boris ever
agreed, though.
