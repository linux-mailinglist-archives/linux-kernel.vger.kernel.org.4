Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10B65BE9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjACLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjACLCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:02:53 -0500
X-Greylist: delayed 1988 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 03:02:34 PST
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4503310D9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:02:33 -0800 (PST)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1pCeXF-005C2N-6D; Tue, 03 Jan 2023 10:28:45 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1pCeXB-004VNL-Fn; Tue, 03 Jan 2023 10:28:44 +0000
Message-ID: <eaedf019-349c-c686-0f23-093371b4b61f@cambridgegreys.com>
Date:   Tue, 3 Jan 2023 10:28:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] um: vector: Fix memory leak in vector_config
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Miaoqian Lin <linmq006@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221229075323.1394010-1-linmq006@gmail.com>
 <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/01/2023 08:00, Geert Uytterhoeven wrote:
> Hi Miaoqian,
>
> On Thu, Dec 29, 2022 at 8:53 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>> kstrdup() return newly allocated copy of the string.
>> Call kfree() to release the memory when after use.
>>
>> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Thanks for your patch!
>
>> --- a/arch/um/drivers/vector_kern.c
>> +++ b/arch/um/drivers/vector_kern.c
>> @@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
>>
>>          parsed = uml_parse_vector_ifspec(params);
>>
>> +       kfree(params);
> Are you sure the memory pointed to by "params" is no longer used?
> "parsed" seems to contain pointers pointing to (parts of) the string
> pointed to by "params", so it cannot be freed.

+1.

I was just about to send the same comment.

>
>>          if (parsed == NULL) {
>>                  *error_out = "vector_config failed to parse parameters";
>>                  return -EINVAL;
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

