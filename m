Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0996C20FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjCTTNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCTTNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:13:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C28F9768
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:05:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b20so17921641edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679339120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJqiI1qSkn8SxUWKJtl1QT8eZfoYnhV9G5VDrchaE0g=;
        b=BITsWnomSXhiBuQxoslShJFtHH1T6J8zurWQmFhj1J8MOQha4IM67M6uoEZx5bE1TR
         zsy0drq73pUy7WH9ia8tl/10sUUR4kWKK6BiFPUudMIkV5SPkT6HrcG/EFe8tpGnWP51
         u7w98VVYSLLmdQIfJgbJY2YM4NR2baImXnqN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679339120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJqiI1qSkn8SxUWKJtl1QT8eZfoYnhV9G5VDrchaE0g=;
        b=rA562SAnWh5/v/D75pCT6ijoxLUHWZC562C9EUJbsivhmHEld9ICVLPYVnZA9/iBst
         x5lYfUx23Z6prwPRbXG7BPfG2SY3ji8ICrGBfQfcEcyR7zART10TDDi1ajQvnVybZjVD
         DMnt3S0fIM8TNdO+M8Z6TqTAikltqL2kIoRrGZ59kkZpih1v99s5SSGQug/lZCKsIfs6
         m0v7j3mJqV3l/0WOrkwbqXdpB28JvlwhkwkZTfJvcdk5LBy1girMWH97FEMB+GzVNjif
         fkZ1KYfXUap0MfXMV8zDf7+hiqNmtuG8KCME5NaAqBvcAoIUKlrivjyrz5lssbybGkri
         8Pzw==
X-Gm-Message-State: AO0yUKVmez2glG0rND/w72ubINMl0yTyVS9HbJGfFMfE0ST61N8aUtQy
        H2oWrJG7ZR0K1ubBXaHk32WZC6pwGbKCY74aFxWjfOaB
X-Google-Smtp-Source: AK7set+KC0Krh6zMDDq05tBPeOrToltFPEq/TqtRSX7s1Hc/NC193TdtgVZrXBqlGj3F3TLSMXNM5Q==
X-Received: by 2002:a17:906:6d4b:b0:862:c1d5:ea1b with SMTP id a11-20020a1709066d4b00b00862c1d5ea1bmr166654ejt.8.1679339120210;
        Mon, 20 Mar 2023 12:05:20 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id gu12-20020a170906f28c00b008b17de9d1f2sm4875509ejb.15.2023.03.20.12.05.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 12:05:19 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id x3so50806971edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:05:19 -0700 (PDT)
X-Received: by 2002:a50:cd0b:0:b0:4fb:4a9f:eb95 with SMTP id
 z11-20020a50cd0b000000b004fb4a9feb95mr345395edi.2.1679339119215; Mon, 20 Mar
 2023 12:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X> <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
 <CAHk-=whXi1qgeDLHbaCyMpZ4XXYqS=fT2daYAmWntEK2rhG25g@mail.gmail.com> <20230320185602.GB615556@dev-arch.thelio-3990X>
In-Reply-To: <20230320185602.GB615556@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 12:05:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhKfp=tBHsNMnqFh7bSO1CiHXSv+hycOr0dueR_GQeZw@mail.gmail.com>
Message-ID: <CAHk-=wjhKfp=tBHsNMnqFh7bSO1CiHXSv+hycOr0dueR_GQeZw@mail.gmail.com>
Subject: Re: Linux 6.3-rc3
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:56=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> I did see a patch fly by to fix that:
>
> https://lore.kernel.org/20230316082035.567520-3-christian.koenig@amd.com/
>
> It seems like the DRM_TEGRA half of it is broken though:
>
> https://lore.kernel.org/202303170635.A2RsQ1Wu-lkp@intel.com/

Hmm. x86-64 has 'vmap()' too.

So I think that DRM_TEGRA breakage is likely just due to a missing
header file include that then (by luck and mistake) gets included on
arm.

You need <linux/vmalloc.h> for 'vmap()'.

There might be something else going on, I didn't look deeply at it.

                   Linus
