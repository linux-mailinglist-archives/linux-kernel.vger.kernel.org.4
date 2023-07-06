Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0274A0F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjGFP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGFP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:28:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D2AA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688657323; x=1720193323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/ZY/Jn97U2CeQ+yPrxzKKzEN7eFECFsMXyqEYNMCDLc=;
  b=Z2yFi94h3kCHTJGqnYAG5ac7NR5EQB4rRJVr5TWmemZKDZzLKPtxqOw9
   BVufgKiQN/FWZUYIzDW/3VufUqbVMPWIg6/IJk8MCnsY8OEn1q8W7ZOY1
   GbsGMtf03cLOaRX7VMuiPXm36SDJfRyhs2Y5F130Xnay0HFXRS0iX63PU
   JaU3rrKJGh988v4nOboF3+xMc6gi53blbxIERiF7mZi8RZqW1JJb/MgfY
   wfl021bQ1KBA7hPzdCTGpzrRyqM0JBJ52olwxZe/Z/WOfUjVoAIJqsOdj
   Pd0e/+Wj5gNDaU1M0IL5s9rhFTVntLL3Q/0GrRn6Tm6bv6hrsEBwB/q/5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="366211817"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="366211817"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 08:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="832988348"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="832988348"
Received: from adityan1-mobl1.amr.corp.intel.com (HELO [10.212.197.9]) ([10.212.197.9])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 08:28:08 -0700
Message-ID: <80383055-7d9f-dea8-1883-91084d0d24a1@intel.com>
Date:   Thu, 6 Jul 2023 08:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Content-Language: en-US
To:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, brgerst@gmail.com,
        ebiederm@xmission.com
References: <20230706052231.2183-1-xin3.li@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230706052231.2183-1-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 22:22, Xin Li wrote:
> When a null selector is to be loaded into a segment register,
> reload_segments() sets its DPL bits to 3. Later when an IRET
> instruction loads it, it zeros the segment register. The two
> operations offset each other to actually effect a nop.
> 
> Fix it by not modifying the DPL bits for a null selector.

So in the end, this is an optimization attempt?  Is there any other benefit?
