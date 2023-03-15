Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26BE6BA55F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCOCze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCOCzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:55:32 -0400
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5245311C5;
        Tue, 14 Mar 2023 19:55:30 -0700 (PDT)
Received: from [172.16.12.33] (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 050976803C1;
        Wed, 15 Mar 2023 10:55:20 +0800 (CST)
Message-ID: <f0f0ac72-0a90-da9e-f686-49c21a76866b@rock-chips.com>
Date:   Wed, 15 Mar 2023 10:55:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] usb: typec: tcpm: fix cc role at port reset
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-2-frank.wang@rock-chips.com>
 <ZBA8Y/dbozOk2df7@kuha.fi.intel.com>
From:   Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <ZBA8Y/dbozOk2df7@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5OS1YdHkgYGRpPT0JPH0hVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6DAw*Iz0JLSIJPC8wQxEM
        USgKFBNVSlVKTUxDQ09DQklJS09MVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISU1MNwY+
X-HM-Tid: 0a86e3318ef62eb5kusn050976803c1
X-HM-MType: 1
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 2023/3/14 17:20, Heikki Krogerus wrote:
> On Mon, Mar 13, 2023 at 10:58:40AM +0800, Frank Wang wrote:
>> In the current implementation, the tcpm set CC1/CC2 role to open when
>> it do port reset would cause the VBUS removed by the Type-C partner.
>>
>> The Figure 4-20 in the TCPCI 2.0 specification show that the CC1/CC2
>> role should set to 01b (Rp) or 10b (Rd) at Power On or Reset stage
>> in DRP initialization and connection detection.
>>
>> So set CC1/CC2 to Rd to fix it.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index a0d943d785800..66de02a56f512 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -4851,7 +4851,7 @@ static void run_state_machine(struct tcpm_port *port)
>>   		break;
>>   	case PORT_RESET:
>>   		tcpm_reset_port(port);
>> -		tcpm_set_cc(port, TYPEC_CC_OPEN);
>> +		tcpm_set_cc(port, TYPEC_CC_RD);
>>   		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>>   			       PD_T_ERROR_RECOVERY);
>>   		break;
> Will this work if the port is for example source only?

Yeah, this only set at port reset stage and CC value will be set again
(Rd for Sink, Rp_* for Source) when start toggling.

BR.
Frank

