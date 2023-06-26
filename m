Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A373D80B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFZGvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFZGvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:51:47 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF897E7D;
        Sun, 25 Jun 2023 23:51:42 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9891c73e0fbso538417866b.1;
        Sun, 25 Jun 2023 23:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687762301; x=1690354301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjqDZn3lJ7Kgt+uw5GaBXsy3/mcmdXSrFa1NBqXg2gw=;
        b=fNY3rk2rI+y7KhNmyEEZoKPGKzy3gGh4ZQYRPP0b+vpQ5jwyxIc10D9i+Rm71dXTyH
         z9f1gjNpCEw80BBrC1TzSTTPtsMT6D+Kkls7YX+oJOVW75XWABkZcHy5sWEtDbKPQW5d
         /9N1mouapMqFfaG8jb8t8eaesPJ7/Tc8PBxqKXct4ACoVPSLMfg0g4xGSXSUsNja0YjZ
         /kEpoAbv51RhWZSLli2jP2pSJcaAE//NVsQzqbKPrq0rOYDjIZCpYxAhGkHMv+3+7RMQ
         gfp1IP1nrzopk4awpnYltMKcm8AR46HwepdItY+mXBvXgBpf4Ug0NYGRPfz67gGN7zLP
         617A==
X-Gm-Message-State: AC+VfDzwR7yGVj/S870jahKNlya48uQ57M23ZFZDbv7nzy7AQo0vzGEU
        i6jQyjuJD65W0nILzz7mUuk=
X-Google-Smtp-Source: ACHHUZ5TcqpCU/a4lfTn1GgvzKl82Z0/y61evtBh4iRo/bk0tPXvJwuCzDR8a77/ADGCM+JawAyd4g==
X-Received: by 2002:a17:907:3f87:b0:977:d660:c5aa with SMTP id hr7-20020a1709073f8700b00977d660c5aamr26059155ejc.31.1687762301096;
        Sun, 25 Jun 2023 23:51:41 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709061c1300b00988b6d05f33sm2846673ejg.223.2023.06.25.23.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 23:51:40 -0700 (PDT)
Message-ID: <eba3d9ce-389b-b4cf-1af2-6a5ee9ca5049@kernel.org>
Date:   Mon, 26 Jun 2023 08:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] carl9170: re-fix fortified-memset warning
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Shiji Yang <yangshiji66@outlook.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230623152443.2296825-1-arnd@kernel.org>
 <7c4622e7-d7a8-ae5d-e381-f726cb511228@gmail.com>
 <24986b5e-5cd1-4cd5-aff3-b5eab2c0fdde@app.fastmail.com>
 <3bb839fe-1dfd-57f5-a5b0-be5adac57a4c@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <3bb839fe-1dfd-57f5-a5b0-be5adac57a4c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 06. 23, 19:15, Christian Lamparter wrote:
> On 6/23/23 18:05, Arnd Bergmann wrote:
>> On Fri, Jun 23, 2023, at 17:38, Christian Lamparter wrote:
>>> On 6/23/23 17:23, Arnd Bergmann wrote:
>>>
>>> Wait! I want to point out this funny thing is happening in ath too!
>>>
>>> https://lore.kernel.org/linux-wireless/TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/T/#mf1b8919a000fe661803c17073f48b3c410888541
>>>
>>> And that patch got NACK by Jiri Slaby because like me he suspects that
>>> this is a compiler bug.
>>
>> FWIW, that is one I don't see with clang-17 or gcc-13. The one I'm 
>> addressing
>> here is the only thing I see in ath wireless with the default set of
>> warning options, though this driver does have a couple of others that
>> are unrelated, when you enable the source data check in memcpy() by
>> building with W=1.
>>
>>   In file included from  drivers/net/wireless/ath/ath9k/xmit.c:17:
>> In file included from  include/linux/dma-mapping.h:7:
>> In file included from include/linux/string.h:254:
>> /home/arnd/arm-soc/include/linux/fortify-string.h:592:4: error: call 
>> to '__read_overflow2_field' declared with 'warning' attribute: 
>> detected read beyond size of field (2nd parameter); maybe use 
>> struct_group()? [-Werror,-Wattribute-warning]
>>                          __read_overflow2_field(q_size_field, size);
>>                          ^
>> include/linux/fortify-string.h:592:4: error: call to 
>> '__read_overflow2_field' declared with 'warning' attribute: detected 
>> read beyond size of field (2nd parameter); maybe use struct_group()? 
>> [-Werror,-Wattribute-warning]
>> 2 errors generated.
>> /home/arnd/arm-soc/include/linux/fortify-string.h:592:4: error: call 
>> to '__read_overflow2_field' declared with 'warning' attribute: 
>> detected read beyond size of field (2nd parameter); maybe use 
>> struct_group()? [-Werror,-Wattribute-warning]
>>                          __read_overflow2_field(q_size_field, size);
>>
>>> so, what's going wrong with fortified there?
>>
>> Kees might have a better answer to that, my best guess is that
>> the one I'm addressing stems from the confusion between different
>> union members.
>>
>> Doing the randconfig builds with the latest compilers, carl9170 is the
>> only one I see with fortified-string warnings, and there are a few
>> dozen other drivers that I see with W=1, including one that affects
>> all wireless drivers.
> 
> Hm, question here (to Jiri as well). Do you think that a workaround patch
> for these 
> sort-of-obvious-but-compiler-bug-but-failed-to-make-a-simple-reproducer
> would be OK to get NACKed? In my case, I fiddled around with it and 
> replaced the
> the cc_ani memset in the following way:
> 
> |        memset(&common->cc_survey, 0, sizeof(common->cc_survey));
> |-       memset(&common->cc_ani, 0, sizeof(common->cc_ani));
> |+       common->cc_ani.cycles = common->cc_ani.rx_busy = 
> common->cc_ani.rx_frame = common->cc_ani.tx_frame = 0;

Nah, you are still changing the code for the compiler. And espectially 
this one calls for troubles later -- when cc_ani changes.

Again, work also with compiler guys, they are usually helpful. Both in 
helping to understand the issue (from the compiler POV) and provide a 
fix/workaround.

Even this carl9170 change looks very bad to me. While 
"memset_after(&txinfo->status, 0, rates);" means exactly what it does, 
those two memsets barely. It took me a while to understand what is going 
on and that it is the same. Don't do this.

Perhaps we need memset_no_check()?

thanks,
-- 
js
suse labs

