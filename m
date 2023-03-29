Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0615C6CD16B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjC2FHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjC2FHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:07:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9E2D48;
        Tue, 28 Mar 2023 22:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680066470; x=1711602470;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=JbHYbDttf7D+bkYuSV1T3QbU8EbIEeJfBKFc3jJbZjU=;
  b=K7Fh9d/8wypf2E+xoDJKKrc66gHV681EHZT5zSbd9d3P7QeIoT05Xpz3
   QSy1+oiE3aQ5b20zybs3bBICsY6FxHyDJdZ/AZv05RQZ7xyWE2u/w0XUm
   XdqQ10KKWstN2iG8scfffNFO8AlhX/pcB49RCHd5I/9YEeX2amzhQFQiL
   6PsQO/8OGBCn8ZDH0TNDVBemtwbu6Td3lhVJ1iTenK6Ou3sVLdRBya6nc
   Am4O4dR1d2NcPANm2ZF0Oq6ibt1k8N207yDr7Bk5QuNAWm9h1fIclRnfx
   JexEvOcqx03qj/6JiKG+RB/Mra4YfWtahIeT9OWsTuUl4l/RSQfcY7G4e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321178332"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="321178332"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 22:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827738096"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="827738096"
Received: from tsennhau-mobl6.gar.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.63])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 22:07:44 -0700
Message-ID: <1e2d77df-da40-0a06-0401-e15af96fe811@intel.com>
Date:   Wed, 29 Mar 2023 08:07:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] perf tools: Address fixes
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230316194156.8320-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230316194156.8320-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/23 21:41, Adrian Hunter wrote:
> Hi
> 
> Here are 3 small fixes resulting from a report from a
> kernel test robot:
> 
> https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
> 
> Issues were revealed due to the use of build
> option:
> 
> 	EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address"
> 
> 
> Adrian Hunter (3):
>       perf symbols: Fix use-after-free in get_plt_got_name()
>       perf symbols: Fix unaligned access in get_x86_64_plt_disp()
>       perf tools: Avoid warning in do_realloc_array_as_needed()
> 
>  tools/perf/util/symbol-elf.c | 10 ++++++++--
>  tools/perf/util/util.c       |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

These seem to be still outstanding.

