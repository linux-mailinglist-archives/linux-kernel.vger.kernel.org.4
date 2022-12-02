Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70C76408AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiLBOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiLBOqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:46:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081EBC2D3E;
        Fri,  2 Dec 2022 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669992366; x=1701528366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YeOXBTpcKW54/I4KLp5hnE2yhE4BreCqf9VS8FQha6M=;
  b=E0nDJXfCf4nCQJvL82Z+HOWykRiF95wt3KB1EcbgNCcP5B7DfpEsRxAv
   gnSI8pdMs0LML30b8SwMXXUBDfInq+LPm7dUt0iPQrfC9mZhvFWhsyWe8
   9Jak6qB8bX1XQw6vrnT++5uie1wnb8p6WQjICsM2nEa1jfa0DRQwXBvgT
   OGcMGBVM2gCtsN2nfUOclukKWHqClE85/aWTDDrEMPXkoKbjZxYbzWrws
   2skMn9Y+OCF+ma+4US3NIABpp7gckWj0jJ3B2cKlLgPe3uu14F/3ggB9b
   812v6R+JTgTeSeYfyXA4CSIbWtLoZSouG4Az1STMdPepm6tany/ZTa3Hu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303568477"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="303568477"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 06:46:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="675849501"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="675849501"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2022 06:46:02 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2B2Ek1m3018822;
        Fri, 2 Dec 2022 14:46:01 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 2/2] modpost: Include '.text.*' in TEXT_SECTIONS
Date:   Fri,  2 Dec 2022 15:44:46 +0100
Message-Id: <20221202144446.3395140-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129190123.872394-3-nathan@kernel.org>
References: <20221129190123.872394-1-nathan@kernel.org> <20221129190123.872394-3-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 29 Nov 2022 12:01:23 -0700

> Commit 6c730bfc894f ("modpost: handle -ffunction-sections") added
> ".text.*" to the OTHER_TEXT_SECTIONS macro to fix certain section
> mismatch warnings. Unfortunately, this makes it impossible for modpost
> to warn about section mismatchs with LTO, which implies
> '-ffunction-sections', as all functions are put in their own
> '.text.<func_name>' sections, which may still reference functions in
> sections they are not supposed to, such as __init.
> 
> Fix this by moving ".text.*" into TEXT_SECTIONS, so that configurations
> with '-ffunction-sections' will see warnings about mismatched sections.
> 
> Link: https://lore.kernel.org/Y39kI3MOtVI5BAnV@google.com/
> Reported-by: Vincent Donnefort <vdonnefort@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This revealed a couple issues in the FG-KASLR kernel. None of them
are false-positive although FG-KASLR doesn't merge text.* into one
section in the final vmlinux. Nice!

Reviewed-and-tested-by: Alexander Lobakin <alexandr.lobakin@intel.com>

> ---
>  scripts/mod/modpost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

[...]

> -- 
> 2.38.1

Thanks,
Olek
