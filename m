Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506E568C601
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBFSmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBFSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:42:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F64C24
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675708953; x=1707244953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0RJykZKIMckg5tSnfL8zY+zfgcfWTZwL6hDDUz9xN+c=;
  b=gWVyzR/B9ImNzAGgUwEtHIrx8qrFyEhBdFOhNqoLOxRzTLaGZQESwlJe
   jZqG8MFH5KT4jDc7Ip3NtvZ7s+ATo2v59FH5CRFX11GsBKe3gqpjWAd+R
   cSLrCAnz7x4e3n2buw/2LG1wHpOwHsLkHPegNEYG69Xhsesl5LhfqXavZ
   R27fW1D5K8SYO8WGCUIVSj9yeHZP015F0QVNK/5/HENqipBjnE5GX9mrJ
   qwQ20pF4A6+VLftsFU04DoFcRwrBRzSL7ZY27f9BeejfbKyAZpTxY0pLc
   N131M6+0/8I8pWhhUNjLosnMBbri7hiWBqOxx8wWtzS+oBMEo1ZmY7D5V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="330578445"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330578445"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:42:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="659931526"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659931526"
Received: from ninhngo-mobl.amr.corp.intel.com (HELO [10.212.134.105]) ([10.212.134.105])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:42:31 -0800
Message-ID: <a75c134d-8278-b17c-e05e-409b70ad15b0@intel.com>
Date:   Mon, 6 Feb 2023 10:42:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230204210807.3930-1-namit@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230204210807.3930-1-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/23 13:08, Nadav Amit wrote:
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -625,7 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
>  		/* 1 byte conditional jump */
>  		p->ainsn.emulate_op = kprobe_emulate_jcc;
>  		p->ainsn.jcc.type = opcode & 0xf;
> -		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
> +		p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
>  		break;

This new code is at least consistent with what the other code in that
function does with 1-byte immediates.  But, I'm curious what the point
is about going through the 's8' type.

What's wrong with:

	p->ainsn.rel32 = insn->immediate.value;

?  Am I missing something subtle?
