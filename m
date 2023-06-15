Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A972731FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjFOSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbjFOSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:08:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ED72D4D;
        Thu, 15 Jun 2023 11:08:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6039752f8f.0;
        Thu, 15 Jun 2023 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686852500; x=1689444500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdicQRGnfDc93YkcMQQA6yonmb0LHEd8ZOrWHxoA7C4=;
        b=Sro7cBRw5EdbOyM1EX0k/Q5uwZz7qLRLM8KmmHhU6IRGVW+aZy24XNkivh5ZBnm4sH
         xrm/Bd7wNbvti8DTf2fcdxPO+SZfEWsLYjCfoHsJZZcHuRH3ma2ExnASNzdf0Nd6/N+Y
         5ZUmxHveifOkxOu4YVd2+Snt9Rc8to61AxoOMvHGb1qmB6dYLEvLfTpPhlpVz4IZbtqj
         aozOYM3pgavAhiyfeF/hrlbsl5SOX8d+9JLnfy30J605CrV5vn6S8A8zUZ/ToWIhdsUg
         icAf6mvZQJgfbQY06DBU7FzFcBcaxVJYO2sFkLlJpR22H6aVbJ9n1zz6oBncxrmVOcnJ
         +Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686852500; x=1689444500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdicQRGnfDc93YkcMQQA6yonmb0LHEd8ZOrWHxoA7C4=;
        b=DX9WpTMFL+KMnUQ2NWaLVo8NfUOpgsN5+ucN8HWuKI05tcJxAIUfwdDe7skm3v1QCX
         LMmmoNGQuj5tzP5XhKxou4knXW8PYSJmn4AGehRpwmSQCj1KX2qxtZuB7MvXmr+JX+Ax
         CFp3l6az+7Eex8bB1fbOLE4U4oEeSTrwxgpjorAqLKrpd5Kii3nP3dwrKIHrUMbNpnt/
         BWSpi3oceIm5iR4MeG/kWHBhcXH5xtNvIqHzpuDCfDp3A/6Y080uMwM9snFdSP5XVTN9
         JUg1vmHGH4VN29lDQXYVfkkLxVCO4HWGSA74AA85NvPI/nuo3zjCmcmpHMIMXaLq7RjJ
         Yo6w==
X-Gm-Message-State: AC+VfDzyRuNNvLVd46nl0z2i35CMuHY89cD5GiVEJWakS8xhi+jiBLH7
        m2EQBjuwSGE60FCEE/skUYJ5ICWetm6HVcxG0U8=
X-Google-Smtp-Source: ACHHUZ7086AepGoCpJ+cTM6732XnEwVHN7ojtkdMcNT5yZRXOQccyazBUX7ASE1FSz7bblVmj/O2Gz3tkIbz1fGqQRU=
X-Received: by 2002:a5d:5491:0:b0:30f:bb97:37e8 with SMTP id
 h17-20020a5d5491000000b0030fbb9737e8mr9091871wrv.47.1686852500181; Thu, 15
 Jun 2023 11:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230614141026.2113749-1-azeemshaikh38@gmail.com> <2023061516-stricken-prior-8057@gregkh>
In-Reply-To: <2023061516-stricken-prior-8057@gregkh>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Thu, 15 Jun 2023 14:08:08 -0400
Message-ID: <CADmuW3UsVA-MCMkNcYvCTCX6F2iUTg48cUSGrg_u0py5P9oiEA@mail.gmail.com>
Subject: Re: [PATCH v2] usbip: usbip_host: Replace strlcpy with strscpy
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 15, 2023 at 5:33=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 14, 2023 at 02:10:26PM +0000, Azeem Shaikh wrote:
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
> > ---
> > v1: https://lore.kernel.org/all/20230613004402.3540432-1-azeemshaikh38@=
gmail.com/
> >
> > Changes from v1 - uses "< 0" instead of "=3D=3D -E2BIG".
>
> Please fix the reported errors from the build bot.
>

Sorry about that, I was hasty with sending out v2. Sent out a build tested =
v3.
