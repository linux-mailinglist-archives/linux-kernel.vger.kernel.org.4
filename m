Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DFA7250CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbjFFX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjFFX3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:29:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7931706
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 16:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686094157; x=1717630157;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2m5Acays/axVHKkZnzGatekU7tm/LDNxL0c803mI3GM=;
  b=ZGW4wmBwTZGJ7VOconGWQifP02wkgXsJnOLGRBUKhMGi2UAas1CEF516
   HvYQPcYjRQ/v2xBlPwkg88hwM1qy+0zqH1NsNajn8h5HGAKjUEZRANGI0
   80FrDqHvYj/aUZeeDYz8KDgpFQf+2dY0HOO6sO3AVdUjuqsNrIg+dUNZX
   nfq7gAdbVb0qGhv/kyUhZesDbXnmXX40FQCFIp25cu65chEQg9HW2lQ5l
   e83MRf8k7sg9Lqqr9amt/uWDFUtvi1xU0oewLxZAiQwitssTlHzZ18hGE
   0fcN0MrocTDyslW37+hxxoC8e+42JuHiim+3lAC9+favgqGoMkqEvMjVY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336450138"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="336450138"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 16:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="821860733"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="821860733"
Received: from hganapat-mobl1.amr.corp.intel.com (HELO [10.212.191.102]) ([10.212.191.102])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 16:29:16 -0700
Message-ID: <1eaf32e1-f808-320d-2643-387682cf7ea0@intel.com>
Date:   Tue, 6 Jun 2023 16:29:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv3 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <20230606095622.1939-3-kirill.shutemov@linux.intel.com>
 <f7f82377-6127-79e3-07d8-def490c4e35c@intel.com>
 <20230606183718.i3iqwbk7gdomiq5s@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230606183718.i3iqwbk7gdomiq5s@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 11:37, Kirill A. Shutemov wrote:
>> Heh, that must be really important info to have it in the changelog twice!
>>
>> I'll fix it up when I apply it.
> Ouch. Please fix the comment in the code too.

I couldn't help myself and rewrote the changelog and comment.  Please
let me know if it looks OK:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx


