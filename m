Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F65E6FA2C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjEHI7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjEHI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:59:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831115695;
        Mon,  8 May 2023 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683536372; x=1715072372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vF8rQRTcg0Qb6PSV+SSaexqlbUZnUeRKMH3XSNDXkBE=;
  b=LkOquEuAGBRiw/ZtvkAA73XWrhbFV2dXG7XGIOApY5iUBELOtIvNXnzo
   uuPrukYSZvExa1chGl0Kbw8AF75LYUQmSShk0wE7jdWxACbB2qBJYD47a
   TQ1C4nkXpYODryitZjLjMuKBDmnLvTsbYNuuU9BWTljN3fwOm42Ycuf8N
   ++W34DIQB/t0SR9BTp6S4pkpP/5x1rVbRW2XVAIWggbW+7gMpuG8QLFel
   ppdXQ5jg8qbgu2zxl3+s2JwV/AqL7+VymLID/HGYByOBPKp3Elm/yRcMG
   cfaqB9RdWcl7BRw8CUSXPa+NKkmrV+YVBX+GZsRcpKoBno0LzvOBFdHv6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="412854457"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="412854457"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="701343490"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="701343490"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2023 01:59:29 -0700
Message-ID: <71834813-4f59-a453-5d17-1a44010047ad@linux.intel.com>
Date:   Mon, 8 May 2023 12:01:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/4] xhci: Add some quirks for zhaoxin xhci to fix
 issues
Content-Language: en-US
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tonywwang@zhaoxin.com, weitaowang@zhaoxin.com,
        stable@vger.kernel.org
References: <20230506201536.7362-1-WeitaoWang-oc@zhaoxin.com>
 <20230506201536.7362-2-WeitaoWang-oc@zhaoxin.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20230506201536.7362-2-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.5.2023 23.15, Weitao Wang wrote:
> Add a quirk XHCI_ZHAOXIN_HOST for zhaoxin xhci to fix issues,
> there are two cases will be used.
> - add u1/u2 support.
> - fix xHCI root hub speed show issue in zhaoxin platform.
> 
> Add a quirk XHCI_ZHAOXIN_TRB_FETCH to fix TRB prefetch issue.
> 
> On Zhaoxin ZX-100 project, xHCI can't work normally after resume
> from system Sx state. To fix this issue, when resume from system
> Sx state, reinitialize xHCI instead of restore.
> So, Add XHCI_RESET_ON_RESUME quirk for ZX-100 to fix issue of
> resuming from system Sx state.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>


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

(Accidentally replied to older v2 series with the above comments)

Thanks
-Mathias

