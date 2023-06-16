Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801907325B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbjFPDNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjFPDNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:13:16 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ECC1AA;
        Thu, 15 Jun 2023 20:13:13 -0700 (PDT)
Received: from [192.168.60.56] (unknown [103.29.142.67])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id E01B8280391;
        Fri, 16 Jun 2023 11:13:08 +0800 (CST)
Message-ID: <45886fef-b84a-5704-0a08-100a20296323@rock-chips.com>
Date:   Fri, 16 Jun 2023 11:13:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: usb: typec: tcpm: add get max power support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230616022157.25877-1-frank.wang@rock-chips.com>
 <f6c9fc11-df51-5ff8-c744-3325c20643b0@roeck-us.net>
From:   Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <f6c9fc11-df51-5ff8-c744-3325c20643b0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0weVh9LGEwdQkJOT04eHlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpKS0NISFVKS0tVS1kG
X-HM-Tid: 0a88c23148222eb1kusne01b8280391
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjY6Mzo5Vj1IURBJMRAUCRQy
        Nk0KCRxVSlVKTUNNQ0NOSkJLSU1IVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9PT0w3Bg++
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 2023/6/16 10:26, Guenter Roeck wrote:
> On 6/15/23 19:21, Frank Wang wrote:
>> Traverse fixed pdos to calculate the maximum power that the charger
>> can provide, and it can be got by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
>> property.
>>
>
> Wasn't this already v3 before ? What happened to the version, and the 
> change log ?
> Or is this a completely different/new patch ?
>

Yes, it is the v3 patch before which has been hold for a long time, 
Gregkh asked me to rebase it  and resubmit, so should I also add an 
"RESEND" tag in subject?


BR.
Frank


> Guenter
>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c 
>> b/drivers/usb/typec/tcpm/tcpm.c
>> index 9f6aaa3e70ca8..829d75ebab422 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -6340,6 +6340,27 @@ static int tcpm_psy_get_current_now(struct 
>> tcpm_port *port,
>>       return 0;
>>   }
>>   +static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
>> +                      union power_supply_propval *val)
>> +{
>> +    unsigned int src_mv, src_ma, max_src_uw = 0;
>> +    unsigned int i, tmp;
>> +
>> +    for (i = 0; i < port->nr_source_caps; i++) {
>> +        u32 pdo = port->source_caps[i];
>> +
>> +        if (pdo_type(pdo) == PDO_TYPE_FIXED) {
>> +            src_mv = pdo_fixed_voltage(pdo);
>> +            src_ma = pdo_max_current(pdo);
>> +            tmp = src_mv * src_ma;
>> +            max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
>> +        }
>> +    }
>> +
>> +    val->intval = max_src_uw;
>> +    return 0;
>> +}
>> +
>>   static int tcpm_psy_get_prop(struct power_supply *psy,
>>                    enum power_supply_property psp,
>>                    union power_supply_propval *val)
>> @@ -6369,6 +6390,9 @@ static int tcpm_psy_get_prop(struct 
>> power_supply *psy,
>>       case POWER_SUPPLY_PROP_CURRENT_NOW:
>>           ret = tcpm_psy_get_current_now(port, val);
>>           break;
>> +    case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
>> +        tcpm_psy_get_input_power_limit(port, val);
>> +        break;
>>       default:
>>           ret = -EINVAL;
>>           break;
>

