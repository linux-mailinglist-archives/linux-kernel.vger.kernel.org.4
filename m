Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FEB6D04FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjC3Mj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC3Mj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:39:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3857A8B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680179997; x=1711715997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YXSJ0Q649uavLR74vvhk3BhDtWCFAVLwvlC7i/3UMzM=;
  b=Ye4UI5QODuSSacWeYzlXIugEAI+F33bkVr8bqRiuFL5tqCHsD7JsWON1
   d9DtEQIqPB+10HQW+9VuDPt4tYlVASGBiJWu2InCJgVCpKJFq+07rQAJb
   s/+YPLPCTwXcsnyj1i4MKPOPEuV+qqt4xmlJh0XajRZtvAIbXrfMB8OeG
   vVUsL9xkiuJDLgkaq+8Z9DUXD3+WqV5flFRSE+IoC5K0QywDrzh9kcp+T
   ZX54vdojtEyVDjKJZGeFUjL/1es+2m3HMUN5ccaMUCZY4GwfK2NZZXUoE
   sYN8RH/h7GAlIMr9IzbEpmNnpd3tFAdW2j200pg9dzzpRGHj8ehy5VJpT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403807358"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="403807358"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 05:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795663145"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="795663145"
Received: from ngreburx-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.91])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 05:39:54 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8E369104388; Thu, 30 Mar 2023 15:39:51 +0300 (+03)
Date:   Thu, 30 Mar 2023 15:39:51 +0300
From:   kirill.shutemov@linux.intel.com
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, tony.luck@intel.com,
        wutu.xq2@linux.alibaba.com
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Message-ID: <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
> It seems MOVSXD which opcode is 0x63 is not handled, support
> to decode it in insn_decode_mmio().

Do you have a particular user in mind?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
