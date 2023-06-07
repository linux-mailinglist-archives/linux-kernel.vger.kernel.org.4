Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F31726542
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbjFGP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241375AbjFGP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:57:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D91FE5;
        Wed,  7 Jun 2023 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686153416; x=1717689416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cZe/eY9WGZFDdbzJxKfNGQkftH/W4BRuRruN4kLXhu0=;
  b=PFavA8LIwNPmlbm5CY1FbpcE1sbNXmPCOurYPpvimN8CEyD5iZup/I7t
   KeA5QTIwbH/sg8a9u2R9nzypxMSlQvMWOxY6StoBqK6l4zq9a0YbhqQDn
   yuOQg1pkV7II3GwM8+nO6crsqiOWYS0ivjK/eqaRyuqLYXHajCbcKO6iU
   QKk2qKmRgooCPmSJaZ16ubWyeTBPuXRKrqwQJEIhGFo816/MJwakj8V6R
   SerxgeU4SqYz9eSl7E5+XM6XRzqpwZsa1jr4sXkox16RjNerzQZ/TN7oW
   AjDX5JwSHyndv9iojwyO9EAXvokt5JLvNVerWG4GERCS6mS1hTbp1SD+5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360360060"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="360360060"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739335786"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="739335786"
Received: from sorrin-mobl3.amr.corp.intel.com (HELO [10.209.124.63]) ([10.209.124.63])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:56:50 -0700
Message-ID: <5f647902-436a-ea1c-412e-30afbc4e71a8@linux.intel.com>
Date:   Wed, 7 Jun 2023 09:51:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] soundwire: qcom: fix storing port config out-of-bounds
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230601102525.609627-1-krzysztof.kozlowski@linaro.org>
 <ZICBvP33XyOswWFM@matsya> <c39dc157-bd3d-a627-4eb0-a34ff43ab664@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c39dc157-bd3d-a627-4eb0-a34ff43ab664@linaro.org>
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



On 6/7/23 08:51, Krzysztof Kozlowski wrote:
> On 07/06/2023 15:10, Vinod Koul wrote:
>> On 01-06-23, 12:25, Krzysztof Kozlowski wrote:
>>> The 'qcom_swrm_ctrl->pconfig' has size of QCOM_SDW_MAX_PORTS (14),
>>> however we index it starting from 1, not 0, to match real port numbers.
>>> This can lead to writing port config past 'pconfig' bounds and
>>> overwriting next member of 'qcom_swrm_ctrl' struct.  Reported also by
>>> smatch:
>>>
>>>   drivers/soundwire/qcom.c:1269 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
>>>
>>> Fixes: 9916c02ccd74 ("soundwire: qcom: cleanup internal port config indexing")
>>> Cc: <stable@vger.kernel.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>> Link: https://lore.kernel.org/r/202305201301.sCJ8UDKV-lkp@intel.com/
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  drivers/soundwire/qcom.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>> index 7cb1b7eba814..88a772075907 100644
>>> --- a/drivers/soundwire/qcom.c
>>> +++ b/drivers/soundwire/qcom.c
>>> @@ -202,7 +202,8 @@ struct qcom_swrm_ctrl {
>>>  	u32 intr_mask;
>>>  	u8 rcmd_id;
>>>  	u8 wcmd_id;
>>> -	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
>>> +	/* Port numbers are 1 - 14 */
>>> +	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS + 1];
>>
>> Better use SDW_MAX_PORTS ?
> 
> That's interesting idea, but except of value, is the meaning actually
> the same? Driver claims that port 0 is masked and max number of ports is
> 14. Therefore it uses in all places constant QCOM_SDW_MAX_PORTS. We need
> here +1, only because we index from 1, not 0, but we still index over
> QCOM_SDW_MAX_PORTS, not SDW_MAX_PORTS. Wouldn't it be also confusing to
> use here SDW_MAX_PORTS but then index over something else?

SDW_MAX_PORTS only applies for the peripheral. DP0 is reserved for
non-audio/Bulk request, DP15 is an alias for "all ports"

There's nothing in the spec that restricts the ports on the manager
side, be it to dedicate Port0 or Port15 to a specific purpose or even
the number of ports.

I would recommend using a vendor-specific definition rather than
overloading a peripheral specification requirement.
