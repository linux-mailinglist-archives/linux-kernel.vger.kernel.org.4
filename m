Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB31D6DDC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDKNi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDKNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:38:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D419AB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:38:51 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="327715774"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="327715774"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="691148175"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="691148175"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2023 06:38:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pmECN-00FHXp-0Z;
        Tue, 11 Apr 2023 16:38:15 +0300
Date:   Tue, 11 Apr 2023 16:38:14 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [RFC PATCH] checkpatch: Support __initconst combined with struct
 definition
Message-ID: <ZDVixjH5qLoy1jTW@smile.fi.intel.com>
References: <20230301094320.15954-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301094320.15954-1-bjorn@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=1.0 required=5.0 tests=SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 10:43:20AM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Checkpatch sometimes report a false positive for __initconst. E.g., for the
> following snippet:
> 
>  | static const struct strspn_test {
>  | 	const char str[16];
>  | 	const char accept[16];
>  | 	const char reject[16];
>  | 	unsigned a;
>  | 	unsigned r;
>  | } tests[] __initconst = {
>  | 	{ "foobar", "", "", 0, 6 },
>  | 	{ "abba", "abc", "ABBA", 4, 4 },
>  | 	{ "abba", "a", "b", 1, 1 },
>  | 	{ "", "abc", "abc", 0, 0},
>  | };
> 
> checkpatch would report:
> 
>  | ERROR: Use of __initconst requires a separate use of const
>  | #190: FILE: ./test_string.c:190:
>  | +	} tests[] __initconst = {
> 
> Improve the reporting by trying harder to find the 'const'.

Joe, what do you think about this?

-- 
With Best Regards,
Andy Shevchenko


