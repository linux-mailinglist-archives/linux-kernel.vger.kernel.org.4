Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCADB5B4D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIKKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIKKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:31:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC53BC7A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662892289; x=1694428289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=55mhbOuv9VSmK0zVkWFv2UkRhlG7d+Yu5JeYFMu/0n0=;
  b=AHc8p6mQUdchTzzTAfDxGzFiMwnQEBGAtju/8MQAClqry48LxBiu+kxc
   7ZuxtO1VhJIhn4k7cf+3GkYVS0WA0qirs8U3yTwmDuslID+99yTVqn6YU
   2vcM++Y3ZZgWskyDZ43eQ29Maxv2v2WyNGUANXRGEr2ysTlGn16t7s6Wu
   wcolGuIJZWg6MOsewhsQ8LTQMRNhc2r5TDtjA+xggQXqK8eET4xiMb9kQ
   ZRhGTa/x6j2WQD7m2Cm2zjubK/zDqhewwsFWCyLXYVY5OaEE2m6BX6tyH
   9GmgJ5P33Tp3fFUvOjMHx/ftmk+sXMaZXky4AqDEKDBY74X/WxtmfktMn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="295296519"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="295296519"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 03:31:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="677741240"
Received: from dasegal-mobl.amr.corp.intel.com (HELO intel.com) ([10.249.46.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 03:31:25 -0700
Date:   Sun, 11 Sep 2022 12:31:21 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        keescook@chromium.org, mauro.chehab@linux.intel.com,
        linux@rasmusvillemoes.dk, vitor@massaru.org, dlatypov@google.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v10 1/9] overflow: Allow mixed type arguments
Message-ID: <Yx24+WqhMcM8Zyc6@alfio.lan>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
 <20220909105913.752049-2-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909105913.752049-2-gwan-gyeong.mun@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Sep 09, 2022 at 07:59:05PM +0900, Gwan-gyeong Mun wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> When the check_[op]_overflow() helpers were introduced, all arguments were
> required to be the same type to make the fallback macros simpler. However,
> now that the fallback macros have been removed[1], it is fine to allow
> mixed types, which makes using the helpers much more useful, as they
> can be used to test for type-based overflows (e.g. adding two large ints
> but storing into a u8), as would be handy in the drm core[2].
> 
> Remove the restriction, and add additional self-tests that exercise some
> of the mixed-type overflow cases, and double-check for accidental macro
> side-effects.

I would split in two different patches the check_[op]_overflow()
helpers with the tests.

Overall they look good though.

> [1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
> [2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com
> 
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Gwan-gyeong, can you please add your SoB here? And you don't need
to 'Cc:' yourself.

Andi
