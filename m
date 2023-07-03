Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284174611F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjGCRFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGCRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:05:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B8CD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:05:02 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GMyvqgymIvjvzGMyvqofj8; Mon, 03 Jul 2023 19:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688403900;
        bh=a0h2WeZR5ZIgLMFVFqtSFBNARYIIoqbQKR8GHb2Hk1Y=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=sXg+tmLwyyU+9QNaWfn68yulpmL1kq+fXYVPAArQHDlnbvZIScYNW2GAKGI/DaKEs
         +VDAMCIFqNyrigWnne5qQDi0o4DwHj38Le3kXcbLxKCVvnPvdjawbUqlIx0IjMLnKZ
         ea5RsLXAuKPOywpW1aDtR23RziUjHKTwJx29/lW1WiW5vJPIlg0GF1DgeMMrsh8cAF
         SO2qeyquh4BmL/6ZsvcI1nq4JgHIYknQ7QwQ+TTW1jFhjORnC1p6umd9Ww/ALZg2ia
         92yVOHmNaGemXxKJGiIswhddDdsdpLN3lJTffc6r/N852rtaBHuXLhe6+3efFYKVZc
         mrrmbr/Xgx59w==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Jul 2023 19:05:00 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1854d8ec-0860-c8c1-bf16-572afda97ce0@wanadoo.fr>
Date:   Mon, 3 Jul 2023 19:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] powerpc: powermac: Use of_get_cpu_hwid() to read CPU node
 'reg'
Content-Language: fr
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230319145931.65499-1-robh@kernel.org>
 <168836201902.50010.13066091729121047041.b4-ty@ellerman.id.au>
 <f97e8c26-1379-dabc-21af-ebf4b06b31e7@wanadoo.fr>
In-Reply-To: <f97e8c26-1379-dabc-21af-ebf4b06b31e7@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/07/2023 à 19:01, Christophe JAILLET a écrit :
> Le 03/07/2023 à 07:26, Michael Ellerman a écrit :
>> On Sun, 19 Mar 2023 09:59:31 -0500, Rob Herring wrote:
>>> Replace open coded reading of CPU nodes' "reg" properties with
>>> of_get_cpu_hwid() dedicated for this purpose.
>>>
>>>
>>
>> Applied to powerpc/next.
>>
>> [1/1] powerpc: powermac: Use of_get_cpu_hwid() to read CPU node 'reg'
>>        
>> https://git.kernel.org/powerpc/c/bc1cf75027585f8d87f94e464ee5909acf885a8c
>>
>> cheers
>>
> 
> Hi,
> 
> I guess, that it does not really matter, but shouldn't the of_node_put() 
> be *after* the "reset_io = *rst;" statements to be absolutely safe?
> 
> 
> (This change is in my backlog and I have apparently never proposed it)

Well, in fact is was in:
https://lore.kernel.org/all/f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr/

> 
> CJ
> 
