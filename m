Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5751621EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKHWJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKHWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:09:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6442181A;
        Tue,  8 Nov 2022 14:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667945374; x=1699481374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+e5d3T1Amm6CI8afHRVMBB4+sTNABVaD9rPm1dr5jE=;
  b=KeHEIkW0zIyozG10D0jSm7zwR9yL2vLbWLatdNukIFNdPKagimJ2Y4uZ
   gxi8IfQyRaH2vsSy+qMzA8BF56sPbuoBHklNjD5N/XTatzXMx36c2O9Ly
   YL7+Zl+sPHWtJ0+bs07E9J07/Rp3wGGVS1/gdtkYei1IIhTMfcQqKGRhO
   BbWwPh+ARlHJfphTdyQgcufPFnTE0XfnLmik8G/yNmVW3ntUi7A/PlmHF
   xSl12T4ZqnlIpzG+Sp8C5t2CZ/qHQHvU9adk+Ktc4kyC4gvWD/2wnREfr
   wRpE5XnzvLXLd5fYMyztEWbh+pva4Rrrj0gOigA5GYpEVfyENhOBAJEoV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="294192151"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="294192151"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:09:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881675674"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="881675674"
Received: from ehartman-mobl.amr.corp.intel.com (HELO desk) ([10.212.198.244])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:09:33 -0800
Date:   Tue, 8 Nov 2022 14:09:31 -0800
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
Subject: Re: [PATCH 3/3] x86/pm: Add enumeration check before spec MSRs
 save/restore setup
Message-ID: <20221108220931.3bavijj6adclj4sj@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <206cec042e17f15432d523d12ce6f5ae9267dc77.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <98ec85df-cbf8-83b7-df79-12ff379eae9b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <98ec85df-cbf8-83b7-df79-12ff379eae9b@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:40:06AM -0800, Dave Hansen wrote:
>On 9/12/22 16:41, Pawan Gupta wrote:
>> On an Intel Atom N2600 (and presumable other Cedar Trail models)
>> MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
>> by msr_build_context().
>
>This changelog needs some help.  Shouldn't it be something like this?
>
>pm_save_spec_msr() keeps a list of all the MSRs which _might_ need to be
>saved and restored at hibernate?? and resume??.  However, it has zero
>awareness of CPU support for these MSRs.  It mostly works by
>unconditionally attempting to manipulate these MSRs and relying on
>rdmsrl_safe() being able to handle a #GP on CPUs where the support is
>unavailable.
>
>However, it's possible for reads (RDMSR) to be supported for a given MSR
>while writes (WRMSR) are not.  In this case, msr_build_context() sees a
>successful read (RDMSR) and marks the MSR as 'valid'.  Then, later, a
>write (WRMSR) fails, producing a nasty (but harmless) error message.
>
>To fix this, add the corresponding X86_FEATURE bit for each MSR.  Avoid
>trying to manipulate the MSR when the feature bit is clear.  This
>required adding a X86_FEATURE bit for MSRs that do not have one already,
>but it's a small price to pay.

Yes, that's a lot better. Thanks.
