Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51F62818E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiKNNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiKNNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:45:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31EF23E9A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:45:14 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h9so18363640wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=QlaQ+5L6ISjl1Quqoe6Zjc/8uHOtFVdW/GdcCpp/E/Q=;
        b=jSCYGC5OOaP6wUoO8qDSxyvxYcDe1o8zBe8FkfWoFAjWSsikhUAtNoMBmNwFeq3uhI
         G32ZWxouIGIydr0MRB9Py4ixg/z42dGJg9X3xVAoWk12hPfQEaNinSiqp34K6y+SQ+iY
         XAHHzVH+RkkSRuTNC9lGBtDX2pacFYyCNwmOOJPgLFOA4nU8UyGPUpGxeHPDvVChT8Oa
         U7WGPpTpSh9yPgOa8AOpqwwv6cLCWiKgJqiqk9m82By7kvu171l8969qwArbJxs+66N0
         WP+Mr33C3tQ6IQaS1TkZIpp2QgXt+NE+dcRr4s5aRbbi+eBghyuQtoYo9k6XbuSKJQ4d
         b3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlaQ+5L6ISjl1Quqoe6Zjc/8uHOtFVdW/GdcCpp/E/Q=;
        b=OLtg7HkCTEFVBL1xbiTTlkGP05P3JrgyzNp1yTNy8N+ZARkjFJlmQ5NWVIb/hMNxhR
         aXGEP5ypeTjF3Xv3h9E+eKJXVbJuCTphlyTrPiJ1Xw7VKFmHJJTAAV+Zh5DUrlyzt8h1
         j4QffvVS0i015Ux7l/CL/beF9ncKfcOuUUrAoR0FKhkjqUHJCqgv5jyGShP5Cp2CCDVW
         TkVmuP7NOe2F/sy9KDWWv/+KhYLk+x/kzKrhk0qWNdzm75+LAt32yqjxzr2mh5ggpNAI
         b2mdD+v67PDd35k4g6QuHJvPGgorMteYtDZI5cEUkBcuLvPaAQw9o2j7/3Tcihd5z/0c
         yMHg==
X-Gm-Message-State: ANoB5pl3jE5UF5hpBvD14vkeI4wJ+xohzF0Y19yzQENHS4WeXzSQZFoo
        a+aYn0COEREPeFNpbpoFBwY=
X-Google-Smtp-Source: AA0mqf6t6wgbEYsEROt1KuQTFtTIDd5a+5nbKAjINA0i+aNpO23kv16iWfHV1aCU/yGepWTsRNrKrA==
X-Received: by 2002:adf:bb43:0:b0:22e:6f0d:d69 with SMTP id x3-20020adfbb43000000b0022e6f0d0d69mr7759486wrg.134.1668433513466;
        Mon, 14 Nov 2022 05:45:13 -0800 (PST)
Received: from localhost (94.197.10.112.threembb.co.uk. [94.197.10.112])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d694b000000b0023691d62cffsm9536367wrw.70.2022.11.14.05.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:45:13 -0800 (PST)
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-6-aidanmacdonald.0x0@gmail.com>
 <03b94d20-05a6-71fb-61e4-00889f5aa64d@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     lee@kernel.org, mani@kernel.org, cristian.ciocaltea@gmail.com,
        wens@csie.org, tharvey@gateworks.com, cw00.choi@samsung.com,
        brgl@bgdev.pl, mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 05/18] mfd: max14577: Replace irqchip mask_invert with
 unmask_base
Date:   Mon, 14 Nov 2022 13:34:10 +0000
In-reply-to: <03b94d20-05a6-71fb-61e4-00889f5aa64d@linaro.org>
Message-ID: <KGy5eAsJh4YwYjYVTvnohmym61EBqJX5@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 12/11/2022 16:18, Aidan MacDonald wrote:
>> Remove use of the deprecated mask_invert flag. Inverted mask
>> registers (where a '1' bit enables an IRQ) can be described more
>> directly as an unmask register.
>>
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  drivers/mfd/max14577.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> Mention this is a resend or provide a changelog for v2.

Most of these patches are resends, but they're so trivial it seems
pointless to mention that fact. There are no changes from v1.

Regards,
Aidan

>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
