Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D286D2401
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjCaPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjCaPaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:30:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4F1BF54
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680276623; x=1711812623;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tL+P/RvkaxQ7mU0pqzAmqD7AYsTTQnFwHKNbZQnzUbA=;
  b=nYVpaAsHUXae4VbmE43MPr7LJurDWnth2udMHEwehPB8JtfRaoDOsbsw
   1mpuDmd9s50fGl+sxntyH2OgAF3s437+NYVB+RJH6cQfEfCcIG1nDZtkU
   BtomuqKp5F5tHSR+bBRn5c1VM9S6fpuE5thM+Jj0o9fBjCoj1Es0RowUn
   ECo/tiy5w2rAKV+rVLl0TP+s5/udrmWLEwK7IBa27MAReyPGvl5v4mrz+
   KUxGGRXTsF3/XEorBJtXipJu88TvBXKrFokFmY+1gybGZFvNwXjn1QEtz
   rcCtcNmeRyJwdxdVFw+V9G5V8KlgaP70tS5Gp6YYLJsEpuy/jWbYeAH6+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="330020870"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="330020870"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="685155690"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="685155690"
Received: from cebert-mobl1.amr.corp.intel.com (HELO [10.252.130.199]) ([10.252.130.199])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:30:23 -0700
Message-ID: <13f83347-e618-b976-78cc-88f991dc80f2@intel.com>
Date:   Fri, 31 Mar 2023 08:30:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Content-Language: en-US
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thomas.lendacky@amd.com, tony.luck@intel.com,
        kirill.shutemov@linux.intel.com, wutu.xq2@linux.alibaba.com
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 19:59, Wu Zongyong wrote:
> It seems MOVSXD which opcode is 0x63 is not handled, support
> to decode it in insn_decode_mmio().
...
>  	switch (insn->opcode.bytes[0]) {
> +	case 0x63: /* MOVSXD r64, m32 */
> +		*bytes = 4;
> +		type = INSN_MMIO_READ_SIGN_EXTEND;
> +		break;

The kernel does not support _arbitrary_ memory access instructions
messing with MMIO.

Before even considering this, I'd want to see a very concrete
explanation for why _this_ instruction in particular is required.  I'd
also want to make sure this doesn't set us off down a slippery slope
trying to make the MMIO decoder more expansive.
