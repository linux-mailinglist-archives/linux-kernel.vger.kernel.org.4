Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731A6B7BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCMPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCMPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:22:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6606A2D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678720957; x=1710256957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Oup9lHphb6RNEbDsaJr5a3idq6YXp47yyARYZ1q9tw=;
  b=GScsUu5hQ/B9HrCS2aiC8Hllr4ftOeU7GyXxikEer+fCfVlAD0jWgzb/
   XqPXu4kMX/elLcyUKhGwrft3OrVcdpC50bZzC2NrUCLmvaH++j198W9xX
   S/eZGQCvc0V1zRcrdvwp6xgXh2Ogl026pxuwwO4yNjEVpFiLEOK+R1gtS
   o1laWwV7358XpSXxfwjRWbICZeigUxwoLnSYdHdrLoKM/wpClw/r9Da11
   VD2XgfSHjIA4V8AsBtTIIHMzPbhZ6oVs8VSCJuUn3YPBIpiIiwgPOifQa
   yUmLpLw0/oFaUY35EUTFW7vW0oFnuOd82VsqPxttjr8Yh9GaeGmyt3jhq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334648698"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334648698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 08:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="1008019706"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="1008019706"
Received: from rahulmur-mobl3.amr.corp.intel.com (HELO [10.212.195.84]) ([10.212.195.84])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 08:22:32 -0700
Message-ID: <5e84fd48-459d-8850-d26f-860c6d34a9ad@intel.com>
Date:   Mon, 13 Mar 2023 08:22:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Content-Language: en-US
To:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, bigeasy@linutronix.de,
        yujie.liu@intel.com, shan.kang@intel.com
References: <20230311084824.2340-1-xin3.li@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230311084824.2340-1-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 00:48, Xin Li wrote:
>  #define GDT_ENTRY_ESPFIX_SS		26
>  #define GDT_ENTRY_PERCPU		27
> +#ifndef BUILD_VDSO32_64
>  #define GDT_ENTRY_CPUNODE		28
> +#else
> +#define GDT_ENTRY_CPUNODE		15
> +#endif

Isn't this kinda a hack?

First, it means that we'll now have two duplicate versions of this:

	#define GDT_ENTRY_CPUNODE		15

in the same file.

Second, if any other users of fake_32bit_build.h for the VDSO show up,
they'll need a similar #ifdef.

I think I'd much rather if we define all of the GDT_ENTRY_* macros in
*one* place, then make that *one* place depend on BUILD_VDSO32_64.

Also, about the *silent* failure...  Do we not have a selftest for this
somewhere?
