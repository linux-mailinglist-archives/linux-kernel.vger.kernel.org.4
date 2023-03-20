Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2516C224C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCTUMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjCTUMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:12:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2EF2C667
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679343128; x=1710879128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zjNn1ywdRNLSuGeL/20uua/uF3ufV4klWvILdjrCBuk=;
  b=XO54q1P2iqxYNQ6pjrG4RSq96/QArR73sYh/KOB9OnZ4MPc3B+7mz3J3
   1I1E3LwIiN+VGtKeGdqEONTSBXTRMu35Q8ewrnvaTZ+CCKvSS5GxExWNR
   JqZG2h+LHdUh5qmumL4wd7uvkddO0bbKIqf8l0R8zCIQ6IRLSnXAt2Cwa
   IBbVmPlJkwyR8VQZdRkZDIrFjXDox5VT/z5OBZk2qiha9rEffe70b3yJt
   4oUMPO7NnVHVDKt6d7+o//qxReZDf2qIdbRaFQxr6+itE7hB/iLr4UFls
   /ET9dF35Jt3UoPfP9BqSxU8pfYTK/zMO5kx+PQiNaxfNShdEgQKKYFLf+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425042918"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="425042918"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="750250748"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="750250748"
Received: from vrchili-mobl2.amr.corp.intel.com (HELO [10.209.117.85]) ([10.209.117.85])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:12:07 -0700
Message-ID: <e8a36925-2965-1dae-da01-5d06ba6747c8@intel.com>
Date:   Mon, 20 Mar 2023 13:12:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5] x86: Avoid relocation information in final vmlinux
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org
References: <20230320121006.4863-1-petr.pavlu@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230320121006.4863-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 05:10, Petr Pavlu wrote:
> The issue is then that the collected vmlinux file and hence distribution
> packages end up unnecessarily large because of this extra data. The
> following is a size comparison of vmlinux v6.0 with and without the
> relocation information:
> | Configuration      | With relocs | Stripped relocs |
> | x86_64_defconfig   |       70 MB |           43 MB |
> | +CONFIG_DEBUG_INFO |      818 MB |          367 MB |
> 
> Optimize a resulting vmlinux by adding a postlink step that splits the
> relocation information into vmlinux.relocs and then strips it from the
> vmlinux binary.

When I saw that this adds a postlink step, I read that as, "adds another
step to the unbearably slow single-threaded part of kernel builds". :)

But, here's one data point that made me feel a lot better.  Using a
random .config:

> https://sr71.net/~dave/intel/config-reloctest

the builds get a _bit_ slower, going from 37.0s->37.7s.  This is pretty
arbitrary of course, using my compiler on my hardware, so YMMV.  But,
for me, this seems like a reasonable tradeoff given the space savings.

I'd be curious what other people are seeing.
