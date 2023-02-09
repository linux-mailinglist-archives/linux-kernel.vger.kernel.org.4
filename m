Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67752690CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBIPXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBIPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:23:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C1B4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675956226; x=1707492226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u8Vb8/bYrBeWgw+p0XSQUULBRKZVvrASNP/roYXBOOM=;
  b=Ccyyu4eaz3fSw3n8dI9KFr9b7guWCKN+S0quFYBZsqHTs8QACGg34rs1
   ERVfUpRQNJqXrILfsj1+obl0F3d5TLrgThTlgjEUP8b5jJMzbpm4s+ImV
   4r0UnHXwwGr2cDXpxL4o84HhQXxOoZ+ANH3xslE4BpxJ7rLqoUGj7+O7w
   DrBgSMI8TLGiNCaG+RBvnOk/WtpZ4wjpnRFGcNCCUR3ynAeVVByAA21oz
   3RomZNQxZdur9c9xWMTs3nnapIO406YAHEL8/OL3gtq4MD0G4vQgJLT2X
   mxh6kPRif/cjZzCSV+uzaCpahsSy19eo0g81+Mav8T4c0lqHQ53Sa1e+n
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="328771491"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="328771491"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:15:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="913156459"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="913156459"
Received: from fpastor-mobl4.amr.corp.intel.com (HELO [10.212.74.130]) ([10.212.74.130])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:15:03 -0800
Message-ID: <f73477e9-b27a-8cc7-dfe9-7208b3522083@linux.intel.com>
Date:   Thu, 9 Feb 2023 09:15:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH] ALSA: hda: remove redundant variable in
 snd_hdac_stream_start()
To:     Mark Brown <broonie@kernel.org>,
        Zhang Yiqun <zhangyiqun@phytium.com.cn>
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
        kuninori.morimoto.gx@renesas.com, ckeepax@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230209121723.14328-1-zhangyiqun@phytium.com.cn>
 <Y+UD4yg2cgsucnlZ@sirena.org.uk>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Y+UD4yg2cgsucnlZ@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 08:32, Mark Brown wrote:
> On Thu, Feb 09, 2023 at 08:17:23PM +0800, Zhang Yiqun wrote:
>> This 2nd variables are all set as true in treewide. So I think
>> it can be removed for easy understanding.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Btw there's another type of always-true parameter, we have a full_reset
parameter that's not used.

sound/soc/intel/skylake$ git grep  skl_init_chip
skl.c:static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
skl.c:  skl_init_chip(bus, true);
skl.c:                          skl_init_chip(bus, true);
skl.c:  err = skl_init_chip(bus, true);

sound/soc/intel/avs$ git grep  init_chip
core.c:static bool avs_hdac_bus_init_chip(struct hdac_bus *bus, bool
full_reset)
core.c: ret = snd_hdac_bus_init_chip(bus, full_reset);
core.c:         avs_hdac_bus_init_chip(bus, true);
core.c: avs_hdac_bus_init_chip(bus, true);
core.c: avs_hdac_bus_init_chip(bus, true);
