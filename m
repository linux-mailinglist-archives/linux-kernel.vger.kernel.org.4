Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F7B748189
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjGEJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjGEJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:54:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68521731;
        Wed,  5 Jul 2023 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688550881; x=1720086881;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gZs5puT8XIu8UqezpunPVtrS+rhk5K8cygXvP7LrZZk=;
  b=KzkIdcMsKq9qUmvu0CKLJtUTtGPRo1+lbyeXzFojPjyjBKupy/oaWXl2
   NrMUW0ZEHZGLI2zU+e22stONqKof3dG2x11v7qNVeOLkqji5DJwLwjQXB
   nthWsNfHEmWgE+dMNxsVG3OKfYfo+qYJiEZfziNxPXXrRJJLcZJ/LniMK
   3vrrbxeGXo353pDgMAyb6CADod6SDldKJlUq1P8wnCZ2uT4uBLwyjzFEE
   1BivjxZ3KVJLvsjD0X43lSLhGo1vDIl54yUOIR6K5dhKpBSLWsri1oU5F
   jGR2oY4mvsidaV34OPeYuAtPcJFzlMxcNiw7358dvTs9zf/dNFN7UmRou
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="360774836"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="360774836"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 02:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="719166445"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="719166445"
Received: from unisar-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.23])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 02:54:37 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
        linux-kbuild@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: __diag_ignore_all(), GCC < 8, extra warnings, and -Werror
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date:   Wed, 05 Jul 2023 12:54:35 +0300
Message-ID: <87wmzezns4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For a long time now, i915 has enabled a bunch of W=1 style warnings
locally, and we try hard to keep i915 warning free.

One of the warnings is -Woverride-init from -Wextra. We need to bypass
that in a few cases, and used to do this for the relevant files:

	CFLAGS_file.o = $(call cc-disable-warning, override-init)

Recently, we switched from the above to a more localized version in each
file.c:

	__diag_push();
	__diag_ignore_all("-Woverride-init", "Allow overriding inherited members");
	...
        __diag_pop();

We now got a report that this fails the build with CONFIG_WERROR=y or
W=e when using GCC version < 8. Indeed, __diag_ignore_all() requires GCC
version 8 or later.

Should we now revert back to disabling -Woverride-init on a file
granularity? Should we consider breaking the build for CONFIG_WERROR=y
or W=e on older compilers a regression?

I'll note that with the current usage of __diag_ignore_all() elsewhere
in kernel, CONFIG_WERROR=y or W=e with W=1 will never pass on older
compilers. But then again, it has never passed on any compiler, so it
can't be a regression.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
