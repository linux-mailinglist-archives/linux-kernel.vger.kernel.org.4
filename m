Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294E65FDDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJMQFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJMQFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:05:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D247AE085
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665677146; x=1697213146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2JjVQsMb4D2fizdgIfbXopLKa+DgIUyh/kLuROOfp7I=;
  b=nf61IkTFcMnxRBRKEw9V/ACBty9sU8g7gRBQQMBsyq8xY/VjGQjnG75o
   DQq9w+vDQOyOrNC3Dv0q0DY0xfXR2cEWeFYwtG6mfCqcSAO6TXl/r0wHV
   /f/QZXgnpslC+H+kQ0l0Ehmcg6fU/eRAl2u25XjAtVY+Bep+aQf9PRs9F
   Onk5jYNc9XDmGV+LHS2Kdwtrnp6JZdxT8iF3Qf1oSF0jLszGtd4FwckB0
   hkIa0D0cCQd/6lifedCDY+50H1oNoXZWUqY5m73a8z4yORL7zYESPlttU
   ZNUjdfU0DaeOpCYb9pTFlA4A9b/zsTak449zRjTxQ+lvCrp8I/w/LknyM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302735515"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302735515"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 09:02:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="716396818"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="716396818"
Received: from mkucejko-mobl.ger.corp.intel.com (HELO [10.213.24.166]) ([10.213.24.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 09:02:48 -0700
Message-ID: <a4860054-0f16-6513-f121-501048431086@intel.com>
Date:   Thu, 13 Oct 2022 09:02:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] x86/tsc: Extend watchdog check exemption to 4-Sockets
 platform
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
References: <20221013131200.973649-1-feng.tang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221013131200.973649-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 06:12, Feng Tang wrote:
> @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> -	    nr_online_nodes <= 2)
> +	    nr_online_nodes <= 4)
>  		tsc_disable_clocksource_watchdog();

I still don't think we should perpetuate this hack.

This just plain doesn't work in numa=off numa=fake=... or presumably in
cases where NUMA is disabled in the firmware and memory is interleaved
across all sockets.

It also presumably doesn't work on two-socket systems that have
Cluster-on-Die or Sub-NUMA-Clustering where a single socket is chopped
up into multiple nodes.

