Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F372442B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbjFFNRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjFFNRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:17:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2B12F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686057472; x=1717593472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y9U03UbFJmeGdJSyWHL3e77sZWmfNJFmQ9rWfILYRNw=;
  b=YjqwvsNrGI89JxhOt6MaAly2KH3ZsIcj9bK1i07QpwGhFR/cR+Iwj6SN
   LLIo6RhrKFKj4MVttFAJEP4qzfSyjEClN5ZZ6JC60oq9nsmdV7xG2fPTM
   KhxAKawrQKlnFSqYMC6EbavYVACU6VymCfXbe6vUUXsb1rJrn2274sEmZ
   LodezFZtepMukwpKJgaaaPMoKunDb6JuqBQYbVNZO10jGAdwFp4mgFR7s
   Wpt29cllWPc0PrG4tCwwg36Gr25GxZUAm9eksyuWANWH8B6kpWHZgOahF
   fV4J8JHwKC1AMIymWwbOjhL+hnmzatmRXNPcDheELnXUsGgV/9KqOhMpP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359984921"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="359984921"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039168823"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="1039168823"
Received: from kumarr2-mobl1.amr.corp.intel.com (HELO [10.212.218.68]) ([10.212.218.68])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 06:10:24 -0700
Message-ID: <c84707e6-4f74-dc89-6243-63a72e86c62b@linux.intel.com>
Date:   Tue, 6 Jun 2023 06:10:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/tdx: Explicitly include <linux/errno.h> in
 <asm/tdx.h>
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <20230606034000.380270-1-kai.huang@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230606034000.380270-1-kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/23 8:40 PM, Kai Huang wrote:
> Currently, in <asm/tdx.h> tdx_kvm_hypercall() simply returns -ENODEV
> when TDX guest isn't enabled in the Kconfig w/o having <linux/errno.h>

Maybe you can explicitly say "CONFIG_INTEL_TDX_GUEST is not enabled"


> header explicitly included.  Although the current code doesn't have
> build error, in general it is a good practice to explicitly include the
> header to make sure any future patch which uses <asm/tdx.h> won't get
> build error due to error code not being defined.

Otherwise, it looks fine.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Fixes: cfb8ec7a31f2 ("x86/tdx: Wire up KVM hypercalls")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
>  arch/x86/include/asm/tdx.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 28d889c9aa16..0f303c9abee8 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -5,6 +5,7 @@
>  
>  #include <linux/init.h>
>  #include <linux/bits.h>
> +#include <linux/errno.h>
>  #include <asm/ptrace.h>
>  #include <asm/shared/tdx.h>
>  
> 
> base-commit: 122333d6bd229af279cdb35d1b874b71b3b9ccfb

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
