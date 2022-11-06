Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C841D61E398
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiKFRCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiKFRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:02:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F5DEBF;
        Sun,  6 Nov 2022 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667754149; x=1699290149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tVXlcBE2aFKbiiRITzLn6WZi+rbe15vkZSuzbS4Aw1k=;
  b=auI+t/yGq0NPI+LR+u+mO2/nJRc9LQ0oZb2EcAvc4gLxDOFYAnFkKMkr
   AKP0PZGqgwzgpjufE9wwO3U+4hqMv2EQpd6SqBm+oKx0WiobxXxvQyVw8
   u3H3OcFFvJ+jbppyd/vJttpsX0t4C7Vfs3GF5eRz028n+5TY+5Sr7x9BN
   Wi3IL8dBpyntn1tm5dRR4qF5Uy++l2Dg40FDBOH0COIzaaj1tJM9zYEtN
   Sb9MkQgXgRxz4OTxJbE8jTwFNze96qbp0bKoLTPkln7nnU1AyG0fHcYFv
   fl5FGDrZY9/+jCNBMck+oOBd6oVN9GuLXcPtwvTLDLFms/9PMkR83Nxed
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="289995254"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="289995254"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 09:02:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="638123578"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="638123578"
Received: from edegrijs-mobl.amr.corp.intel.com (HELO [10.209.44.139]) ([10.209.44.139])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 09:02:28 -0800
Message-ID: <d4614b70-b37b-44b8-6a9c-54d59a6f9fec@intel.com>
Date:   Sun, 6 Nov 2022 09:02:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [tip: x86/urgent] x86/tdx: Prepare for using "INFO" call for a
 second purpose
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org
References: <166734513630.7716.12952231613533508782.tip-bot2@tip-bot2>
 <Y2esXPWwulendusf@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y2esXPWwulendusf@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 04:45, Borislav Petkov wrote:
> On Tue, Nov 01, 2022 at 11:25:36PM -0000, tip-bot2 for Dave Hansen wrote:
>> @@ -121,7 +121,7 @@ static u64 get_cc_mask(void)
>>  	 * The highest bit of a guest physical address is the "sharing" bit.
>>  	 * Set it for shared pages and clear it for private pages.
>>  	 */
>> -	return BIT_ULL(gpa_width - 1);
>> +	*cc_mask = BIT_ULL(gpa_width - 1);
>>  }
> I'm looking at the next patch too and I still don't see what the point
> is of making it a void?
> 
> IOW, what's wrong with doing this?

It's fine for now, except that the naming on this:

-	tdx_parse_tdinfo(&cc_mask);
+	cc_mask = tdx_parse_tdinfo();

is a bit funky since tdx_parse_tdinfo() is doing a couple of things and
will need to return a second item shortly.

But, zero objections if you want to make it that way for now.
