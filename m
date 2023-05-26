Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0819C7124F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbjEZKkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbjEZKkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:40:07 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00321FB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:40:06 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-561d611668eso10458447b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685097606; x=1687689606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Um1UKc6m4BdE36Z1im121lfRoHu7Yl1ObhXNqm6trM=;
        b=ohJIo1Juhen6tk/HYDRDNHLMTtBS9nw8MMHFlfqC2IeY4+bzVAn8ulnO0xtO2yGiCl
         etaI36h0fR7ozc6Js9NP6DUk2SdWr8koFF8jh6lvSvQELCjAYzIyFGwnfqCmXcy9bUkn
         57qZZQiSzqwpanesT3R+3196uWB/r43ejGX2tul/+tfwxmxBbpOPalxutSbSbWFTzInk
         ZIJXtrFWRwa5XhIgNwTdfk40deyxGkrKZFQWco/LChwtjeW2vuzMMT2oJT35yPL5R4sl
         jKgGwae/eorCUF6BEX2RNob5yCjawmWbzXdS5HZTuFbNPIRa1mIwmsQPyhQaeuGuooof
         j6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685097606; x=1687689606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Um1UKc6m4BdE36Z1im121lfRoHu7Yl1ObhXNqm6trM=;
        b=kTNqv+uxYuQiFT9aq9rTZNH5nj1mbnqYwln0Is1kgYQl4lwSD8IZaZlnoPlkVtinC5
         TlMBJ4MCrJi7kUESiTnuKbGHa/VzMzNm1HjHzCkZlGAgfxkQmcLyoezPhPOln4NYaNgl
         n5sKq/yJxsyVhuLS91ptTbfYPoDDVCcuTVuSLIomikqmwkQigzaT7b28X98p4al+OdHc
         mGFiIKeNx/b7io9gEzPgDKLfTdnAJpZPDjOSWqudLe/qQfO57W0O2O3JJBrhh5zS/Wgr
         TXDDao50rUndrObFiDuuRrkcBzSVaC6OQ46XGF3+50X0IC4l+C5wBi83rAFQWPS7BtF5
         n03A==
X-Gm-Message-State: AC+VfDwQ4tgEuDiABd/N03XhYltv7G+RzoE+YsMPD28bwejW+cUIV7+f
        3CuJtFUTeyR77yOFgWYvbNNI00EQQDyxB3qU7O/6yuWGb5g=
X-Google-Smtp-Source: ACHHUZ5/Z3LtOJXlIQJRUFXgO7Ly4Dz7VWN4V2S7zNwonhIZPsk0xeASWC5xOCfrzsA4JsNZoegGu9815lL3gJd4zfw=
X-Received: by 2002:a0d:e2c7:0:b0:55a:7c7:6ff7 with SMTP id
 l190-20020a0de2c7000000b0055a07c76ff7mr1646862ywe.11.1685097606157; Fri, 26
 May 2023 03:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230525205840.734432-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230525205840.734432-1-u.kleine-koenig@pengutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 May 2023 12:39:55 +0200
Message-ID: <CANiq72=qi4yXH+24zFHFatBdUHy_ekNrFoYnpZL0fSMa76kpug@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Switch i2c drivers back to use .probe()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:58=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks for this! The conversion has taken a while given the date of
the first commit :)

The wording of the message was a bit confusing, perhaps a ";
finally/now" before "convert" would have helped, but no big deal.

If somebody is taking all the patches treewide, then:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I will queue it.

Thanks!

Cheers,
Miguel
