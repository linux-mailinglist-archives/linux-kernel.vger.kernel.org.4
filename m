Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05A4714EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjE2Rdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Rdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:33:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C953BE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:33:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso5720068a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685381616; x=1687973616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SnnxOPGDcq5IgZITbMgF+/5A6j86ONCYACpYZC4l3I=;
        b=Ba/UoowdP5Dt1gcZhoPhL64PQGgRI/QvrlUi1tHUH2pEeJ06J4goEfGdzKZOMWYPvb
         suPVSAS459z2FchfuO+dSgaUSm02N/qbzcgi0A0lFib1aHON7VoSA0ArqFzp/qnKtMII
         Qb6S7BAmVyCar00ns4w0oXFH6tIAsgf3ISU9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685381616; x=1687973616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SnnxOPGDcq5IgZITbMgF+/5A6j86ONCYACpYZC4l3I=;
        b=bsL17AXOyz2ry12Ynbunsr1qaeqI0UxZVWkZxYwtaJf5MW2YtDxpuAZ9P2wz6uEjGn
         puXB0xdbrf+HFZvpgkwu2yWMlqzWx1gGx4x6/MuPsLKN1wQzaEuXKe201tWHR47h9OsR
         m34aA5T0dc6/fmWcjx9nsv3MhhAVx2gHowsEw9HSQhM/cT+OD71Jazuf1gMjkJHwLe6P
         PagM5P/XXvEa2uZHmBJ6OhdnBHGNZ8vH9v12t2SgISshAhFYQsHXMDePbIA3LbYQzRPP
         dgiY4O4rzZxasACWH2I4UsFZRn/Q0yxkiKOxaeANXhk3nJ1i2ElYSet9rAagxlB619SA
         oRWw==
X-Gm-Message-State: AC+VfDzYXsWBrfgj0Wa/apM42z66icZR/L0Ickh6I2q9dzBDWQzJwwuc
        /wWvyzRNkIOthdQrsZXPsGlekHqYurmVA2dtE4rHD5Mg
X-Google-Smtp-Source: ACHHUZ6vipbJY8lDZ+9x1m/kVC+X5IZTtdEtUpcK5s/mkxOH+Hr63IiEEn3Uda7bBwJ9+2caSf0HKA==
X-Received: by 2002:aa7:da03:0:b0:514:9e61:18ab with SMTP id r3-20020aa7da03000000b005149e6118abmr325816eds.14.1685381616496;
        Mon, 29 May 2023 10:33:36 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a10-20020aa7cf0a000000b00506987c5c71sm3259968edy.70.2023.05.29.10.33.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 10:33:35 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96f818c48fbso663215266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:33:35 -0700 (PDT)
X-Received: by 2002:a17:906:ee83:b0:94f:2a13:4e01 with SMTP id
 wt3-20020a170906ee8300b0094f2a134e01mr9672114ejb.74.1685381615429; Mon, 29
 May 2023 10:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
In-Reply-To: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2023 13:33:18 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjpb_j4xJoKLivHFkrruR2TRcicEUkNVfXkY3xV5ybRSA@mail.gmail.com>
Message-ID: <CAHk-=wjpb_j4xJoKLivHFkrruR2TRcicEUkNVfXkY3xV5ybRSA@mail.gmail.com>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"
To:     sedat.dilek@gmail.com
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
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

On Mon, May 29, 2023 at 12:18=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> Building from scratch with latest Linus Git including:
>
> Revert "module: error out early on concurrent load of the same module fil=
e"
> https://git.kernel.org/linus/ac2263b588dffd3a1efd7ed0b156ea6c5aea200d

So just to confirm: both plain 6.4 _and_ with that revert hangs?

The revert is pure "go back to old state", so the revert really
shouldn't cause any problems what-so-ever.

So if rc4 doesn't boot for you, and the revert also didn't fix it for
you, then there is something else going on.

There have been other module changes during the merge window, and
obviously it might be entirely unrelated to modules too. Can you try
to narrow down when it started failing?

          Linus
