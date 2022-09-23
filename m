Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058A35E7DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiIWOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiIWOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:54:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E031233
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:54:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m3so533588eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mUvnHMrqfDygHJMP4jfoffRWSC2dEXcdYnkQt9a9yPM=;
        b=TPh/CO1WsOshsy9Z1qDuaG5AVH9P5aDVxMID5Ar49LbzNe7WdIev6YWo8FuVK23rhT
         YTYLnJ/I0E37oBcMvk7wX+rNMqxdQOrRkaYwq8ai2h/imkGljlsWS43Nu3F0qsn2pAG9
         5t2nYlUIp29PGr0JlxAHAT4/usbuEDLKPW0yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mUvnHMrqfDygHJMP4jfoffRWSC2dEXcdYnkQt9a9yPM=;
        b=I+Jr6JBZpAVuo3vsiNKFkll/NrywC256eo1SI3ouUjoZ8IfIlS7F4SCTHgWNSPkz8e
         nnN6XirBLsx4HLSg7AFRDkN7xnH6Otva73zgKA27FJ/ykIzilFhT15e415pP/sPls/Pb
         O7aufvMKn9r9vPA9np34mR+5KuESNmh9LLD/1teRKNX0+luFV2x0BAQxp4XGvEqeE2sZ
         2OFahXg6J7NhL2QcIVYo4TF7VP4LJ2CNiv6eZiQ4NloP8ucE7/XCcYuhQhwFmdh4KGWd
         7sOOsC3HYrdkGC4nbkFc3/FKI2SI/A0yroZag5oGwToQ1KwKhtBAFFpMLK8lChSbLrhA
         3LYA==
X-Gm-Message-State: ACrzQf3sQxlviZWYVEfY1er4MNEZSC5pLnmJa88Xv2O/nnaWNzdxZvFY
        ljub1jxoWUrKG0dAcdtStkGrIcmoxvwnsrdP
X-Google-Smtp-Source: AMsMyM5OIpr9X6MpjNrpU/1FYEqoQw27grKINK7tdEZO2zf3jcTL20VfB8Q25XOMnRHpEgHXw0iq5Q==
X-Received: by 2002:a05:6402:748:b0:44e:b48f:f5ec with SMTP id p8-20020a056402074800b0044eb48ff5ecmr9132950edy.146.1663944890174;
        Fri, 23 Sep 2022 07:54:50 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b007341663d7ddsm4176337ejd.96.2022.09.23.07.54.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:54:49 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id s14so476083wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:54:48 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr5684489wra.617.1663944887695; Fri, 23
 Sep 2022 07:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220923083657.v5.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
 <20220923083657.v5.2.Ic4e8f03868f88b8027a81bc3d414bae68978e6b7@changeid>
In-Reply-To: <20220923083657.v5.2.Ic4e8f03868f88b8027a81bc3d414bae68978e6b7@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Sep 2022 07:54:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSy3x=9qQdrDGZvc82NZYsQ=TRQ05cHECbU+Q5U5f16Q@mail.gmail.com>
Message-ID: <CAD=FV=WSy3x=9qQdrDGZvc82NZYsQ=TRQ05cHECbU+Q5U5f16Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: input: touchscreen: elants_i2c: Add
 eth3915n touchscreen chip
To:     Yunlong Jia <ecs.beijing2022@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Bob Moragues <moragues@chromium.org>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 23, 2022 at 1:47 AM Yunlong Jia <ecs.beijing2022@gmail.com> wrote:
>
> Add an elan touch screen chip eth3915n.
>
> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v5:
>  1. ekth3915 is the true compatible and ekth3500 is the fallback.
>
> Changes in v4:
>  1. eth3915n dt bindings added in v4.
>
>  .../bindings/input/touchscreen/elan,elants_i2c.yaml    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Fabulous. I'll expect this patch to go through the input tree and
patches #1 and #3 to go through the Qualcomm tree.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
