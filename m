Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F64F7282C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjFHOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbjFHOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:34:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE02D53;
        Thu,  8 Jun 2023 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686234860; x=1717770860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XxmivJGLgaCaH1WntFP9Euy9AMy9td0vUpD6mlwrIWU=;
  b=faAx3kZeM7Bc1PN1Gd3r1wwaWOutMgRsQkiczA6kkEcAs9HYVKLZ1Q1u
   WXy/J69GpJ5WUQBsxzVwpXxa/1K1WjjCj2vQcNoMVTIbN9R0NkQ1vDK8I
   q3w1PiIiC2b8z+w6EqN+nMlxpbIv5dc4YYiZThZoZRow721xKF7xAuF5S
   weSLDD5lDHlUYKzxDUrC7nub83RWBpsaHTRVl8+YFz4zCL2u4uBM1yYzo
   EdVN1DGx6t9jhUkRm3496vYX6eT1vWBqvn25ThSCYJ3SXN784nByY39Rg
   L3DiJkALF4/65gPdnpeZNfZV0S8rXRJcLDDIEXPpohFxnGPYHIboenLAT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="423188590"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="423188590"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 07:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="1040125134"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="1040125134"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2023 07:27:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q7GcA-002BKI-0n;
        Thu, 08 Jun 2023 17:27:50 +0300
Date:   Thu, 8 Jun 2023 17:27:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC PATCH 1/1] vsprintf: Warn on integer scanning overflows
Message-ID: <ZIHlZsPMZ2dI5/yG@smile.fi.intel.com>
References: <20230607223755.1610-1-richard@nod.at>
 <20230607223755.1610-2-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607223755.1610-2-richard@nod.at>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:37:55AM +0200, Richard Weinberger wrote:
> The scanf function family has no way to indicate overflows
> while scanning. As consequence users of these function have to make
> sure their input cannot cause an overflow.
> Since this is not always the case add WARN_ON_ONCE() guards to
> trigger a warning upon an overflow.

...

>  	if (prefix_chars < max_chars) {
>  		rv = _parse_integer_limit(cp, base, &result, max_chars - prefix_chars);
> +		WARN_ON_ONCE(rv & KSTRTOX_OVERFLOW);

This seems incorrect. simple_strto*() are okay to overflow. It's by design.

>  		/* FIXME */

...and that's why this one is here.

>  		cp += (rv & ~KSTRTOX_OVERFLOW);
>  	} else {


-- 
With Best Regards,
Andy Shevchenko


