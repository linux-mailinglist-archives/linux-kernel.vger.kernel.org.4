Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E76573D41D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjFYUce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFYUcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:32:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9DB1B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:32:31 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id DWPLqcf9VaSuRDWPLqwghG; Sun, 25 Jun 2023 22:32:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687725149;
        bh=nXME6OkhzX+Q4/pak1Ee9R+HRMC5lmyRGp4wFkA/euE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=K2ec7ji3GcYvg/KUnFVjxHN/jm84mzOYzLt9J//aQuo6uoAOhtGX5hht1eT+0EUKN
         dzM4RD+e0+4JPCFPHvF/c1/JNdKgOx+VpkF5EmeSqEmryeMAkTsxsu4IOtA3dpljdE
         hqrRDwA4FQhTDMENHMHRcPCM4UC3gperLZKXUyoYThwInX2E1lhWJSux3l5yYCB2CL
         ArgD103J54cXgWADbDhOp2GdOfALHfG+Unhj/bh+d1ozdVlUV4Jvh0zUwJuKY+VVEW
         f1lRtyvEZ2UXn3pzXjSxkOEyYk0Kg1Y2a58RAuDyxCrmY1S7FR2Q2MtzbhiLy++uGF
         npg+Ir+solJ5w==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Jun 2023 22:32:29 +0200
X-ME-IP: 86.243.2.178
Message-ID: <36d9998f-e8b1-58cb-9b0a-97273b5eb91b@wanadoo.fr>
Date:   Sun, 25 Jun 2023 22:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/26] octeon_ep: use array_size
Content-Language: fr, en-GB
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Veerasenareddy Burru <vburru@marvell.com>,
        keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-3-Julia.Lawall@inria.fr>
 <20230624152826.10e3789b@kernel.org>
 <beb409e3-0c13-b817-dfa3-15792a341130@wanadoo.fr>
 <alpine.DEB.2.22.394.2306252221310.3022@hadrien>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <alpine.DEB.2.22.394.2306252221310.3022@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/06/2023 à 22:25, Julia Lawall a écrit :
> 
> 
> On Sun, 25 Jun 2023, Christophe JAILLET wrote:
> 
>> Le 25/06/2023 à 00:28, Jakub Kicinski a écrit :
>>> On Fri, 23 Jun 2023 23:14:33 +0200 Julia Lawall wrote:
>>>> -	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
>>>> +	oq->buff_info = vzalloc(array_size(oq->max_count,
>>>> OCTEP_OQ_RECVBUF_SIZE));
>>>
>>> vcalloc seems to exist, is there a reason array_size() is preferred?
>>
>> Hi,
>>
>> just for your information, I've just sent [1].
>>
>> CJ
>>
>> [1]:
>> https://lore.kernel.org/all/3484e46180dd2cf05d993ff1a78b481bc2ad1f71.1687723931.git.christophe.jaillet@wanadoo.fr/
> 
> For some reason, I have only received Christophe's mail, not Jakub's...
> 
> In any case, thanks for pointing out the existence of these functions.  I
> just redid what Kees did in 2018, when I guess these functions didn't
> exist.  I will look more carefully to see what functions are now available
> and resend the whole thing.

Hi,

should you want to go 1 step further and simplify some code:

git grep v[mz]alloc.*array_size\( | wc -l
174

CJ

> 
> Thanks!
> 
> julia

