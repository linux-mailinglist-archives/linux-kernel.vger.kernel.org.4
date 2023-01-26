Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1097267C703
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjAZJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjAZJW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:22:29 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEFB6779A;
        Thu, 26 Jan 2023 01:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674724948; x=1706260948;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=QZRD9g35F/NDRqYmL+T9yJOxG2xvHNVanQSxoCD9XHk=;
  b=l9MLMPdZi0HTJJUrYVqj9pkU6p4D/YbX9MpxO6W/0FK3xVfJIdxNbMIg
   eKBMA1wKvQXEXYL/ZsnXUIn/L7MUj00UIDIetYSoyaI/CYrmufnwLNyVT
   IrbLVAUqiuRvjFmUvXPt2YZfni4yLa0Iy5Kh8113uHc+x65UpbKCVC+5U
   NzhrtrEq3yShiKy52nnLu0HN+XZBD9XAZktFWk22woLYwqo9kQqfBO6S1
   /9crbFf2wDwHi6V6BiC4AFZ9XvOAhqCExO8hDH09EMY/qQPvV9PQ2FJVU
   DnO0/11CmQnJ1+VfHPVmoy+zmR2htlFJkjuufwJ3SST9ivSE2TvFqO7ky
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="413000682"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="413000682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 01:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="693274407"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="693274407"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2023 01:22:21 -0800
Message-ID: <1e889754-6492-4c53-27f0-796002d5680c@linux.intel.com>
Date:   Thu, 26 Jan 2023 11:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH v2 00/22] Introduce QC USB SND audio offloading
 support
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.1.2023 5.14, Wesley Cheng wrote:
> Changes in v2:
> 
> XHCI:
> - Replaced XHCI and HCD changes with Mathias' XHCI interrupter changes
> in his tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
> 

I'll submit the first three patches from that branch myself to usb-next, might modify
them slightly.
Just need to make sure they don't cause regression. Those are changes I want done anyway.

> Adjustments made to Mathias' changes:
>    - Created xhci-intr.h to export/expose interrupter APIs versus exposing xhci.h.
>      Moved dependent structures to this file as well. (so clients can parse out
>      information from "struct xhci_interrupter")
>    - Added some basic locking when requesting interrupters.
>    - Fixed up some sanity checks.
>    - Removed clearing of the ERSTBA during freeing of the interrupter. (pending
>      issue where SMMU fault occurs if DMA addr returned is 64b - TODO)

Was this solvable by first clearing high 32 bits and then low 32 bits?

Thanks
Mathias



