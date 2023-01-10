Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB38664F39
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjAJW5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjAJW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:57:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3E8E89
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673391438; x=1704927438;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4hylK35tR8nLIfFa9ivU4mSQk21DXzIlpMCpdjPytHc=;
  b=O6/YdPBnL4peoyBj6iicv/vAO72G0PQb1SJRyx8RKXg//KPHWajUk9s9
   K9SZsICUmc724HHiU41d+1ZLdhtgfgFMFIMPO4XdPq5dinnw9TZwJTIRo
   d9PFM/OVg0F2MLVSkyyXzrlMMgUaLjX/TL6UgdXxJA5icIQ3TROZTbVJG
   jONnlJvnVrcpxcEITuv2RqkHvyh0OXxenqFDvtUWFAgJvBdIrngQhkGak
   ADOTPcptqp0Ggp0yMu30qLL9rs3Ai/eIB603RnPqEkh2Y+V7G2U2BeBlv
   7ewtS53/G5diWcEMBaOUxKsUAOZQQjPGfiF1SrWGW0gkF+HqPS6xI56i6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="302979387"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="302979387"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 14:57:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="902516181"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="902516181"
Received: from svenka7-mobl1.amr.corp.intel.com (HELO [10.209.63.27]) ([10.209.63.27])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 14:57:17 -0800
Message-ID: <8ac54f52-5bf0-bf6c-2473-7f0cf2a1a957@intel.com>
Date:   Tue, 10 Jan 2023 14:57:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/7] Enable LASS (Linear Address space Separation)
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230110055204.3227669-1-yian.chen@intel.com>
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

On 1/9/23 21:51, Yian Chen wrote:
> LASS (Linear Address Space Separation) is a security
> extension that prevents speculative address accesses across 
> user/kernel mode. The LASS details have been published in
> Chapter 11 in 
> https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> LASS works in 64-bit mode only and partitions the 64-bit
> virtual address space into two halves:
>     1. Lower half (LA[63]=0) --> user space
>     2. Upper half (LA[63]=1) --> kernel space
> When LASS is enabled, a general protection #GP(0) fault will
> be generated if software accesses the address from the half in
> which it resides to another half, e.g., either from user space
> to upper half, or from kernel space to lower half. This
> protection applies to data access, code execution, cache line
> flushing instructions.

This does a good job of explaining the nuts and bolts -- *what* LASS
does.  It does a less good job of explaining why this was built, how it
can benefit end users and who cares about it.

LASS seemed really cool when we were reeling from Meltdown.  It would
*obviously* have been a godsend five years ago.  But, it's less clear
what role it plays today and how important it is.

Could you enlighten us, please?
