Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA2717FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjEaMTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEaMTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:19:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EDC10F;
        Wed, 31 May 2023 05:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69CD763889;
        Wed, 31 May 2023 12:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9880C433D2;
        Wed, 31 May 2023 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685535584;
        bh=MOaDbL+NiO4OhRTPz+e/kwwin5a8AKAbdpTTLVge0Yo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AHeTiweYFXX2P52j7l6i6MADs9RfXctsbgXrUNXzzXe/FKKVpRY7rB1lIx5Vt/S26
         ikZYC6v6fSKWlTpS/8cIdBqORXNwLP3Mqd2TDF7SOjX93x3qtDNvwCe8h/B8EZuAOO
         lBI7Ycu/DIcutr2uBZirHiStlzt1x+6LY/0qYt2IjdWQLPXh+dC8WIA8qVvpdjfJAs
         4pzzBiYqRUcauM9SNwCykBOSC2YwtoxqPr6gTBens6KnVmEYoie6kcvlvIT/9y7ddd
         +QQgNTEfWR86l/OAvcdq+PRpf2n3OU/qvSfjv35Y8//vA/km+M2tTUMjFyAyRVfxAh
         5U0QsHi7EqegA==
Message-ID: <90e94292-4300-e7f0-1a37-72a5c3bd77dc@kernel.org>
Date:   Wed, 31 May 2023 14:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] soc: qcom: pmic: Fix resource leaks in
 device_for_each_child_node() loops
Content-Language: en-US
To:     =?UTF-8?B?6Lev57qi6aOe?= <luhongfei@vivo.com>,
        "konradybcio@kernel.org" <konradybcio@kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <TYZPR06MB66976D6A4FC1674574531D45CE489@TYZPR06MB6697.apcprd06.prod.outlook.com>
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <TYZPR06MB66976D6A4FC1674574531D45CE489@TYZPR06MB6697.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.05.2023 12:40, 路红飞 wrote:
> 
> On 2023/5/31 17:03, Konrad Dybcio wrote:>
>> On 31.05.2023 10:54, Lu Hongfei wrote:
>>> The device_for_each_child_node loop in pmic_glink_altmode_probe should have
>>> fwnode_handle_put() before return which could avoid resource leaks.
>>> This patch could fix this bug.
>>>
>>> Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
>>>
>>> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
>>> ---
>> This is the third revision of this patch, please version them accordingly.
>>
>> You can pass `-vN` to git format-patch and it'll do the job for you.
>>
>> Please also describe the changes since last revision below the --- line.
>>
>> Konrad
> The latter two versions have added Fixes: tag, without any changes to the
> 
> specific content of this patch.
The commit message is an integral part of the patch, it's not only the 
diff that matters. Any change deserves a new revision number, unless you
made a mistake when sending the emails (e.g. you didn't fill out the To:
and Cc: fields properly), in which case you should use the [RESEND PATCH] tag.

> 
> Just use the third version of this patch.
Which I have to dig up by hand from the tens of patches I've received
since, because you did not specify which one is the third version
in the title. This also messes with patch workflow tools like b4.

Konrad
> 
> Thanks.
> 
> Lu Hongfei
> 
>>>   drivers/soc/qcom/pmic_glink_altmode.c | 27 ++++++++++++++++++---------
>>>   1 file changed, 18 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
>>> index df48fbea4b68..a7fc6570fa1e
>>> --- a/drivers/soc/qcom/pmic_glink_altmode.c
>>> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
>>> @@ -395,7 +395,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>>>   		ret = fwnode_property_read_u32(fwnode, "reg", &port);
>>>   		if (ret < 0) {
>>>   			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
>>> -			return ret;
>>> +			goto err_node_put;
>>>   		}
>>>   
>>>   		if (port >= ARRAY_SIZE(altmode->ports)) {
>>> @@ -405,7 +405,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>>>   
>>>   		if (altmode->ports[port].altmode) {
>>>   			dev_err(dev, "multiple connector definition for port %u\n", port);
>>> -			return -EINVAL;
>>> +			ret = -EINVAL;
>>> +			goto err_node_put;
>>>   		}
>>>   
>>>   		alt_port = &altmode->ports[port];
>>> @@ -420,33 +421,37 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>>>   
>>>   		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
>>>   		if (ret)
>>> -			return ret;
>>> +			goto err_node_put;
>>>   
>>>   		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
>>>   		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
>>>   		alt_port->dp_alt.active = 1;
>>>   
>>>   		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
>>> -		if (IS_ERR(alt_port->typec_mux))
>>> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
>>> +		if (IS_ERR(alt_port->typec_mux)) {
>>> +			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
>>>   					     "failed to acquire mode-switch for port: %d\n",
>>>   					     port);
>>> +			goto err_node_put;
>>> +		}
>>>   
>>>   		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
>>>   					       alt_port->typec_mux);
>>>   		if (ret)
>>> -			return ret;
>>> +			goto err_node_put;
>>>   
>>>   		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
>>> -		if (IS_ERR(alt_port->typec_switch))
>>> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
>>> +		if (IS_ERR(alt_port->typec_switch)) {
>>> +			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
>>>   					     "failed to acquire orientation-switch for port: %d\n",
>>>   					     port);
>>> +			goto err_node_put;
>>> +		}
>>>   
>>>   		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
>>>   					       alt_port->typec_switch);
>>>   		if (ret)
>>> -			return ret;
>>> +			goto err_node_put;
>>>   	}
>>>   
>>>   	altmode->client = devm_pmic_glink_register_client(dev,
>>> @@ -455,6 +460,10 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>>>   							  pmic_glink_altmode_pdr_notify,
>>>   							  altmode);
>>>   	return PTR_ERR_OR_ZERO(altmode->client);
>>> +
>>> +err_node_put:
>>> +	fwnode_handle_put(fwnode);
>>> +	return ret;
>>>   }
>>>   
>>>   static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
