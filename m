Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63964C22D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiLNCM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiLNCMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:12:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7F21832
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670983972; x=1702519972;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmK/KU5tTbZX8ybLUypBojUhuMY9rkggoufgf9gLQOk=;
  b=HK10/Xl+qxBH/W8sUy+krIskNqeiDnBgmf/i67XpRGp0Z6GgBOQQerrl
   Y4j9PI/tY7q/5JtODCXBWq8uVDowI/9L2gVy5mqrJw838ykLovqd8otum
   fcHjddptXsBInHDjvcwcomneNU80IXYvJ551SWUJr7EOjeApPpszqBGYz
   peuoQWXqRedrGtW2/lpyozr8/uzE83v0Q4dd4qLafhbz+quSklZoDaNrb
   N7KTKEmuUMGxRhHrSK772yFMDBSqMMHAn9C+g3UoQ/ye1b67em0tNuoIs
   /nKYWKPOlMO58VY6prR0NPaz9V4u3xNO9/zoqpG1I63iTA43x1aK1QAgi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="404561370"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="404561370"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 18:12:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="894106998"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="894106998"
Received: from emanneba-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.199.244])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 18:12:51 -0800
Message-ID: <34d950e1e11dc91281adf3d2e8bb52645b4a7d6e.camel@linux.intel.com>
Subject: Re: thermal throttling on xps13: unchecked MSR access error
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Date:   Tue, 13 Dec 2022 18:12:51 -0800
In-Reply-To: <CAHk-=wgDEq2LYW6rnfQXmEOSfF8ECPkuwjJ3CR7aC4N2zuRLWQ@mail.gmail.com>
References: <CAHk-=wgDEq2LYW6rnfQXmEOSfF8ECPkuwjJ3CR7aC4N2zuRLWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry about the issue.

On Tue, 2022-12-13 at 16:35 -0800, Linus Torvalds wrote:
> Hmm.
> 
> I don't think I've seen this before on my trusty old x86 laptop (XPS
> 13 9380 - it's a few years old)
> 
>     unchecked MSR access error: WRMSR to 0x1b1
>       (tried to write 0x0000000004000aa8)
>       at rIP: 0xffffffff8b8559fe (throttle_active_work+0xbe/0x1b0)
> 
You got a (PROCHOT#) throttling event.
 
> I'm blaming one of
> 
>   930d06bf071a ("thermal: intel: Protect clearing of thermal status
> bits")
>   6fe1e64b6026 ("thermal: intel: Prevent accidental clearing of HFI
> status")
> 
This is to blame. I am able to reproduce on an old system.

I sent a patch " thermal: intel: Don't set HFI status bit to 1"

Please check.

Thanks,
Srinivas

> with no real reason apart from being the last commit to touch that
> function, but also when it started happening.
> 
> The first kernel I see this for is 6.1.0-03225-g764822972d64, but
> honestly, it's possible that it has happened before too, and the real
> issue is that the machine just happened to be hot and throttling at
> bootup and/or I just didn't notice.
> 
> The CPU in this thing is a
> 
>   Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz
> 
> which hopefully makes somebody go "Ahh, yes, I missed that case".
> 
> I don't *think* the MSR access checking has changed, but maybe it
> did,
> and I'm barking up the wrong tree.
> 
> Anybody?
> 
>                  Linus

