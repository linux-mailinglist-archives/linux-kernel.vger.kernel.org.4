Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF94470C414
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjEVROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjEVROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:14:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49211A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:13:53 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 196NqhcLAr2Gz196NqoYOC; Mon, 22 May 2023 19:13:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684775626;
        bh=cGy6oFFLYzBpOT3LT4xtm7V7n2XyhA3gSVOtW4fFuNU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=odtf7rUDDm/H+U5gEcs4tUKVR+fXrqEezUjRHAHR+9tXsyX4+B6PwwMyFzcSbxn76
         PfYzmPQCUKIoeqgkRRanLywuInoIa2uNXZmaDcEB2qTAHhzeheynow7cOgj9k3iU4G
         5c3R3LsjGvpUUiha1zgN3lBNVko4ff1V7gORdkQRCmp90CjWb3+egEblELsFuaMrmy
         6Q60hFKJ2lZiGpwkIIeEjw43wRq7o3XWGfuiAW4Y4+cxvBl44dxDrBQcaXc1UrabW6
         tmZh9RRfWtEaj+Aa1eQQVfHl/egA1koS3Fj1DWSc1E2Sdqlox+ATU5BtL3arBUvAH2
         ZbQQV3jiN03uA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 May 2023 19:13:46 +0200
X-ME-IP: 86.243.2.178
Message-ID: <8dbb4087-db01-fbbf-4e96-a5b0e170249a@wanadoo.fr>
Date:   Mon, 22 May 2023 19:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] forcedeth: Fix an error handling path in nv_probe()
Content-Language: fr, en-US
To:     Simon Horman <simon.horman@corigine.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Rain River <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ayaz Abdulla <aabdulla@nvidia.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
References: <355e9a7d351b32ad897251b6f81b5886fcdc6766.1684571393.git.christophe.jaillet@wanadoo.fr>
 <ZGtAIJZ3QzkBJgHI@corigine.com>
 <f4296d23-83ce-4147-894a-3e5640cdf87c@kili.mountain>
 <ZGtNwCc8ogSlwtYV@corigine.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZGtNwCc8ogSlwtYV@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/05/2023 à 13:10, Simon Horman a écrit :
> On Mon, May 22, 2023 at 01:35:38PM +0300, Dan Carpenter wrote:
>> On Mon, May 22, 2023 at 12:12:48PM +0200, Simon Horman wrote:
>>> On Sat, May 20, 2023 at 10:30:17AM +0200, Christophe JAILLET wrote:
>>>> If an error occures after calling nv_mgmt_acquire_sema(), it should be
>>>> undone with a corresponding nv_mgmt_release_sema() call.
>>>
>>> nit: s/occures/occurs/
>>>
>>>>
>>>> Add it in the error handling path of the probe as already done in the
>>>> remove function.
>>>
>>> I was going to ask what happens if nv_mgmt_acquire_sema() fails.
>>> Then I realised that it always returns 0.
>>>
>>> Perhaps it would be worth changing it's return type to void at some point.
>>>
>>
>> What? No?  It returns true on success and false on failure.
>>
>> drivers/net/ethernet/nvidia/forcedeth.c
>>    5377  static int nv_mgmt_acquire_sema(struct net_device *dev)
>>    5378  {
>>    5379          struct fe_priv *np = netdev_priv(dev);
>>    5380          u8 __iomem *base = get_hwbase(dev);
>>    5381          int i;
>>    5382          u32 tx_ctrl, mgmt_sema;
>>    5383
>>    5384          for (i = 0; i < 10; i++) {
>>    5385                  mgmt_sema = readl(base + NvRegTransmitterControl) & NVREG_XMITCTL_MGMT_SEMA_MASK;
>>    5386                  if (mgmt_sema == NVREG_XMITCTL_MGMT_SEMA_FREE)
>>    5387                          break;
>>    5388                  msleep(500);
>>    5389          }
>>    5390
>>    5391          if (mgmt_sema != NVREG_XMITCTL_MGMT_SEMA_FREE)
>>    5392                  return 0;
>>    5393
>>    5394          for (i = 0; i < 2; i++) {
>>    5395                  tx_ctrl = readl(base + NvRegTransmitterControl);
>>    5396                  tx_ctrl |= NVREG_XMITCTL_HOST_SEMA_ACQ;
>>    5397                  writel(tx_ctrl, base + NvRegTransmitterControl);
>>    5398
>>    5399                  /* verify that semaphore was acquired */
>>    5400                  tx_ctrl = readl(base + NvRegTransmitterControl);
>>    5401                  if (((tx_ctrl & NVREG_XMITCTL_HOST_SEMA_MASK) == NVREG_XMITCTL_HOST_SEMA_ACQ) &&
>>    5402                      ((tx_ctrl & NVREG_XMITCTL_MGMT_SEMA_MASK) == NVREG_XMITCTL_MGMT_SEMA_FREE)) {
>>    5403                          np->mgmt_sema = 1;
>>    5404                          return 1;
>>                                  ^^^^^^^^^
>> Success path.
>>
>>    5405                  } else
>>    5406                          udelay(50);
>>    5407          }
>>    5408
>>    5409          return 0;
>>    5410  }
> 
> Thanks Dan,
> 
> my eyes deceived me.
> 
> In that case, my question is: what if nv_mgmt_acquire_sema() fails?
> But I think the answer is that nv_mgmt_release_sema() will do
> nothing because mgmt_sema is not set.

At least, it is my understanding.

Can you fix the typo s/occures/occurs/ when applying the patch, or do 
you really need a v2 only for that?

CJ.

> 
> So I think we are good.
> 
> 
> 

