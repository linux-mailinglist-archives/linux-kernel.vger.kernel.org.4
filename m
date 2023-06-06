Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCD724AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjFFSOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjFFSOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:14:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC751B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686075270; x=1717611270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Okqhg8qh5B88CrP2Vdkx5lOdo06NqA+suoyiSSguqTg=;
  b=FSeHEdI8jAyQ5mR8bx1Rep7A2kMdKf7BYkTfskydj9XK85pxGjUx8Gsi
   uxiHc7rQKg89a8EtUIx1a8iS+7CQe1dU4s4hnmFnucqdRRPClqNlBYQE6
   ZTwsBufTgy2DGhNJ8+DTpDwuHVTY6fksT7DkKGRWn5JdMELV3szr+b/Ra
   WnOb9IeiPafg8nIA07sebNse0GCIXJXfXMtN1tLbQNf/U+8oUPgiWpVDA
   NAWt7I9lt92d31xCmAdyEgD42N4KyKHsk8yjaXnQDVsBUMVN9hXey20SG
   +f9AjIE25AHgIx/yxI3bGrDH+L/dilLQ+0qayHL8rXtYXwihKSGM72y9x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="346366578"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="346366578"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 11:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="686637427"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="686637427"
Received: from hganapat-mobl1.amr.corp.intel.com (HELO [10.212.191.102]) ([10.212.191.102])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 11:14:29 -0700
Message-ID: <f7f82377-6127-79e3-07d8-def490c4e35c@intel.com>
Date:   Tue, 6 Jun 2023 11:14:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv3 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <20230606095622.1939-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230606095622.1939-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 02:56, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can touch memory that is not owned by the
> caller, but just happened to next after the owned memory.
> This load_unaligned_zeropad() behaviour makes it important when kernel
> asks VMM to convert a GPA from shared to private or back. Kernel must
> never have a page mapped into direct mapping (and aliases) as private
> when the GPA is already converted to shared or when GPA is not yet
> converted to private.
> 
> load_unaligned_zeropad() can touch memory that is not owned by the
> caller, but just happens to be next after the owned memory. This
> load_unaligned_zeropad() behavior makes it important when the kernel
> asks VMM to convert a GPA from shared to private or back. The kernel
> must never have a page mapped into direct mapping (and aliases) as
> private when the GPA is already converted to shared or when the GPA is
> not yet converted to private.

Heh, that must be really important info to have it in the changelog twice!

I'll fix it up when I apply it.
