Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E563460EA69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiJZUmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiJZUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:42:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951F9F35E;
        Wed, 26 Oct 2022 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666816924; x=1698352924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xeuc8kocyPNzVa+dllrDgz0yAMqfPDA2pAu02G6CzG0=;
  b=WECIVBevJ3BQ9kkrdWZIVzuNXCdcF7sgUL3jyXJlt7vW1WKtWUJ4bN2w
   fhOSS81vX2PMlUI5tEXXiONsnjGUs+F0Cf9J507CkzIza47wG8WpZPO8e
   0M5yQjz1+J+QF7rCHI5EOtWkToFRrSAuw1LQl3ZGVGgiW1XaWIoYBHmnV
   fvRrmgzMK3wr9mavdUvZFSIQ6gFpA6/eZb5vfZryAWgJ/g3TlL4QgIEia
   Sa+civQQpC3FmbTJg7z0XC8NpH6AaGhlnmegL3ez/3UunAIzc94IURidk
   oJd2iu2RIvbCWc95rHNl3zKeHuNBvjp6ULD6ogm3dcRL9f9de7Sa/97W6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="288450855"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="288450855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:42:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="610103334"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="610103334"
Received: from bcoan-mobl2.amr.corp.intel.com (HELO [10.209.189.197]) ([10.209.189.197])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:42:03 -0700
Message-ID: <37b7c58c-a82d-257f-27d8-a4d61bc3677a@linux.intel.com>
Date:   Wed, 26 Oct 2022 15:38:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/9] ASoC: qdsp6: audioreach: topology use
 idr_alloc_u32
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, bgoswami@quicinc.com
References: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
 <20221021165207.13220-2-srinivas.kandagatla@linaro.org>
 <35f55696-c4c5-1f00-dc7e-b5c7dcf0a091@linux.intel.com>
 <4d2fcabe-291a-9f8d-ca48-eaf52e00695e@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <4d2fcabe-291a-9f8d-ca48-eaf52e00695e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/22 04:19, Srinivas Kandagatla wrote:
> Thanks Pierre,
> 
> On 21/10/2022 18:09, Pierre-Louis Bossart wrote:
>>
>>
>> On 10/21/22 11:51, Srinivas Kandagatla wrote:
>>> SubGraph and Module Instance ids take 32 bits, so use idr_alloc_u32
>>> instead of idr_alloc to able to accomdate valid ranges.
>>
>> typo: accommodate.
>>
> will fix it in next version
> 
>> Also worth checking
>> https://www.kernel.org/doc/html/latest/core-api/idr.html
>> "The IDR interface is deprecated; please use the XArray instead."
> Thanks for this hit, this looks really good and specially lookups
> without Locking, this could cleanup the code a bit.
> 
> Having said that I would still like this patch go as it is with idr for
> now, and I can plan to rework on converting idr to xa later, as there
> are few more Qcom Audio drivers that have usage of idr.

sounds good.
