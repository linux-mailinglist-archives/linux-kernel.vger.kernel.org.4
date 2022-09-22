Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876965E6887
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiIVQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiIVQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:35:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF689825
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:35:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r18so22235955eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wZaKULsqE6LPfhGn2zZsoD5uf/xGzt0VKkKFX+0TH68=;
        b=UM+JHRUYPPnGIIYrfOp9SmuYFha6xXnmUVgZxEr0ywxHcy8N9/J2BSrqRRuQc+uAin
         36pw1bn21loi8UlPSenX+31DU+Dp0JgFyqRxYRuxbEcvvbi1ELpSOBauYHgALMaqnkxr
         TogNE7SeC9G4XnLJ+v0G/dxG5NzU3e3QSB/xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wZaKULsqE6LPfhGn2zZsoD5uf/xGzt0VKkKFX+0TH68=;
        b=ItMBD/afgF/iQnbZGFY72OVnX/bSUIkVm9N8Q+pNaONSwimlTZ/KdJLQ6Wkvrzbfwy
         Gm8dB4M7vVDDQHIaNQAP1GT77czkt4ZhtHaS+iRqYE4CNjrY/6Nc0+LhUyoaw43JhQ4L
         XYwOTk5NT8oWbCeu2AScXSu86/Rr4lmAv770TMBigYHA+ZxV9QpuSk/JX+BUUV312Hw7
         WE/h8fJ2dOxRYMi3SdNmH1CnwUG215se13zmOUZqZoI/iRKS5Rh9HiNyFT0fn7MuXAQX
         mvapS3fCjCQJIkkO6OCuxScMgZNz13dWjxMBs1Rnv2VZyPj81nsvINJDJn1Ai9Pen7Px
         GbYw==
X-Gm-Message-State: ACrzQf1JTceJOV1ufqNk4oMyDAvm4dEr0BOyMBXq/T4nXX4ewjfXFF5r
        DgEaeUdHvvRPvTbb9l8m0hpTl0k9WLt+vqMd
X-Google-Smtp-Source: AMsMyM6F+txg3QSdT5GTj4LJUGmVNFWI2lU+AnZGAjT5G8YAig359b24/+9ChPHRjNrXpgtmNiubzg==
X-Received: by 2002:a17:906:4fc3:b0:72e:eab4:d9d7 with SMTP id i3-20020a1709064fc300b0072eeab4d9d7mr3541281ejw.599.1663864516494;
        Thu, 22 Sep 2022 09:35:16 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709063a4c00b0073a20469f31sm2828400ejf.41.2022.09.22.09.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:35:14 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id z6so16492555wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:35:14 -0700 (PDT)
X-Received: by 2002:a05:6000:168c:b0:226:f4c2:d6db with SMTP id
 y12-20020a056000168c00b00226f4c2d6dbmr2591189wrd.659.1663864514135; Thu, 22
 Sep 2022 09:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
 <20220922101813.v4.4.I0cebec46a06dd3ea8f6b7abde038faed917dd5d4@changeid>
In-Reply-To: <20220922101813.v4.4.I0cebec46a06dd3ea8f6b7abde038faed917dd5d4@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Sep 2022 09:35:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEa=+Gp5o1YjLnLrYQ7uMPa3QLy1R6m6Cygo0bbugYcg@mail.gmail.com>
Message-ID: <CAD=FV=WEa=+Gp5o1YjLnLrYQ7uMPa3QLy1R6m6Cygo0bbugYcg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] input: touchscreen: elants_i2c: Add eth3915n
 touchscreen chip
To:     Yunlong Jia <ecs.beijing2022@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
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

On Thu, Sep 22, 2022 at 3:23 AM Yunlong Jia <ecs.beijing2022@gmail.com> wrote:
>
> The ekth3915 and ekth3500 are almost the same.
>
> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

You shouldn't have added my Reviewed-by here. I haven't seen this patch before.

Also: you should drop this patch. The way we've specified it in the
bindings you can rely on the "fallback" compatible string for the 3500
to handle things.
