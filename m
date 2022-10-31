Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947AF6138E1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiJaOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiJaOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:22:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED49525C9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667226159; x=1698762159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jLXu6gq3vGZxJtvk5qii7PRMYQi6nR4c8aoYP5o3ZPE=;
  b=k4oJTPGzanq4pMIfUPWttqDpk7Oa+hj7l2xTR9or2SjW5ApFz8vIifyh
   hoM7XE6Acl9SEokB1C71SCZxV7Jvd6Dgw51HOY/N2R1WlQWmvj4506dac
   pGv8mcaueDAwQZOvXHS46mYxTps+e3Cc/Oh1NWR4QwBY6Q8ti/GuHqaPL
   UXrq0zuVmQ807HvzCorFUdTkG6xqA2w/3VzTiMQ1BSPA0xkn7JBU5Tw6d
   Ot37X4RA9UfC4OoRb/lbfVPB05nJmfgjHnow1TsmdXhUWstnk9Fydky2F
   aIiJVAVir6y9dQvao1Q58+0kRa+WzF1IVWZbreAm2x/SJm16+k4tC3vIv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="296322924"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="296322924"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 07:22:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="722823180"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="722823180"
Received: from jfbondi-mobl1.amr.corp.intel.com (HELO [10.212.163.129]) ([10.212.163.129])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 07:22:38 -0700
Message-ID: <4bfcd256-b926-9b1c-601c-efcff0d16605@intel.com>
Date:   Mon, 31 Oct 2022 07:22:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] x86/tdx: Do not allow #VE due to EPT violation on the
 private memory
Content-Language: en-US
To:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com
Cc:     ak@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
        david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        x86@kernel.org
References: <20221028141220.29217-3-kirill.shutemov@linux.intel.com>
 <b5d04a6c-79b4-bbdc-b613-6958d9f75d53@linux.alibaba.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <b5d04a6c-79b4-bbdc-b613-6958d9f75d53@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 21:07, Guorui Yu wrote:
> We have encountered similar problems on SEV-ES, here are their fixes
> on Kernel [1] and OVMF[2].

SEV-ES and TDX are very different beasts in this area.

> Instead of enforcing the ATTR_SEPT_VE_DISABLE in TDX guest kernel, I
> think the fix should also include necessary check on the MMIO path of
> the #VE routine.

Instead?

Without ATTR_SEPT_VE_DISABLE, a #VE can occur on basically any
instruction.  We call those kinds of exceptions "paranoid entry" points.
 They need special handling like the NMI or #MC handlers.

I'd be happy to look at a patch that does the MMIO path check *and*
turns the #VE handler into a robust entry point.

Bonus points if you can do ~5 lines of C like the approach in this thread.
