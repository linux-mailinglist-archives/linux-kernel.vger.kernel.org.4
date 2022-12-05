Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABF6428CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiLEMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiLEMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:53:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29521A212;
        Mon,  5 Dec 2022 04:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670244797; x=1701780797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Qnk8evx1bCs9pSHx08fCvWXFHhwjrBycZptawhJUfPQ=;
  b=fwdNAPfE+X9eH+iUJobJdm8ost4sW/QaAHRDp96ZclhPWrTw0K3qs8L0
   SRUN0UxnD8gQ6rMX+zahJXbZ71X3gckFsgNpYFL8SceBeeZO7BX1PqHSh
   4JFT4caoia0y2GjNIkCJbUKdNh2JVnxUAfpaTQAJ2ZOtduTy2JvrlGnWK
   5S6/JV1VdjQ5dksTPIGxVPp4M4o0uCdnJewsdGTgAhrx8a44ZyJ5Uf8Us
   3ulriDt5+k41jhqokZCRe2bbG50UsTZtO7gj/l2bFBNeQitOcOGYHpVRC
   G4KCO/CkXiCmiWS/hnx3BA1ATYxbK5oacDxmfUsjUZ3ys2mvg+whnZsRN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="299765106"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="299765106"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 04:53:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752176970"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="752176970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2022 04:53:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p2Ay5-004sPI-2Z;
        Mon, 05 Dec 2022 14:53:09 +0200
Date:   Mon, 5 Dec 2022 14:53:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Subject: Re: [PATCH v10 1/2] gpio: loongson: add gpio driver support
Message-ID: <Y43ptYqOznh+jhFG@smile.fi.intel.com>
References: <20221201123220.7893-1-zhuyinbo@loongson.cn>
 <CACRpkdZm-4-5625szX_VqJoQH1OQZnw+jH3SqWsb9nr3S0Nbmw@mail.gmail.com>
 <35ff475a-e925-81eb-ffeb-448be43f59ff@loongson.cn>
 <Y4tq4i2CJdnQWFZC@smile.fi.intel.com>
 <Y4tuOyKOdZcQ4sjm@smile.fi.intel.com>
 <899d9d4c-36e8-6a4f-4243-dcf16f9ef29f@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <899d9d4c-36e8-6a4f-4243-dcf16f9ef29f@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:04:09PM +0800, Yinbo Zhu wrote:
> 在 2022/12/3 23:41, Andy Shevchenko 写道:

...

> I just compile it that it is still okay when remove acpi.h, so I will remove
> it in v11.

You need to address all review comments. I don't remember if I reviewed this,
but there are a lot of contribution from your side to the different subsystems
where I have commented on your code and you can check those reviews because
some of the remarks can be applied to this contribution as well.

Nevertheless, please Cc me in your v11 when you consider it will be ready.
Note, you have approx. month now to make it better. Of course you can
send a version to review before that.

...

> and, I'm afraid I didn't catch your meaning about "
> 
> what that "nice" container of the platform device for."
> 
> you said is for following code ?
> 144         struct platform_device *pdev =
> 145                 container_of(chip->parent, struct platform_device, dev);

Have you seen to_platform_device() macro?

-- 
With Best Regards,
Andy Shevchenko


