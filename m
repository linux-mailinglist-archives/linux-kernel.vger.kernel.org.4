Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D16C2E47
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCUJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCUJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:54:41 -0400
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669C23347A;
        Tue, 21 Mar 2023 02:54:38 -0700 (PDT)
Received: from [172.16.12.33] (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 17150680B61;
        Tue, 21 Mar 2023 17:54:31 +0800 (CST)
Message-ID: <6d7a4677-de1a-8851-026a-b180fca34632@rock-chips.com>
Date:   Tue, 21 Mar 2023 17:54:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/3] usb: typec: tcpm: add get max power support
Content-Language: en-US
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
 <19b39d82-8510-2717-cf3b-71cb955373d0@rock-chips.com>
 <20230321050048.3p7xtyikf2lkqwrg@mercury.elektranox.org>
From:   Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <20230321050048.3p7xtyikf2lkqwrg@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoeSVYZTx8fTUsfQkhKQ0tVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Txw6Qj0PORYyDEI#Dj4P
        TDUaFFZVSlVKTUxCSEJJT0xJS0lDVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTENINwY+
X-HM-Tid: 0a87039779f72eb5kusn17150680b61
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

On 2023/3/21 13:00, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Mar 21, 2023 at 09:32:53AM +0800, Frank Wang wrote:
>> On 2023/3/21 4:31, Sebastian Reichel wrote:
>>> On Mon, Mar 20, 2023 at 06:07:11PM +0800, Frank Wang wrote:
>>>> Traverse fixed pdos to calculate the maximum power that the charger
>>>> can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
>>>> property.
>>>>
>>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>>> ---
>>>>    drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>>>>    1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>>> index 13830b5e2d09f..d6ad3cdf9e4af 100644
>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>>> @@ -6320,6 +6320,27 @@ static int tcpm_psy_get_current_now(struct tcpm_port *port,
>>>>    	return 0;
>>>>    }
>>>> +static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
>>>> +					  union power_supply_propval *val)
>>>> +{
>>>> +	unsigned int src_mv, src_ma, max_src_mw = 0;
>>>> +	unsigned int i, tmp;
>>>> +
>>>> +	for (i = 0; i < port->nr_source_caps; i++) {
>>>> +		u32 pdo = port->source_caps[i];
>>>> +
>>>> +		if (pdo_type(pdo) == PDO_TYPE_FIXED) {
>>>> +			src_mv = pdo_fixed_voltage(pdo);
>>>> +			src_ma = pdo_max_current(pdo);
>>>> +			tmp = src_mv * src_ma / 1000;
>>>> +			max_src_mw = tmp > max_src_mw ? tmp : max_src_mw;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	val->intval = max_src_mw;
>>> The power-supply subsystem expects Microwatts and not Milliwatts.
>> Yes, but I see the 'power_supply_propval' member 'intval' is an integer
>> type, I worry about it may be overflowed that uses Microwatts.
> Data being encoded in Microwatts is part of the ABI. The data
> you are supplying will be interpreted in µW. If you submit your
> data in mW it is basically always wrong even without an overflow.
>
> Now regarding the overflow: A signed int can store 2^31 bit, so
> 2,147,483,648 µW = 2147 W. Looking at your code you effectively
> calculate Microwatts in an unsigned int and then divide by 1000.
> Since the intermediate value (before dividing by 1000) needs to be
> stored you gain only one bit. That raises the question: Why do you
> expect data to be between 2147 W and 4294 W when the latest released
> USB PD spec allows 5A@48V = 240W?
>
> -- Sebastian

Okay, got it, I shall delete conversion codes ( divide by 1000 ) in the 
next version.


BR.
Frank
