Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510F6FD64D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjEJFmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjEJFmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:42:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02330DD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:42:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so12657060a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683697356; x=1686289356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vufql6/ecz2yZXzMpZRiarcSXO1qn2RCsrk7qDujkI=;
        b=btoNBuCKMHSLgqnNYWYzxkh+LbfZ0VY2ZIoiWvfsaehbd46EtcrjtttICe/PCnWV6i
         YpsS1BO2afwKs3Dx9BacN+1aVx8TcnxrDZxTDihxKUBn+cbrcTQwIf5dG/OKcmXXeIdI
         NtKCmCYxQx16B97a9p8r8R1uCylCOaBPCEN70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697356; x=1686289356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vufql6/ecz2yZXzMpZRiarcSXO1qn2RCsrk7qDujkI=;
        b=XWeIbmbA8KbB/+miKfU7LhHXjUc9XsJtnj3xvHHg2ahgKNjd98y0WrmyWLn9FMBdSl
         KMXYaOY/dHSXrCyrRM69BSv29vKXSF1RaQEyYhJV1Tg41y6JQ/C0RzgVIfsZyKgdoWiC
         IFKaCJmnPxHqk0UexzX02/963q+2Cwnn+3o8xnRkmwKthOZ+ZrDKHP1LJr6lua1bZ4ou
         jeHn/JJP7FGFfDnfaBn1xNwTBZ3ldFcSqRB61xrV14QxeUX6l5fin5wPxWaz2l51+lRb
         fYXiHv+IOU5a26B0u/wzHxNPGgmMYtoijrDj9Ta7DXe9LBvdo6agFOsL/T1mGpkEVR2u
         QqPQ==
X-Gm-Message-State: AC+VfDyf5lj46dP0pbt8bq/w2bQyIO/tK3PwQDWtHbU6kTRk5CNYp41R
        VutmHimXAznHLftafhUwrFoPMmVsBDtMTeVKcfOv0g==
X-Google-Smtp-Source: ACHHUZ4Sl/EGPAruGrTNQGlh7bapY2nnzGPQKNTX/n09ov+bzUuKW0uJZPE9Pw+Jl5eeLuFgFafcag==
X-Received: by 2002:a17:907:980a:b0:968:2bb1:f39d with SMTP id ji10-20020a170907980a00b009682bb1f39dmr7880034ejc.36.1683697356051;
        Tue, 09 May 2023 22:42:36 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b0096a27dbb5b2sm319873ejc.209.2023.05.09.22.42.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 22:42:33 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1226922166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 22:42:31 -0700 (PDT)
X-Received: by 2002:a17:907:da4:b0:966:4d99:b0aa with SMTP id
 go36-20020a1709070da400b009664d99b0aamr10366313ejc.59.1683697351492; Tue, 09
 May 2023 22:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230509223036.3007500-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230509223036.3007500-1-azeemshaikh38@gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 10 May 2023 00:42:14 -0500
X-Gmail-Original-Message-ID: <CAHk-=wg7pwWiF4eWVTfFYkfAk_5YDHkmkgZ04cgXkNUO_9pR3A@mail.gmail.com>
Message-ID: <CAHk-=wg7pwWiF4eWVTfFYkfAk_5YDHkmkgZ04cgXkNUO_9pR3A@mail.gmail.com>
Subject: Re: kernfs: Prefer strscpy over strlcpy calls
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, security@kernel.org,
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

On Tue, May 9, 2023 at 5:30=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.co=
m> wrote:
>
> +/* strscpy_mock_strlcpy - imitates strlcpy API but uses strscpy undernea=
th. */
> +static size_t strscpy_mock_strlcpy(char *dest, const char *src, size_t c=
ount)
> +{
> +       strscpy(dest, src, count);
> +       return strlen(src);

Absolutely not.

This makes the whole exercise pointless.

The reason to use strscpy() is to *avoid* doing the strlen() on the
source, and limit things to the limited size.

If you need to do the strlen(), then use strlcpy(). It's a broken
interface, but creating this kind of horror wrapper that does the same
thing as strlcpy() is worse than just using the regular version.

So the strscpy() conversion should *only* be done if the caller
doesn't care about the difference in return values (or done *together*
with changing the caller to use the nicer strscpy() return value).

It's also worth noting that 'strscpy()' not only returns a negative
error value when the string doesn't fit - it will also possibly do the
copy one word at a time, and may write extra zeroes at the end of the
destination (all within the given size, of course).

So strscpy() is _different_ from strlcpy(), and the conversion should
not be done unless those differences are ok.

               Linus
