Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69073744685
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 06:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGAEXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 00:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGAEXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 00:23:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F831B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 21:23:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso4254057e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 21:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688185384; x=1690777384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ViFCqfiw9NC8hbaUDlyrBH6eii1s13MnpTkthHHGEXE=;
        b=ACV7XAyCVqAaBPNd+vSu/FV7OVAcONKkLsIThuTWcFsU+vFFJE8UGIfDFQ9syAqfBF
         UHhVf2ek1ZJtMlI1dLek6aI8vF62vW5SiqORp+TfAwaKEs8e3//gpSn8LzMzxLe8PJ+e
         fkz6qDz5S4RTJATaYWGRbVauPShNUyPDdt41U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688185384; x=1690777384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViFCqfiw9NC8hbaUDlyrBH6eii1s13MnpTkthHHGEXE=;
        b=kMpW9qqnkLYCzIZhmsDFb2jbavOocNhzQ5AxaqzZLyd9DKO2QaDYAzCUixR/p2IDH2
         bVxYVfB6Pwn4dYNSgxDmYLtVnzobbdEOcRmwqCvF7MFqsgZPRLdxp6ZP8m9awFAcaZF5
         Od+W6LL0TxYxYNZZGnma21pbfJe6lirhlSNWFVxcMSQzSGaNLnLsSYBnIfyuOiXysiY+
         yE9vtPu9LG0ULgM1DJiy1sQzzpOoz6O7VXbFhLtstZ3yqwQE/yL/k/5QeeF8GDnM4uvA
         bof73RXO5ST/lm+xq9VpNl4nLcs37MKpxrw0FYwI0XEz+NQSBePRpAfc0aJu5Gd4SNlH
         Bvpg==
X-Gm-Message-State: ABy/qLa1SgFgt0nsX/bwZJP3uuns0Z8Kv0xaa5U9f3+qn4TcqfIN0Eg+
        8A8tPJsVBYOAH7FcOeGyY3vepgOxivl5zhgPm6t3MRVx
X-Google-Smtp-Source: APBJJlEy1Axjgi/RPcqM8Hp3KMrEOG/QlThE4PMvZ4YKGT26PQEPJe2zmhT25lMu4kdmZupgBZ8mRg==
X-Received: by 2002:a05:6512:5c8:b0:4fb:8953:bb8 with SMTP id o8-20020a05651205c800b004fb89530bb8mr2948664lfo.50.1688185383994;
        Fri, 30 Jun 2023 21:23:03 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c1-20020a197601000000b004f3afa1767dsm1320900lff.197.2023.06.30.21.23.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 21:23:03 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso42228411fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 21:23:03 -0700 (PDT)
X-Received: by 2002:a2e:888e:0:b0:2b5:9f54:e290 with SMTP id
 k14-20020a2e888e000000b002b59f54e290mr3104948lji.0.1688185382985; Fri, 30 Jun
 2023 21:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
 <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net> <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
 <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net>
In-Reply-To: <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 21:22:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
Message-ID: <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 at 19:50, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Yes, the patch below fixes the problem.
>
> Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... running ......... passed

Thanks. Committed as

  d85a143b69ab ("xtensa: fix NOMMU build with lock_mm_and_find_vma()
conversion")

and pushed out.

                    Linus
