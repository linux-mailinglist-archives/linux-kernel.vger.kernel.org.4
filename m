Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071CD74487F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGAKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGAKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:32:39 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971F63C18;
        Sat,  1 Jul 2023 03:32:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b03ec2015fso2473974fac.3;
        Sat, 01 Jul 2023 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688207556; x=1690799556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcWDmFedEmlvfM/QLPpiDImU6EfFXswotA0Bd0Mv+MU=;
        b=pN/GaXWU0xGEGqbcGBsu7u8YBk6BuzF57rO6R1o3JJ3Ki8T8d+dTfCzzyJXFF619gg
         utm12XXsQsJNv2RefA+A99ifJ83+HcNxRyGPxMr0Bg4ZNwj3BBo4/HhfBtV3Fqzgp+1y
         TAsxkHcQ1qNFQLsPlIUNWfXDBg1EaYVUSeNCaeDXeSGuTTyv4obtlLOWC0ECET4BS4ST
         WzlsgkEw+og7F4qrbzSN8Dc7owrXS/qifb454ZKBcLnL6nJdtZ26O4wmO2gfGiRWWvyb
         RBK77i1UV1zaXixJgkgspveLtbM7iRVZ+Svnwf/XqFLdqUPDpIcpl/BPwfeDE5zIqBtQ
         Mlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688207556; x=1690799556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcWDmFedEmlvfM/QLPpiDImU6EfFXswotA0Bd0Mv+MU=;
        b=PLx9VZv2dyR4XFNyTjqkerxIBZDsxmGRM6gRSPDhX+U1HJYJD+i9VxfaxnLOdZaATx
         x8OuNpuFXIzcOap40+AHMaobrNho5hZIDJXiCVvjqTcWazVEkERm2xIh+Hk8hb5sL09W
         d+lPxACQElfOhhi8V4T6SuATLznV8pDbogK394bphroy4MwAo0mupURnp0PTy72DzUup
         Z+wPs1bFSrONgwTLiY7lsMA+wwuF2TYiyeR+aKOj47tVqNKZQwRniAjOia8FVUeiCwBW
         6+cKKLkpG/tnmtDy58h0oXidp3fP/jmCv4+gO2jX7qF8HjlW3O5zRShTUoflC6YgSzrN
         7B5g==
X-Gm-Message-State: ABy/qLb6SWlQ0dxuYpcE7VENGS/zC0figwYQwMl+ePClLR7UKqIoKb2Q
        3IGuVoTcU2nKiSBkFEccj7n3eM/CC7pQH36wwfw=
X-Google-Smtp-Source: APBJJlHnL7gWIGSB1c+m38g/UnfxLbMWby09tpjJJgfdnvfSi3WcKwqDa93+oabEZXQ83fTXdkputC2ZldZ+TTHeSOs=
X-Received: by 2002:a05:6870:bac3:b0:1b0:146e:75d6 with SMTP id
 js3-20020a056870bac300b001b0146e75d6mr5756259oab.51.1688207555856; Sat, 01
 Jul 2023 03:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
 <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net> <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
 <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net> <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
In-Reply-To: <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 1 Jul 2023 03:32:24 -0700
Message-ID: <CAMo8BfJ+FcR8ZfNk8GNL5pRsJO13O=on8ewRHSJkuQ85_WPk0A@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Jun 30, 2023 at 9:23=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 30 Jun 2023 at 19:50, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Yes, the patch below fixes the problem.
> >
> > Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... running ...=
...... passed
>
> Thanks. Committed as
>
>   d85a143b69ab ("xtensa: fix NOMMU build with lock_mm_and_find_vma()
> conversion")
>
> and pushed out.

Thanks for the build fix. Unfortunately despite being obviously correct
it doesn't release the mm lock in case VMA is not found, so it results
in a runtime hang. I've posted a fix for that.

--=20
Thanks.
-- Max
