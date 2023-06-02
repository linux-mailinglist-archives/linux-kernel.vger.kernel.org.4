Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0B71FAFB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjFBHah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjFBHae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:30:34 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A5F132
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:30:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so4586925276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685691032; x=1688283032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxFSOXXFgnoP01OVrtj1Y1/28s16uxzvIdjHJcaLi2k=;
        b=lH9b3Lr4r5i+zW4hQ8gQTKYJlJovlT8aQyLcmNVJVAEdkvd+JB3DuRLEdmL35i7WVN
         BKnX8JRj6zRFIJEvSk3BJK4UnRWIpGebePPjmvCsgjfm4fwSrRarrx4ZTryg2PRW4e0Q
         UpbRalsWq4ULmiuV5BzaiiS4kfjU5YEshQY15ZYoK4Olm1KUJIy5iP084eykTN30sk0K
         J+JbGn4WcPfogxIJ/SRdENOX8/KdMI3EXQT/0THWKFZNTbfHaTe3qN6dYmFjwkXxSXvV
         HH5VuaWWxeQYJQlRgZo7+Kd/YvgVgA12brzsOzVq0ny17SywU2ithiSrPpyl4BpcnSxy
         3iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685691032; x=1688283032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxFSOXXFgnoP01OVrtj1Y1/28s16uxzvIdjHJcaLi2k=;
        b=Bskq9+X1NuIgNvyFP1itsKb9J76tLKo0WEF6cHmZaq8Gz+kWxXDareRFfC58hzjxZy
         xLzA6fVIgUipCYUipmw9Z3J/IETtsCC7/eR1/XDuefuviB/9pPK8ZVe99kvwqBQrV7eZ
         FrWkzHFyHoH39P4BEuoxw3cqF7rXS0SlFZio51SVVgCthSzqT2dU39twra+9em5Cb8Gi
         b1IJ23PzZ7LpCTo5zb+RNVucB8icaJDzJSB+0xznk+sRZ1GJN56lcy6oiBqbiXjD/6Dq
         z4xb4XIftYUj03I2mU77kdBb1I2MbU0389GzOyUEA+wiAKXTqzVTQQgf5R39W/Dafogs
         AXyw==
X-Gm-Message-State: AC+VfDynIRVUKKSumN2x51zhkcXPh49CWKontxNsDmZ61C4U7HG4oA+b
        Dz5bpSP0ORc+/Bjo3nX1uQvFPg8QrTb7I2H8NNoXdw==
X-Google-Smtp-Source: ACHHUZ5E8FIkTaSdTE5Q9EFjnz3zPY8IoDuoz5apKmFxeTl1D83H27p0qQd/AxmYGJs0o+Ru4QAItjjbG9AHkm37mNw=
X-Received: by 2002:a0d:d988:0:b0:550:65b4:ca60 with SMTP id
 b130-20020a0dd988000000b0055065b4ca60mr5224092ywe.8.1685691032438; Fri, 02
 Jun 2023 00:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me> <20230601054549.10843-16-nikita.shubin@maquefel.me>
In-Reply-To: <20230601054549.10843-16-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Jun 2023 09:30:21 +0200
Message-ID: <CACRpkdai0OZGW-v-u7_kmYT_6tUZQU=HkMv54436W=U5-5wxtQ@mail.gmail.com>
Subject: Re: [PATCH v1 34/43] gpio: ep93xx: add DT support for gpio-ep93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 7:46=E2=80=AFAM Nikita Shubin <nikita.shubin@maquefe=
l.me> wrote:

> Add match table.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
