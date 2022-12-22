Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187F165414E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiLVMr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLVMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:47:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9E22B;
        Thu, 22 Dec 2022 04:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671713272; x=1703249272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPM8RDFaM30ZmFrIb8CKMZ1JANhWUp662jbH45qLr6M=;
  b=U7Ti5gM7uX2hSBxzWafGGZSDBcDqjumI2csrgPUV3Gmaxw1BNaf3z8Ro
   FF6neieM8V/SA6HrQxhmet6cGsg8V1Pn4Ot+4KX3fglxDxDH1pnW3PVoK
   9YZRCSIZn28az1kCO6XUr5BdCTW0FvwIqD4SViceQ6X0gdg6zF7f5QLxR
   /Bo00h41XDF2crkrb9MNAQZgCN8wXjmgNq51blBh7KNfBIdJYH2/+Rvm3
   /zv4/jpzOePRSdt+y2oFm4ceGTgMmphSDzSce147uOX4vF6brBHpliEaY
   BbIViYm6PVSbzGpAKVyuCm0/IWoVcd4nQbwgISsWEK4Ox8GcXvIGwMOIB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="322031547"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="322031547"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 04:47:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="897213732"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="897213732"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 22 Dec 2022 04:47:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p8Kz8-00Duf4-1e;
        Thu, 22 Dec 2022 14:47:42 +0200
Date:   Thu, 22 Dec 2022 14:47:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 18/19] linux/include: add non-atomic version of xchg
Message-ID: <Y6RR7hPZUN22ytap@smile.fi.intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
 <20221222114635.1251934-19-andrzej.hajda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222114635.1251934-19-andrzej.hajda@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:46:34PM +0100, Andrzej Hajda wrote:
> The pattern of setting variable with new value and returning old
> one is very common in kernel. Usually atomicity of the operation
> is not required, so xchg seems to be suboptimal and confusing in
> such cases.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
>  include/linux/non-atomic/xchg.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/linux/non-atomic/xchg.h
> 
> diff --git a/include/linux/non-atomic/xchg.h b/include/linux/non-atomic/xchg.h
> new file mode 100644
> index 00000000000000..f7fa5dd746f37d
> --- /dev/null
> +++ b/include/linux/non-atomic/xchg.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_NON_ATOMIC_XCHG_H
> +#define _LINUX_NON_ATOMIC_XCHG_H
> +
> +/**
> + * __xchg - set variable pointed by @ptr to @val, return old value
> + * @ptr: pointer to affected variable
> + * @val: value to be written
> + *
> + * This is non-atomic variant of xchg.
> + */
> +#define __xchg(ptr, val) ({		\
> +	__auto_type __ptr = ptr;	\
> +	__auto_type __t = *__ptr;	\
> +	*__ptr = (val);			\
> +	__t;				\
> +})
> +
> +#endif
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


