Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD76379A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKXNDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:03:23 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3E19C19
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:03:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ho10so4073491ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CXYjrEeqBjoEZp5atThlO1xUvZiu3dT5u3aKCEaJMEc=;
        b=cyc29IYj7Deq6koejGBwgRUcnb+If87+B0Zu7Hl1WrDMAG/4cQpUf27x45pe8qekg+
         ItpFc0i8LTicTfEb7TR4kX42EVQdEwQwr+sdD34TgEwMZwFkvHliuRL75oX/anttCjKO
         ctoDLTg0q1/UtMWPYoB8ONR8u0XFbVnMrc7RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXYjrEeqBjoEZp5atThlO1xUvZiu3dT5u3aKCEaJMEc=;
        b=AqSy7NojQHfoe3FwTfGQ8PrQHN9tFybuXf80vUcBg3kh1Ic8azZx9wedFJ3j02h6uo
         hyADRJc8w31d1I19wHXL2XH7fxi9Zql7zhuauXuyrN/P2HBIQ8BAVAFtj1x4q205wywJ
         LoLYsA8Qm15U4bnJDY0GCxB+BKGN/FmcVmcuf4s0rl5ha91bbRojOq8MbiCeg289kmkI
         WrsrUHTJo6Eg+NWk0rCbd8jwiYfzKlaBG5FtzU+fPQbTiEqlsJPBi85+hUiCr/4odhAI
         JWv83yWJn/zJ9cn4Qrfm6LcZhBy5j0O+jRVBMxvvDxfFlK3kjyBCvaknhrP7EMFqLD19
         NIhA==
X-Gm-Message-State: ANoB5pmUZl7zknKDElR1eZvzHjnBZtN0TFpSMU+Rs8r1SWs47BOOSE16
        dIe3adbyyQceTdSNiLdoHiwtXjCvpX8njaqzPsszjg==
X-Google-Smtp-Source: AA0mqf6z9LXsbx/DeTFaMuLETxiKT4zMlPDRPChHW2y8ky/D4eqL+AWLHIL1obyxqAJLLZkg52XHEEw0ZnYIYSU528s=
X-Received: by 2002:a17:906:99c8:b0:7b5:ff35:6715 with SMTP id
 s8-20020a17090699c800b007b5ff356715mr10558287ejn.255.1669295001360; Thu, 24
 Nov 2022 05:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20221120034143.684416-1-o451686892@gmail.com>
In-Reply-To: <20221120034143.684416-1-o451686892@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 24 Nov 2022 14:03:10 +0100
Message-ID: <CAJfpegs6Upm6NcbO9GAJ88Vn_WDmCqs2C71tiRr9BfJEhR+7OQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: check IOCB_APPEND flag
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022 at 04:42, Weizhao Ouyang <o451686892@gmail.com> wrote:
>
> Add *_APPEND flag for ovl_iocb_to_rwf().

Why?

Thanks,
Miklos
