Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85635F9CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiJJKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiJJKjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:39:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404E101D7;
        Mon, 10 Oct 2022 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665398394; x=1696934394;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ezsf5xOPax03u3YmTxIyb1Cp501FLQRZmpDy7xiLNTI=;
  b=hruvWSzk/1DxKX0WWYfA0qDz40WqmSWcrVrTYGCmGXEj9+ysxDpdN+PZ
   EXplogOAahpVBENApsYLGiWSYHe5tFELralalSosHu5dhbshvd3WpicgC
   ZD+PO5tISAdLsTUVoRxIeigJZyLJxLcNtY3t0cnQ2CqblRfVHlFvb3mSc
   nuhs9tXjewKuH78cB2hd+UgaaqIgn7ZdfEG3mdcU05fz1qlnsmD9x7Mn6
   uom2aDMdEOylQ2RxatnJJeI4R+zQVJmFcYOgHiJ8N/ochOJmfmyAsoXWz
   l9MRG+99rYxBtI7RtS8DEK78rJWx2RLmVA6NBG3FXX63gN7Nc+LTJk3k9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="291481268"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291481268"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 03:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="751311194"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="751311194"
Received: from mylly.fi.intel.com (HELO [10.237.72.71]) ([10.237.72.71])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2022 03:39:51 -0700
Message-ID: <0c7e6208-307e-3788-e864-b79647c8b2a1@linux.intel.com>
Date:   Mon, 10 Oct 2022 13:39:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH v5 06/10] pwm: dwc: split pci out of core driver
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221005221242.470734-1-ben.dooks@sifive.com>
 <20221005221242.470734-7-ben.dooks@sifive.com>
Content-Language: en-US
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20221005221242.470734-7-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 10/6/22 01:12, Ben Dooks wrote:
> Moving towards adding non-pci support for the driver, move the pci
> parts out of the core into their own module. This is partly due to
> the module_driver() code only being allowed once in a module and also
> to avoid a number of #ifdef if we build a single file in a system
> without pci support.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v4:
>   - removed DWC_PERIOD_NS as not needed

...

> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> -
> -#define DWC_TIMERS_TOTAL	8
> -#define DWC_CLK_PERIOD_NS	10
> -

Actually DWC_CLK_PERIOD_NS is still used here. Only the next patch 07/10 
is removing usage of it so this patch is not bisect safe.

Jarkko
