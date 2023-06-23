Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D392773BD96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFWRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFWRP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:15:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859BE19B7;
        Fri, 23 Jun 2023 10:15:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa71db4208so10108995e9.0;
        Fri, 23 Jun 2023 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687540520; x=1690132520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpruJpqRD9Nivq+p9bS5TatzCkYJCxgQ7JQyKEsL28M=;
        b=Nuh+b2r/XmWQEodrpVSZ8d8x+YAsFt4xqZsh6zA+LMbLWjEPXnHIgNxsJxVz+Xd9ja
         fxJ3IpuJ6SilPR/bx/VHr/AVT4uRvjJF+Uto0EUqvHYzcqAoWoCYfM7/6cpXTNEYNw/p
         c2f4qWO8YViR9NEKNjUJ0PK1p3H4io1DupAGXK4RAETaFc1jCw42nkO00/D+tUZWmieV
         6Dt7x6/LND0EWMC1osJNxwq4kqqU+qxGEAYMucbXV7dM2qPiXwVfS4XFbn9GhsGN2Gdg
         M8j9iPsUd0COr2UC5vdueaVk05FJmszrWL4wSz05oP3M/XiFaKwpSRaO0TmYlBLgTwKj
         KUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687540520; x=1690132520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpruJpqRD9Nivq+p9bS5TatzCkYJCxgQ7JQyKEsL28M=;
        b=K5dfyvsIsaZTy2drG3gizdjDm8xaQ5ZmWfdFZpqT0XBp5SMfgGy9Sflg7kWshA8B3k
         C+cnisFpRoUr4AaZC7ljSBw4/pYqr8Fs6OrMV9UHcfKdFuRUhjowmfHWiS+6wSdQYcoA
         LkLR4SW7MQ7BHcQ+QSnSzsf1p9s/aQBeOuXh3zL3pQ4wrNNdNRf+4agGs7nkNqZvuTOt
         IVNIYTUpu93qdmZ1MEBbYmqGTISUCFI6YuxKteXYZ8S5uIONXbN7fKpJj9Qzq68SVG6j
         MijRpJYSj302xFxSK066MMUbARP86zeHm1K+dfizrroc4QzvPCyKoUC7zW/Qr/TZARfX
         7PGQ==
X-Gm-Message-State: AC+VfDyshRsQoIdVpcrww46fMr/gJu4wFAy5Y/PF6ItowmEIsgia4HAf
        3lgwX0/jHLtqAzRyiqas5Cw=
X-Google-Smtp-Source: ACHHUZ61eY+ASvCwEJ0lXVzPXcLUyLn30qyrPxO7CWBIOxsHqGUkO8TK9Z0Kx6CKTN7QSaJxLLj8KA==
X-Received: by 2002:a05:600c:ad9:b0:3fa:7db9:86b0 with SMTP id c25-20020a05600c0ad900b003fa7db986b0mr1525661wmr.37.1687540519662;
        Fri, 23 Jun 2023 10:15:19 -0700 (PDT)
Received: from shift.daheim (p200300d5ff176500aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff17:6500:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b003fa74bff02asm2899201wml.26.2023.06.23.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 10:15:19 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift.daheim with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1qCkNS-000CgC-2Q;
        Fri, 23 Jun 2023 19:15:18 +0200
Message-ID: <3bb839fe-1dfd-57f5-a5b0-be5adac57a4c@gmail.com>
Date:   Fri, 23 Jun 2023 19:15:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] carl9170: re-fix fortified-memset warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Shiji Yang <yangshiji66@outlook.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230623152443.2296825-1-arnd@kernel.org>
 <7c4622e7-d7a8-ae5d-e381-f726cb511228@gmail.com>
 <24986b5e-5cd1-4cd5-aff3-b5eab2c0fdde@app.fastmail.com>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <24986b5e-5cd1-4cd5-aff3-b5eab2c0fdde@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 18:05, Arnd Bergmann wrote:
> On Fri, Jun 23, 2023, at 17:38, Christian Lamparter wrote:
>> On 6/23/23 17:23, Arnd Bergmann wrote:
>>
>> Wait! I want to point out this funny thing is happening in ath too!
>>
>> https://lore.kernel.org/linux-wireless/TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/T/#mf1b8919a000fe661803c17073f48b3c410888541
>>
>> And that patch got NACK by Jiri Slaby because like me he suspects that
>> this is a compiler bug.
> 
> FWIW, that is one I don't see with clang-17 or gcc-13. The one I'm addressing
> here is the only thing I see in ath wireless with the default set of
> warning options, though this driver does have a couple of others that
> are unrelated, when you enable the source data check in memcpy() by
> building with W=1.
> 
>   In file included from  drivers/net/wireless/ath/ath9k/xmit.c:17:
> In file included from  include/linux/dma-mapping.h:7:
> In file included from include/linux/string.h:254:
> /home/arnd/arm-soc/include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                          __read_overflow2_field(q_size_field, size);
>                          ^
> include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> 2 errors generated.
> /home/arnd/arm-soc/include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                          __read_overflow2_field(q_size_field, size);
> 
>> so, what's going wrong with fortified there?
> 
> Kees might have a better answer to that, my best guess is that
> the one I'm addressing stems from the confusion between different
> union members.
> 
> Doing the randconfig builds with the latest compilers, carl9170 is the
> only one I see with fortified-string warnings, and there are a few
> dozen other drivers that I see with W=1, including one that affects
> all wireless drivers.

Hm, question here (to Jiri as well). Do you think that a workaround patch
for these sort-of-obvious-but-compiler-bug-but-failed-to-make-a-simple-reproducer
would be OK to get NACKed? In my case, I fiddled around with it and replaced the
the cc_ani memset in the following way:

|        memset(&common->cc_survey, 0, sizeof(common->cc_survey));
|-       memset(&common->cc_ani, 0, sizeof(common->cc_ani));
|+       common->cc_ani.cycles = common->cc_ani.rx_busy = common->cc_ani.rx_frame = common->cc_ani.tx_frame = 0;

(Note here: cc_survey and cc_ani are of the same struct ath_cycle_counters!
and they are right next to each other! Even better: reordering the memset
in the code does not help. Reordering it in the ath_common does!)

This is less intrusive since it only replaces one line... but I'm afraid it
too will get flagged for the same reason... Maybe can someone give Shiji Yang,
or me, if he has lost interest, some guidance on how this can be addressed?

Best Regards,
Christian
