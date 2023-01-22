Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176A9676B0C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 05:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAVEeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 23:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjAVEeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 23:34:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261B15CAA
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 20:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674362051; x=1705898051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q21kRTwJw+Eq+WoprO8u9oA8bN3/e1g2CKnGz/MGKNE=;
  b=d1BPzvtCJMJ7zqVfMKKjJYohsRVj8y1dlzsDz76XjYkOqyfDf4JaUvrD
   wc5R7l4NNgF7neuOgtd0dXiBAnu9+taI0uUaUrC3TtyFVUbrKMPkEZ0KB
   f/vPEY2O86Bl+X7egXKPJhJsYUSTMb3QLzs4FTHnTsD6gaITC8fjJtuqk
   foTM5ZPsQtAEBwyFIRTowGXxXDdoaf2NKYYCTB9199yQDR7IKJd7kMLpa
   5DU5glGxIGSaBbN2bvjvhB2fP8cax+UmW21Nl2rKyJ8P4mRxxSPeO4++T
   DUK3OuWYVjljlcma04B6+SZp6kaoRo1uM0y1/Abb4Tow3EEGpo1GV58bD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="309440563"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="309440563"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 20:34:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="724420916"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="724420916"
Received: from aureliaw-mobl.amr.corp.intel.com (HELO [10.255.230.48]) ([10.255.230.48])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 20:34:10 -0800
Message-ID: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
Date:   Sat, 21 Jan 2023 20:34:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Content-Language: en-US
To:     "Li, Xin3" <xin3.li@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 19:38, Li, Xin3 wrote:
>> However, it doesn't seem to make sense to do so to me. The current behavior is
>> much more of an artifact than desired behavior.
> We kind of have an agreement that %r11 = %flags after returning from the kernel.
> 
> And the question is, is it what we want?

Can the selftest just set r11=rflags before the syscall?  The old
syscall entry path will set r11=rflags.  The FRED path won't touch it.
Either case will pass an r11==rflags check.
