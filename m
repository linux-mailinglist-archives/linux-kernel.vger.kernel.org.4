Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43F672732
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjARSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjARSiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:38:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE0E10F0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674067097; x=1705603097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fNVfUI0/Z0DjRR7gwu1N9IY2Ziu6mt7cPXccrzYKj08=;
  b=Evyh7w1rRiRJqyWMa2Sjsxd98u9zMI5J9xtzcLCOKOIbjnlnNBydPQ3f
   Bbk5CW8c84woaRlo4msdR/IL7Z0ZKiShae0vHyNuNqfdVs/Z4gYnResQe
   wizX4yAmgCCp2QzmHw8BwA6xixw+EAjYTXAepkKVYKTHe1oPsOIca/a+s
   888WsVULEyImxBqjnIKQsoiDyQFv85uI4WJSVPNGvgY98g8IxlObuFytY
   ecGbotd4rISbamWSGQQI0XGYdfg0ntL2I/BlgxWSZn7CauF8kahCr16Ws
   EMtTTGTcNLQjrUMJxCx4gkQ21kHsIXrR6QwN+n/ntIQ/lOIjMFO+LB8Mw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327138542"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="327138542"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:38:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783777265"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="783777265"
Received: from jaibarra-mobl.amr.corp.intel.com (HELO [10.209.131.1]) ([10.209.131.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:59 -0800
Message-ID: <feb8eedc-c7fe-ef0e-85c8-faf6b0f3592e@linux.intel.com>
Date:   Wed, 18 Jan 2023 11:43:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/8] ASoC: cs42l42: Add Soundwire support
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/23 10:04, Stefan Binding wrote:
> The CS42L42 has a Soundwire interface for control and audio. This
> chain of patches adds support for this.
> 
> Patches #1 .. #5 split out various changes to the existing code that
> are needed for adding Soundwire. These are mostly around clocking and
> supporting the separate probe and enumeration stages in Soundwire.
> 
> Patches #6 .. #8 actually adds the Soundwire handling.
> 
> Changes since v1:
> - fixes for various review comments from v1
> - add support for wakeup from clock stop using hardware interrupts
> - use port_prep callback to prepare/deprepare codec
> 
> Richard Fitzgerald (6):
>   ASoC: cs42l42: Add SOFT_RESET_REBOOT register
>   ASoC: cs42l42: Ensure MCLKint is a multiple of the sample rate
>   ASoC: cs42l42: Separate ASP config from PLL config
>   ASoC: cs42l42: Export some functions for Soundwire
>   ASoC: cs42l42: Add Soundwire support
>   ASoC: cs42l42: Don't set idle_bias_on
> 
> Stefan Binding (2):
>   soundwire: stream: Add specific prep/deprep commands to port_prep
>     callback

probably want to CC: Vinod and Bard to get their Acked-by tag...

>   ASoC: cs42l42: Wait for debounce interval after resume
> 
>  drivers/soundwire/stream.c     |   4 +-
>  include/linux/soundwire/sdw.h  |   8 +-
>  include/sound/cs42l42.h        |   5 +
>  sound/soc/codecs/Kconfig       |   8 +
>  sound/soc/codecs/Makefile      |   2 +
>  sound/soc/codecs/cs42l42-sdw.c | 603 +++++++++++++++++++++++++++++++++
>  sound/soc/codecs/cs42l42.c     | 127 ++++---
>  sound/soc/codecs/cs42l42.h     |   9 +-
>  8 files changed, 716 insertions(+), 50 deletions(-)
>  create mode 100644 sound/soc/codecs/cs42l42-sdw.c
> 
