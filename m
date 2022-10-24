Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0861960B52F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiJXSN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiJXSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:12:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB6E7CA9A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666630481; x=1698166481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dv4QDRIPcuHumVexzn37KMl4eAOU2AKnc4Ln3f02ot4=;
  b=oGQMgPsT96TTRJ7H88RypU/oBDYCI401hKHFK4zskfLrDFBmAlxop5KX
   mQVU8TikzgB+iuFl0OUuW6bZ4tMEHQE5rQ/EzkzcrIF3Yq87WqKUoLN/X
   GqbUtiS4AOyLlg1BdIitRrnpi96HA8c1YgLItSosJAuoQq5g1I5T4Oi2e
   vSabfq+VR+eC0gXjQBJKra+SixVcdcKjKlZlwbNvPrEzj+A41N1mAar+D
   qf8CcEDCeYziw4tuO9S6S7c72k77up1tRpn9w7pbL9J8HzLS/f3PCgYnO
   jqM8adomGm677najOx3dUTHNf70v6tDBYw7mxZFVhcGVoYTzemJIRTzBZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290755428"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="290755428"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:43:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609238828"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="609238828"
Received: from csun9-mobl.amr.corp.intel.com (HELO [10.209.104.152]) ([10.209.104.152])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:43:33 -0700
Message-ID: <397f513f-9273-76d1-a0ba-9d1d403020c5@intel.com>
Date:   Mon, 24 Oct 2022 08:43:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>, liaoyu15@huawei.com
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
 <63dca468-c94d-844a-5b19-09c03cf84911@intel.com> <Y1ZArguS/rVEjXOb@feng-clx>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y1ZArguS/rVEjXOb@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 00:37, Feng Tang wrote:
>> For instance, I can live with the implementation being a bit goofy when
>> kernel commandlines are in play.  We can pr_info() about those cases.
> Something like adding
> 
> pr_info("Watchdog for TSC is disabled for this platform while estimating
> 	the socket number is %d, if the real socket number is bigger than
> 	4 (may due to some tricks like 'maxcpus=' cmdline parameter, please
> 	add 'tsc=watchdog' to cmdline as well\n", logical_packages);

That's too wishy-washy.  Also, I *KNOW* Intel has built systems with
wonky, opaque numbers of "sockets".  Cascade Lake was a single physical
"socket", but in all other respects (including enumeration to software)
it acted like two logical sockets.

So, what was the "real" socket number for Cascade Lake?  If you looked
in a chassis, you'd see one socket.  But, there were two dies in that
socket talking to each other over UPI, so it had a system topology which
was indistinguishable from a 2-socket system.

Let's just state the facts:

	pr_info("Disabling TSC watchdog on %d-package system.", ...)

Then, we can have a flag elsewhere to say how reliable that number is.
A taint flag or CPU bug is probably going to far, but something like this:

bool logical_package_count_unreliable = false;

void mark_bad_package_count(char *reason)
{
	if (logical_package_count_unreliable)
		return true;

	pr_warn("processor package count is unreliable");
}

Might be OK.  Then you can call mark_bad_package_count() from multiple
sites, like the maxcpus= code.

But, like I said in the other thread, let's make sure we're agreed on
the precise problem that we're solving before we go down this road.

> and adding a new 'tsc=watchdog' option to force watchdog on (might be
> over-complexed?)

Agreed, I don't think that's quite warranted yet.
