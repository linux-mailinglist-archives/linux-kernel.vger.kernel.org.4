Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA064EEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiLPQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiLPQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:25:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5D12B614
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671207912; x=1702743912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nnzen4nLuLfiAJ4hqgajBtxg2nJbs/7T46mVUJK7HDs=;
  b=ZmQfsiPmrM+6aie8vIE3qtuqEJDzbZ/qVy8TjGY1SCSDYwEw9aztbdT/
   l7RJI9yLGl7nHQoZIA9rdzmXqiSEsUwZBxUSLE8gEzxh5I+OxQfov4akG
   6VUKyS2hJYk9AfmZcIh1z+2CS+H2RAj9qcixjumXEfrehaNligJHOA3y3
   J264h0cYJm7dsuS741JCSc5iiOyexH4DIPfbXjLkaEzzqm7NL4w+IE6wO
   5mlG1g25sLGZawMySJG8xkUI9Q39+87Qjsm1Ji/yiau9bi5E2uaYS0FJh
   B69o7G4D3Hqpq/3Uc3d/KS/FvfmXGbmcsNuH/9GgTZCKGlw7RDZmwMTgH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="405256504"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="405256504"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:25:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="978654497"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="978654497"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2022 08:25:10 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2BGGP9MD009227;
        Fri, 16 Dec 2022 16:25:09 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vmlinux.lds.h: add HEADERED_SECTION_* macros
Date:   Fri, 16 Dec 2022 17:25:00 +0100
Message-Id: <20221216162500.3023331-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117002022.860237-3-jim.cromie@gmail.com>
References: <Y20+PqtF+dFAe7hX@kroah.com> <20221117002022.860237-1-jim.cromie@gmail.com> <20221117002022.860237-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 16 Nov 2022 17:20:22 -0700

> These macros elaborate on BOUNDED_SECTION_(PRE|POST)_LABEL macros,
> prepending an optional KEEP(.gnu.linkonce##_sec_) reservation, and a
> linker-symbol to address it.
> 
> This allows a developer to define a header struct (which must fit with
> the section's base struct-type), and could contain:

[...]

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 85d5d5b203dc..a3b6aa30a525 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -214,6 +214,21 @@
>  
>  #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
>  
> +#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> +	_HDR_##_label_	= .;						\
> +	KEEP(*(.gnu.linkonce.##_sec_))					\
> +	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
> +
> +#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> +	_label_##_HDR_ = .;						\
> +	KEEP(*(.gnu.linkonce.##_sec_))					\
> +	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
> +
> +#define HEADERED_SECTION_BY(_sec_, _label_)				\
> +	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)

Now HEADERED_SECTION_PRE_LABEL() takes 5 arguments, but this line
passes only 4 to it. This went unnoticed probably due to that the
macro is not used anywhere, thus can't trigger a compiler error.
Would you prefer to fix it yourself or me to send the fix?[*]

> +
> +#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
> +
>  #ifdef CONFIG_TRACE_BRANCH_PROFILING
>  #define LIKELY_PROFILE()						\
>  	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)
> -- 
> 2.38.1

[*] If it needs fixing at all -- some people over the MLs say that
    if there's no trigger, then there's nothing to fix :clownface:

Thanks,
Olek
