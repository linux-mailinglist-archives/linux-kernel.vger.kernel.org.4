Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6568392C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjAaWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:19:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508427A9D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675203566; x=1706739566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1k+bgDHjFw33vi2FYCvnMsD2v6XTns/PIAju5+u3Wh4=;
  b=R8z8SZH4GbpBKk50WqkOcLu5g6V7y4fLXr5RqJgqCW+QrrGDfqL5jli5
   kCa+MLutPL7Gr8pjRn39B9E9AOeaf6H+bRc2HLmq/4U2uOk4apyczTu1R
   VeFUkiO4122/2h+Yl6LLmdmzLPgu+Jg4jaaCUQkwy0oVRucMnyHAUrR7M
   ZPAj37wrwMuyL5CTpCUrkKMua2OOzgFeYjxzUt7smlx2Auabi7W0zicif
   mqv4TrPfhcwzi979fICoO4vB6EtbSLB1ts3UP3nUg8coJqEkoeyGdp46U
   uQm5SnyQ0Qthc7UCvkQ97TFRux0lnj5XmItem//15bmjY7NRyS33kXdzM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308318506"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308318506"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:19:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="788615794"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="788615794"
Received: from ncollins-mobl.amr.corp.intel.com (HELO [10.212.85.244]) ([10.212.85.244])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:19:25 -0800
Message-ID: <12b10990-8f06-e0a3-df6a-33fa20ba2cd9@linux.intel.com>
Date:   Tue, 31 Jan 2023 09:52:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3 8/8] ASoC: cs42l42: Wait for debounce interval after
 resume
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-9-sbinding@opensource.cirrus.com>
 <1e5e1312-18f5-e70f-3237-c2ffc851eef7@linux.intel.com>
 <cb52e4cf-47d8-33be-f77d-fc2d0b868a5c@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <cb52e4cf-47d8-33be-f77d-fc2d0b868a5c@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 05:03, Richard Fitzgerald wrote:
> On 30/01/2023 16:45, Pierre-Louis Bossart wrote:
>>
>>
>> On 1/27/23 10:51, Stefan Binding wrote:
>>> Since clock stop causes bus reset on Intel controllers, we need
>>
>> nit-pick: It's more that the Intel controller has a power optimization
>> where the context is lost when stopping the clock, which requires a bus
>> reset and full re-enumeration/initialization when the clock resumes.
>>
> 
> Ok, it's true that clock stop doesn't _cause_ bus reset, bus reset is
> necessary when exiting clock stop. We can re-word if you want us to
> describe that accurately.
> 
> But from the codec driver's point of view, a clock stop causes a bus
> reset.

it's fine, we all agree here.

>> The rest of the patch is fine so
>>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>>> to wait for the debounce interval on resume, to ensure all the
>>> interrupt status registers are set correctly.
>>>
>>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
