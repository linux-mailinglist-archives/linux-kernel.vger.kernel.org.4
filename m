Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA16C277E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCUBdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCUBdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:33:00 -0400
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18C722DEC;
        Mon, 20 Mar 2023 18:32:58 -0700 (PDT)
Received: from [172.16.12.33] (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 770EF6803D2;
        Tue, 21 Mar 2023 09:32:52 +0800 (CST)
Message-ID: <19b39d82-8510-2717-cf3b-71cb955373d0@rock-chips.com>
Date:   Tue, 21 Mar 2023 09:32:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/3] usb: typec: tcpm: add get max power support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230320100711.3708-1-frank.wang@rock-chips.com>
 <20230320100711.3708-4-frank.wang@rock-chips.com>
 <20230320203139.quld3gmoo6esu56i@mercury.elektranox.org>
Content-Language: en-US
From:   Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <20230320203139.quld3gmoo6esu56i@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9LTlYdGEMaHh0YSR8YTUhVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nz46Dww6Dz0WIRA3MxYtNBEL
        F0MaCzNVSlVKTUxCSE1JSExISENNVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSkJKNwY+
X-HM-Tid: 0a8701cc34f42eb5kusn770ef6803d2
X-HM-MType: 1
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 2023/3/21 4:31, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Mar 20, 2023 at 06:07:11PM +0800, Frank Wang wrote:
>> Traverse fixed pdos to calculate the maximum power that the charger
>> can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
>> property.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index 13830b5e2d09f..d6ad3cdf9e4af 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -6320,6 +6320,27 @@ static int tcpm_psy_get_current_now(struct tcpm_port *port,
>>   	return 0;
>>   }
>>   
>> +static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
>> +					  union power_supply_propval *val)
>> +{
>> +	unsigned int src_mv, src_ma, max_src_mw = 0;
>> +	unsigned int i, tmp;
>> +
>> +	for (i = 0; i < port->nr_source_caps; i++) {
>> +		u32 pdo = port->source_caps[i];
>> +
>> +		if (pdo_type(pdo) == PDO_TYPE_FIXED) {
>> +			src_mv = pdo_fixed_voltage(pdo);
>> +			src_ma = pdo_max_current(pdo);
>> +			tmp = src_mv * src_ma / 1000;
>> +			max_src_mw = tmp > max_src_mw ? tmp : max_src_mw;
>> +		}
>> +	}
>> +
>> +	val->intval = max_src_mw;
> The power-supply subsystem expects Microwatts and not Milliwatts.

Yes, but I see the 'power_supply_propval' member 'intval' is an integer 
type, I worry about it may be overflowed that uses Microwatts.


BR.
Frank

> -- Sebastian
>
>> +	return 0;
>> +}
>> +
>>   static int tcpm_psy_get_prop(struct power_supply *psy,
>>   			     enum power_supply_property psp,
>>   			     union power_supply_propval *val)
>> @@ -6349,6 +6370,9 @@ static int tcpm_psy_get_prop(struct power_supply *psy,
>>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>   		ret = tcpm_psy_get_current_now(port, val);
>>   		break;
>> +	case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
>> +		tcpm_psy_get_input_power_limit(port, val);
>> +		break;
>>   	default:
>>   		ret = -EINVAL;
>>   		break;
>> -- 
>> 2.17.1
>>

