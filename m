Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB262472B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiKJQiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiKJQgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:36:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9183F057;
        Thu, 10 Nov 2022 08:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668098212; x=1699634212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0nehVTwI3rF9wE0y2jLW9Y42uRXunpJ9jpEkFCIDdY=;
  b=NEH0esm5u3215OLuRGYZ3Sr71BeHYL+QvS0D6iRoEDhiFZ8NG9CnGe3H
   5oRK6UeYGWs6RJcw861dCIDzCet328Sqyg3LmvVHex1aHOQmaCCu63Xpe
   ziIhJMXtl05JvCD0w7vc2XwlsXQlsaKJ4Mmx9sbMqNw4XnEjsYAbotj52
   h/HCP6sRnsoTAPhbbAsG4v6CWsqBfaYFRiCHMEhCumI+RC1xfa2q35RrJ
   5zUYpqAa8GXjPk8IhMQkIjgYpfaThIn/WcVQSP5lCFQEotkgdVdjV2Ht2
   di+3j6L5QQZ4D2tlTBt116hkFWnJRt/RJp8qiY6SWuJv8LRKhJOUuxqOa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310074307"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="310074307"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 08:36:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="726447052"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="726447052"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 08:36:22 -0800
Date:   Thu, 10 Nov 2022 08:36:20 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Andre Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH V3] x86/split_lock: Add sysctl to control the misery mode
Message-ID: <Y20ohNc3xGtCd0Bj@agluck-desk3.sc.intel.com>
References: <20221024200254.635256-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024200254.635256-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 05:02:54PM -0300, Guilherme G. Piccoli wrote:
> Commit b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
> changed the way the split lock detector works when in "warn" mode;
> basically, not only it shows the warn message, but also intentionally
> introduces a slowdown (through sleeping plus serialization mechanism)
> on such task. Based on discussions in [0], seems the warning alone
> wasn't enough motivation for userspace developers to fix their
> applications.
> 
> Happens that originally the proposal in [0] was to add a new mode
> which would warns + slowdown the "split locking" task, keeping the
> old warn mode untouched. In the end, that idea was discarded and
> the regular/default "warn" mode now slowdowns the applications. This
> is quite aggressive with regards proprietary/legacy programs that
> basically are unable to properly run in kernel with this change.
> While it is understandable that a malicious application could DoS
> by split locking, it seems unacceptable to regress old/proprietary
> userspace programs through a default configuration that previously
> worked. An example of such breakage was reported in [1].
> 
> So let's add a sysctl to allow controlling the "misery mode" behavior,
> as per Thomas suggestion on [2]. This way, users running legacy and/or
> proprietary software are allowed to still execute them with a decent
> performance while still observe the warning messages on kernel log.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony
