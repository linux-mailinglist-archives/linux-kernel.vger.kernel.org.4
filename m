Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58C619AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiKDO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiKDO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:58:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7931ED4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667573895; x=1699109895;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lPsbdi3iEDPlS9ix5hC1hyJYJM01ewfiP0KOIWr82XQ=;
  b=HVQXfIDxuq6k3UY3TExEiN0+vC3V1RTIa7e/xTJnGb6oO2DPyff/Fl7h
   7J69MerOI8FdhTF9oqiW8Qje7iwOVpdSmzHDHvLz7wu3kWq2flEr+OLTx
   zFoxJRNV6KFfOqyUb8FqZNfFCO2rva1Yfmhzg0J1BVzqNeY2FhrGcNFJl
   RdwRgTHNPtDgcp+EvaxYY0ErzKcKYilkPFz68gzY8Zu4oBfY9UnXNrWhs
   yx8qu1kvcaW9e1mUf2oHkT0rfhe4QfOYKU30DjUmxV0ziFE3gIV5wZ7en
   rbLBtLohr6q5yvVTKZ9qB0/J6KQKM11ijNpmxfNWn5IWsdP2RUCFoysMY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="309973434"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="309973434"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 07:58:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="637606501"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="637606501"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 07:58:14 -0700
Message-ID: <41808063-94b7-b2bc-a261-23d99ba1c0ba@intel.com>
Date:   Fri, 4 Nov 2022 07:58:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/5] x86: remove unneeded 64-bit dependency in
 arch_enter_from_user_mode()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221104072701.20283-1-jgross@suse.com>
 <20221104072701.20283-3-jgross@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221104072701.20283-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 00:26, Juergen Gross wrote:
> The check for 64-bit mode when testing X86_FEATURE_XENPV isn't needed,
> as Xen PV guests are no longer supported in 32-bit mode.

Tiniest nit if you revise this: please call out that this "no longer
supported" thing is enforced in Kconfig.  It's not just some random
edict where we pronounced 32-bit PV guests unsupported.

Otherwise:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>


