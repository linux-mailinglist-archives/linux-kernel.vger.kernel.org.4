Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A46613E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJaT1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJaT1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:27:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD1713D55
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667244450; x=1698780450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2fHYGkaRNoWB3mK+jOd2soSQVYRDZfMfl4sULJdOohU=;
  b=FsoSAPEqcy2kxhyhugyeElGs1l9wvY8tjC8iga+x8IdcG64M6DEs6g5L
   todp9ezz9B9PZfNs6Y4SQy0Ab/7l4+xArmEEFBKqK+oWJZFFg3KI66R7v
   zEP/9z8XiLxoMHpUe2LGmnusKutwNekGw5Jzvsm4Hn+TEf/3RQcrVic4O
   34a7CQde64+jTooExv8eIRPp8ed6kRWHwB9Mmvjjc+g/hyjLEWz9fygzn
   ZF6t0sWlH8D8+/dwLBZePldJROZjelWh3fgzFMuNO9JDdtVRsmMe8Nw0x
   DMr7fecXo3Klc/9TxQhwXMk5WZIMylwWwPAi5qRXbe7uJ4/nLNLNVRb59
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="395296028"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="395296028"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 12:27:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="722920836"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="722920836"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.155.138]) ([10.212.155.138])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 12:27:28 -0700
Message-ID: <8887d182-a3e3-f62a-8b8f-36db1da75b19@linux.intel.com>
Date:   Mon, 31 Oct 2022 12:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
 <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
 <20221028235951.p2vdu7drbbf3ccg7@box.shutemov.name>
 <20221031041252.mdcjocqn6k4k4gvy@box.shutemov.name>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20221031041252.mdcjocqn6k4k4gvy@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sted-by's would be appreciated.
> One thing that I must bring up is that it seems that there's no way to get
> the panic message to user. I tried to convinced myself that it is qemu
> misconfiguration on my part or some race, but no: it is just too early for
> earlyprintk.
>
> We only get earlyprintk working after parse_early_options() which happens
> well after tdx_early_init().
>
> Moving panic() after earlyprintk working is not good idea as it exposes
> kernel more: by the time we already have full #VE handler.


It should be fine to move since there is no user land at this point (the 
attack requires user land)


>
> We can move it earlier into decompresser which has different earlyprintk
> implementation. Not sure if it worth this. What do you think?

That would make uncompressed kernels unsafe.

-Andi

