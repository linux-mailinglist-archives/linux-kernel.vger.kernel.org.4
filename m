Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE9710FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbjEYPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbjEYPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:39:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B4718D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:39:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso5551605e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685029141; x=1687621141;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e5MsIAMoJVar8Zj7rADk8UannLcUgUHv/XJnO8fuyYI=;
        b=eOLcsLkyESvvG3aMyrGh7ie/Y2rSj5chRxW+yOYyku20HOX42lFDWAikOONenaTKtQ
         98J+LRq5wIKaEY30zfpmbprkS5bXV+0h9FlxEu/FGfKfGBDeHI4FoJqMtlnELBbjZFnP
         XEQzYuaz/TTzTgt+ENbdDFuvjpM2juM3oTjQpMxF8XAmRPDtA4OLbueJhdc0b1cxt9z9
         Tdq+3Q0d2yK5d6NWiYPo8TRlp+QZKhfWTLyo8C2+Vgu5rwXp0BfYq0epdE/gPLFKOQ3H
         Gw0CuS2zQ5h/3j4NdhUD3pn+qlA0+ZtmACvc1H8dhj8YFiL0EndDHT63H58cEM21k4XK
         bd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685029141; x=1687621141;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5MsIAMoJVar8Zj7rADk8UannLcUgUHv/XJnO8fuyYI=;
        b=CsoDvoDz94aRT0ZBTNzj/HOwUmQ7wIL9bobUYCufXA0eyUE1j8eKsGllN1fHAS1qS7
         eGsXbNREsiM6wn50oKZn7yUGc+hdUiRpwFLVUZz0Qoel/0Yg2kcoTtmNBvdcgC4XPZyb
         cBcsr9oFOpubVykPif2BDpE+LK/w3jpgIqgxFiHshCqPyQQOks1u+SqB/PCJ4+N3wNEM
         p9OktRmVzYcKw1vYoLsN2qpd+QONND7Blv2eoRgLqDl6gLCGwvo0XbMo1BJIFGrTrVQF
         HvAPvvOhxdFQdFiB+kyvl7Z1uiIEC0GSE6v8W8En/Ylp+c94Mp9VPk4g4nZ5b9M3HMc/
         FtXw==
X-Gm-Message-State: AC+VfDwtRi5rYx08pXNbxoUOKWq0kRcz75+lfBaQ6BegGkL6aDOYBzBT
        wqAi95eA6gwuIc2+RsO7qq7twA==
X-Google-Smtp-Source: ACHHUZ7RcZZc9uwnUpx72FTFYuDnECqOlRd6TRRbs+KFyMpHIOiDmbB6Jg9nOuBTN9bsYAwBbdcnYA==
X-Received: by 2002:a05:600c:2119:b0:3f6:468:79b8 with SMTP id u25-20020a05600c211900b003f6046879b8mr3463927wml.22.1685029140748;
        Thu, 25 May 2023 08:39:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5cdb:105b:7481:b0e6? ([2a01:e0a:982:cbb0:5cdb:105b:7481:b0e6])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f4248dcfcbsm6106829wmc.30.2023.05.25.08.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 08:39:00 -0700 (PDT)
Message-ID: <8c65c5c3-0415-78c0-4585-df94a532a04e@linaro.org>
Date:   Thu, 25 May 2023 17:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable
 clocking
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>
References: <20230518230626.404068-1-aford173@gmail.com>
 <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
 <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
 <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com>
 <CAOMZO5Csjx17kfkxN1xMLuCg+-J0v6rjiuvaK-ZktXO50ZTuSw@mail.gmail.com>
 <CAHCN7xL2GWLTwMttCha=b9_W0nE5aimCQ08YJFrCF5vNZUOL7Q@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAHCN7xL2GWLTwMttCha=b9_W0nE5aimCQ08YJFrCF5vNZUOL7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 14:49, Adam Ford wrote:
> On Wed, May 24, 2023 at 7:45 AM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Hi Adam,
>>
>> On Tue, May 23, 2023 at 8:49 PM Adam Ford <aford173@gmail.com> wrote:
>>
>>> Inki,
>>>
>>> I haven't heard back from you on whether or not you want the bindings
>>> patch to be included with me resending the series as V7 or if you're
>>> OK with a single, stand-alone patch.
>>> Will you let me know?  I have the patch standing by waiting for
>>> instructions.  If you're not the right person to ask, please let me
>>> know who the right person is.
>>
>> Neil has also been collecting samsung-dsim patches. Maybe he can clarify.
> 
> If it matters, my preference all along was to do the bindings as a
> separate thing once the driver updates were merged into the tree.
> Since the bindings can be done in different ways, I was hoping to have
> a separate discussion on the right way to do the bindings. If they
> need to be part of the series, I can do that.

If you don't introduce compatibles, no need to send bindings, it can
be send separately.

Can I apply this serie and 20230503163313.2640898-2-frieder@fris.de ? seems all has been reviewed.

Neil

> 
> adam

