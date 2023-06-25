Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3600673CEAF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 08:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjFYG2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 02:28:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C67E46;
        Sat, 24 Jun 2023 23:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687674514; x=1719210514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C4MG8G7LRWqQ3aeXbDL7mcsgQWK2qLblMjk7Tb7DukY=;
  b=VzRk+O3l8yaFU+CX5M/CMZOEBSDUQNqXzTsSlQfCum/erS0snUWdXQ51
   r2Kn7GNGMLN7+FAh0C5YimwA1Wk7j2E90oUUKetoGHd0lRPNwf2h0ymuw
   20ab4oyTCj7yrFZDEqN/hQ/wU3w5sJxbwf/zmOn3qvlBqpyvdR2A4CAG1
   L+CBk5IZsaWnTC4erHDyN/sWE7l77zeo64vg7v3hWX8GS5RcjLfuOSzKu
   FrYITy7uv/amMUDeEygQ0O2WqJsSluOhYEHCbdFKddYEQWRD2e8kNxSO4
   3AKrfwlno89HKhTdj2QfOUlDRdxpG1Lm+tsl6Ypbqo7U/amQTAARduc+9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="350801505"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="350801505"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 23:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="1046087683"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="1046087683"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.214.223.122]) ([10.214.223.122])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 23:28:31 -0700
Message-ID: <546387b5-9e18-a0df-2aa9-159b19435a51@linux.intel.com>
Date:   Sun, 25 Jun 2023 09:28:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Use PME poll to circumvent
 unreliable ACPI wake
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com
Cc:     linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20230601162537.1163270-1-kai.heng.feng@canonical.com>
From:   "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230601162537.1163270-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2023 19:25, Kai-Heng Feng wrote:
> On some I219 devices, ethernet cable plugging detection only works once
> from PCI D3 state. Subsequent cable plugging does set PME bit correctly,
> but device still doesn't get woken up.
> 
> Since I219 connects to the root complex directly, it relies on platform
> firmware (ACPI) to wake it up. In this case, the GPE from _PRW only
> works for first cable plugging but fails to notify the driver for
> subsequent plugging events.
> 
> The issue was originally found on CNP, but the same issue can be found
> on ADL too. So workaround the issue by continuing use PME poll after
> first ACPI wake. As PME poll is always used, the runtime suspend
> restriction for CNP can also be removed.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
