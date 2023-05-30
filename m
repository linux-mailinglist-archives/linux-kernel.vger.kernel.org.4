Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2655D7157C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjE3H7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjE3H7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:59:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D0AEC;
        Tue, 30 May 2023 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685433572; x=1716969572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2wQjHFnZKBKTamAwk9amhA1vwnpcm0OjoXqFO3kzPY=;
  b=iZ0aa6qWMtTYjazlpSn1Qo7FUuS8MosEW71J6Ms/6X52rLwXUAzqCRj8
   fzwNPfvQAqv+kML+kr01Xpurea4ylNcsDBLA9pYjajkSMKolrO71GeQu7
   wi2/O6lSLDwB/bSZj6uKlEmXwV+wKbwnZI3kp+ibUTeP6bwG4XCf9950Y
   nUQARTLZOyrH65i4PW7axEKUIApyOhYmjDCJAf2MXBpkxTbz7wGiFc5cq
   +Hmzzv6e1X3O3FtTBRFsMNMMg2W2Kf4kx8cYddXiT2itng0SJtcabAdYX
   cueOHDT2+ztnRlRfDomFTtxknCIiSTG60t0+sD9YhOuVUPEm3xr40mRvY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="441203217"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="441203217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 00:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="776207742"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="776207742"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 00:59:31 -0700
Date:   Tue, 30 May 2023 00:59:30 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Address some perf memory/data size issues
Message-ID: <ZHWs4o9SBqfspNds@tassilo>
References: <20230526183401.2326121-1-irogers@google.com>
 <ZHWCPXKo2fFJmtlT@tassilo>
 <CAP-5=fXXykcwjXjd+W=8Eez79JhmuKhf1Z-1R_8+AD4XdY4a8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXXykcwjXjd+W=8Eez79JhmuKhf1Z-1R_8+AD4XdY4a8A@mail.gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> BSS won't count toward file size, which the patches were primarily
> going after - but checking the size numbers I have miscalculated from
> reading size's output that I'm not familiar with. The numbers are
> still improved, but I just see a 37kb saving, with 5kb more in
> .rodata. Something but not much. .data.rel.ro is larger, which imo is
> good, but those pages will still be dirtied so a mute point wrt file
> size and memory overhead.

The way perf is written (lots of separate code depending on a single high level
switch) most pages probably won't be dirtied.

> 
> For huge pages I thought it was correct that things are aligned by max
> page size which I thought on x86-64 was 2MB, so I tried:
> EXTRA_LDFLAGS="-z max-page-size=4096"
> but it made no difference to anything, and with:
> EXTRA_CFLAGS="-Wl,-z,max-page-size=4096"
> EXTRA_CXXFLAGS="-Wl,-z,max-page-size=4096"
> file size just got worse.

The default alignment to 2MB was dropped in the GNU toolchain in 2018 or
so.

-Andi
