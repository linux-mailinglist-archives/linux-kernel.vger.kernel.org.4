Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079536F2131
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjD1XfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjD1XfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:35:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70F49DE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:35:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-953343581a4so54390166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682724905; x=1685316905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nC3lDy6oF9TSUP8W2/TITo5d6aWrWCjfITyVQ/L7zgs=;
        b=B0VSON09q68IX0X4fxgCMfNEPdIuVtVfm5uZkWzqrLl5+9Y49omu1CarH2yxxantgk
         Z4heCJ44zsZtQMwVjx8fIWhROPdA69IAAkykA+UQtwKUfZBzrl0YxQyf67PDt68wYlAo
         aKwAsZd0lHwcwwMcnKdUIHXdot8ZQ0QVleBQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682724905; x=1685316905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nC3lDy6oF9TSUP8W2/TITo5d6aWrWCjfITyVQ/L7zgs=;
        b=WMhRoHVztKT60Js7tolyCthk3bR4Bi0SfTzm7lHwFbqeePCEphDlX9kTSwW4MK9zCR
         4pYNIUprLwbfdsQ/VROOMLvB9hw3W7zspqFw7kuj89vXgMcAgakKrubiLz6Y8hJLMKtN
         zSk1g4LzszSxD/qF724BhaqIobEdEmJjFfeDVOFEMksXkRFcfK7KIrNi1FYTZWmSfMfi
         TioeGZJ1QCTbKgntvM2P+FJcUO7yknwR6v0BcDdqHRhVWUc5fDeI8b9QPEc4LIo6j3z5
         Ghc2iYUU1irvgjtVhtqLGZ6XR8ZAy5H5fMBUETDVBqVceRm1mRzgPk6rNxsJwACU03vP
         irPg==
X-Gm-Message-State: AC+VfDz55n7iGuLEoBqVo4hVvHc5c9/bEKPMkfE2p4DxSSdH8HSVZn2W
        EV5l5+sOTeAKo3zThHkIYK2WHWjNgEFOtBRCDCL8Axig
X-Google-Smtp-Source: ACHHUZ5iqeAreJ1eeG6tzKd1CTz2WSU3/8FbipiDt9Bxa+qMd5Q8Gc06Iuk9XjkHvm/z3W22hso9UQ==
X-Received: by 2002:a17:907:1c95:b0:948:eed:b4e0 with SMTP id nb21-20020a1709071c9500b009480eedb4e0mr8683170ejc.61.1682724905514;
        Fri, 28 Apr 2023 16:35:05 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id qp4-20020a170907206400b0095390b1dd39sm11840236ejb.115.2023.04.28.16.35.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 16:35:04 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-504ecbfddd5so433041a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:35:04 -0700 (PDT)
X-Received: by 2002:a17:907:6e90:b0:94f:5079:ade2 with SMTP id
 sh16-20020a1709076e9000b0094f5079ade2mr8278173ejc.62.1682724903906; Fri, 28
 Apr 2023 16:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <87fs8k734t.fsf@mail.concordia>
In-Reply-To: <87fs8k734t.fsf@mail.concordia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 16:34:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgY8_-BvS5mFR+UtCwbLrOVikYfHi_m9OFxE2D43B+=8g@mail.gmail.com>
Message-ID: <CAHk-=wgY8_-BvS5mFR+UtCwbLrOVikYfHi_m9OFxE2D43B+=8g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     aik@ozlabs.ru, ajd@linux.ibm.com, alex.williamson@redhat.com,
        arkamar@atlas.cz, bgray@linux.ibm.com, christophe.leroy@csgroup.eu,
        ira.weiny@intel.com, joel@jms.id.au, kconsul@linux.vnet.ibm.com,
        kjain@linux.ibm.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        liubo03@inspur.com, mcgrof@kernel.org, mikey@neuling.org,
        nathan@kernel.org, nathanl@linux.ibm.com, nicholas@linux.ibm.com,
        npiggin@gmail.com, nysal@linux.ibm.com, pali@kernel.org,
        paul.gortmaker@windriver.com, paulus@ozlabs.org,
        rdunlap@infradead.org, robh@kernel.org, seanjc@google.com,
        tpearson@raptorengineering.com, windhl@126.com
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

On Fri, Apr 28, 2023 at 2:44=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/=
powerpc-6.4-1

Odd. Your shortlog has this:

> Michael Ellerman (46):
>       powerpc/configs: Make pseries_defconfig an alias for ppc64le_guest

that removed the 'pseries_defconfig' file, but then your diffstat

>  arch/powerpc/configs/pq2fads_defconfig                                  =
             |  80 ----
>  arch/powerpc/include/asm/atomic.h                                       =
             |  53 +-

doesn't have it, resulting in the summary not matching what I get:

> 278 files changed, 2672 insertions(+), 9188 deletions(-)

versus my

 279 files changed, 2690 insertions(+), 9528 deletions(-)

and I see no obvious reason for it.

I wonder if your test-merge just didn't remove the file (it did have a
conflict due to the IXGB driver removal), and that's why.

Anyway, I'm not entirely sure about the mismatch of the end result,
but it seems to be due to that one defconfig file, and I think my
merge is fine. But please double-check.

                   Linus
