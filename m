Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637E9725CED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbjFGLUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbjFGLUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:20:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9C192
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686136802; x=1717672802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D++EtAsb67eCSEHqH4SO48A7/dF6fCd1ln+2Ij7tkKI=;
  b=RbU6C0YvbRgcq+HQYtXlnoL3YXuHYldzSXL+Tlk/o9weGNDofrNwd6A0
   YXqVLHuOXLGhDMfJbFHBMdUo0VmYvBnahMUlgMzjZM9HQai+qTEWRlxe8
   leieOuKBpudyWUICdHNQn3a8h+URURAWFxzNxJj4GUzbKD+SceIryw/p0
   vywld/pIuJdUutKnKZ8jCL/4waMncZ/4AklUEU9cmUtjBoNeKX3+rET1i
   AJK5RqNt8KJqjEuQOULP4X7ENPzdNuQsHB7EPCsU9PbXHm+jMrlK4Uj4A
   7OBMgBf5dFh9AJ9VRQNpiS5gicCkSawhI9PID1P7b7SCVha/7fg3lGCQP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385276545"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="385276545"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="712570491"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="712570491"
Received: from akuporos-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.211.72])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:20:00 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 34B2C10F0D2; Wed,  7 Jun 2023 14:19:57 +0300 (+03)
Date:   Wed, 7 Jun 2023 14:19:57 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, konrad.wilk@oracle.com,
        rostedt@goodmis.org, jpoimboe@kernel.org
Subject: Re: [PATCH] x86/kexec: Add a comment to relocate_kernel() for better
 readability
Message-ID: <20230607111957.sppocwpkhfb2e2vf@box.shutemov.name>
References: <20230607103910.407779-1-kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607103910.407779-1-kai.huang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:39:10PM +1200, Kai Huang wrote:
> The reason to save %rcx to %r11 before calling swap_pages isn't that
> obvious w/o looking into the swap_pages itself.  Add a comment to
> improve the readability.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..97deae3c5e6c 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -169,6 +169,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	wbinvd
>  1:
>  
> +	/*
> +	 * Save the preserve_context to %r11 as
> +	 * swap_pages clobbers %rcx.
> +	 */

Line split is not needed. It fits nicely under 80-characters.

+	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */

Otherwise, LGTM.

>  	movq	%rcx, %r11
>  	call	swap_pages
>  
> 
> base-commit: 409bf2895d71bb68bc5b8589036e5ed1ca30bada
> -- 
> 2.40.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
