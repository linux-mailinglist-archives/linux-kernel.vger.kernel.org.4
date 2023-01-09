Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640FF661FF6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjAII1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbjAII1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:27:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32826573;
        Mon,  9 Jan 2023 00:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673252837; x=1704788837;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=g1VnRHklLqjppg92qJLKB39oj5YFDePuqVevtrB3EZQ=;
  b=eUR3AcJr46VNG/BZPLKNpgA+JBxI7jYTvQvNQr1IusZOGRnH25CdH5zs
   wwNpzXwLR59NlLhd16aXAylThR/C+L3lou6lbktKB1wA2Jqp0gU+arAhW
   953N61t7kOxeg0zFJ3XsIor6grN+Y6qJXoaVlt8rHN6mW8V/6BSpfQRdz
   fBrv4A7ErJa5Xg3Mgu8MR6Id4ySeyvHH1nYlY7RdJkyTxAapoQQ3uw9qH
   gbZIfp3HG0sPdLNaiSMD99eTfMwCpghYnztllMDl3jTY76Oay4IhDeuSC
   0CxisuibnbZquUgoydWG2LGyqhzwu8mvxf9TOtxTXWf+fx68tNlVHP7bk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="320523137"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="320523137"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 00:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="719857265"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="719857265"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2023 00:27:15 -0800
Message-ID: <30fefd03-0ead-8980-ff5f-5e8a95e74c8a@linux.intel.com>
Date:   Mon, 9 Jan 2023 10:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221111101813.32482-1-jilin@nvidia.com>
 <f2dbfe41-7164-dffa-8e9c-2d5b0f8fcae6@nvidia.com>
 <Y7g9g0CbCc6b+3EN@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v7 0/3] xhci: tegra: USB2 pad power controls
In-Reply-To: <Y7g9g0CbCc6b+3EN@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.1.2023 17.25, Greg KH wrote:
> On Fri, Jan 06, 2023 at 02:56:51PM +0000, Jon Hunter wrote:
>> Hi Greg,
>>
>> On 11/11/2022 10:18, Jim Lin wrote:
>>> 1. Export symbol on xhci_hub_control
>>> 2. Add hub_control to xhci_driver_overrides
>>> 3. Program USB2 pad PD controls during port connect/disconnect, port
>>> suspend/resume, and test mode, to reduce power consumption on
>>> disconnect or suspend.
>>>
>>> Patch
>>> xhci: tegra: USB2 pad power controls
>>> depends on
>>> xhci: hub: export symbol on xhci_hub_control
>>> xhci: Add hub_control to xhci_driver_overrides
>>>
>>> Jim Lin (3):
>>>     xhci: Add hub_control to xhci_driver_overrides
>>>     xhci: hub: export symbol on xhci_hub_control
>>>     xhci: tegra: USB2 pad power controls
>>>
>>>    drivers/usb/host/xhci-hub.c   |   1 +
>>>    drivers/usb/host/xhci-tegra.c | 125 ++++++++++++++++++++++++++++++++++
>>>    drivers/usb/host/xhci.c       |   2 +
>>>    drivers/usb/host/xhci.h       |   2 +
>>>    4 files changed, 130 insertions(+)
>>>
>>
>>
>> I have verified that this still applies cleanly on top of -next. Please let
>> us know if this can be queued up for Linux v6.3?
> 
> Normally for xhci stuff I want it to go through Mathias for things that
> are outside of just xhci-tegra.c.

Looks good to me, can be picked up directly
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Or I can add this to the series going to usb-next if that is preferred.

Thanks
Mathias


> 
> thanks,
> 
> greg k-h

