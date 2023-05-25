Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632F9711703
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbjEYTPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbjEYTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:15:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A123C27
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685041624; x=1716577624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZyPik9WGlty0Y8aIFzf+wy5PVhSVd7+fy7mRiJhCPx4=;
  b=Ui1wGlH2pwN8NOU4FGJQ+aPGXZImmSZxU08JgKgd5fxx9V/jRi2ENb4z
   ZNKaKvvprmw34NXFJ24y1IUAF85NxzSNvRAT8sf+kWvxFsmvcDs2JA+gj
   dNu8GZygYG3gldNwVwJ/+pZwAlA+4oPiLQ+WmTQUnEjv57gyqSwsuPy4/
   hudEKRwI7n5wAd9Y8SCOcGjX9Ctj6WWyJVpGp+lB8I+Ylau5xIiMakyXL
   ozHjzgC621fAXLU7SYCZathEeuc63F4QBCDYiieD06YErV7JnwWMNdCtP
   8FGwIigFh2w2WsKLJKOczEE6wHXlCNAb6GVieQ+hcQxfMu/y8sri3JRAJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="333615597"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="333615597"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 12:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="817243678"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="817243678"
Received: from shuklaas-mobl1.amr.corp.intel.com (HELO [10.212.186.148]) ([10.212.186.148])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 12:05:42 -0700
Message-ID: <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
Date:   Thu, 25 May 2023 12:05:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
References: <20230525184244.2311-1-namit@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230525184244.2311-1-namit@vmware.com>
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

On 5/25/23 11:42, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> When SYM_CODE_START_LOCAL() is used, the symbols are local but need to
> be preserved in the object. However, using the ".L" label prefix does
> not retain the symbol in the object.
> 
> It is beneficial to be able to map instruction pointers back to symbols,
> for instance for profiling. Otherwise, there are code addresses that do
> not map back to any symbol.  Consequently, the ".L" label prefix should
> not be used when SYM_CODE_START_LOCAL() is used.
> 
> Few symbols, such as .Lbad_put_user_clac and currently have both the
> SYM_CODE_START_LOCAL() invocation and the ".L" prefix.  This commit
> removes the ".L" prefix from these symbols.
> 
> No functional change, other then emitting these symbols into the object,
> is intended.

Nadav, could you perhaps do a bit of research on how this situation came
to be?  Was it an accident or on purpose that these symbols came to be
.L?  Then, could you CC the folks who made this change and ask them
directly if they intended to induce the effects that you find undesirable?
