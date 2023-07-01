Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28D744A35
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGAPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGAPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:01:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FBB35BC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 08:01:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d80c5c834so5122968a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688223689; x=1690815689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wvLshWsSLBZ/5yypeB0xY2a5lfsRQLT8GONX/h7vZc=;
        b=Evafb925bOkL13cW+fj2G8xKEXf4U946yMCWqaVjm51cpPQeH2n6pwG5YxYiwxgxRJ
         4y9x3oZkcIWIAmucJAMPSwxxvlHgGKuU64c3otiPe8mRUJO11Bs0azZZMiUIsHewXsbW
         JNRGD/qOPlDIapZr9QMwLE7hAXojsmShhdOCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688223689; x=1690815689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wvLshWsSLBZ/5yypeB0xY2a5lfsRQLT8GONX/h7vZc=;
        b=FkbUSeGnhGZT784RyAwavBiB53LtlQ60zkAVGM81rCAAUoatnVpgAokG+5O0dluxFY
         GFGzM2aX5VMtXrqgFyJr6+PzFJ5rmIEZyjBCFqpTbh2MpbcsVp4Oe9XV648YM7cJAP9O
         ZPQDOXRt+hrJKpYnTBiZ7GtXXen/YKteczpsyWjSSShx59KzkOIrQAMmMnOnzkYVN6uG
         doucgl0+47DKnaAEV/EysWbnDlC823UKgN1hruW9Ox0RKo/MzfajT7Z/J/AuMPGxBzaz
         VQAwJR1nbHPvFqnvz7sDih6ycdbIWlBrbtYiSPYDb7KCQdBX7bnUMxBG5zRZj/JhAlj1
         4ngg==
X-Gm-Message-State: AC+VfDyZ1DVom6aoBfV2Kg4NNjBvkP65j/6FhvdNRUEhSS+bg3FmIpqS
        GuAeYP7dsT6gu8kl3gB2GQ38rmXSs40rHu6jJMHtVEom
X-Google-Smtp-Source: ACHHUZ5br4Ha0DwO/jeSbbts4YGQK7LRX8zxyxTLWlVOqBHupU6lC5qvwywvtWh/XtrWNtszA1gVUA==
X-Received: by 2002:a05:6402:889:b0:51d:87d7:5a3 with SMTP id e9-20020a056402088900b0051d87d705a3mr8815843edy.13.1688223688847;
        Sat, 01 Jul 2023 08:01:28 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c98d000000b0051dd4daf13fsm3253587edt.30.2023.07.01.08.01.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 08:01:28 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51dd0205b2cso5057066a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 08:01:28 -0700 (PDT)
X-Received: by 2002:aa7:d047:0:b0:51b:f862:7b6a with SMTP id
 n7-20020aa7d047000000b0051bf8627b6amr9564270edo.14.1688223687666; Sat, 01 Jul
 2023 08:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
 <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net> <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
 <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net> <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
 <CAMo8BfJ+FcR8ZfNk8GNL5pRsJO13O=on8ewRHSJkuQ85_WPk0A@mail.gmail.com>
In-Reply-To: <CAMo8BfJ+FcR8ZfNk8GNL5pRsJO13O=on8ewRHSJkuQ85_WPk0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Jul 2023 08:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy=8CEGoGJnHkuz4p0pR+Q-5RvsM4VNyYeWabshYr5yQ@mail.gmail.com>
Message-ID: <CAHk-=wgy=8CEGoGJnHkuz4p0pR+Q-5RvsM4VNyYeWabshYr5yQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Chris Zankel <chris@zankel.net>,
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

On Sat, 1 Jul 2023 at 03:32, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Thanks for the build fix. Unfortunately despite being obviously correct
> it doesn't release the mm lock in case VMA is not found, so it results
> in a runtime hang. I've posted a fix for that.

Heh. I woke up this morning to that feeling of "Duh!" about this, and
find you already had fixed it. Patch applied.

            Linus
