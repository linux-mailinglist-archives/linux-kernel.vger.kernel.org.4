Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA836D6678
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjDDO7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjDDO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:58:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4759DD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:58:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w4so31505900plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680620283;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9uYwVcXo7cBUUBOTLZ2J2lrgVJ/xfkFZclj3HBehK8=;
        b=UAETlx+9wQOEYw9NkD5esQ22zJR9CYzlPJFuuru/zG8A7bcoHUo5CXJ9VMeQYHfVj4
         a6KAda1lEkoabUz13lUVXFC0HOTYZxNrY28ZtkJwknBw2NpS4RPwtznfSXXUrdnZI0T7
         QmwkjqpQrUKWOZC3HtGUeObmFnSzFFtkmfJSqhp40MV8d2URnW6nb/8H83pnqsLUpNCo
         9E4Ebl0P7KOXfKbvh46S7fB2ewb8ceCDSz600lMgQ4Jr1IKVVBcoP4jovOaIi2xfINbo
         ZiZlIOrHGJNGygni7UnfXlF+ipe0cAdJEAT54EvufshEYUUh8gD6sHYaV/jSusLemeot
         wXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620283;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9uYwVcXo7cBUUBOTLZ2J2lrgVJ/xfkFZclj3HBehK8=;
        b=ODFex+sXhmJzB9td99yRc+ExrBwIMQ++xtUt9hJDgEkcJBvST1yfyoCm1dFy6A0Rgd
         MacGHI50h0hQOVBGDBH4iaZtSPkbnLwNyLHh++N0JkAqf95lmLerv9xZ7KuMoQgt9C7r
         lCl8sfZBOJr2KwdpcZUIurd2UP+rsy1RYcWccvMTgD10WcIQkHjbqOMCGS8WA0Wuyc+4
         CPAvoXWS6DyOL9EkS0pJzRIEdS1RlbxgFIKxBCw2fEzREzdcqP+MvdIU+n5jv8q7Isv7
         LDPZp+mWeq7HcH3AWFKAW9TOwiWr6D6HNHB6dw1sn9BBHJUH+s8UTmDorx3hyxgR3gOc
         CbbQ==
X-Gm-Message-State: AAQBX9ckvWyR/hzkZUPwVy+48ymHqarq5pHSyq9s+qQ0pOS34c0naoR6
        T9MN2r72RjqQaY1ueGSytE5khg==
X-Google-Smtp-Source: AKy350YdY2blg+WDMTITRqonrmBC853Tqawrwror3LCdLvv5uZ3X8E8eImt5a/UgDnCMC9oeW3hnfg==
X-Received: by 2002:a17:902:ec92:b0:1a2:87a2:c91a with SMTP id x18-20020a170902ec9200b001a287a2c91amr3262702plg.34.1680620283196;
        Tue, 04 Apr 2023 07:58:03 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902761100b0019ef86c2574sm8381272pll.270.2023.04.04.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:58:02 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4n?= =?utf-8?Q?zer?= 
        <bero@baylibre.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 00/11] Improve the MT8365 SoC and EVK board support
In-Reply-To: <7h1ql0y0j7.fsf@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
 <7hy1ncydtc.fsf@baylibre.com>
 <CAFGrd9rKy9a4bUf1dkUtTogtWPFr5eu3jcsdaixi3hs_dWMwrg@mail.gmail.com>
 <CAFGrd9qLzcDJO_Fk_-B6XYuuxQzQoYLXmdp0Qj1Tszr0-sqNgw@mail.gmail.com>
 <7h1ql0y0j7.fsf@baylibre.com>
Date:   Tue, 04 Apr 2023 07:58:01 -0700
Message-ID: <7hy1n7wv7q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Alexandre Mergnat <amergnat@baylibre.com> writes:
>
>> Here a build-able & working branch with dependencies:
>> https://gitlab.baylibre.com/baylibre/mediatek/bsp/linux/-/commits/amergnat/i350-evk-board-support
>
> This branch doesn't compile.

I'm wrong, it compiles fine.  I was on the wrong branch.

Sorry for the noise,

Kevin
