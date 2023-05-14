Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14770207A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjENWgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENWgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:36:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB4310EF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:36:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso2230328166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684103772; x=1686695772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HYVKLMXGjuFdvx8zV45PWgJzLlXTE9uCc5no8IUiBo=;
        b=HN5BitY1t8Wy5SuqGQnLKPhOyXrZcNemc/54f0DLzbyR/YqEFJ3d+g1/KcKKM8VbMs
         6c4ffKbIXNaOK+9/W5ugAAs6ydupd51mFZ6FXhn68mPh5w08Snog7BeblJXpGwPJK5Uj
         ZuCATL6zMelA8226heGjeivIx/BORmsfcoaME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684103772; x=1686695772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HYVKLMXGjuFdvx8zV45PWgJzLlXTE9uCc5no8IUiBo=;
        b=Ugg7qVfKsULYdokgBdEcZFmzNA0UDLujuj5ZMG647hMVw1zzjoYk0rlfGU6dtdiSWD
         j/l7JsQoT3t9+6lkWmDujQEZQjkfg23UgZz6r6+0DMQPUW8mmsTx/lT6gtRkCV8tIWKk
         TKl+BxpqC5tVEuitI2LkiotTZf6wgt2waAiQLuBn81VOLhIr3/NxBKYxOjMwLmZagsCf
         y/aC2zcRQOxKtAJP21UDbTJ0w319LzC84jpytvsPPbwmUEEWSJ1wrJGaeTKnQrnLP+VR
         Wbs0lJrrWhcq0rTS1P4rkvVMFDmL7w5UZhldxjSoTaEmjMGpE6m4LQkB9Pl7Xh/8+ZBe
         0lZg==
X-Gm-Message-State: AC+VfDyZ2ZY4XW+Qk/NjYUjaEE2KFewQeVs54XUVVpfHfMktuJBUhScH
        P4hlSwCdelgY7Bu7owqTToEasbqpV9WPhzb/aanAqA==
X-Google-Smtp-Source: ACHHUZ6KPweKCELIHvYDuIEpuHXJa8wRCUwFhRD0e3+1eWS0xlNkyGKr5tkuZhSRr5DbTdXgMMD7Uw==
X-Received: by 2002:a17:906:7947:b0:94e:dd68:aba1 with SMTP id l7-20020a170906794700b0094edd68aba1mr28530488ejo.67.1684103771739;
        Sun, 14 May 2023 15:36:11 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906688400b00965f98eefc1sm8679953ejr.116.2023.05.14.15.36.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 15:36:11 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9659e9bbff5so2233255266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:36:11 -0700 (PDT)
X-Received: by 2002:a17:906:58d5:b0:969:9fd0:7cee with SMTP id
 e21-20020a17090658d500b009699fd07ceemr21655421ejs.10.1684103770755; Sun, 14
 May 2023 15:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230511162721.12385-1-lxzheng@gmail.com>
In-Reply-To: <20230511162721.12385-1-lxzheng@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 May 2023 15:35:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgszeWrJpC9oGwBo59CH+VdUXtjOpJ1QmnvtBgw4N4uJA@mail.gmail.com>
Message-ID: <CAHk-=wgszeWrJpC9oGwBo59CH+VdUXtjOpJ1QmnvtBgw4N4uJA@mail.gmail.com>
Subject: Re: [PATCH] iomem: Adjust address width for 64-bit addresses
To:     Lingxiang Zheng <lxzheng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 9:28=E2=80=AFAM Lingxiang Zheng <lxzheng@gmail.com>=
 wrote:
>
> Modify the address width determination in /proc/iomem output to better
> handle 64-bit addresses. The previous implementation did not correctly
> account for 64-bit address space, as it would limit the address width to =
8
> hexadecimal characters.

Note that the width is the *minimum* number of characters to print
(with zero padding due to the zero in front in the printf format). Not
the maximum.

I do not believe we actually want to expand the width to be 16
characters wide, just because it's above the 4GB area. That would make
the numbers huge.

The main reason for the 4/8 split is actually for the IO port cases,
ie we do *not* want to show IO ports (that are limited to 16 bits) as
8 hex-char wide.

So think of the 4/8 as a visual distinction between the iomem and
ioports files.

And yes, I'm aware that some platforms have IO ports that are larger
than 16 bits, and on those platforms as a result the iomem and ioports
files will have similar visual behavior.

            Linus
