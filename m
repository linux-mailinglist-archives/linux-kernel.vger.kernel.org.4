Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54E47486BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjGEOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjGEOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:45:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A871BDF;
        Wed,  5 Jul 2023 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688568301; x=1720104301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s0GWJM5gFoud1+XZjR2N78Pc/ZDBarybll1Oke7Rovs=;
  b=kXRzAr1DMUkOspd90Mgaw5wg5aYYmRZ3NCAEXjxc2yJ1oWF8db5hmXJq
   i1jfWVI357igoyL7ew5GZ+wdtfPZ+Z5n8THbkfkCANl5uxuvfHHeku2PB
   O3GfkwK3QbKbqwyrFqKwXza1X03wbNt8Kt9BrtsMr/+MvbkWQSuuUYa8o
   b3wi41MohGnHsfDjJE2CP/qzHWq9cY1uD2bgVhCSB0KyU3UdgWgGPL2nD
   spAuYjLoIJZHYixzwo5LCWngzkn9YcznCYNXcb0JtXPLy4ErymORtKpwE
   WaOXvaDyZchgXy5ACtFBqkiEfrx+Ufs3q8NBLRrFakWcWd0pRuWcTwe6a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362226707"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="362226707"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 07:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="722430589"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="722430589"
Received: from meggieha-mobl.ger.corp.intel.com (HELO [10.252.48.235]) ([10.252.48.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 07:44:57 -0700
Message-ID: <14395e2a-db0b-8f26-3356-741945478eb0@linux.intel.com>
Date:   Wed, 5 Jul 2023 16:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/8] soundwire: fix enumeration completion
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rander Wang <rander.wang@linux.intel.com>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-2-johan+linaro@kernel.org>
 <907ad7a3-3384-c0c4-90a9-5beab4cc45e0@linux.intel.com>
 <ZKV-oXAWzRXnjXus@hovoldconsulting.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZKV-oXAWzRXnjXus@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/23 16:30, Johan Hovold wrote:
> On Wed, Jul 05, 2023 at 02:53:17PM +0200, Pierre-Louis Bossart wrote:
>> On 7/5/23 14:30, Johan Hovold wrote:
>>> The soundwire subsystem uses two completion structures that allow
>>> drivers to wait for soundwire device to become enumerated on the bus and
>>> initialised by their drivers, respectively.
>>>
>>> The code implementing the signalling is currently broken as it does not
>>> signal all current and future waiters and also uses the wrong
>>> reinitialisation function, which can potentially lead to memory
>>> corruption if there are still waiters on the queue.
>>
>> That change sounds good, but I am not following the two paragraphs below.
>>
>>> Not signalling future waiters specifically breaks sound card probe
>>> deferrals as codec drivers can not tell that the soundwire device is
>>> already attached when being reprobed. 
>>
>> What makes you say that? There is a test in the probe and the codec
>> driver will absolutely be notified, see bus_type.c
>>
>> 	if (drv->ops && drv->ops->update_status) {
>> 		ret = drv->ops->update_status(slave, slave->status);
>> 		if (ret < 0)
>> 			dev_warn(dev, "%s: update_status failed with status %d\n", __func__,
>> ret);
>> 	}
> 
> I'm talking about signalling the codec driver using the soundwire device
> via the completion structs. Unless the underling device is detached and
> reattached, trying to wait for completion a second time will currently
> timeout instead of returning immediately.
> 
> This affects codecs like rt5682, which wait for completion in component
> probe (see rt5682_probe()).
> 
>>> Some codec runtime PM
>>> implementations suffer from similar problems as waiting for enumeration
>>> during resume can also timeout despite the device already having been
>>> enumerated.
>>
>> I am not following this either. Are you saying the wait_for_completion()
>> times out because of the init_completion/reinit_completion confusion, or
>> something else.
> 
> It times out because the completion counter is not saturated unless you
> use complete_all().
> 
> Drivers that wait unconditionally in resume, will time out the second
> time they are runtime resumed unless the underlying device has been
> detached and reattached in the meantime (e.g. wsa881x_runtime_resume()).

Makes sense. The default on Intel platforms is to reset the bus in all
resume cases, that forces the attachment so we never saw the issue.

For this patch:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


