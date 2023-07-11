Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7FA74EFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjGKNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjGKNNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:13:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1798FE4F;
        Tue, 11 Jul 2023 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689081188; x=1720617188;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=50brX0dAGzV/41unamisAQyWpHQt3BVzkzzBwjspMdE=;
  b=Ex5L4ZsmDh3IPjlOJsNArHqNnDkINtWKLYZV38jGuqra54Uvby0bZxD4
   BHtA6Eln5v3jCKFd/1sIwBYdsH6cdeqeedrHjvjOdnK/nzvEZLl7qQTxM
   hhrkiPagfMBXC3dC6SGsAK9yyTbqS+5Ba2tJsyl9RHkj/bPmQH4FBBtXz
   6EPCn+X7jqvC6KmDKJ4cVwKoiGG9rxe0mSaQkywMWaMj971b0Hyn4Ntbh
   g1D6k0ytKNPHL4903wM7qUtMi1kmtFuqJw9YqZYQrrJ1oyGWolvb/6pVk
   jeFO/CDmk0WuVb7cVLfIFeOzKTs8IHt4+Ebc1PWm2z9h1xwMwCGeaq1yi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363476380"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="363476380"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786620562"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="786620562"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:12:56 -0700
Message-ID: <180925f8-57f3-c97a-15c4-db2c73abe4a2@intel.com>
Date:   Tue, 11 Jul 2023 16:12:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] perf evlist: Export perf_evlist__propagate_maps()
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-2-yangjihong1@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230704074217.240939-2-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/07/23 10:42, Yang Jihong wrote:
> For dummy events that keep tracking, we may need to modify its cpu_maps.
> For example, change the cpu_maps to track side-band events for all CPUS.
> Export perf_evlist__propagate_maps () to support this scenario.

__perf_evlist__propagate_maps() is quite low-level so it would be better
to avoid exporting it.

