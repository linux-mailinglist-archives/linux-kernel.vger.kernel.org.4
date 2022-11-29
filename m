Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC73D63C712
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiK2SRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiK2SRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:17:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F392AC5E;
        Tue, 29 Nov 2022 10:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669745832; x=1701281832;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j3q251Mal8lVh/DoJnMLHUehgxsWyNpXO8J1mcI96BY=;
  b=i4Ij+9GHqSVKo5IWyC/WuyNLwfLgGlZSC7JilsE4ai0kUFn0GUPbIvmD
   te+AQM4UNlvo9gZjWZrDI/eDgKLhmSF2HFKkhwchiw/y9V7CDPojxLSzQ
   9uyDox8er2nw/fjU2Y/MfpK76n1Gf4HyZWJTarcSWMG4Zy8M7gVfvF5c+
   FFIxGdTHQ+hjZ9lVijDoS0vuj2wUwGY6re+YEWQ+l6TE8MAZiHtMQ/MXT
   8UFzPjtgpKKtRQ9cfar0Bgi/C5Q4IqbEph0265LkcHfph6aYeN5vt2I7z
   qhqwHEYejfIw324gmmdFk9taQXHhL2zV5H+QWprnLJWisAYidWtKEyUZO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="315221077"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="315221077"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 10:17:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="972786562"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="972786562"
Received: from wteng-mobl1.gar.corp.intel.com (HELO [10.209.83.194]) ([10.209.83.194])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 10:16:59 -0800
Message-ID: <31b30c00-9de9-2881-53c3-b08804571d6c@intel.com>
Date:   Tue, 29 Nov 2022 10:16:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [tip: x86/fpu] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
Content-Language: en-US
To:     Ivan Zahariev <famzah@icdsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <20200512145444.15483-6-yu-cheng.yu@intel.com>
 <158964181793.17951.15480349640697746223.tip-bot2@tip-bot2>
 <CALCETrXfLbsrBX42Y094YLWTG=pqkrf+aSCLruCGzqnZ0Y=P-Q@mail.gmail.com>
 <10a553a5-699f-6921-705e-9afa1a8e42de@intel.com>
 <87y2c28zir.ffs@nanos.tec.linutronix.de>
 <ff5ad474-6d32-8bf8-e297-ed71a967d27c@icdsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ff5ad474-6d32-8bf8-e297-ed71a967d27c@icdsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 03:19, Ivan Zahariev wrote:
> Can you please take a look into this bug which syzbot tracked to a
> commit of yours (b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94). Even since
> we switched from kernel 4.14 to 5.15 we are experiencing often random
> segmentation faults with the following error in "dmesg":

Which kernel are you running, exactly?  There is a fix for the commit
that you identified:

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=484cea4f362e

but it should have been in 5.15.

Is there a chance you could test current mainline and see if the issue
is still there?
