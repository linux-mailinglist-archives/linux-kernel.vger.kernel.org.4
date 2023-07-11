Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014974FBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjGKXIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGKXH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:07:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706EACF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689116878; x=1720652878;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fFtkcFDO8ixMyETrfbSOUsYJNuMITAkLOlhjZD0bGpk=;
  b=I4yBbWLLRH63Sc9b+orvAkMFN7HFimSf/UY6JbXpsf69YDo0UszqhWnh
   oRyIP+jPY4asnRBbFrHjFNj3ys9zFdY84dcNvhxYMU4CiyPZvtNrfBbn4
   fANDTexiTULAugqnq6zKTQnvxgTryXNZuLZa9B8bAVe/1PRXsjoI2Ch2X
   +3H2aWfREYsl/y5cWu1flq+AInTuMsGFOC9PiXtSsuObax0sWE1oJGPxc
   Z95cxPL+dTd63SwF1jaqivE7RStU5Nl15xFTmfvQewGcUtQwLYMU3qJHk
   nK/UB9STppvrt3jurUkrYBbcGrXbAB9WgEWLVEA2q5YDGBpfBtHs7iBIY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362224692"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362224692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 16:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834890058"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="834890058"
Received: from ticela-or-054.amr.corp.intel.com (HELO [10.209.95.41]) ([10.209.95.41])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 16:07:57 -0700
Message-ID: <7422da56-a5a1-d6b2-a2a0-fd4ee5dde5e0@intel.com>
Date:   Tue, 11 Jul 2023 16:07:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/platform/uv: Abort UV initialization when reduced
 nr_cpus requires it
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20230711202618.85562-1-steve.wahl@hpe.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230711202618.85562-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 13:26, Steve Wahl wrote:
> When nr_cpus is set to a smaller number than actually present, there
> is some node-to-socket mapping info we won't get access to in

First of all, no "we's" in commit messages.

> https://www.kernel.org/doc/html/next/process/maintainer-tip.html#changelog

> build_socket_tables().  This could later result in using a -1 value
> for some array indexing, and eventual kernel page faults.
> 
> To avoid this, if any unfilled table entries are found, print a
> warning message, and resume initializing, acting as if this is not a
> UV system.  UV features will be unavailable, but we will not cause
> kernel dumps.
> 
> This is a condition we expect only in platform debugging situations,
> not in day-to-day operation.

This seems like a hack.

The real problem is that you've got an online Linux NUMA node with no
CPUs.  uv_system_init_hub() (probably) goes and does:

>         for_each_node(nodeid)
>                 __uv_hub_info_list[nodeid] = uv_hub_info_list_blade[uv_node_to_blade_id(nodeid)];

But the node=>blade lookup uses socket numbers.  No CPUs means no socket
numbers.  You _have_ the blade information _somewhere_.  Is there really
no other way to map it to a NUMA node than using the CPU apicid?
