Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409DC6D6D22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjDDT2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjDDT2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:28:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952F84699
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680636510; x=1712172510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pnX2oZkahxccT55Ym8SzySplVHw8swVwxF8XJ8S7fQo=;
  b=ZDyAF1hXwQnVRPSzU2Y22zdAZBaKsdYrDybrLMynv/1jIAD2P736s3kW
   KeLFw26W/vcz9Q6uQyRMt56UlAEJjt2tX5n/LZOa8quzUopS/jF6/yodE
   Uhsq78b8YQyYuFXta3r4gTeZHdM2fwpKJxhYl18PvnGtpPps42jR9vkp0
   yTK4ToibzWSsYV9T4ef5PBs2HtK8XCRdoCaY8NEw1INlTbtugdsGesvzz
   cl2E9QNuSItgiFhJ3+T/jbHimsF2CbsejrYS3VQi2pxLiJYm2JUeSk0x0
   6kYS9RvG1pU9LdzGCaHTQ1TB0TUdFG7e8b4M/W6/VvQ4JFvuAJC6wApRB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="370102384"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="370102384"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 12:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="797629414"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="797629414"
Received: from jshresth-mobl1.amr.corp.intel.com (HELO [10.209.62.86]) ([10.209.62.86])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 12:27:43 -0700
Message-ID: <d3d95889-67ec-576e-ec9c-b9bd462e1c0e@intel.com>
Date:   Tue, 4 Apr 2023 12:27:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com>
 <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
 <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 11:09, Kirill A. Shutemov wrote:
>> If our AMD friends don't do this, what is their alternative?
> The alternative is coordination on the host side: VMM can load a BIOS that
> pre-accepts all memory if the kernel is older.
> 
> I know that it is not convenient for VMM, but it is technically possible.

Yeah, either a specific BIOS or a knob to tell the BIOS what it has to
do.  But, either way, that requires coordination between the BIOS (or
BIOS configuration) and the specific guest.  I can see why that's
unpalatable.

> Introduce an ABI with an expiration date is much more ugly. And nobody
> will care about the expiration date, until you will try to remove it.

Yeah, the only real expiration date for an ABI is "never".  I don't
believe for a second that we'll ever be able to remove the interface.

Either way, I'd love to hear more from folks about why a BIOS-side
option (configuration or otherwise) is not a good option.  I know we've
discussed this in a few mail threads, but it would be even better to get
it into the cover letter or documentation.
