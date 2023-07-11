Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EBD74EA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGKJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGKJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:25:05 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A81BD7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:21:06 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3466725f0beso7107155ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689067266; x=1691659266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EcSi56+I/iiHX6DYCKsNAvHqRVfHSrumW++BHQC568=;
        b=FcDG0z6O6apqWaZX92K+NiLUDRZx2DzRF3R2Cl0ZCrhDUJytRpVSvFk5KzrkdrRh7k
         fpWe93nbCwShBqEpwdqdWX3BfyRfFzJyet9kxGZmTctrc2IJH6vVoV6rkNs3rhSHNHIm
         iQTE/5yjnnYaC+zq7GMf2xKxeA8JhCtf0xKsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689067266; x=1691659266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EcSi56+I/iiHX6DYCKsNAvHqRVfHSrumW++BHQC568=;
        b=kj7AVtYEBCo25xt0IbzCS86w1mbRpxIJ2+oeLZ3a1dywB54Yg4yvw0AlSBThr/SJ1r
         inHkXnIKTFO+ta5uCAOgt3z98aDCC1BsQbm+SYT7SE43Y4RxygPtqZOoRZSImwLqMmvG
         P7F20diRrh7PzHHDMHb/V/jHi0WobF16+raQUn49CrR6qucQ9ltW7jdZN8VvtPqjx37g
         l+3j3XCMS7vYx8im+SCWzTJ7n6JfdZ39XmavdSN6YZrImhO+VaNqtIm3u0Nhi4rhKlrR
         hwNSQcMTQ5QJxrObFPzvhNUyhbzJ1BSwFevH3JTmydwHy6C5Zl8SBfVy1GIxG8zpD9Aj
         Zz6g==
X-Gm-Message-State: ABy/qLbH26H5O60ZuxnQ4a+OaU+qtqzI+3d/pH2IerE4h44OosvooQOt
        mcUm2hm0eOhIJoIFqxPSJODH7mgUJNdXrDm1XNo=
X-Google-Smtp-Source: APBJJlHXvooGVsjHojcWNSQFxLRsKaIeATcJ7+NMELzDj1o8e2ZbN+YKYcLp7kN29QNiwx4KzfsFHw==
X-Received: by 2002:a92:c505:0:b0:345:b953:7bfa with SMTP id r5-20020a92c505000000b00345b9537bfamr14262244ilg.30.1689067265991;
        Tue, 11 Jul 2023 02:21:05 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id y9-20020a92d809000000b003460b8505easm501597ilm.19.2023.07.11.02.21.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:21:05 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-78362f57500so270647739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:21:05 -0700 (PDT)
X-Received: by 2002:a5d:9f48:0:b0:776:fd07:3c96 with SMTP id
 u8-20020a5d9f48000000b00776fd073c96mr18436123iot.7.1689067265096; Tue, 11 Jul
 2023 02:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230711083055.1274409-1-fshao@chromium.org> <CAHp75VfSL5j-ZUYkezELWzq+c_V+CFL6iVQWQ=roPYrZ=h1rSw@mail.gmail.com>
In-Reply-To: <CAHp75VfSL5j-ZUYkezELWzq+c_V+CFL6iVQWQ=roPYrZ=h1rSw@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 11 Jul 2023 17:20:28 +0800
X-Gmail-Original-Message-ID: <CAC=S1njKS0fLBtBS9P_K5gawaA7E804=Jkhe0PGekVAUxUbEDw@mail.gmail.com>
Message-ID: <CAC=S1njKS0fLBtBS9P_K5gawaA7E804=Jkhe0PGekVAUxUbEDw@mail.gmail.com>
Subject: Re: [PATCH] leds: pwm: Fix an error code
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jul 11, 2023 at 5:10=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 11, 2023 at 11:31=E2=80=AFAM Fei Shao <fshao@chromium.org> wr=
ote:
> >
> > Use the negated -EINVAL as the error code.
>
> Thank you, it seems Dan had been the first one.
>
> Message ID <a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain>
Thanks for the pointer. Please disregard this patch.

Regards,
Fei
>
> --
> With Best Regards,
> Andy Shevchenko
