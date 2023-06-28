Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9B74164A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjF1QYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:24:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:59533 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231537AbjF1QYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687969484; x=1719505484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eTlpY6oRYUtQFRez87pCwiAALo1ql9cjRbAJSgFjALI=;
  b=VefjteyeXTAuWyTpRxwaNOaR4rwHRkOrGtCRjDrUnQDQQSzMrcQv2OVH
   gZDPWyDfxwNU+6Qg6GulAsRB9aXNfaLOvEeR0BWlAFxWsn9lFwSJzgiUj
   Hus+6QU7iZAUhk8OkBdy/Murnsitwf+R39fR3tqKY5ZQGFf5KYfcief0F
   83oFe8HhUss2oVwXpW4j+VofR10WmCWFJQyFO0/FKZptwUQiwoARgwQyt
   /5HBPEKOGnIwM0h8PQ8xApb1HUw/Nq7aou6feza3tFQWo/2SwWAyNQPSJ
   LAOJxtomv59oXF7/FWLbW4t8+8h8NKEoaWks8WROREBjQJHyULIlnG9Om
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="351683549"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351683549"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 09:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="711094924"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="711094924"
Received: from atkalcec-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.40.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 09:23:31 -0700
Date:   Wed, 28 Jun 2023 18:23:29 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: mark __arch_xchg() as __always_inline
Message-ID: <ZJxegS0m6QIyE4h5@ashyti-mobl2.lan>
References: <20230628094938.2318171-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628094938.2318171-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> An otherwise correct change to the atomic operations uncovered an
> existing bug in the sparc __arch_xchg() function, which is calls
> __xchg_called_with_bad_pointer() when its arguments are unknown at
> compile time:
> 
> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
> 
> This now happens because gcc determines that it's better to not inline the
> function. Avoid this by just marking the function as __always_inline
> to force the compiler to do the right thing here.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
> Fixes: d12157efc8e08 ("locking/atomic: make atomic*_{cmp,}xchg optional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 

Thanks,
Andi
