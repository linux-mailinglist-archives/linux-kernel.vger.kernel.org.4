Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76576717007
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjE3V5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjE3V5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:57:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E844F7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:57:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so6358070a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685483833; x=1688075833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dRXUhZqAXtIVu5pGmKLHh9adzhr/kFGdlVLQd625Qs=;
        b=ZsdehW9Pfs8WHcCJwuE3zxa378WBg+oybGabkQ195uuuUAZoBT8u29asveo67MNpTb
         2XjJv8vqpftIxKkzY5dUZ8ogbRp6//OC2Fvnn2kioXs2pGtgD5R8O7p7uzFLg5DhcmqT
         ulZhprjbhaEFPxQetuZHPx2LEXYwNfZl2GD/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483833; x=1688075833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dRXUhZqAXtIVu5pGmKLHh9adzhr/kFGdlVLQd625Qs=;
        b=FFxhI06HPOeg+3vn7Bv+Ekpb/qhUus2XlPrGMAQlvqJVIPA5Z5fXIpS9Za4xW0xx4i
         lMwaW9n2QECHIoNrGLHin1Jf4yhFrrbodrzsU5EKwStU9+SIoYywZ/eFr6MXQE+BOZjq
         bksX+6kXMlj+bC0gFIxCnqhVqKLFkwLNixmti/wdOfcLr9KhkVtXbuDchTpmH+WXUSnm
         XIxs2mHHCnZYwqPWBna1UpFXbQ27qncf/ZfYYEKgiq8oazQ8NoKzsL6VD09liQp3UvC2
         8IIyqbrtJOFT9pgrjy6wSEFh3ij1Ujr+JY7mdGMsXrEhjxj46yE8mZT4Gn6+ugfDfTES
         ATpw==
X-Gm-Message-State: AC+VfDwV3rcW6rKQga2Ts96No1wo/uuIAeGSTzBZGTQFgpeGpjrYev4X
        Kzjj+yq8ih5Nzu8UDYJLGbkM+nkjgCq3UBATY4e4UjDY
X-Google-Smtp-Source: ACHHUZ74swF/EMAOxXv/PnvS3WyV9LhZlJJPyeXCJdsrnSrZhP4+adbkuZHUprGG00y5wIUQPI2ADA==
X-Received: by 2002:a05:6402:515c:b0:510:d889:88c8 with SMTP id n28-20020a056402515c00b00510d88988c8mr2410510edd.38.1685483833651;
        Tue, 30 May 2023 14:57:13 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id b3-20020a05640202c300b0050d988bf956sm4804241edx.45.2023.05.30.14.57.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 14:57:13 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so919906866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:57:12 -0700 (PDT)
X-Received: by 2002:a17:907:5c8:b0:966:53b1:b32a with SMTP id
 wg8-20020a17090705c800b0096653b1b32amr2872578ejb.53.1685483832618; Tue, 30
 May 2023 14:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 17:56:55 -0400
X-Gmail-Original-Message-ID: <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com>
Message-ID: <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 5:43=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> [ add linux-cxl ]
>
> Sedat Dilek wrote:
> > Hi,
> >
> > after building Linux v6.4-rc4 I can NOT boot into my Debian GNU/Linux
> > AMD64 system with root-ext4 (/dev/sdc2 - of course using UUID in
> > /etc/fstab).
>
> I did not find a mailing-list thread for "9828ed3f695a module: error out =
early
> on concurrent load of the same module file", so replying here.

It is this thread:

   https://lore.kernel.org/lkml/20230524213620.3509138-1-mcgrof@kernel.org/

which initially proposed a different solution, then that "just reject
concurrent loads", and after that caused problems, there's yet another
proposal at

   https://lore.kernel.org/lkml/CAHk-=3Dwg7ihygotpO9x5a6QJO5oAom9o91=3D=3DL=
_Kx-gUHvRYuXiQ@mail.gmail.com/

although if you want to try out that approach, Johan pointed out a
missing initialization of a spinlock in that patch in a reply there.

> Just wanted to highlight this a test case for the next attempt at this
> fix.

See above: the next attempt won't be until 6.5, but if you saw the
failure on your test-cases, it might be a good idea to check out that
next attempt early..

               Linus
