Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C46BFC34
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 19:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCRS5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCRS5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 14:57:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C5523A63
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 11:57:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd5so32376343edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679165855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM/qm8tuy+CwBAqdkEhnw/YF3C8EgxLtBG2rYLxmTn8=;
        b=C2HKbOxszTOLB8zwDKq4Xwkd/0BDSEw4SlkXlsMVJC3C660t8LX1mcpFAurCNZWw5X
         6IGYZSk0iHYU+hsQ8mw1KMSbFq6f8bEunsNJoVnjmu5fnVD9O0A2F0K/cky0WPpgz7/5
         pJterdgDAjO8JCz0P3cVg95mtqK5lnkC86qS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679165855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aM/qm8tuy+CwBAqdkEhnw/YF3C8EgxLtBG2rYLxmTn8=;
        b=vVTo+DH7j9C/Zjdl+wJoK0QQL93Xdnr09CwO/5rQvuBZuLFJZQL9DPTOruVMbbiJYJ
         R3cswx0N2xSMTL6ZJx8ptIYIoQUc7ZTU53Qxu0KmLQzXQe7feVadvDktBZTICA8Fz1n1
         aVBs1M8OXyVaNg/D4KRE4wWU0KJz18UbN727LLcrw+Vza8HGMR35rLAufEmu1MMCbzKv
         UlXu/mDDoyPOq4OIWIscjukB8abMYwF+5clcBm/YjtAl+juotU1aBiV/Rlf25e20qfdo
         OvRs5FfU4nbcZWbhNq0XwOSwUqTy0JZN9X0sCcIr5aWmzi03OahHaqjQukqf9LDHb+rX
         Srrg==
X-Gm-Message-State: AO0yUKUkWu+scxfuFItEhLRrwFuPYa1YQfc+02C2UVWZNJhEnfoydBi5
        QPMM7OkYbD7uyrcVUIrgDFktM0cP3na9Wv2gBUPNqA==
X-Google-Smtp-Source: AK7set+fesUQSMuAI9H688sduG3tQ7+ECOe136p1Y778ZcSuBI+aUPYhnD+84MW4WpHD6tpV6CFY3w==
X-Received: by 2002:aa7:c510:0:b0:4fd:29e4:ccfe with SMTP id o16-20020aa7c510000000b004fd29e4ccfemr6737313edq.18.1679165855003;
        Sat, 18 Mar 2023 11:57:35 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id n7-20020a170906b30700b0092f500c5936sm2431723ejz.201.2023.03.18.11.57.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 11:57:34 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id er8so20682092edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 11:57:34 -0700 (PDT)
X-Received: by 2002:a17:906:cc9a:b0:931:6e39:3d0b with SMTP id
 oq26-20020a170906cc9a00b009316e393d0bmr1622308ejb.15.1679165853857; Sat, 18
 Mar 2023 11:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARH1PPARMD31mECPFs86j8o1MSDTrwahdavDm-C3Dg_sA@mail.gmail.com>
In-Reply-To: <CAK7LNARH1PPARMD31mECPFs86j8o1MSDTrwahdavDm-C3Dg_sA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Mar 2023 11:57:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJeNev2qR+ZjX_UKc-XTrsnae0cUV+RqaE_rMprKL_Ng@mail.gmail.com>
Message-ID: <CAHk-=wiJeNev2qR+ZjX_UKc-XTrsnae0cUV+RqaE_rMprKL_Ng@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v6.3-rc3
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 8:46=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Please pull Kbuild fixes.
> This removes scripts/list-gitignored.
> I hope you will be happy with it.

Woohoo. Looking good.

Thanks,
          Linus
