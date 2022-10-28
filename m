Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10D061162C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ1Pn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ1PnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:43:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B31CA58F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666971803; x=1698507803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M8lBjisbrUmX7YpmP6kTjIJyyN8ldczVQ7JZJGEy5vg=;
  b=dvUnUPnmeES7aooaGm8s40q4FqGO1F8ZDQvSVfndBs/TYrBvPoQRpO5/
   re8EUyk2WHS7LyAnEcqFVKXnnDO1RtdlHPLX0gJhNSueu1hmqcJAuVGgo
   XzD+jQPlKQ++K0hPFdvmzXgF/Aa860ZNXivZzN/B5B/qPSbCv1/xjYfwC
   O2ZqGVoqIyrxnk5bszTarHRl8YXTvu/ekXujjwxI3VdSj0j8ANNbiN8xM
   5i/X3I78HmfYs9kEcxRcaHlQQh+qMHIY2gYkfE2Ih5vEApK5szxqAsK3y
   Ur/ftGvBZ1DbfKUAHPyxiZ7unB0rkC1RD2XA8iMfSgQBNxb6hjG/PeHLL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="308510148"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="308510148"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 08:43:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="738146230"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="738146230"
Received: from jbandiax-mobl.amr.corp.intel.com (HELO [10.209.126.71]) ([10.209.126.71])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 08:43:22 -0700
Message-ID: <2a1886e7-fa5d-99e2-b1da-55ed7c0d024b@intel.com>
Date:   Fri, 28 Oct 2022 08:43:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 07:12, Kirill A. Shutemov wrote:
> +	 * information, TD attributes etc. More details about the ABI can be
> +	 * found in TDX Guest-Host-Communication Interface (GHCI), section
> +	 * 2.4.2 TDCALL [TDG.VP.INFO].

Folks, I thought we agreed long ago to stop putting section numbers in
these comments because they're not stable.  Am I remembering this wrong?
