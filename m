Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED92712750
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbjEZNOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbjEZNOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:14:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CBF1A8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:14:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so654884f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685106884; x=1687698884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkVaao4LtBpB5P1B3tLZxzGuMjJCrzkDcbHFtv+t/BA=;
        b=CQa5TosoK4BroftU06tqqI4ZdsZA7t32w5o96Hdfl1FoC4INZY5MA/7zJY6nYZPPTI
         G8RE9Pf67umWPGDtgcOkTHjoP4M1IhEOZQ+ddOG401n52y3MuxTjYzE/HYSpzCSs4nT7
         bu5V3EmE68JCrwpU53oNgRRM9RfdJ0TWmcJvMfSJpxqNlHWzmFo+K6pKvCPQdRWhxNWF
         7fZYWRY9NIuS5epHVwkW5KHkWZR0LrP0qxrmfYTmeaLpO7+qGcnN/DMTc6c11dSNHyQy
         aWmQmvmWs9HO91fiE4GxsjEI9xUuC90mhUpFGXYBq13LHdJqEuQCK0saZqvnj/RnsP0t
         VcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685106884; x=1687698884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkVaao4LtBpB5P1B3tLZxzGuMjJCrzkDcbHFtv+t/BA=;
        b=SIjeJIYVpBc2evq7vh/b+UHLA9qZsf+PIvVa+H8HFJsj8xNe61SkfSp0FD3bR1gNj9
         rB9o5C3nQcrJbP+o4uO3BQ4JUWW6wNkFuw4nNYwVX08KBvmKQKFpJW9X2/Y7un9YDPMj
         ZCftl1y4Y7ZbXJSEhHyOPBifM/oFYkbCupvUM7UROselEdoV5WEN8eNB+kLq9s/MKCZM
         EgLMpmxLeWMsECQ9ftUwKyJB81SlZ2GRGjBBl9Dbhe/GqQgjr/60pmRnLDHEJisFiXpi
         92TBvJ8Wc3mZtXq+JDu+LgU3jNtwJWj4g3eaSOQFQVhUrUwEAkgKpzQ2pPyJ+7AgS0IB
         /W/g==
X-Gm-Message-State: AC+VfDxZVAgOG8PpM4H/vbiWVb8iSV7fK4F80DTtX3o8EExLeIvEHHNY
        ghxzX91BqhVQgBddiFpfaDADgROxzbUd59Q43Ox5aA==
X-Google-Smtp-Source: ACHHUZ5kH6a3H4k9W9oC92DeCoFNiRyfbYNBHeqWE1xm1hc049FvWVz5H3EgoHgOPAC0o+XiVl6YQZsxliJ99poFoDM=
X-Received: by 2002:a5d:5750:0:b0:307:8800:bbdb with SMTP id
 q16-20020a5d5750000000b003078800bbdbmr1211243wrw.58.1685106884257; Fri, 26
 May 2023 06:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
 <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy> <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy> <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud> <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
 <20230525-desecrate-imposing-d97ab34e06ad@spud> <CAOnJCUKfRv68Bh8ue=ZhMGxai9_UEHLpm3553g2c2NXh-RP-TQ@mail.gmail.com>
 <20230525-batting-botch-7e03393a2d97@spud>
In-Reply-To: <20230525-batting-botch-7e03393a2d97@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 26 May 2023 15:14:33 +0200
Message-ID: <CAHVXubiDezbwZO6X2btvgpq-XqHnxZjXzaMnSK2YrHc_ioLx8Q@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On Thu, May 25, 2023 at 11:24=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, May 25, 2023 at 01:06:04PM -0700, Atish Patra wrote:
> > On Thu, May 25, 2023 at 11:39=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Thu, May 25, 2023 at 11:37:40AM -0700, Atish Patra wrote:
> > >
> > > > Any testing of hibernation still needs to revert the patch until we
> > > > have the proper fix.
> > >
> > > "the patch" is what exactly? I assume you don't mean depending on
> > > NONPORTABLE, since that is a Kconfig option.
> >
> > Nope. Sorry I meant the commit
> >
> > 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
>
> Ah, if your SBI implementation is one of the affected ones, yeah.
> If not, you can just set NONPORTABLE :)

@Bj=C3=B6rn T=C3=B6pel emitted the idea of excluding from the hibernation a=
ll
the memory nodes in the "/reserved-memory" node
(https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/devicetree/=
bindings/reserved-memory/reserved-memory.yaml):
I have to admit that I don't see why it is not done by default by the
kernel.

Unless there is stuff in this node that needs to be "hibernated", I
think that would be a very good solution since we would not rely on
the name of the "internal" nodes of "/reserved-memory" (i.e.
"mmode_resv").

I'm digging into why it is not done by default, just wanted to have
your feedback before the week-end :)
