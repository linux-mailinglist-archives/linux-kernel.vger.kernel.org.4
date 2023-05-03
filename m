Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EED16F5C47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjECQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:58:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B662210C0;
        Wed,  3 May 2023 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683133085; x=1714669085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kO7/faBRypIieapfr1cyUkdtWOsYKOnH/qpu0PsViTY=;
  b=Z4nJWMxMktViI9/n5q+EvStN4YZo8HQYZNyCUuu3KULH2epDBPcEYgZz
   ZR+FNpXgGLncgSYeC/FsCWTBC5+gxOTD6ZuQvrAJ3qfvB3yPjMjDA0+zT
   PuShhmK6AoTT/cnO1Bh8xC4HKJRcZdIe9wKDLd7CVlY5aB2Cubx9nKfzU
   XTP10aDO4OPDBlHZz3mY+Fczkse0pwPPXnzTFGHu65oDk7rNZ87jdb64W
   K20fxAD7n3OwjiinI4zDvBBzfidIyMl6MZMfQgGms+Qy83WRmEcUXcYey
   TIRuPiU+M220Dsf8whNKRemIO04G15RIhBU4WrcZ/HzN+W+X33l4PRg0b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="435015870"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="435015870"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 09:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="766202179"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="766202179"
Received: from jshields-mobl.amr.corp.intel.com (HELO [10.209.77.83]) ([10.209.77.83])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 09:58:04 -0700
Message-ID: <d98a8aa1-9e15-7cb4-3bbb-4d4cd437d636@linux.intel.com>
Date:   Wed, 3 May 2023 10:30:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ASoC: codecs: wcd938x: fix accessing regmap on
 unattached devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Patrick Lai <quic_plai@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20230503144102.242240-1-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230503144102.242240-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/23 09:41, Krzysztof Kozlowski wrote:
> The WCD938x comes with three devices on two Linux drivers:
> 1. RX Soundwire device (wcd938x-sdw.c driver),
> 2. TX Soundwire device, which is used to access devices via regmap (also
>    wcd938x-sdw.c driver),
> 3. platform device (wcd938x.c driver) - glue and component master,
>    actually having most of the code using TX Soundwire device regmap.
> 
> When RX and TX Soundwire devices probe, the component master (platform
> device) bind tries to write micbias configuration via TX Soundwire
> regmap.  This might happen before TX Soundwire enumerates, so the regmap
> access fails.  On Qualcomm SM8550 board with WCD9385:
> 
>   qcom-soundwire 6d30000.soundwire-controller: Qualcomm Soundwire controller v2.0.0 Registered
>   wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:4 (ops wcd938x_sdw_component_ops)
>   wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:3 (ops wcd938x_sdw_component_ops)
>   qcom-soundwire 6ad0000.soundwire-controller: swrm_wait_for_wr_fifo_avail err write overflow
> 
> Fix the issue by:
> 1. Moving the regmap creation from platform device to TX Soundwire
>    device.  The regmap settings are moved as-is with one difference:
>    making the wcd938x_regmap_config const.
> 2. Using regmap in cache only mode till the actual TX Soundwire device
>    enumerates and then sync the regmap cache.
> 
> Cc: <stable@vger.kernel.org> # v3.14+
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Patrick Lai <quic_plai@quicinc.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Changes since v1:
> 1. Previous solution touched Soundwire. Rework it according to feedback.
>    https://lore.kernel.org/all/20230420101617.142225-7-krzysztof.kozlowski@linaro.org/
> 
> Thank you Mark and Pierre-Louis for great hints and valuable feedback!

LGTM, this was a very interesting thread to comment on.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
