Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F66F9A7C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjEGRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEGRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:12:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16455100D9;
        Sun,  7 May 2023 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683479559; x=1715015559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xadsDlIqSLYDH8jAUQJ+rU/bh9AyzgsU04VnNDkPNZk=;
  b=UwySByN+YkfSAk6pK1Oydz5lI4I53iHIoPty4SiLewuSURi7QhMFP7wK
   XlMjkw+mt7iIFUjnxMwqa48Y5uDSIq88PgE9Vq79VtBuqOEwN5emMtWUE
   LBYycJ5thV3HhRleCYnYlXemCbyK29p4vtDPBdAzvXahdS+Z+CS1yyIz4
   u+Ts4o4fO7fUA3AE9oewIkQohzyBmTmBZsz8G5cSs+uFXoqJ6Ok87Gmq1
   cmcGE6Mw8VdCiZF3kf6zTJiHo7gF6Rjjv3yweMe+QLT5WeO3uMYC9BDRT
   D3A5MB7UwnXYQgYzwTuu+V2tLi1WmVKEc18LwNvZJQZVUDarlbCrQrZVv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="333933231"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="333933231"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 10:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842466547"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="842466547"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 10:12:37 -0700
Date:   Sun, 7 May 2023 10:12:29 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ian Rogers <irogers@google.com>, ravi.v.shankar@intel.com,
        ricardo.neri@intel.com, Stephane Eranian <eranian@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Will Deacon <will@kernel.org>, ito-yuichi@fujitsu.com,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Marco Elver <elver@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] hardlockup: detect hard lockups using secondary (buddy)
 cpus
Message-ID: <ZFfb/bTi22RQwaol@tassilo>
References: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CAP-5=fUB1e=bJk-w0i8+MEo4sLOZtb_Eb7FMy4u7ky7D2AZm6A@mail.gmail.com>
 <CAD=FV=Xuuefi9XBQA7z7sbe+Qw0=WeZ956gLGCoFGHBg6GBftg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xuuefi9XBQA7z7sbe+Qw0=WeZ956gLGCoFGHBg6GBftg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Apr 24, 2023 at 08:23:59AM -0700, Doug Anderson wrote:
> HPET system seems to have a single CPU in charge of processing the
> main NMI and then that single CPU is in charge of checking all the
> others. If that single CPU goes out to lunch then the system couldn't
> detect hard lockups.
> 
> In any case, I'm happy to let others debate about the HPET system. For
> now, I'll take my action items to be:

We don't really seem to make any progress on the HPET series, so even
if it is better in some way a series that is never merged is always
worse than one that is.

My experience is that cases where everything locks up are very rare.
I suspect as long as we cover the garden variety single CPU lockup case well
it is likely very diminishing returns to handle more complex cases. So whatever
gets the job done is fine.

Yes freeing the Perfmon resources is big advantage of either.

-Andi

