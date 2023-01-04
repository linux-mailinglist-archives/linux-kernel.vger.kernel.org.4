Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7265D4EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjADOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbjADOFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:05:04 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0F0B0C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:05:02 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id k4so30818359vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbYqEYMuK4QQdOqZ2O5qfwO8lqdYM3p9ldHBfSASKhU=;
        b=an3SkIec6n/usy8qQfvGM+/vshmxGPQdaG3L7Cb0q+0wEUv4qG7txU/8PMXwd9/p7P
         iKenT/Kb4jYLH7i2XPhN3/Q5iZ0aVZ62ai/3bKPZhQrBDVAiSMHI+zXjZTNBYIjMmOrH
         b8xq9/LS4wuTf4ZyNZXrIeOh1GfLzZrQqOALnYTsIqveInzXRXd0jGXm0lN7jk/be+8t
         63xMhntFWce9EnN0aajrD3eRhhFiP1oE5g9vePdyLzMaiGP9icV4USSi9MI+dCc1DsPd
         R7QZxppptA/HyZ9PDQSBThLGDhkv0kpn+Wk9zzTwzfF19Hi0cG/cJ7JXiW5dyLFIiwQc
         YK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbYqEYMuK4QQdOqZ2O5qfwO8lqdYM3p9ldHBfSASKhU=;
        b=yfH4A5PFWVnqShUUBWDfI5f4Bts9kZ14yVfMOF9vZJFVT8v/yHcO1+YV1h1Wjqhqat
         fQrZ8TEZZIM8MBh+LjOwmSLbi0cqXkm0TZhNpBBNCAMjjPBpv3OCapFxSgsZFdlOnLa5
         FdQbH8LNiP1ASRJ8Tmxl79XwjBao36m66zK1cY6USBXLXOO1Flg57E5YcoSw4sx+qyNU
         JlTB6dx3WTQRoXTutBlQAgChAz8Tl8eQHOLXwz4QWTB3509IdUUhYlLSXgsZCshSt1gJ
         Ebh4/K9I3ArkeLJ0RbXDczWIJxzAmY184zFSDdymthr9nf/X5iQ5qAmf9kSzWfvKYW9r
         xw6w==
X-Gm-Message-State: AFqh2kpoHXQXvwh0dgD0Ge13nU+9FPtf+0tIFisP5XQFvvaOI2tUi8DA
        q64p+CYgXwKf7/E8hpGqksc2p4OA0eIaTrVbP0zQCA==
X-Google-Smtp-Source: AMrXdXtM8lyaKq6Vjld3wibhq6Rsi6BKDrfwzZTLeVJU64asXWBb5lJt0ZvPvWi0bZs2234bpkxCZyga/AHBhU3l+RI=
X-Received: by 2002:a05:6102:302d:b0:3ce:a2e1:b574 with SMTP id
 v13-20020a056102302d00b003cea2e1b574mr694108vsa.55.1672841101340; Wed, 04 Jan
 2023 06:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20230103141102.772228-1-apatel@ventanamicro.com> <9a98300c-e845-60d6-bdf1-12010eae2075@linaro.org>
In-Reply-To: <9a98300c-e845-60d6-bdf1-12010eae2075@linaro.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 4 Jan 2023 19:34:49 +0530
Message-ID: <CAK9=C2WkiE7W3yU7NoUn_neS8yW1Hs1ErNA+FXsad164QgtndQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Improve CLOCK_EVT_FEAT_C3STOP feature setting
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 6:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
>
> Hi Anup,
>
> shall I pick the entire series or just the bindings and the driver change=
s ?

Yes, that would be great. Palmer has already ACKed this series.

Thanks,
Anup

>
>
> On 03/01/2023 15:10, Anup Patel wrote:
> > This series improves the RISC-V timer driver to set CLOCK_EVT_FEAT_C3ST=
OP
> > feature based on RISC-V platform capabilities.
> >
> > These patches can also be found in riscv_timer_dt_imp_v6 branch at:
> > https://github.com/avpatel/linux.git
> >
> > Changes since v5:
> >   - Rebased on Linux-6.2-rc2
> >
> > Changes since v4:
> >   - Update commit text of PATCH1 based on Samuel's comments
> >   - Renamed DT property "riscv,timer-can-wake-cpu" to
> >     "riscv,timer-cannot-wake-cpu" in PATCH2 and PATCH3
> >   - Updated description of DT property "riscv,timer-cannot-wake-cpu"
> >     in PATCH2
> >
> > Changes since v3:
> >   - Rebased on Linux-6.1-rc7
> >   - Replaced PATCH1 with a patch to initialize broadcast timer
> >
> > Changes since v2:
> >   - Include Conor's revert patch as the first patch and rebased other p=
atches
> >   - Update PATCH2 to document bindings for separate RISC-V timer DT nod=
e
> >   - Update PATCH3 based on RISC-V timer DT node bindings
> >
> > Changes since v1:
> >   - Rebased on Linux-5.19-rc8
> >   - Renamed "riscv,always-on" DT property to "riscv,timer-can-wake-cpu"
> >
> > Anup Patel (2):
> >    dt-bindings: timer: Add bindings for the RISC-V timer device
> >    clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT
> >
> > Conor Dooley (1):
> >    RISC-V: time: initialize hrtimer based broadcast clock event device
> >
> >   .../bindings/timer/riscv,timer.yaml           | 52 ++++++++++++++++++=
+
> >   arch/riscv/kernel/time.c                      |  3 ++
> >   drivers/clocksource/timer-riscv.c             | 10 ++++
> >   3 files changed, 65 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/timer/riscv,time=
r.yaml
> >
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
