Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD39723393
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjFEXNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjFEXNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:13:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE486BE;
        Mon,  5 Jun 2023 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686006827; x=1717542827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Rs36xHdJOPkeYTMg5ogikCQYXM31lyqn0jteQ1r2C4=;
  b=SFWhDDJAcb3DXGq/xa/JkXYKOAbKPn/UlJ8iiJGorMYmexu6f9vSu0WQ
   DYnG05WKii32xp55i/V/oBC7ocyUysOjY754R3ZWlxmuAckRRNnH9TSKE
   9+Rf2Snt4WuX377oAyWOhb2ZAKO0O6ojp2zgp8/dI224G/E1oZGr4Tjcn
   bZi7vrJhfCnf50IziHrKarw9l+VZL925T3XXdoer13RsLLemAFi68GKqk
   QQR/wCfltd7CIa5yKjqRwIXQUQYn0YmDj7IYfhHgtAnYpw721rDWOn+Ix
   JHMVY25tYBI2/PRKPz9tKD7mdnrjkG8g8x1aCoZJKl9j7AiIbRXoQrKh/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359822747"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="359822747"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 16:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="711975756"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="711975756"
Received: from pmudgal-mobl1.amr.corp.intel.com (HELO [10.209.41.254]) ([10.209.41.254])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 16:13:46 -0700
Message-ID: <7e0e7074-4bc7-3f39-27df-623448044c72@intel.com>
Date:   Mon, 5 Jun 2023 16:13:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 05:02, Kirill A. Shutemov wrote:
> Touching privately mapped GPA that is not properly converted to private
> with MapGPA and accepted leads to unrecoverable exit to VMM.
> 
> load_unaligned_zeropad() can touch memory that is not owned by the
> caller, but just happened to next after the owned memory.
> This load_unaligned_zeropad() behaviour makes it important when kernel
> asks VMM to convert a GPA from shared to private or back. Kernel must
> never have a page mapped into direct mapping (and aliases) as private
> when the GPA is already converted to shared or when GPA is not yet
> converted to private.
> 
> guest.enc_status_change_prepare() called before adjusting direct mapping
> and therefore it is responsible for converting the memory to private.
> 
> guest.enc_status_change_finish() called after adjusting direct mapping
> and it converts the memory to shared.
> 
> It is okay to have a shared mapping of memory that is not converted
> properly. handle_mmio() knows how to deal with load_unaligned_zeropad()
> stepping on it.

Yeah, as other said, the changelog grammar here is a bit funky.  Can you
fix it up and resend, please?
