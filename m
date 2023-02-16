Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8D8699B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjBPRuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBPRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:50:42 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D44CC86
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676569840; x=1708105840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u0+P41I+U7P6oEkW9H2fAtZW+9aVP335JS7RgNi8h70=;
  b=hgZBjIVWHvl0vPJmiSBxQf5TxIbAmIG+YCUSJcY+mbcUk98wEBfqQN0r
   BQI/4VEOak/oJAGLlYFN2T7mQQvYXJAoJa2lLxXbb403i7+hxUt1Bx20g
   R250oVZKTG7sdP0YEP1L3zmYsSbkPSEbcFXVNsdNZHm04NzQJn0U81Zyl
   TlajL1wrMniDjQ/6KnFvI+AqXPTEZZB2S4uS/9crBGTIeFgweKPE/iQMd
   7HvaGnbRw32plibGMOemLyXz35+rJwMOk4iS+m2blaw0krUOgDWwiB+RQ
   VXZlIx+fE9PVijWYJiv5JRWCQrISRh0V6d6GWzu8vKYHrjei+DE282thx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331784593"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="331784593"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 09:50:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="813047050"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="813047050"
Received: from bjelliot-mobl1.amr.corp.intel.com (HELO [10.209.100.192]) ([10.209.100.192])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 09:50:32 -0800
Message-ID: <65fc95bb-5ad9-b589-d6a4-762289b3f6bc@intel.com>
Date:   Thu, 16 Feb 2023 09:50:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 15:48, Kirill A. Shutemov wrote:
> The patch brings basic enabling of kexec in TDX guests.
> 
> By "basic enabling" I mean, kexec in the guests with a single CPU.
> TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
> doesn't allow to put a CPU back offline if it has woken up.
> 
> We are looking into this, but it might take time.

This is simple enough.  But, nobody will _actually_ use this code as-is,
right?  What's the point of applying it now?
