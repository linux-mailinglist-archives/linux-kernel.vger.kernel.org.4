Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8F269D0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjBTPjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjBTPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:38:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67151FF20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676907531; x=1708443531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rBdCUzCaJidlLZQ1PiVGjvu5BCuYQc7pnv2z4p6KY78=;
  b=NhDZUipRMVa+nwi9ctGnfDL9UwEwk1FFVhciRC324ZGbFEkXETYMsOcO
   WPPgYqc4uG11XdgtHdfeSu3hU1igdwTnh/ogALNFOabgTV6WUyimvdoaS
   IJK4hMg3F56VquY/jg87F2DBBD2N+vOzyEKN5lc+weDI6Tl2eE0itan21
   mModbrWIhquwkihwHZg/y4CkdFrJugh5HXrcULM8TNKu3iAVmQRJyi4bo
   rZc1ei1oVCNQBoaRlIiM2VAdFydb9oj54YlDZg9fZItfZIfUb7BwDucwq
   JCMobA4z+2DbZ8oXjz34Hr9lVHuAqvt0bXd31gxuI2irKwsP2jWPIg85X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="394909910"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="394909910"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 07:38:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="621193407"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="621193407"
Received: from msharm8-mobl2.amr.corp.intel.com (HELO [10.212.192.206]) ([10.212.192.206])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 07:38:50 -0800
Message-ID: <4996fd95-49bf-71bb-7071-6050b60529c1@intel.com>
Date:   Mon, 20 Feb 2023 07:38:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RESEND] x86/speculation: Fix user-mode spectre-v2
 protection with KERNEL_IBRS
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, KP Singh <kpsingh@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?UTF-8?Q?Jos=c3=a9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20230220120127.1975241-1-kpsingh@kernel.org>
 <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <Y/OETPFTJbGtCADM@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y/OETPFTJbGtCADM@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 06:31, Borislav Petkov wrote:
> This above probably wants to say that you need to write 1 on CPL change
> because it has a flushing behavior of killing user prediction entries.

Right.  The naive way of looking at IBRS is that setting IBRS=1
mitigates spectre-v2.  But, as the documentation says, just _leaving_ it
set to 1 is not good enough.  It must be actively rewritten in order to
get the strongest semantics.

It's still rather early in the morning, but I'm also quite confused
about what exactly the problem is here.  The patch and the changelog
aren't especially clear.  I'll need to stare at it with a cup of coffee
before I can give any coherent better suggestions, though.
