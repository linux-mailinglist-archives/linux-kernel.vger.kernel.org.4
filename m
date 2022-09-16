Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC345BAC2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiIPLTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIPLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:19:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C24DF30
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:19:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b35so31048360edf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=icUBRZO3jxS3eTTQZGMHo/3Ro+JI8Iz+Fgnw4zMxh1s=;
        b=mU59pLpvgebTMWSxaEMVYRYLsvuehZDwksFV4RuU9EVVQxnF8Sj5T3QpMfGM7wGc3t
         pWsMLdz97fwFP+uQ+tedL5b8P3hMcdYEb5giZ2Ma9jAKsbuvAaMOKsT+6j2gje++qp4n
         72XGo9nKMcGw6szjbchS8faU06IDRdyZIjuy1WdCJTO6KLkFUx+/7fFnCETXrDVhsv6w
         yuDsE7GIqckoRAct8SOzsUbvhd4HAPkZpWTleQXtgZzUNEzqH4+zmnhk7G3duvBLmC9f
         u4jrXQNZKhUUWwwTmPCPGMChl7/rmBNkU2/Rv66zoc1ZEXeecPYcF2A/ufcZ83F5qPeu
         hKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=icUBRZO3jxS3eTTQZGMHo/3Ro+JI8Iz+Fgnw4zMxh1s=;
        b=NYbqnAGc+MEGo5F7DiND+skNYdrz7dMY80x9S9ibgw1sLoy6PQrIuVtPEFveLS/FCZ
         ua3pMDfkij6SkRgeNfD4UVwgDhLOtQye4Nb8ZS1CY0LS0QvAxoBg06EMOkjVIkvxz6wl
         PqZC/OVp4Wh9IF9qF6mBvLLwYX0t+spfwjYKK4GwR7cOYxUPgdjNlNCwAtzmvlYYzVvU
         OFlQFuSXlcCM5DGO1GWh8qABHUdk83luU1jslAYfcJr7IwRwtQRSyzzW9u+KJQygWsAx
         EsVdZ5cbMf0+vm5bTFOqeyaeKVjiuNaBv2vWCAsnSwGqtK1+ngvO6DyP0HBhYSXVJ6rk
         WxAQ==
X-Gm-Message-State: ACrzQf1hWEj5ODW4Nr11qzvts9tX98zax5yObEVJrEt6El9MpXwkFJDE
        hwRrlwN+AscRt821R2FHmj+JFn7OYDTrvLkxAa6LZg==
X-Google-Smtp-Source: AMsMyM7uG7ObWhfMYe3sbpSf7mOrJABzgDz5ES/6pcMzLsublRjWfYLHRWZK0mwQxUh2UdidY6sMh8DlCwmIeldo+JM=
X-Received: by 2002:a05:6402:190f:b0:452:d6ba:a150 with SMTP id
 e15-20020a056402190f00b00452d6baa150mr3582318edz.126.1663327155181; Fri, 16
 Sep 2022 04:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220916110118.446132-1-michael@walle.cc>
In-Reply-To: <20220916110118.446132-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Sep 2022 13:19:04 +0200
Message-ID: <CACRpkdbSkLxG8YiBPvFPuRm73iBXXB3FmChHV113dLXvSnpHfw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix OOB access in quirk callbacks
To:     Michael Walle <michael@walle.cc>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 1:01 PM Michael Walle <michael@walle.cc> wrote:

> Commit a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> introduced an array of quirk functions which get iterated over. But a
> sentinal value is missing. Add it.
>
> Fixes: a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
> Signed-off-by: Michael Walle <michael@walle.cc>

Looks correct, an alternative would be to have the for-loop use
ARRAY_SIZE() but this is just as good.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
