Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1435E6FF3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbjEKOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbjEKOTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:19:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2371991
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:19:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so79823604a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683814768; x=1686406768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/W5GB4E38fHdQpL0SzJkoknJdNzqLnuSIkNSr13Ymk=;
        b=RSDHREpAcYSI/HiA9jG4HfyGuqu8emlmGKaiyNbYoEm/449/U+d5jLKr0N3HbDhrFu
         Eq7KapRhjPG9gz+JhbrNON5QWOHN3yZn3bHoLzL5qWlBBfz2D78ujJZOm+lsIYwhz+5Q
         ZKnwi+0oioOzmlbW/9Vvel2zp5TgJ4jM31y74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814768; x=1686406768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/W5GB4E38fHdQpL0SzJkoknJdNzqLnuSIkNSr13Ymk=;
        b=GtOzWmecpEy9Im+KEQzdJC+C5lFkX9dZh0Hkh3wddgBNV2Gq7ZZdf1GbaID6uScPHA
         3Uq2SBnXZ6jfhkzECvontXG3CPWkMQCz6nQscSdJWVLCyawlmXGBY8t04u2ZD0jj2sjv
         o15WIflXdq/KW/x/tpd+3bOShhzn9d0+0tzo9lwSfXt3PYrXM1jieBwsqiXyYxFlTtfb
         C6CQB69Etub0sAB9QfDaKrxa4KNYyl5yMcYIdiWbi51zrb/KsuGeI30MU9sm84tc+1dV
         YSUxc65kwhgSwk3GauwG+TH1AiL2R8W0HaU4uTstTeTf9UFE/YcyPh/bxCb62x7g7V7z
         HcWQ==
X-Gm-Message-State: AC+VfDyHx+rDRCCHHH9ss97j+NXc7cQAuO7/lN8fLUM7ZwmpMZ1KFg4C
        xnEGXT1BBxvMfZV93avVbqOV75/8Y+bY41jzpikp+A==
X-Google-Smtp-Source: ACHHUZ68/tdofVbS0Ru/RoRPte7P2LqseGJCh7k0rx+PS6EtdigqTu3hfEBFwVrXzgo0GJW8jM/5mQ==
X-Received: by 2002:a17:907:7d88:b0:967:2595:b099 with SMTP id oz8-20020a1709077d8800b009672595b099mr11191249ejc.28.1683814768353;
        Thu, 11 May 2023 07:19:28 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id kz23-20020a17090777d700b009659fed3612sm4055385ejc.24.2023.05.11.07.19.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:19:27 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so79959141a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:19:26 -0700 (PDT)
X-Received: by 2002:a17:907:3ea8:b0:953:37d9:282f with SMTP id
 hs40-20020a1709073ea800b0095337d9282fmr18146763ejc.38.1683814766379; Thu, 11
 May 2023 07:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030705.399628514@linuxfoundation.org> <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c> <2023050913-spearhead-angrily-fc58@gregkh>
 <20230509145806.GA8@df3c0d7ae0b0> <2023051025-plug-willow-e278@gregkh>
 <CAG9oJsnr55Atybm4nOQAFjXQ_TeqVG+Nz_8zqMT3ansdnEpGBQ@mail.gmail.com>
 <2023051048-plus-mountable-6280@gregkh> <CAG9oJskrJotpyqwi6AHVMmhnFmL+Ym=xAFmL51RiZFaU78wv-A@mail.gmail.com>
 <2023051132-dweller-upturned-b446@gregkh> <CAG9oJskf0fE7LiumdzD4QW8dTmGpmVyXBSyiKu_xP+s72Rw44A@mail.gmail.com>
In-Reply-To: <CAG9oJskf0fE7LiumdzD4QW8dTmGpmVyXBSyiKu_xP+s72Rw44A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 May 2023 09:19:08 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjJNHjwfrT0X5DvSP3fZzUF0SAbErkc30qAWDW=U9uKtQ@mail.gmail.com>
Message-ID: <CAHk-=wjJNHjwfrT0X5DvSP3fZzUF0SAbErkc30qAWDW=U9uKtQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, ntfs3@lists.linux.dev,
        almaz.alexandrovich@paragon-software.com
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

On Thu, May 11, 2023 at 3:30=E2=80=AFAM Rudi Heitbaum <rudi@heitbaum.com> w=
rote:
>
> I have run 6.1.28-rc2 today, and was able to trigger the error. So
> definitely bad in both 6.3 and 6.1.
>
> [13812.020209] BUG: kernel NULL pointer dereference, address: 00000000000=
00020
> [13812.021322] #PF: supervisor read access in kernel mode
> [13812.022346] #PF: error_code(0x0000) - not-present page
> [13812.023591] PGD 0 P4D 0
> [13812.024876] Oops: 0000 [#1] SMP NOPTI
> [13812.026088] CPU: 5 PID: 20386 Comm: .NET ThreadPool Not tainted 6.1.28=
-rc2 #1
> [13812.027336] Hardware name: Intel(R) Client Systems
> NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
> [13812.028593] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]

I suspect this is fixed in mainline by commit 6827d50b2c43 ("fs/ntfs3:
Refactoring of various minor issues") which changed the IS_ERR() check
into a IS_ERR_OR_NULL().

But dropping the original fix from stable might be the right thing to do.

                 Linus
