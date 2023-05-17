Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24B6706D19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjEQPoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEQPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:43:45 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF2F558B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:43:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f38c23b06eso5741041cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684338222; x=1686930222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FbpSjYQddUQnSYRkxb3E42SH+gBskrRUrxlf2CYvQo=;
        b=R29k5K9SgP9/7YwRiM0/WPCKRfkJzS5ETUNTh40s/ioZ0qLMlB2DIlrbbuB+7/hAe/
         ZUo+HxFxGWciKMVkEO18NlcT+NQZIFL+ffNg2vFiwq9vgKXJqr6nToKBmfcxTc9IRmbj
         fTGWk3+rVM3CXpsggRAJJgZSbfXKtJ0rOBHcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684338222; x=1686930222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FbpSjYQddUQnSYRkxb3E42SH+gBskrRUrxlf2CYvQo=;
        b=da0Q6Z9vEsAjfok9j5ZldB0kb/SzpDtAVUm6N+aCO+327ORpgx0Ei1uAi8HcUs/Mf6
         q0r9Yj6kUPphrnMrr+UIKTAmkXmEyQWX60dGeedWqv8pA4bYTo0gG/yKLb1GRmc5DdQS
         WW5yHYPEAabhxm/bLFgRe8+a586JAqtqx+mKGtPMPJcEiPbTy+X6vOFzTrrrQUeOvMv4
         QrLIpPXYkvBM2GIei8c0b+w18oIxGe1pgr9Am+qzAtnfsss+NeDxWRVXwGCjqP5D/dTU
         Bzk5d0MV016MozwXgX4VZYlGcj0V3Df+ijP1tth4tt7WqR0Ylg64BGeqAqziYs4gH9ZO
         K5pw==
X-Gm-Message-State: AC+VfDzXMtZKdaXaQNe0OQNGy/EmGinosUc3py10CREPYL4axWl17BiK
        0l5eue4H5W1+F0/zaMSMLaahPc7mUPWHfocOI2Q=
X-Google-Smtp-Source: ACHHUZ7+UVvrFx3tlmO+Yq6wj9A2R/ER4VZTZihsMwW8F4mUksUqVEK8xxHQ+MjmksHFv9RIKT0H6A==
X-Received: by 2002:ac8:57c9:0:b0:3d9:4586:3ab2 with SMTP id w9-20020ac857c9000000b003d945863ab2mr205766qta.28.1684338222448;
        Wed, 17 May 2023 08:43:42 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id n19-20020a05620a153300b007595010d3bbsm691989qkk.92.2023.05.17.08.43.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:43:41 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f51ea3a062so167921cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:43:41 -0700 (PDT)
X-Received: by 2002:a05:622a:34a:b0:3f3:75c2:7466 with SMTP id
 r10-20020a05622a034a00b003f375c27466mr405967qtw.8.1684338221234; Wed, 17 May
 2023 08:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230517125423.930967-1-arnd@kernel.org>
In-Reply-To: <20230517125423.930967-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 08:43:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9+urs=+xJS5=bMSsrF5_8XwHaG3YT2BjC=nUQiBnqag@mail.gmail.com>
Message-ID: <CAD=FV=V9+urs=+xJS5=bMSsrF5_8XwHaG3YT2BjC=nUQiBnqag@mail.gmail.com>
Subject: Re: [PATCH] kdb: include header in signal handling code
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 17, 2023 at 5:54=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> kdb_send_sig() is defined in the signal code and called from kdb,
> but the declaration is part of the kdb internal code.
> Include this from signal.c as well to avoid the warning:
>
> kernel/signal.c:4789:6: error: no previous prototype for 'kdb_send_sig' [=
-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/signal.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
