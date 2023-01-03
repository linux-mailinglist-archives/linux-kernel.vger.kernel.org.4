Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F765BFBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjACMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjACMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:17:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB83A0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:17:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g16so22748779plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfHfxq3lX1f1scaBbnguDJEQzcQB49P5IAxROskdV+Y=;
        b=IKGnRgMpl0f0h7CR06OjOBmJXVNuyPBZdFuYhwyKib57ildXrzfTeCj7jnxdwYBm+O
         s6eh5WjpxSN/nyh/4VNrNeNwvKsxI+PJbXPOBe+jBMIM6rMqBdeVt33MOWFCZ7WwZY6A
         FH5HbOL0x2yBF8Y4Ny5C6TnHgYRvPGEvQ47hagVL4mpLX1F1hu8jWPut68MnPGxPDPnN
         9R9e8YIuP7zh+udt+1rTkDG+bY0jf0TbxDGjYe+0YoV1ROYY7CrO8c7lkdyJ28v7WXNS
         DRdj+bz7wLEJg2XTVpIE3hUFo3t/x6Hlm/4BEvP06zt4dxpDA7rtTCBiuC0uovGwxRdI
         GE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfHfxq3lX1f1scaBbnguDJEQzcQB49P5IAxROskdV+Y=;
        b=1QMoDW7s+GdegH0J6qW885xsghUtcu+Jauub/8XxnaBg1xwNMrz2yVq9jlyqKH6GhQ
         9z1hAxBAAg4oSMFCFY85VcNzJ1jQfqtoKPImq+LRrmWJppkxn3y/oapZaQooNx79LK13
         Wte1VEEBIbgnLhGGD+ThmkzX41NkC02V4nsfdn3bcNRmCBTRS7yAiotzYU/ZlbcKa475
         sHlcabAxWlaAk9SuOytWRcAu/2PIK5eJjNtYO4wqqmn2CdQfBVtqLoeRSwMK4J7+4T76
         pcXrbf/msz+bVajluluLUXQiPDws7a5XE+lDuCw3f8x8QyeqW8iz1DNPXkjhpQMLggEB
         wvEg==
X-Gm-Message-State: AFqh2kpOY8rS/8Rai5os8HH4Fs651vYEcPwOYSRW3HMQge5E9i0OOEB8
        fVEWekTaVJqwYyaupfNRh34=
X-Google-Smtp-Source: AMrXdXuPj0aDU2Pv1FchTwsvpXdW+66hAyjk7/7CmbxZ+eZvWBGR1MYIcryRSJ3NGLpc7z/HKBKwbA==
X-Received: by 2002:a17:902:d491:b0:192:b40b:e41 with SMTP id c17-20020a170902d49100b00192b40b0e41mr21388428plg.61.1672748241839;
        Tue, 03 Jan 2023 04:17:21 -0800 (PST)
Received: from [192.168.0.105] ([183.254.109.196])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0017849a2b56asm22174565plg.46.2023.01.03.04.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 04:17:21 -0800 (PST)
Message-ID: <a098244c-fe15-2c88-5c02-59aaa6cc3c6d@gmail.com>
Date:   Tue, 3 Jan 2023 20:16:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] um: vector: Fix memory leak in vector_config
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221229075323.1394010-1-linmq006@gmail.com>
 <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
 <eaedf019-349c-c686-0f23-093371b4b61f@cambridgegreys.com>
Content-Language: en-US
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <eaedf019-349c-c686-0f23-093371b4b61f@cambridgegreys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/3 18:28, Anton Ivanov wrote:
>
> On 03/01/2023 08:00, Geert Uytterhoeven wrote:
>> Hi Miaoqian,
>>
>> On Thu, Dec 29, 2022 at 8:53 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>>> kstrdup() return newly allocated copy of the string.
>>> Call kfree() to release the memory when after use.
>>>
>>> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
>>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> Thanks for your patch!
>>
>>> --- a/arch/um/drivers/vector_kern.c
>>> +++ b/arch/um/drivers/vector_kern.c
>>> @@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
>>>
>>>          parsed = uml_parse_vector_ifspec(params);
>>>
>>> +       kfree(params);
>> Are you sure the memory pointed to by "params" is no longer used?
>> "parsed" seems to contain pointers pointing to (parts of) the string
>> pointed to by "params", so it cannot be freed.
>
> +1.
>
> I was just about to send the same comment.
>
Oh yes, thanks for spotting this. We should only perform release when uml_parse_vector_ifspec() fails (returns NULL). In this situation, 'params' is no longer used. Do you agree?

Thanks,

>>
>>>          if (parsed == NULL) {
>>>                  *error_out = "vector_config failed to parse parameters";
>>>                  return -EINVAL;
>> Gr{oetje,eeting}s,
>>
>>                          Geert
>>
>> -- 
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                  -- Linus Torvalds
>>
