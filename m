Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889A66EF573
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbjDZNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbjDZNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:23:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7175FCC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:23:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1310045366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682515403; x=1685107403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+Pe5pCZek4eB9zZ8kO7fYvIftijJw+lDBogjs05z64=;
        b=KKDUAd4ySBQk6nBep/Pq4UE6p8xqAauak5B57qszursKK6MKQxo95UauYRaSGQPOf7
         LLYeopK4pOPdPyuVSRCuwQU9sWxzP9nO4vnbcjhN8OpVyJcL/NNCRq2Lt/iAa5AKlDTq
         vxrQDMYnrF1D55LfLnAtmJS8YPIqMKzkV+63A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682515403; x=1685107403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Pe5pCZek4eB9zZ8kO7fYvIftijJw+lDBogjs05z64=;
        b=ggZ2LJx73K6qepdaiyrYqR7HUwuiJGecF6Bgc+5Oao7Vl1HP7Hpfe77c7kDHHg+49y
         C31L7PqinRvVa+o2QL+CrXDqPkDkMH0FUj6w0XcfiIyaqCNa/V4r/8lnm/uYt/29zr+5
         v7FSJqQC+bMiC2QmgZeKQtm6ISzU0Cnj2VNluGvJno5ZpD2rbaP17Ol9cck4jGwGuYkl
         Hy7C9UUO1VRobc9SJmQZnccmLzVbzeypA5A9+u7d2I/atUB9iY3OnYJyOTVLVznrMIvj
         JNc3eTkJTBr/rxqKpfz8RrQCLobHhXXD5BBTorHHPKAVlfIxEQ1ftYdS5DrRBgG8qr7J
         X43w==
X-Gm-Message-State: AAQBX9fTbFhKLdKfCyrSXVRNO1/u5UT2Bl++dGkgHFJHc/UUCtF80XEl
        0L7d8zmFvRsFVgPRA1lwBLmCAw==
X-Google-Smtp-Source: AKy350amP6RDFH92vm4ua4+WHulGtoC0G6R7LjK8P5MtrJ+ZkUCv+MYHWxU0WU7FW5TeNnOAWqduJA==
X-Received: by 2002:a17:906:3b0e:b0:94f:3bf7:dacf with SMTP id g14-20020a1709063b0e00b0094f3bf7dacfmr18036135ejf.71.1682515402781;
        Wed, 26 Apr 2023 06:23:22 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906805000b00953285b937asm8175033ejw.189.2023.04.26.06.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 06:23:22 -0700 (PDT)
Message-ID: <a56c2cec-b10c-ec73-2179-6b92251a7419@rasmusvillemoes.dk>
Date:   Wed, 26 Apr 2023 15:23:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] spi: spi-imx: fix use of more than four chip selects
Content-Language: en-US, da
To:     Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kevin Groeneveld <kgroeneveld@lenbrook.com>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
 <706c591f-4800-1b96-52c0-37b5f6de7623@rasmusvillemoes.dk>
 <fd22bfc4-b019-4445-acc5-f7902a2386fe@sirena.org.uk>
 <9f403dd7-1ac8-bebe-1b24-bede61087bba@rasmusvillemoes.dk>
 <38eef5df-ca8d-41f1-93e7-e13c1d7b6232@sirena.org.uk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <38eef5df-ca8d-41f1-93e7-e13c1d7b6232@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 15.10, Mark Brown wrote:
> On Wed, Apr 26, 2023 at 02:47:44PM +0200, Rasmus Villemoes wrote:
>> On 26/04/2023 14.25, Mark Brown wrote:

>> I described a problem with what is now 87c614175bbf in linux-next: If
>> one has five spi devices, the first four of which use the four native
>> chip selects, there is no way to use a gpio for the fifth, because
>> whichever "channel" you choose in the CHANNEL_SELECT field will cause
>> the ecspi IP block to drive some SSx pin low, while the spi core is also
>> driving the gpio low, so two different devices would be selected.
> 
> Sure, and therefore I'd not expect anyone to actually describe the
> hardware like that but to instead describe the hardware as using three
> or fewer of the native chip selects with the remaining chip selects
> described as GPIOs.  If the device requires that a native chip select be
> controlled the hardware simply won't work without at least one native
> chip select being unallocated.

Exactly. But the current state (as of next-20230425) of the spi-imx
driver also doesn't work if one describes the hardware using between 1
and 3 native chip selects and the rest as gpios, because the naive
masking of ->chip_select could easily hit one of those native ones.

>> It's not exactly a regression, because any chip_select >= 4 never
>> actually worked, but what I'm saying is that 87c614175bbf also isn't a
>> complete fix if one wants to support mixing native and gpio chip
>> selects. For that, one really needs the unused_native_cs to be used for
>> all gpio chip selects; in particular, one needs some unused native cs to
>> exist. IOW, what my series tries to do.
> 
> No, we only need one unused chip select to be available.

Which is exactly what I'm saying, so I think we're in agreement.

I.e., something like this 3-patch series is needed to actually support
mixing native and gpio chip selects (having the core verify that there
is an unused chip select available, and provide that in the
->unused_native_cs field in the spi_controller). I don't think there's
any textual conflict with 87c614175bbf, and the masking done by
87c614175bbf doesn't hurt, but also becomes irrelevant if this series is
applied, since we'd never pass any value > 3 to those macros.

Rasmus

