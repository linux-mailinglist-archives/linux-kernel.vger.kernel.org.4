Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4FC6A1E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBXPW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBXPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:22:24 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC366ADF6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677252143; x=1708788143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MhGM3MYVaJvxOcvRH4LRPO69GfRXxYIcxsnbb3HzPvE=;
  b=CBlUgKchaVSLsbpZES3cm2gPS5YunSRd6Q4imruzTySawq5DA8IDGFez
   +mhLg7hl89+ZX8V29QjOKrQL7dGkD9a15/8J6XLgWu4qt2hQMBkRl6YMV
   y1iuIsOph+2fnkEDWSq/YYAOTiavFNw4VVgIPQypOYMaKibVIqgBh8i7A
   Elwwg4NefVT/6hpmdmRFBcDLWTorMduXRkF92iED7LVY99C3SYasyUfBd
   ExwKBhd/4W43v+0/Kwt6wv3zNS3k8aODFXIbFE51tiV+fNQGMed7rEaU4
   gYOW9XpJKgcOjyWdb7EdJUr+quSknJi/tDKCfB37fEjCSP11bLI5ZH1mE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="396009164"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="396009164"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 07:22:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="650391419"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="650391419"
Received: from mrevans-mobl.amr.corp.intel.com (HELO [10.212.167.241]) ([10.212.167.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 07:22:18 -0800
Message-ID: <f32f1f77-c707-ae19-ae1a-dc0a37fa9806@intel.com>
Date:   Fri, 24 Feb 2023 07:22:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <6b09a3505bf3deaa11906a2ecb9d15c4ec427ea2.camel@infradead.org>
 <20230224143004.xqhpv6upn2fkqkjp@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230224143004.xqhpv6upn2fkqkjp@box.shutemov.name>
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

On 2/24/23 06:30, Kirill A. Shutemov wrote:
> Ideally, it has to be addressed on BIOS level: it has to provide a way to
> offline CPUs, putting it back to pre-wakeup state.

Is there anything stopping us from just parking the CPUs in a loop
looking at 'acpi_mp_wake_mailbox_paddr'?  Basically park them in a way
which is indistinguishable from what the BIOS did.
