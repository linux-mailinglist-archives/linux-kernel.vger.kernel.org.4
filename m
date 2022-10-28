Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08FD610FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJ1Lou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1Lor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:44:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744A311466;
        Fri, 28 Oct 2022 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666957485; x=1698493485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1bWiADtDd/t4Z9azXx4wg4Dmo+HQ4lKAycHBBevlklw=;
  b=AoH0d37lTLzO6bYFWLvTMkxtE8Sk3jbRA/5yYWT04irLHlrwhmPzwLWm
   g9fFIDJZUIfAzK9S5JjtXE1b8KDNUwQt23NpQTtH4pkqMGx2n77yRQK53
   y7NwIlzFUdbGgtLK0Bug29yU9kijUw82lpJZqOuMSFWv7JvMdfPbejMIq
   sQBrJaR4B2H4hdwlarKipXuo1+P0i7biPjg6xxPYrabG62a0268RXgPYN
   wKjbPqU3y8PCIQmobsa+5C2fpLmJI2eGRXR0gWSLrkQCNSTs6weduz2yF
   Utforn/mELjAFdnSJmTYNZQRE+Y/o2fioUtyJkxqgevVRR/G3ajNR9sRm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370537785"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="370537785"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 04:44:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="758056624"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="758056624"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.230]) ([10.99.249.230])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 04:44:40 -0700
Message-ID: <a7275ee4-c6ec-c0e8-c49d-dec9ca367d9f@linux.intel.com>
Date:   Fri, 28 Oct 2022 13:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 2/2] ASoC: dmic: Add optional dmic selection
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        devicetree@vger.kernel.org,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-3-ajye_huang@compal.corp-partner.google.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20221028102450.1161382-3-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2022 12:24 PM, Ajye Huang wrote:
> Having two DMICs, a front DMIC and a rear DMIC,
> but only host audio input AUX port0 is used for these two Dmics.
> A "dmic_sel-gpios" property is used for a mixer control to switch
> the dmic signal source between the Front and Rear Dmic.
> 
> usage: amixer -c0 cset name='Dmic Mux' 'FrontMic'
> usage: amixer -c0 cset name='Dmic Mux' 'RearMic'
> 
> Refer to this one as an example,
> commit 3cfbf07c6d27
> ("ASoC: qcom: sc7180: Modify machine driver for 2mic")
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---


I'm very suspicious of this patchset. As it is you add kcontrol which 
won't take effect on most platforms making use of DMIC. It feels to me 
that it is something you want to handle on machine driver side instead.

