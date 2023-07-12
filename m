Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1731174FCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGLBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjGLBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:44:57 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 12A141712;
        Tue, 11 Jul 2023 18:44:55 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 66A6F60672098;
        Wed, 12 Jul 2023 09:44:41 +0800 (CST)
Message-ID: <284c0843-b749-00c8-95bc-6a0b220d9421@nfschina.com>
Date:   Wed, 12 Jul 2023 09:44:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next v2 03/10] net: ppp: Remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     mostrows@earthlink.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, xeb@mail.ru,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <ZK2Wf4man0H4e9Zz@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/12 01:50, Simon Horman wrote:
>> -	struct sock *sk = (struct sock *)chan->private;
>> +	struct sock *sk = chan->private;
>>   	struct pppox_sock *po = pppox_sk(sk);
>>   	struct net_device *dev = po->pppoe_dev;
> Hi,
>
> Please don't break reverse xmas tree ordering - longest line to shortest -
> of local variable declarations in Networking code.

Hi,

This can't be reversed because it depends on the first declaration.
Should I change it like this?

-	struct sock *sk = (struct sock *)chan->private;
- 	struct pppox_sock *po = pppox_sk(sk);
+	struct pppox_sock *po = pppox_sk(chan->private);
  	struct net_device *dev = po->pppoe_dev;
+	struct sock *sk = chan->private;

But this seems to be bad. As the advice of Andrew[1] and Dan[2]:

"

When dealing with existing broken reverse Christmas tree, please don't
make it worse with a change. But actually fixing it should be in a
different patch.

We want patches to be obviously correct. By removing the cast and
moving variables around, it is less obvious it is correct, than having
two patches.

"

Wu Yunchuan

[1] 
https://lore.kernel.org/all/23e98085-8f07-4ee2-8487-8e3b439b69f4@lunn.ch/
[2] 
https://lore.kernel.org/all/45519aec-6ec8-49e5-b5b2-1b52d336288c@kadam.mountain/
>
