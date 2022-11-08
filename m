Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF362193D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiKHQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiKHQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:20:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA2A1AE;
        Tue,  8 Nov 2022 08:20:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p12so9119814plq.4;
        Tue, 08 Nov 2022 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fcOTwRt74ZUVDeA76qVKozYMO1aqfbJjR0DYqZfdJoQ=;
        b=jgOlJCy9S5gp21jGo9mQxzBK+hBiRAXgddp+NZJ6U5V5orcLW9BzzSJOD9Qsky6ITl
         teDTlteRzITS5V8xd2L2VW/zflT0w4cs7WiZsOw4z++zYSDHtVADYshhQbgi/16YZrV2
         2af3rZUPvFyr1JVtmJa24pm/fK++e4PCUDnlThz+G6LckZAMWGoysf+6Epd6TjDRv1uA
         bm+ksxg+auVmeaBc3OvCXCtijS6gbjV6hTycASzez1w6qJO55qO6ILh8u92RqHcdN5Ga
         W/cIjE4Go4/RJh2Cc8T4eUKEfNADi2aOQs8MQbLbsnjIzfqfDpuB3ea6y3poIp+ZHGnX
         531A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcOTwRt74ZUVDeA76qVKozYMO1aqfbJjR0DYqZfdJoQ=;
        b=AwxJ8qJpJC7k/lbvtHB/vQHQVcUbbSU3FRy2Fo37MLBUKi1h0ngImJzd6ChNQLX9bM
         gvWMguW3Lln5nwOEcgUFG3jqYSh4GW3oZPJKGhbJz5arI3sv9v7+7gAeYe+EPaNzViHz
         NTK+bcpy/a5j329e2gFUlwZXQ3fuf7lzVZ8Gi8ZBUG2TCMxGIQColOVzVkRvut6RIz4r
         yRIkCyMIzB/vnB3Wvoj1D+4r939bj5miLjm33gIW00AuvFELaQtFc+8tdF+FiI09GMia
         hoE5d3KWSehVfmcV5UYllO5HxMDQ3VEFHSQxSX0jiUm/7WLeAuTy98HXAGXGQblLVVVY
         PhFA==
X-Gm-Message-State: ACrzQf1vnO37lPTRpV0614EmJeY5tIgoLT2u/4Qp5phHbTEzec6hv3HM
        1ku4V6/M7epKGQld0qeBQm4=
X-Google-Smtp-Source: AMsMyM5JNkw4ZkI3BmSYbnomBaqSCJ9lcpfu/3fXi6rQ1LR5WG8SRwMJ2atG+pMlOBzMySNhkzYCDg==
X-Received: by 2002:a17:90a:d794:b0:20b:590:46b1 with SMTP id z20-20020a17090ad79400b0020b059046b1mr1025563pju.83.1667924441551;
        Tue, 08 Nov 2022 08:20:41 -0800 (PST)
Received: from ?IPv6:::1? ([2607:fb90:8e10:f652:ac39:6d51:4e64:df08])
        by smtp.gmail.com with ESMTPSA id p6-20020a63e646000000b0046b2ebb0a52sm5883889pgj.17.2022.11.08.08.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 08:20:40 -0800 (PST)
Date:   Tue, 08 Nov 2022 08:20:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Qiang Zhao <qiang.zhao@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qe: request pins non-exclusively
User-Agent: K-9 Mail for Android
In-Reply-To: <CACRpkdaW-dwKNtTQ2_Mj4JpG34N3m19g+s5xcs3Xj=2kAdE0cw@mail.gmail.com>
References: <Y2nKIbKxHAMimxII@google.com> <CACRpkdaW-dwKNtTQ2_Mj4JpG34N3m19g+s5xcs3Xj=2kAdE0cw@mail.gmail.com>
Message-ID: <490B1A14-9DD0-4001-9F39-869F42F7AAA7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 8, 2022 2:50:07 AM PST, Linus Walleij <linus=2Ewalleij@linaro=
=2Eorg> wrote:
>On Tue, Nov 8, 2022 at 4:16 AM Dmitry Torokhov
><dmitry=2Etorokhov@gmail=2Ecom> wrote:
>
>> Commit 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()") change=
d
>> qe_pin_request() to request and hold GPIO corresponding to a given pin=
=2E
>> Unfortunately this does not work, as fhci-hcd requests these GPIOs
>> first, befor calling qe_pin_request() (see
>> drivers/usb/host/fhci-hcd=2Ec::of_fhci_probe())=2E
>> To fix it change qe_pin_request() to request GPIOs non-exclusively, and
>> free them once the code determines GPIO controller and offset for each
>> GPIO/pin=2E
>>
>> Also reaching deep into gpiolib implementation is not the best idea=2E =
We
>> should either export gpio_chip_hwgpio() or keep converting to the globa=
l
>> gpio numbers space until we fix the driver to implement proper pin
>> control=2E
>>
>> Fixes: 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()")
>> Signed-off-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>
>Wow! Thanks for fixing this!
>
>Reviewed-by: Linus Walleij <linus=2Ewalleij@linaro=2Eorg>
>
>I just sent that patch into the SoC patch tracker (soc@kernel=2Eorg)
>with a not to apply it directly, I suggest you do the same (or ask me
>to sign it off and send it)=2E

I am not really plugged into soc patch/workflow so if you could do that th=
at would be wonderful=2E=20

Thanks!


--=20
Dmitry
