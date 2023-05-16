Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B90704973
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjEPJiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjEPJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:38:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397011A4;
        Tue, 16 May 2023 02:38:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24e09b4153eso9537471a91.2;
        Tue, 16 May 2023 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684229884; x=1686821884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcPyZ54ldUCQts1fa3VDXSS+xl2KucQtdFVpSxiwBxc=;
        b=DU5/VIrFG7reTAO9QxhhODhV5q6nQbRuCcFF7dZS+vo49dM051KgUyLTkEGAY17YhA
         NUGNaHs5g+z1g2S5tlreNpi9npqPyctgfVcd0xndJqnSK+rH/C5pdo8KDhhlMEDrJrMb
         8jM9ZfbDgCjNowGUfj9bHMn/XwXc0dcDMrCJIj699zNypRCUhm6quAIUot8k8IuBoiS7
         Khkjv4D+39G03t+FtvLUJzQm0f3FhID83B+2w8QYJTJh2exa6+XX6eJeeY2ZQaJNciXI
         eawJngTYScPCmzGUv2+sDdBg+EIu8iAnjOO9eIj30DgNFWMJdg3yYUZdsJ5imJGfrseA
         DJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684229884; x=1686821884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcPyZ54ldUCQts1fa3VDXSS+xl2KucQtdFVpSxiwBxc=;
        b=bQpgLLlKJPbeoaaj1mY0QnaQQsiZprBuE8mbbdVr0rJXUaewb9EIAUrjsw0+oFOKIN
         wdg+8+AZ+3I2OHtIRJeCqpkqmDLdCEQ46yh4xagbIjEpA9pUSKp6xbT0sBsO2mCXoh6Y
         8MCeASd/uCzXT3Dy48NK82pqdc64hlwNdU4rwFrtkCXY2ex3hysS/Vd+cfVaD5v2NvVR
         jYE64av8noKBc2kRaKR8Sx85V/743wnhH4ZT1swQpw/zRiwX+XgjNjkxiXyjeAFuRpTl
         lqfYRRG4OkOlwIiRlX5I5oPNQCn6frsDD2qaLHj7WU28SRxdXDzq/MWxBU4WgIKk2pSh
         xRdA==
X-Gm-Message-State: AC+VfDzUsyufdbIJHZqq5SStjBcHSjjfQwyseiXAg9fAUw3X4lcRftlW
        hxVBD9/9hKNcvvZSCz3DxtVUFclfmZw0X+yeJRU=
X-Google-Smtp-Source: ACHHUZ66lklqalTjUc1ffo3yWrc+bRrfEml1qJYxgf/ydcHrvZSuxhSIWWtNK8ldHQ96S4/rnUtpu1XgkdQdHu4Km8Y=
X-Received: by 2002:a17:90a:fe05:b0:250:9d75:abe7 with SMTP id
 ck5-20020a17090afe0500b002509d75abe7mr26052714pjb.47.1684229884532; Tue, 16
 May 2023 02:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230511093234.3123181-1-suagrfillet@gmail.com>
 <20230511093234.3123181-5-suagrfillet@gmail.com> <20230515143700.26beeacf@gandalf.local.home>
In-Reply-To: <20230515143700.26beeacf@gandalf.local.home>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 16 May 2023 09:37:53 +0000
Message-ID: <CAAYs2=hd1geHCTGrO=JohTYtgu+yj+D7EPono-ADOGfjYnLfrA@mail.gmail.com>
Subject: Re: [PATCH V10 4/4] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, mark.rutland@arm.com,
        guoren@kernel.org, jszhang@kernel.org, e.shatokhin@yadro.com,
        bjorn@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=80 18:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 11 May 2023 17:32:34 +0800
> Song Shuai <suagrfillet@gmail.com> wrote:
>
> > select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> > for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
> > the ftrace-direct*.c files in samples/ftrace/.
> >
> > Link: https://lore.kernel.org/linux-riscv/c68bac83-5c88-80b1-bac9-e1fd4=
ea8f07e@yadro.com/T/#ma13012560331c66b051b580b3ab4a04ba44455ec
> > Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > Tested-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                          |  2 ++
> >  samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
> >  samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++
> >  samples/ftrace/ftrace-direct-multi.c        | 24 +++++++++++++
> >  samples/ftrace/ftrace-direct-too.c          | 27 ++++++++++++++
> >  samples/ftrace/ftrace-direct.c              | 23 ++++++++++++
> >  6 files changed, 150 insertions(+)
>
> I acked v8 (which you will need my ack to get these in). Unless this patc=
h
> changed since v8, you should include my ack in further versions.
>
There were no changes in this patch, except for a few tab pretties since v8=
.
your Acked-by will still be included.
> Or you may be waiting longer for its acceptance.
>
> If the patch did change, please acknowledge that in the next version (or
> this one if it did change), asking me to ack it again.
>
> -- Steve



--=20
Thanks,
Song
