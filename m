Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945AE6FA2A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEHIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:55:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577E44ED7;
        Mon,  8 May 2023 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683536109; x=1715072109;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=AWmWl70RzQ8bynQO/SBe1KoPGhvlrfJclFBw3z2YPoI=;
  b=OYDb/uzkTuOjm1WM9MTV4CVPGKgeVZGcXqLZ5XCRtgcG7vG+Tjfh/BHM
   gj3VG+hOvDmbYOeNJHtnkbc844MwmJNdSZvKt/ScGJD/KAVLoQ1rEiaUv
   M6LSR2R42JdJoYErpN/1WSq7j6ahbUzR1EPlzi7VFK/Q8PtesVfHt/Nq6
   FU0AdUd+uqfBN3yiip7hkq60yqCNi98fOni9vXAYkLVcaC1C3ihZdiJUc
   zk9g5qjEZksLQuKuzgvQhJ6iThYkaGwZ/s0Au7c/MrfVi0DyC2sDUVceq
   5xxHw0RsZ1ur9Rf80BtFqZW6fFCEdS42KbG47hZAHUlhsN64+Bk3443Ev
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="377685270"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="377685270"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:55:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="872723153"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="872723153"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2023 01:55:02 -0700
Message-ID: <06a03d3b-f1a1-8058-3b8c-c9786d66d3de@linux.intel.com>
Date:   Mon, 8 May 2023 11:56:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Content-Language: en-US
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tonywwang@zhaoxin.com, weitaowang@zhaoxin.com,
        stable@vger.kernel.org
References: <20230421203853.387210-1-WeitaoWang-oc@zhaoxin.com>
 <20230421203853.387210-2-WeitaoWang-oc@zhaoxin.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2 1/4] xhci: Add some quirks for zhaoxin xhci to fix
 issues
In-Reply-To: <20230421203853.387210-2-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.4.2023 23.38, Weitao Wang wrote:
> Add a quirk XHCI_ZHAOXIN_HOST for zhaoxin xhci to fix issues,
> there are two cases will be used.
> - add u1/u2 support.
> - fix xHCI root hub speed show issue in zhaoxin platform.
> 
> Add a quirk XHCI_ZHAOXIN_TRB_FETCH to fix TRB prefetch issue.
> 
> On Zhaoxin ZX-100 project, xHCI can't work normally after resume
> from system Sx state. To fix this issue, when resume from system
> sx state, reinitialize xHCI instead of restore.
> So, Add XHCI_RESET_ON_RESUME quirk for zx-100 to fix issue of
> resuming from system sx state.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---

I'd split this series into different logical parts:

patch 1/4
   Set XHCI_RESET_ON_RESUME quirk to ZHAOXIN host to fix resume issue.
   cc: stable

patch 2/4
   Add XHCI_ZHAOXIN_TRB_FETCH quirk flag together with code that allocates double pages
   cc: stable

patch 3/4
   Add XHCI_ZHAOXIN_HOST quirk flag together with code that corrects USB3 roothub minor version
   cc: stable

patch 4/4
   Set XHCI_LPM_SUPPORT quirk together with code that sets tier policy and u1/u2 timeouts,
   Don't add stable as this is about adding feature support.

Thanks
-Mathias

