Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8505E6E13CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDMR5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:57:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C887E113;
        Thu, 13 Apr 2023 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681408630; x=1712944630;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nOkN3J71NLvRwTbsFR1qkqzfC374Ahf3CYQE2o4SPzo=;
  b=iR2fk7RtijpiKktdQ0LzF2BKq8d2ZFf407lLX502V9D8BOGm/JWita02
   ifCOHCXgCQuAmVWqu2fjrc5U6TSlTlSvHV7d+KsGCp6CHCNk74pX2Fsiv
   c6PoeDjtkkubx+iYx1UG0pQohlsGeEUNGcAd6FJpzIf/pPcdjXcFNKhdm
   vriW/4TEWmwwPf/5aaxWiB9Rqfe8uVsrgfkKTGYKxNgCCtfDFSJlyyLP6
   k3lIkkZWynHAP8O6L2yia907Qoee27obGo8OR8NoUeia7yfmol3n32LQy
   ehrok2jWMDvOY4bUkmF2md5N5ZOIjGJzGp8JXeAVWfBTho3Eh7Iy0s7MI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="344256516"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="344256516"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 10:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935693296"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="935693296"
Received: from rmorle-mobl.amr.corp.intel.com (HELO [10.251.3.135]) ([10.251.3.135])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 10:57:09 -0700
Message-ID: <1ea129d9-19cc-5f33-fc10-3e832679c5a2@intel.com>
Date:   Thu, 13 Apr 2023 10:57:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] x86/Documentation: Add documentation about cluster
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org,
        oleksandr@natalenko.name, bagasdotme@gmail.com
References: <20230413172918.1500-1-kprateek.nayak@amd.com>
 <20230413172918.1500-3-kprateek.nayak@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230413172918.1500-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 10:29, K Prateek Nayak wrote:
> +  - cluster_id:
> +
> +    A per-CPU variable containing:
> +
> +      - On Intel, the common upper bits of APIC ID of the list of CPUs sharing
> +        the L2 Cache with lower bits set to 0.
> +
> +      - On AMD and Hygon, with Topology Extension, the common upper bits of the
> +        Extended APIC ID of the list of CPUs sharing the L2 Cache, left shifted
> +        to remove trailing 0s.

I think this is too much detail for Documentation.  We have the code if
anyone cares _this_ much.

Also, I'm perplexed by the "left shifted" comment.  I don't see a lot of
left shifting in the patch.  Am I just missing it?

Further, this makes it sound like all Intel CPUs have the cluster_id
populated.  I'm also not sure that folks reading this will have any
worldly idea what "Topology Extension" is.

Why don't we just say that some CPUs don't have this info?  That way we
don't need to spell out AMD vs. Intel or expect our users to go figuring
out of their CPU has "Topology Extension" or leaf 3 or wherever this
info is on Intel.

How about:

A per-CPU variable containing:

   - Some upper bits extracted from the APIC ID.  CPUs which have the
     same value in these bits share an L2 and have the same cluster_id.

     CPUs for which L2 cache information is unavailable will show 65535
     as the cluster_id.
