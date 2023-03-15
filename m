Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30886BA562
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCOC5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCOC5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:57:43 -0400
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324904BE9B;
        Tue, 14 Mar 2023 19:57:42 -0700 (PDT)
Received: from [172.16.12.33] (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 39E6768060E;
        Wed, 15 Mar 2023 10:57:37 +0800 (CST)
Message-ID: <d2edd8b0-642a-8519-3676-4591dd5399d0@rock-chips.com>
Date:   Wed, 15 Mar 2023 10:57:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] usb: typec: tcpm: fix multiple times discover svids
 error
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-3-frank.wang@rock-chips.com>
 <ZBA8xWmNDSDhUys2@kuha.fi.intel.com>
From:   Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <ZBA8xWmNDSDhUys2@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlCTVZKGB0ZTU5PTUlJHh1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6Ihw6DT0NLSI9LBkXDDA3
        CQ8KCSxVSlVKTUxDQ09CS05MQkNNVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPS0lINwY+
X-HM-Tid: 0a86e333a3022eb5kusn39e6768060e
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

On 2023/3/14 17:22, Heikki Krogerus wrote:
> On Mon, Mar 13, 2023 at 10:58:41AM +0800, Frank Wang wrote:
>> PD3.0 Spec 6.4.4.3.2 say that only Responder supports 12 or more SVIDs,
>> the Discover SVIDs Command Shall be executed multiple times until a
>> Discover SVIDs VDO is returned ending either with a SVID value of
>> 0x0000 in the last part of the last VDO or with a VDO containing two
>> SVIDs with values of 0x0000.
>>
>> In the current implementation, if the last VDO does not find that the
>> Discover SVIDs Command would be executed multiple times even if the
>> Responder SVIDs are less than 12, and we found some odd dockers just
>> meet this case. So fix it.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index 66de02a56f512..2962f7c261976 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -1515,7 +1515,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
>>   		pmdata->svids[pmdata->nsvids++] = svid;
>>   		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
>>   	}
>> -	return true;
>> +
>> +	/*
>> +	 * PD3.0 Spec 6.4.4.3.2: The SVIDs are returned 2 per VDO (see Table
>> +	 * 6-43), and can be returned maximum 6 VDOs per response (see Figure
>> +	 * 6-19). If the Respondersupports 12 or more SVID then the Discover
>> +	 * SVIDs Command Shall be executed multiple times until a Discover
>> +	 * SVIDs VDO is returned ending either with a SVID value of 0x0000 in
>> +	 * the last part of the last VDO or with a VDO containing two SVIDs
>> +	 * with values of 0x0000.
>> +	 *
>> +	 * However, some odd dockers support SVIDs less than 12 but without
>> +	 * 0x0000 in the last VDO, so we need to break the Discover SVIDs
>> +	 * request and return false here.
>> +	 */
>> +	return cnt == 7 ? true : false;
>          return cnt == 7

Okay, next to fix it.

BR.
Frank

