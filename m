Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A395E688146
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjBBPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjBBPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:08:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1023A38035
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:08:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a2so1711913wrd.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYJ2N8WEHs5GTVFeSbPZHq4ulIlep5wwgIPvf0xRpx0=;
        b=emNEyF3xnXXJeUYNxx4wyhSDQsXeD7Sk7CkJ2QxZyKKtgxNaMEHAGYJOT2KelT2+gr
         vV2FkylDdDdrf5043yzEiNHi4T5MRroRPEo1cTUPo1JEoqm9O40uVrrrJW5hgje1VXQ6
         0/c5nriNGy/cjH/hC1wtc5l0CjVTLad2xhYhrvygdv55HP0eblbie7V7tfL38JDdLzqU
         fyMpG8LsIlthgQcsQ1hPgsgOPHoMR1qqAxdJrVRK5sValp3HgypcwDXSvkrqQL+V7UGh
         QjoBYblpYxqTzZsD+mv2a8u2R9Fxs/1wEqcEphvu0v4m6tzYCYdKEWuzCAxMIonwB9kp
         AM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYJ2N8WEHs5GTVFeSbPZHq4ulIlep5wwgIPvf0xRpx0=;
        b=l2ei1B6Js3tRUBqLfyApyp0x8+hanuH/UCQorBqOH+Q+DFAeL8Kiu8jVOa3efxzeeX
         sOFjELbllSmgW1ZPfeEVOsdTk7qJPU4+vVfDq8e0yuOyMT1PaUa9RFLcFZp9CvAq/Mdc
         3d/JSxf/IjmpC80PBaP8NLLHMm5GueGvEbObY+7EFKGVpKwW4j86z8/sUtDF7YIpIOuW
         QXu4aULhlGBWBkQu49RzUT+Kc5IKaLaSzD6NK6TWyUfeYVpvgg3S689TFij6UbpIpMV0
         xiAC9sAenyhfzGXGFxnUSwB45KKLMWf1IptR2CfOniW89vDW+8z4yc5xYRz+Vq13osrj
         Kx6A==
X-Gm-Message-State: AO0yUKWem1uFRFtWQfK5thbGOeUwfKlbKeiCcxGpcDOSaxjUYGACHAsx
        ysv8/Smqd7sytbXZVP95i+Qwmi/LQ12QdqfDjE1Wdw==
X-Google-Smtp-Source: AK7set+XEkvriksqDV6S8qdBAREdpP7cT4xADg8EhSkS/3ETeDAmV4wBFCCd91Ps9riFQGmny878Fyz+jPXTTIINCVc=
X-Received: by 2002:adf:ffcb:0:b0:2bf:e95c:9918 with SMTP id
 x11-20020adfffcb000000b002bfe95c9918mr219059wrs.330.1675350482003; Thu, 02
 Feb 2023 07:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20230131151115.1972740-1-alexghiti@rivosinc.com> <Y9lrB+RUBk1Njhaq@spud>
In-Reply-To: <Y9lrB+RUBk1Njhaq@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 2 Feb 2023 16:07:50 +0100
Message-ID: <CAHVXubh+DgdgXZ-hHk5rxmQkXSBdk1AvTr3dvT80L5YXQZF=sw@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] riscv: Allow to downgrade paging mode from the
 command line
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Tue, Jan 31, 2023 at 8:25 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Alex,
>
> On Tue, Jan 31, 2023 at 04:11:14PM +0100, Alexandre Ghiti wrote:
> > This new version gets rid of the limitation that prevented KASAN kernels
> > to use the newly introduced parameters.
>
> What's the base commit for this version?
> Fails to apply for me on top of for-next, fixes, rc1, and linux-next :/
> I also tried it on top of your KASAN series, but no luck there either!

Really sorry about that, that's the second time it happens, I'll
improve my workflow: I'll include the base-commit sha1/tag + a link to
all needed-but-not-yet-upstreamed patches.

Thanks for your time,

Alex

>
> Thanks,
> Conor.
>
> > While looking into KASLR, I fell onto commit aacd149b6238 ("arm64: head:
> > avoid relocating the kernel twice for KASLR"): it allows to use the fdt
> > functions very early in the boot process with KASAN enabled by simply
> > compiling a new version of those functions without instrumentation.
> >
> > I had to change the handling of the command line parsing to make the
> > code self-contained in kernel/pi/cmd_early.c to avoid calling too many
> > __pi prefixed functions from outside this file.
> >
> > I'll use this approach like arm64 to handle the extraction of the random
> > seedi from the device tree for KASLR.
> >
> > @Ard: I copied the "pi" name but I have to admit I don't know what it
> > means.
> >
> > Alexandre Ghiti (1):
> >   riscv: Allow to downgrade paging mode from the command line
> >
> >  .../admin-guide/kernel-parameters.txt         |  5 +-
> >  arch/riscv/kernel/Makefile                    |  2 +
> >  arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++++
> >  arch/riscv/kernel/pi/cmdline_early.c          | 52 +++++++++++++++++++
> >  arch/riscv/lib/memcpy.S                       |  2 +
> >  arch/riscv/lib/memmove.S                      |  2 +
> >  arch/riscv/mm/init.c                          | 36 ++++++++++---
> >  7 files changed, 126 insertions(+), 7 deletions(-)
> >  create mode 100644 arch/riscv/kernel/pi/Makefile
> >  create mode 100644 arch/riscv/kernel/pi/cmdline_early.c
> >
> > --
> > 2.37.2
> >
