Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D36F58C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjECNNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjECNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:13:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B56A4C;
        Wed,  3 May 2023 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683119577; x=1714655577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IIXeI+ripUd8s4v1sJyWenwzfuWgZ/8pmxvBQG8Cqh8=;
  b=Yj/BVKS7YGvaeVXJrZkR5gH6AIu7KudYBTUqUG33fqWT4yzEwv0ZrRnB
   XdMgQ1LNHcq/GZ02FlId0mojO5fBAoxR+FpoWEnaoUU4cbvmP8TdoTldU
   Z42NGgvICtxnrWY84fV2PsI6QCCWFY9SDD3YuknBxsprPEDjWbr+i6LMI
   MIdSmHyUT7EC0a9I7MP4qMrsixcohd1SxWcQ5yBO/FQ75iS4/oVceS6cL
   oUViJFEnM4auFmGdzqyWr7OtMCfxSc+JyTKp6UoNIDei+1By2KnhKAEyH
   TSRyywVSaWxQB5ELTWz0REKbEPBdxSTbZsKtf2wngcbfkr5y51ZRQpNJe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="350727071"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="350727071"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 06:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="1026493664"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="1026493664"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2023 06:12:53 -0700
Message-ID: <8c4f85c1-32db-a84c-f77c-6e2aa556d2f4@linux.intel.com>
Date:   Wed, 3 May 2023 16:14:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v2] xhci-pci: Only run d3cold avoidance quirk for s2idle
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Donghun Yoon <donghun.yoon@lge.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424214859.3109-1-mario.limonciello@amd.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20230424214859.3109-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.4.2023 0.48, Mario Limonciello wrote:
> Donghun reports that a notebook that has an AMD Ryzen 5700U but supports
> S3 has problems with USB after resuming from suspend. The issue was
> bisected down to commit d1658268e439 ("usb: pci-quirks: disable D3cold on
> xhci suspend for s2idle on AMD Renoir").
> 
> As this issue only happens on S3, narrow the broken D3cold quirk to only
> run in s2idle.
> 
> Fixes: d1658268e439 ("usb: pci-quirks: disable D3cold on xhci suspend for s2idle on AMD Renoir")
> Reported-and-tested-by: Donghun Yoon <donghun.yoon@lge.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Guard against CONFIG_SUSPEND not being set

Thanks,
Checkpatch complains that it wants a link to the issue after a "Reported-by:" tag.

Is there any public report of this?

Thanks
Mathias


