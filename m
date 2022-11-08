Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB585621ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKHWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKHWGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:06:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C451FFBA;
        Tue,  8 Nov 2022 14:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667945196; x=1699481196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqgDL/xn1/PN4O0PG4nRGxzUZ83zDyTOgC7cLxxyXro=;
  b=SDleToGnfpctdKq9RMjenhVvzTu4eK6o9PpZIGCXpGpdmmj3IY6a1XW8
   lSWtal+rzcwHhirC8jvqAOYGngTwciOsijuBqhjOmvOUCxRGCGOMGnXta
   dVZV2TxNIuOkTgxkJBdezxYXtD6+685BZNgz14sF6TH+//1Hzs1e3s0kE
   fT492NtnYha8GElXZpH9pCFHlLRNsQmRyGHzCiJ2hJIWMPjt5b+PW7gp7
   PGrWW3Z42BaaZlf2WhZ18lmqT8dGBjgcM9NMiam6ssAazBGqDdPTL0Pb5
   W/BY6rXkjzd9dKCPejH5hp3MmLwOOkZbnG4uAocohc/wNy+3zJwzXGO4D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="337552622"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="337552622"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:06:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881675147"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="881675147"
Received: from ehartman-mobl.amr.corp.intel.com (HELO desk) ([10.212.198.244])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:06:35 -0800
Date:   Tue, 8 Nov 2022 14:06:33 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 1/3] x86/tsx: Add feature bit for TSX control MSR support
Message-ID: <20221108220633.2vfazpun6bgiiglw@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <8592af5e3b95b197231445beb8c3123948ced15a.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <9eb8f395-c77f-a0bf-96b7-f1a3bb178c48@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9eb8f395-c77f-a0bf-96b7-f1a3bb178c48@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:27:56AM -0800, Dave Hansen wrote:
>On 9/12/22 16:39, Pawan Gupta wrote:
>> Support for TSX control MSR is enumerated in MSR_IA32_ARCH_CAPABILITIES.
>> This is different from how other CPU features are enumerated i.e. via
>> CPUID. Enumerating support for TSX control currently has an overhead of
>> reading the MSR every time which can be avoided.
>
>I only see tsx_ctrl_is_supported() getting called in three places:
>
>> 1 tsx.c tsx_clear_cpuid       138 } else if (tsx_ctrl_is_supported()) {
>> 2 tsx.c tsx_dev_mode_disable  161 if (!boot_cpu_has_bug(X86_BUG_TAA) || !tsx_ctrl_is_supported() ||
>> 3 tsx.c tsx_init              194 if (!tsx_ctrl_is_supported()) {
>
>Those all look like boot-time things to me.

Except tsx_clear_cpuid() could be called during S3 resume as part of
secondary CPU's init, but still its not too often.

>Why does the overhead matter?

This patch is mainly needed for patch 3/3 that relies on feature bits to
decide which MSRs to save/restore during suspend/resume.

I just gave a hint about it in the commit message:

     This will also be useful for any code that wants to use the feature bit
     instead of a calling tsx_ctrl_is_supported().

I will fix the commit message with this as the main reason for adding
the feature bit.
