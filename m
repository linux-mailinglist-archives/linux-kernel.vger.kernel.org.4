Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F18732593
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbjFPDDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbjFPDD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:03:26 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E422D72;
        Thu, 15 Jun 2023 20:03:23 -0700 (PDT)
Received: from [192.168.60.56] (unknown [103.29.142.67])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id B72D02803D6;
        Fri, 16 Jun 2023 11:03:14 +0800 (CST)
Message-ID: <f4bc4e7e-b9d4-432b-2157-f5b30c160a3a@rock-chips.com>
Date:   Fri, 16 Jun 2023 11:03:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: usb: typec: tcpm: fix cc role at port reset
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230616022001.25819-1-frank.wang@rock-chips.com>
 <3c3fbecd-caf9-c432-0890-93cceade98c1@roeck-us.net>
From:   Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <3c3fbecd-caf9-c432-0890-93cceade98c1@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGE5PVh0YHR8ZQkMfTRpLH1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpISkJIS1VKS0tVS1kG
X-HM-Tid: 0a88c228375a2eb1kusnb72d02803d6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46Ohw5GD1MPhAMSUIIKlY2
        ETIaFEtVSlVKTUNNQ0NPTkJNS0NIVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhPQkI3Bg++
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

On 2023/6/16 10:27, Guenter Roeck wrote:
> On 6/15/23 19:20, Frank Wang wrote:
>> In the current implementation, the tcpm set CC1/CC2 role to open when
>> it do port reset would cause the VBUS removed by the Type-C partner.
>>
>> This sets CC1/CC2 according to the default state of port to fix it.
>>
>> Comments are suggested by Guenter Roeck.
>>
>
> I have no idea (recollection) of what I suggested here :-(

Aha, this is also an old patch I have sent before, you suggested that 
the cc role should require some tweaking based on the port type or 
default state, do you remember it now?

Anyway, Can you help to review this patch again?


BR.
Frank

>
> Guenter
>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c 
>> b/drivers/usb/typec/tcpm/tcpm.c
>> index 3c6b0c8e2d3ae..9f6aaa3e70ca8 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -4885,7 +4885,8 @@ static void run_state_machine(struct tcpm_port 
>> *port)
>>           break;
>>       case PORT_RESET:
>>           tcpm_reset_port(port);
>> -        tcpm_set_cc(port, TYPEC_CC_OPEN);
>> +        tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
>> +                TYPEC_CC_RD : tcpm_rp_cc(port));
>>           tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>>                      PD_T_ERROR_RECOVERY);
>>           break;
>

