Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7C621BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKHS3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKHS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:29:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6F2AE2;
        Tue,  8 Nov 2022 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932146; x=1699468146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pJxT5M9z/7O1GhSHzC1EnjXBsVZgl67H/7V8AvhcL0o=;
  b=RzSAjGcJF8tit26BUqmTPBu8+S7mNT/Ci3H54HYzaPOXmF7/ZA4NWVI3
   3kyhDc5Phw9grBeWynrg1w6wtqO4PSEqWbGh0Mm0MakFNNy4Bdj177C4L
   1jBrh4Z1QX6/JxOV6LV6dY4k3z9Wz6ZHZs//KgE07WPwHCVowSEBpQIYi
   v4DMGw6zRwwW9KQzUU/SjjjkqtikqtFf8++ZLG8llCcCEWv3F1WH82A2C
   tieLwCtjJW6Yu/V27eSJGL55T28WGx9rJNLPX8qGwUk2kyh+wvNqZURnb
   xyrW/FYm31AolGbM8yiSMWltE2ZdESr2sF5qoYMdg1apz6MLl7I29bE6S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="311928738"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="311928738"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:27:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="638890327"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="638890327"
Received: from vibhusha-mobl1.amr.corp.intel.com (HELO [10.252.133.56]) ([10.252.133.56])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:27:57 -0800
Message-ID: <9eb8f395-c77f-a0bf-96b7-f1a3bb178c48@intel.com>
Date:   Tue, 8 Nov 2022 10:27:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] x86/tsx: Add feature bit for TSX control MSR support
Content-Language: en-US
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <8592af5e3b95b197231445beb8c3123948ced15a.1663025154.git.pawan.kumar.gupta@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <8592af5e3b95b197231445beb8c3123948ced15a.1663025154.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 16:39, Pawan Gupta wrote:
> Support for TSX control MSR is enumerated in MSR_IA32_ARCH_CAPABILITIES.
> This is different from how other CPU features are enumerated i.e. via
> CPUID. Enumerating support for TSX control currently has an overhead of
> reading the MSR every time which can be avoided.

I only see tsx_ctrl_is_supported() getting called in three places:

> 1 tsx.c tsx_clear_cpuid       138 } else if (tsx_ctrl_is_supported()) {
> 2 tsx.c tsx_dev_mode_disable  161 if (!boot_cpu_has_bug(X86_BUG_TAA) || !tsx_ctrl_is_supported() ||
> 3 tsx.c tsx_init              194 if (!tsx_ctrl_is_supported()) {

Those all look like boot-time things to me.  Why does the overhead matter?
