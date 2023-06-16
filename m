Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA52732442
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjFPA1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFPA1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:27:30 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513FEC;
        Thu, 15 Jun 2023 17:27:29 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-78f29aa11d4so67165241.2;
        Thu, 15 Jun 2023 17:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686875249; x=1689467249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eihtICZd/7oi0xZ9lyfUo+FmRDcsM++u/puAvpZ38k=;
        b=btMYLP4ErViknFD5WScEiXGi8aCptr/gykn+wyfbH4Nll743jx3yG8TEnDZuour2Aw
         uaV8zbTDUU5QSrA6KhTad2hMy5l0HW57aI4aXO8URwrp8/TrebUpbzfgek8qbJfCHxAj
         GyeW94ptyY4PNuIHCIoxx+huskJzgb9Ga7M52kEqqx9b/Zpw8scgJQQW+nkDvGKAxi0/
         1SnxKlexOwptWoQG+MSxtwFcCIsY0M/R99M9SurjpNSz6xXHcFLlxk3PLgZ+X0CRpo+X
         CSqYIFDcBBCVrogUP2XlT2rBlfY8PZQA5LEcIm7La7+iWXWAIBV5Wx4N+y2k5cwvXIyb
         PV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686875249; x=1689467249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eihtICZd/7oi0xZ9lyfUo+FmRDcsM++u/puAvpZ38k=;
        b=hB9LxwteWt8z9ZIrNgcgEDQavjS2CgPUb+9TAi1TNP3mJ6rchlK5XM8WGFpmWgWK7+
         QqrCS25NYF3E/6oiVU2eOGjuOko6h44o8E6qRbYvkk0ZAtit0fZPDWCdZ2pvFjleIXcn
         sFcsRhsauys76WvR3lWNRADKyuBy/8U7RCYPdt/RhnyyoDlT0LVvCRfjiwKnVy24wLoV
         IRb8vFftq2clEoJzIBvkFy/Vwm3xlU3xM36W3iy9nee1F30inj5qNok+9pBwvQtaQmwn
         XcVq2xd7qV/+9wksdbe7okdB3V4j5y3sVcMNWNdg1Qs5mvV1MlqTkBMTFt6jwQfmWlkU
         pFkQ==
X-Gm-Message-State: AC+VfDxCPIY+faObl4tLKtgz+wip/gz72InFLQ1HZcVq5WhP+WCCeOjz
        1TSbh7yAP167dO8z7KpucP79UavOw6NAMEiNc6I=
X-Google-Smtp-Source: ACHHUZ63nwlZMTim3+MLre9xvnalRH+x1MrLs8K66X276k6UJZZwEAPFc8nVCxzfoF7LzVxFi1vbBoGoCPjuRX/oADk=
X-Received: by 2002:a05:6102:3a6a:b0:43d:ecf7:5018 with SMTP id
 bf10-20020a0561023a6a00b0043decf75018mr1017264vsb.4.1686875248839; Thu, 15
 Jun 2023 17:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230507084116.1099067-1-dev@mattleach.net>
In-Reply-To: <20230507084116.1099067-1-dev@mattleach.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jun 2023 02:27:17 +0200
Message-ID: <CANiq72mH=Wp5J2Kk1SWgv5N34v6Qviuf3ut-uSks-NW-C2L3VA@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust_is_available: check for empty libclang version
To:     Matthew Leach <dev@mattleach.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, May 7, 2023 at 10:41=E2=80=AFAM Matthew Leach <dev@mattleach.net> w=
rote:
>
> If bindgen can't find libclang, then bindgen will panic with the
> following error:
>
> thread 'main' panicked at 'Unable to find libclang: "couldn't find any
> valid shared libraries matching: ['libclang.so', 'libclang-*.so',
> 'libclang.so.*', 'libclang-*.so.*'], set the `LIBCLANG_PATH` environment
> variable to a path where one of these files can be found.
>
> This is outputted to stderr, leaving stdout empty. The empty string is
> then passed to get_canonical_version and the following is show to the
> user:
>
> $ make LLVM=3D1 rustavailable
> ./scripts/rust_is_available.sh: line 21: 100000 *  + 100 *  + : syntax er=
ror: operand expected (error token is "+ ")
> make: *** [Makefile:1825: rustavailable] Error 1
>
> Note: bindgen's bad exit code isn't caught by 'set -e' since it is ran
> in a subshell.
>
> Fix this by prnting out a more helpful error message if the output of
> bindgen is empty.
>
> Signed-off-by: Matthew Leach <dev@mattleach.net>

Thanks a lot for this patch! This was previously reported and should
be fixed in this patch series (I added you as a reporter in v2):

    https://lore.kernel.org/rust-for-linux/20230616001631.463536-1-ojeda@ke=
rnel.org/

If you could please test the series, to make sure it solves your
issue, it would be great!

Cheers,
Miguel
