Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF786F1C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346116AbjD1QTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbjD1QTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:19:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DE103
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682698781; x=1714234781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ZpQk9tAcoryWI38DUUiVvWpt7vJGjwLk5lCeWTJvIQ=;
  b=HIJh1f/YUFOJj0U2UP0E0I39hf+8MTzPkPZmadf7bAdMsUX4Uq+V25gB
   NlypIRdgWdli7+MJIgbIB5nZ/9FhaJomuWoi+Vflf5rHFwS+Kb0gJD4e1
   86G8NBqo6vFJsonybvZqX+E6MI66hOls29wAc8tTn2TPB7OPSH6ie6d5v
   Ebrti6WLtFMTvmLILG5yC/csk/k5TGyShjlcRHwKp4R2MyTLlGFKXhevL
   Gi7PpuuSRTvVuo53gu+ORm+3m1qo6W+o+CBif7axYAYgX2/JAnGSeKTYV
   WKf37uY0Q61j0SBckQx9JxvSl0+r2EmN5g8cTQdsJKcF6vX14sy+6lhsO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="349816322"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="349816322"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="819061759"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="819061759"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2023 09:19:38 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psQor-0000YB-1O;
        Fri, 28 Apr 2023 16:19:37 +0000
Date:   Sat, 29 Apr 2023 00:19:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <202304290057.wh62fc4w-lkp@intel.com>
References: <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 61d325dcbc05d8fef88110d35ef7776f3ac3f68b]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Down/printk-Do-not-delay-messages-which-aren-t-solicited-by-any-console/20230425-210828
base:   61d325dcbc05d8fef88110d35ef7776f3ac3f68b
patch link:    https://lore.kernel.org/r/4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris%40chrisdown.name
patch subject: [PATCH v5 2/2] printk: console: Support console-specific loglevels
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/c92f68c2bbfd8d7ff05785c20f0c2535861143c5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chris-Down/printk-Do-not-delay-messages-which-aren-t-solicited-by-any-console/20230425-210828
        git checkout c92f68c2bbfd8d7ff05785c20f0c2535861143c5
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304290057.wh62fc4w-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/printk/printk.c references a file that doesn't exist: Documentation/admin-guide/per-console-loglevel

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
