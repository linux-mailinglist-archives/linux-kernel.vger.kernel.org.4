Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF69A6FC150
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjEIIJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjEIIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:08:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4ED6A59;
        Tue,  9 May 2023 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683619687; x=1715155687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CsBQVDzs+AyhViIYfvFI7BjnqmBy7jowKSpDt9yNVOM=;
  b=XOEVcmiWEHbkfhPTN4msxsgwJItL2C9B+T/xKlszgwswY5A8l6ALvM+R
   FPHBYHnaUpaiNAsauWOJMY7f2NWSaFcN3B9LhLLPRfVSoF4C7igbEvszg
   7MraUzyp+O5B2uwSVUbkVrLt+80COhglPhd1oS8jl0ccG/K6G5+plGUO6
   3zxFrIkr80/kbmIHVhqQUZBO0NXw9y9k3gXr2VKTzs0Gw2NAn7yjcmp3b
   Wi1heGGjUFHrYWUQBdt9UNLTvO8bwfjRFJWRwMJVEu3RLyLzR7/JOJSRv
   3XYrmKH4O0sEAz5t4kpwkka/i8LQXBlIeWHUea2WACMvc1WpF6CGE6KKJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="415400202"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="415400202"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 01:06:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="1028722785"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="1028722785"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2023 01:06:26 -0700
Message-ID: <d59ce91a-1992-6cae-1a6a-ada922594cda@intel.com>
Date:   Tue, 9 May 2023 11:08:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v4 0/4] Fix some issues for ZHAOXIN xHCI host
Content-Language: en-US
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     WeitaoWang@zhaoxin.com
References: <20230508212058.6307-1-WeitaoWang-oc@zhaoxin.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <20230508212058.6307-1-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.5.2023 0.20, Weitao Wang wrote:
> Fix some issues for ZHAOXIN xHCI host.
> 
> Weitao Wang (4):
>    xhci: Fix resume issue of some ZHAOXIN hosts
>    xhci: Fix TRB prefetch issue of ZHAOXIN hosts
>    xhci: Show ZHAOXIN xHCI root hub speed correctly
>    xhci: Add ZHAOXIN xHCI host U1/U2 feature support
> 
>   drivers/usb/host/xhci-mem.c | 38 ++++++++++++++++++++++++--------
>   drivers/usb/host/xhci-pci.c | 13 +++++++++++
>   drivers/usb/host/xhci.c     | 43 ++++++++++++++++---------------------
>   drivers/usb/host/xhci.h     |  2 ++
>   4 files changed, 62 insertions(+), 34 deletions(-)
> 

Thanks, added to queue

-Mathias
