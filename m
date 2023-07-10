Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35274C9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGJCg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGJCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:36:56 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC0E0;
        Sun,  9 Jul 2023 19:36:55 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so3773307276.2;
        Sun, 09 Jul 2023 19:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688956615; x=1691548615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3XEg4q7KHiIFxw+vZ9TCJt73U1Opkr0tChPrvQjUrw=;
        b=piUG3eNNngUZ5OivMBd56VnDb7ZVpVgDcp5zmA3oWTAjtGTSEVzmBrFnmNJ7f75aKc
         GFieFnE58F29a7GgRRkVRTsEuczvcBvg7MegkvgjSXbWtZxGq5b+2XpssKUEbfgJ9NhA
         tOcQ+j99cxSR0PYV6tHQ9wZ2Ja8k/q8vuHK+myhKSKWZLVbOnqPVmR+ahvyHSaOhjRKm
         IwMGPV2HzLNHsISosPCgAnYb1mUTgIxyWAspy/3A1331Xv/VzwFTRdXndsbeNMq+1Ov6
         OUW/kw9+QCeq3teFHV+EoYMgokRoHYPjJU3ornzKXdM9Q7v+LKFee2r2060CJDi7ib8C
         EpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688956615; x=1691548615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3XEg4q7KHiIFxw+vZ9TCJt73U1Opkr0tChPrvQjUrw=;
        b=DUjldnsaAqpwn5B+HnQL6BgFJGo0srBJESFgKvHZFbODEzcL8ywcCBEAndLxwauJW7
         T90HveAdTruUyGqk57Wnc2mphxfSWCV4VOOREaOqSDZ9E+o//yT5S0FYUpjtAFoFB+Tn
         8SxlzeqBpbpnBR1eey/Ce+amESv/owNCE2g0k3/8OUgr5ishlfRdjnEdcVtJMpf6hpLW
         Pxyn8CxAFVcaOw4ROqaSITgH5JczIL9EnpQOswWD985C12Oc533bR7D8lEdgvMWJEEWF
         C8MI19akGqaNEPHo6ONImJ/rsHu58jyCiwfdSM7+c8CE5higkDp4csPNzYPyjHcBWi3a
         QUTQ==
X-Gm-Message-State: ABy/qLYRttZBWsGnTyuoUmbeh+qELyR/0pND6dH0U7E0JyhftqmQBLoL
        yZDyZQjxDmTmVPJ/x4zQvo4JaM7QGW4rseSsKeY=
X-Google-Smtp-Source: APBJJlGmgkn41KVGmJK6jmsL7u3NDJiDfMPK2soV0sGV2ONvwwz/30etSudifomZNq+dEI80vgCg58Empf256F4zsM4=
X-Received: by 2002:a05:6902:87:b0:c5d:d6cd:fade with SMTP id
 h7-20020a056902008700b00c5dd6cdfademr5535414ybs.50.1688956614808; Sun, 09 Jul
 2023 19:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230620200832.3379741-1-azeemshaikh38@gmail.com> <202306201311.862B05981F@keescook>
In-Reply-To: <202306201311.862B05981F@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Sun, 9 Jul 2023 22:36:44 -0400
Message-ID: <CADmuW3XKZkYB4dKPa2Bsoj96CK4hT_8cwV++7rEFP=Wxw7hGvQ@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-hardening@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 4:12=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jun 20, 2023 at 08:08:32PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since return value of -errno
> > is used to check for truncation instead of sizeof(dest).
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> Thanks for fixing up the variable type. (And thank you Eric for catching
> the signedness problem!)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Friendly ping on this.
