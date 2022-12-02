Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A76406AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiLBMVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiLBMVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:21:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2321865A5;
        Fri,  2 Dec 2022 04:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669983694; x=1701519694;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=RCNCqkazhFBYrQaykaK4k78oh0l+6rQ5XaKkf5iBXLo=;
  b=St31RbfvJnvwS2xlikxiTbRCnTxYavzCnp3NNhpeiK0axAoTkv9Ggtyf
   7napnRMgATF0F8XOUBkPvBPcEylPTAEwMeSPSyFG3wODhFiRkz+ES2nDy
   fAPNTVLtfGUtMcWBgl8LQHp5LYhjBnaBJ4Rx4L6yVeIwdypZCjVgwX4A7
   FGDEgHNVSF29eA3nYpHt6yDLNe2O5+SlLMJHr00VANQ1SlJTRgWPe68Eo
   ix1x9ql9IdycSf/iD6/lLiqFjqHa+cPcR6iOvfJOl1bda0che50Im4sI+
   ZSh4eIuDhylx/5E0GWQ1BzkndBOJ/IPgdGAiTi5Zu/P+3shpoymC3v9ko
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="317091090"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="317091090"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 04:21:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="645012213"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="645012213"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2022 04:21:23 -0800
Message-ID: <ec0ce90c-b165-d84f-340d-4973b65609b3@linux.intel.com>
Date:   Fri, 2 Dec 2022 14:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daehwan Jung <dh10.jung@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
 <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
 <Y4hgnxGMEuizJumr@kroah.com>
 <c524cba6-4438-461a-ab05-9325fe09f832@app.fastmail.com>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH v1 2/2] usb: host: add xhci-exynos to support Exynos
 SOCs
In-Reply-To: <c524cba6-4438-461a-ab05-9325fe09f832@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.12.2022 11.01, Arnd Bergmann wrote:
> On Thu, Dec 1, 2022, at 09:06, Greg Kroah-Hartman wrote:
>> On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
>>> This driver works with xhci platform driver. It needs to override
>>> functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
>>> scenario of system.
>>
>> So this means that no other platform xhci driver can be supported in the
>> same system at the same time.
>>
>> Which kind of makes sense as that's not anything a normal system would
>> have, BUT it feels very odd.  This whole idea of "override the platform
>> driver" feels fragile, why not make these just real platform drivers and
>> have the xhci platform code be a library that the other ones can use?
>> That way you have more control overall, right?

Agree that overriding the generic platform driver xhci_hc_platform_driver
from this exynos driver is odd.

But I don't understand how this works.
Where are the hcds created and added when this xhci-exonys driver binds to
the device? all this driver does in probe is the overriding?

Am I missing something here?

> 
> Agreed, having another layer here (hcd -> xhci -> xhcd_platform ->
> xhcd_exynos) would fit perfectly well into how other SoC specific
> drivers are abstracted. This could potentially also help reduce
> the amount of code duplication between other soc specific variants
> (mtk, tegra, mvebu, ...) that are all platform drivers but don't
> share code with xhci-plat.c.
> 
> Alternatively, it seems that all of the xhci-exynos support could
> just be part of the generic xhci-platform driver: as far as I can
> tell, none of the added code is exynos specific at all, instead it
> is a generic xhci that is using the wakeup_source framework.

Sounds reasonable as well, and if some exynos specific code is needed
then just create a xhci_plat_priv struct for exynos and pass it in
of_device_id data like other vendors that use the generic
xhci-platform driver do.

-Mathias

