Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1874E311
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGKBNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKBNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:13:52 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D2AC995;
        Mon, 10 Jul 2023 18:13:50 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id EFE6C602AC886;
        Tue, 11 Jul 2023 09:13:31 +0800 (CST)
Message-ID: <5ed0fff8-52dd-4059-797b-4275d54ae86b@nfschina.com>
Date:   Tue, 11 Jul 2023 09:13:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next v2 01/10] net: wan: Remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     qiang.zhao@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <23e98085-8f07-4ee2-8487-8e3b439b69f4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/11 00:34, Andrew Lunn wrote:
> On Mon, Jul 10, 2023 at 02:39:33PM +0800, Su Hui wrote:
>> From: wuych <yunchuan@nfschina.com>
>>
>> Pointer variables of void * type do not require type cast.
>>
>> Signed-off-by: wuych <yunchuan@nfschina.com>
>> ---
>>   drivers/net/wan/fsl_ucc_hdlc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
>> index 47c2ad7a3e42..73c73d8f4bb2 100644
>> --- a/drivers/net/wan/fsl_ucc_hdlc.c
>> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
>> @@ -350,11 +350,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
>>   static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
>>   {
>>   	hdlc_device *hdlc = dev_to_hdlc(dev);
>> -	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)hdlc->priv;
>> -	struct qe_bd *bd;
>> -	u16 bd_status;
>> +	struct ucc_hdlc_private *priv = hdlc->priv;
>>   	unsigned long flags;
>>   	__be16 *proto_head;
>> +	struct qe_bd *bd;
>> +	u16 bd_status;
> When dealing with existing broken reverse Christmas tree, please don't
> make it worse with a change. But actually fixing it should be in a
> different patch.
>
> We want patches to be obviously correct. By removing the cast and
> moving variables around, it is less obvious it is correct, than having
> two patches.
Got it, thanks.
I will resend the v3 later  which remove the change of reverse Christmas 
tree.
So sorry for this!

Wu Yunchuan

>
>         Andrew
