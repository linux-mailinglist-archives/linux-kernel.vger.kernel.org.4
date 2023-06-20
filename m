Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31BE73717F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjFTQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFTQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:27:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A1DC;
        Tue, 20 Jun 2023 09:27:28 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38ede2e0e69so3135341b6e.2;
        Tue, 20 Jun 2023 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278448; x=1689870448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpnniq76PXiCDxg/rDwxgmARY1zRtNLr8bVJxlqw4q0=;
        b=bzBfGUDzmJ/U10TDjWJ4dsXKAS19ieQ2vMUY/K8NSFl+1rzia8AdbDNRjtUPlorX5g
         mmyXIPCOAuT8Dqnxin4zVlWPTIE0p6yjzS4rM+PebVLqdLmvvsUl+XTzyURSp/P+T+dL
         +7xSZSk35Zzmxh+rRgjGJETERnVq+2Sutg+axQHP3LaTIHW7+YKvUf9GXNpiUvrDmgds
         3yq50KhCLgAyZAPy8eosPt5y/aQyER5oSjgNwtjBGJI+hQc80VOi1qVeCiDlBCpHUvT8
         F/EP2G5ak/HTotG/d7xgxZ4RT2fty31Z8Y/C4OntXmGg+LuKaKs53pBL1O8kH0J0zUTW
         0QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278448; x=1689870448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rpnniq76PXiCDxg/rDwxgmARY1zRtNLr8bVJxlqw4q0=;
        b=f0OZyQwYeuS8EVb0Fk36Fh8paghRrrkhU92o4QiqdL4iZ1Qn3oFn+LQsiA9AK9+GH/
         NZyGaNWHPQvQH5XcMcea2GMbOMLSJPbNWh4y5Uw5s7/fxG1Ur+fzzdIIVA12h6WwzL79
         GIfySBxHk7FJvKdK6O//wGc5fgt0/rtAi3EoWgYWdkyX3JcKuNsci6gx0qAu9WEvergB
         pLvXukZLInnloLVgqqZ6F+Hy0Gu4oelXTzUDjjz9h8m25EDXO5ycvBmHdFmxQVCmN0B1
         BuCnGR5rjpn9HM6q3BM17pFEBOM4JWl3G6JJ+jO3dy1SWInkCo8/K2KlQ7/KlV6DaWrA
         9eKw==
X-Gm-Message-State: AC+VfDwaoPlAOAtNnmxmcgvnOe3az6P8nt7ARGTSdd++42J10ZmDPtU8
        4fWul82r8QjgPnvfIx5Ro1jpvU5SXDn8ffv90ts=
X-Google-Smtp-Source: ACHHUZ6eKurANqWw6fRQ3Hyc/pEvSxuO6i2ydbcU9ew7NJNN8ad5zhu1i7+QAETSC2pO/hQH8IoVyH9ZZQW46BREs8E=
X-Received: by 2002:a05:6808:1481:b0:3a0:373c:2960 with SMTP id
 e1-20020a056808148100b003a0373c2960mr3238276oiw.36.1687278447901; Tue, 20 Jun
 2023 09:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230614095158.1133673-1-elver@google.com> <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
 <CANpmjNOSnVNy14xAVe6UHD0eHuMpxweg86+mYLQHpLM1k0H_cg@mail.gmail.com>
 <CA+fCnZccdLNqtxubVVtGPTOXcSoYfpM9CHk-nrYsZK7csC77Eg@mail.gmail.com>
 <ZJGSqdDQPs0sRQTb@elver.google.com> <CA+fCnZdZ0=kKN6hE_OF7jV_r_FjTh3FZtkGHBD57ZfqCXStKHg@mail.gmail.com>
 <ZJG8WiamZvEJJKUc@elver.google.com>
In-Reply-To: <ZJG8WiamZvEJJKUc@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 20 Jun 2023 18:27:16 +0200
Message-ID: <CA+fCnZdStZDyTGJfiW1uZVhhb-DraZmHnam0cdrB83-nnoottA@mail.gmail.com>
Subject: Re: [PATCH] kasan: add support for kasan.fault=panic_on_write
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>
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

On Tue, Jun 20, 2023 at 4:49=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Tue, Jun 20, 2023 at 03:56PM +0200, Andrey Konovalov wrote:
> ...
> > Could you move this to the section that describes the kasan.fault
> > flag? This seems more consistent.
>
> Like this?
>
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index 7f37a46af574..f4acf9c2e90f 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -110,7 +110,9 @@ parameter can be used to control panic and reporting =
behaviour:
>  - ``kasan.fault=3Dreport``, ``=3Dpanic``, or ``=3Dpanic_on_write`` contr=
ols whether
>    to only print a KASAN report, panic the kernel, or panic the kernel on
>    invalid writes only (default: ``report``). The panic happens even if
> -  ``kasan_multi_shot`` is enabled.
> +  ``kasan_multi_shot`` is enabled. Note that when using asynchronous mod=
e of
> +  Hardware Tag-Based KASAN, ``kasan.fault=3Dpanic_on_write`` always pani=
cs on
> +  asynchronously checked accesses (including reads).
>
>  Software and Hardware Tag-Based KASAN modes (see the section about vario=
us
>  modes below) support altering stack trace collection behavior:

Yes, this looks great! Thanks!
