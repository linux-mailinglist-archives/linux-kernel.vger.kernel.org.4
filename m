Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC826B4B62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjCJPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjCJPms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:42:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE067431D;
        Fri, 10 Mar 2023 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678462172; x=1709998172;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=uRO3ncPTAeH91sp2hvb+p3FEDisPorSl78+BYWZMFcs=;
  b=f1a072YVVWTiY6veYABibib8mEgIWTPohQCguoeqRq07xTt39mNLzQtu
   cSytQZtdfgpGLzoT/LKBd4sfUFDlF+eaUCoa48sgRb+NNsP5CToccQAW6
   10xMQftSQkIZA93b/FemIijKq8/VP/Ss64Tkgma5rOXYq2ynJHSnpUxma
   wAlJ+4kFIWXSPvWLutQXqT7xx0dIyXV35ZoLetLq1E98ZCsOonh0RUBbf
   e+i/8NtqL9sepWm446o2DqZYZ7dl3/mFqhV1/LpQoFTZCqW24srSiuJt0
   hFkmR8o3AeO+27glcjgDxwJIaekWFXt/OJ5lwMED40xtKUZo/Im+nyDIZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="399342959"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="399342959"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 07:06:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="655216793"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="655216793"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2023 07:06:19 -0800
Message-ID: <a45ff335-0563-85c7-3b31-d6ca23a54a3f@linux.intel.com>
Date:   Fri, 10 Mar 2023 17:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-2-quic_wcheng@quicinc.com>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3 01/28] xhci: Add support to allocate several
 interrupters
In-Reply-To: <20230308235751.495-2-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.3.2023 1.57, Wesley Cheng wrote:
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Introduce xHCI APIs to allow for clients to allocate and free
> interrupters.  This allocates an array of interrupters, which is based on
> the max_interrupters parameter.  The primary interrupter is set as the
> first entry in the array, and secondary interrupters following after.
> 

I'm thinking about changing this offloading xHCI API
xhci should be aware and keep track of which devices and endpoints that
are offloaded to avoid device getting offloaded twice, avoid xhci driver
from queuing anything itself for these, and act properly if the offloaded
device or entire host is removed.

So first thing audio side would need to do do is register/create an
offload entry for the device using the API:

struct xhci_sideband *xhci_sideband_register(struct usb_device *udev)

(xHCI specs calls offload sideband)
Then endpoints and interrupters can be added and removed from this
offload entry

I have some early thoughts written as non-compiling code in:

git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git feature_interrupters
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

Let me know what you think about this.

> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

My Signed-off-by tag is being misused here.

I wrote a chunk of the code in this patch as PoC that I shared in a separate topic branch.
It was incomplete and not intended for upstream yet. (lacked locking, several fixme parts, etc..)
The rest of the code in this patch is completely new to me.

Thanks
-Mathias

