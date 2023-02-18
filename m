Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70869B68E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBRABr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBRABp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:01:45 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816505B2F2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:01:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h14so10541740edz.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeFzD8Gkwqt455RHoaOjOeMVzGIa8tNFoTFyyh8rWfA=;
        b=DTLkbmMA0cgX2XdVwgWeFtYboPCmbmsu3OmV2hYxhtBey37Zw8IazxIWpdaU7QbbYw
         iPq02wcf7WM4zCfY+IOjawp7SGzeGrC3pntam9ruJr77Ms2bCOi5tSsAHUBTV3F0j1qo
         cuhq9js6hot4G/fhkPuGvP9UzNnctSMOfqk1weL53muzvUYsQUHP4i354324DG5P/G1v
         PBgShuSYoHziZElUvFxS79KKjvrX0QWQETuVEydpbyBGQHici9wCX2eAA0kjMMLk/Hon
         LG4E+iQMUsG720nnC3VX42qbIXxvXMiQG5LMXSJxDGy1KbUxeukRxkutyjQ5MavwDUBC
         B3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeFzD8Gkwqt455RHoaOjOeMVzGIa8tNFoTFyyh8rWfA=;
        b=foC91PREdKKi6bhy2bWw6kDr4pSevKjbqZ3dvoLxM8mzi13AMwZpY4kDmg9k3TLkhX
         cuPUlbTuhsTQ5aVhfxGlfwZMkvPMQ/Tpp7QzTz+zym4wqJlAtPKIBavIkySefTEP5NnD
         a7IKL6eIVtnGpyHAvzfLA9OmHcX+B9y7u4pp1MmFPUq9QcQxmLbH1Nt1S6zFcIzVwWav
         X0cUs1yyFXhsU0yClhSrZAP54wUm/yTnS8GiIz+Km8F45whyhwooGzEKowZwzFYxEdrb
         nRO+iwKS4p+ba0b592gK27k+iZc6DzwCFPBVpmf/Lo4V86gmzsvnWBIfj7j8J+HDb+DL
         YmcQ==
X-Gm-Message-State: AO0yUKV5u/iZVAw1YpBUT7Y218Q/hkt80QLSTD21FhcPi/OGVjyYOZ6L
        zW/ZLVQutC6G1I+jh68l08NbFw==
X-Google-Smtp-Source: AK7set+PnUEMbHgiFF7Ajte2EzfnX9RBJ03L+e2pHxDLhXcC9Ah0gDHHiCNHzU871r7s2xrlwYNnLQ==
X-Received: by 2002:a17:906:16c5:b0:870:94e:13f9 with SMTP id t5-20020a17090616c500b00870094e13f9mr1774545ejd.0.1676678501986;
        Fri, 17 Feb 2023 16:01:41 -0800 (PST)
Received: from smtpclient.apple (ip5f58e70e.dynamic.kabel-deutschland.de. [95.88.231.14])
        by smtp.gmail.com with ESMTPSA id f8-20020a1709067f8800b008af2a7438acsm2680535ejr.188.2023.02.17.16.01.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2023 16:01:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <CAGETcx_OKA+MkExc98337kZYKsoJtV0ZdfYJE7Tk00CFvCt2bA@mail.gmail.com>
Date:   Sat, 18 Feb 2023 01:01:30 +0100
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, m.reichl@fivetechno.de,
        robin.murphy@arm.com, vincent.legoll@gmail.com, wens@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6AC6A52-49BA-4F80-91A8-271E11CD17E4@kohlschutter.com>
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
 <20220825212842.7176-1-christian@kohlschutter.com>
 <CAGETcx__Ez8i9O2O30-Q1R00xOqBjkKMCwt37_AGAQjNvZqpdg@mail.gmail.com>
 <B6E001E2-9BCD-420A-B0F6-1495DE46955E@kohlschutter.com>
 <CAGETcx_OKA+MkExc98337kZYKsoJtV0ZdfYJE7Tk00CFvCt2bA@mail.gmail.com>
To:     Saravana Kannan <saravanak@google.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. Feb 2023, at 00:46, Saravana Kannan <saravanak@google.com> wrote:
>=20
> On Fri, Feb 17, 2023 at 3:33 PM Christian Kohlsch=C3=BCtter
> <christian@kohlschutter.com> wrote:
>>=20
>> On 18. Feb 2023, at 00:22, Saravana Kannan <saravanak@google.com> =
wrote:
>>>=20
>>> On Thu, Aug 25, 2022 at 2:28 PM Christian Kohlsch=C3=BCtter
>>> <christian@kohlschutter.com> wrote:
>>>>=20
>>>> Previously, an unresolved regulator supply reference upon calling
>>>> regulator_register on an always-on or boot-on regulator caused
>>>> set_machine_constraints to be called twice.
>>>>=20
>>>> This in turn may initialize the regulator twice, leading to voltage
>>>> glitches that are timing-dependent. A simple, unrelated =
configuration
>>>> change may be enough to hide this problem, only to be surfaced by
>>>> chance.
>>>=20
>>> In your case, can you elaborate which part of the constraints/init
>>> twice caused the issue?
>>>=20
>>> I'm trying to simplify some of the supply resolving code and I'm
>>> trying to not break your use case.
>>>=20
>>> -Saravana
>>=20
>> Here's a write-up of my use case, and how we got to the solution:
>> =
https://kohlschuetter.github.io/blog/posts/2022/10/28/linux-nanopi-r4s/
>=20
> I did read the write up before I sent my request. I'm asking for
> specifics on which functions in the set_machine_constraints() was
> causing the issue. And it's also a bit unclear to me if the issue was
> with having stuff called twice on the alway-on regulator or the
> supply.
>=20
> -Saravana

I'm afraid I cannot give a more detailed answer than what's in the write =
up and the previous discussion on this mailing list; I thought it's =
pretty detailed already.

However, it should be relatively straightforward to reproduce the issue.

