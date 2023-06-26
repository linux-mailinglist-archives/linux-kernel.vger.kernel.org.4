Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E073EB31
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjFZT0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjFZT0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:26:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E606E74
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:26:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b698937f85so33838891fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687807578; x=1690399578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdhf6AU7xFfNbH+mJiJHsGXbFeFQT625rjZDqqOdH3o=;
        b=bgQhc/tr2dOe24OxURwIssbTAW8cinuImIIs4wxHR6Rc7m0aBRrPdrUU7Jb0PV14Of
         H5LAfIJNZdoqSOzMGajcsDrKQNrrYBZEH8wGxi1sH3WiSkjNlD0/vZHRKhZOB6MLINN3
         HiKYxu/V+NkQQNGeIellk1sTw1t4NZp/8z2MRdlaOlzQZDAhYuxh9EnitqS0eQ0dTRuG
         pbhNH+1jx3H+tdIX8yhkaYetXbqO+GiOAHbpYGmdXkTIacwcyRW3D8hzwpxAf8bPsi+Z
         OOk9/xOz7ut8bYdvDV8GohEmgVSYbepXzPgadEf37nFtZ+5LrxZavKr+e1X30LyhQlAl
         hY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687807578; x=1690399578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdhf6AU7xFfNbH+mJiJHsGXbFeFQT625rjZDqqOdH3o=;
        b=BD5j/PQl/74tmFTtwOFm1SnywNwUnCPRHwcWr7ZYd+ZSb8W4B1vrjTRARN9OIIJsrv
         tkxxFnjNxrp1tEi/HXRObhsov+WXO+WxUa6QAT39v/Ud/T7Wf+LZ39t8V/juW74snTMP
         tXgxRwaSr2IMOdff7rC24QIDgjImw+YnQvjZ8ThIbOwoC93OJszUQmc5WICO7lnNlQNZ
         ZH7JOUiq0/1iN+bE+6FjvlMITfnCsZpSN9+lJ63Wf14etOB6LZy5No9ZxRiGwvsCKopX
         AjcByaLUQL+EGvxmTpPyKsUYgIKUPOgGR5t1IDBlBuhEuGFX6ACL1ZnB8tXsdoghiuyG
         Y7mA==
X-Gm-Message-State: AC+VfDxbiM6ZoYKpVksEEjRcxDKescuZ8GeyrSzRV61cMGAMIeOgp+aY
        5hogDgGPe2qumT0iJXZVLhpLYGxSIMcdVTf7m9aksg==
X-Google-Smtp-Source: ACHHUZ4k70aHHQYBZk12ajsNjQus+hTZHIiTLLotn416SbSKOwhRtCLRw3mxXJt91UCR61iwRgGJbhf+2GPBiHpZSUw=
X-Received: by 2002:a05:6512:280b:b0:4fb:2c1e:4e03 with SMTP id
 cf11-20020a056512280b00b004fb2c1e4e03mr3277813lfb.32.1687807578527; Mon, 26
 Jun 2023 12:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230623222353.3742384-1-evan@rivosinc.com> <20230624-mortally-parking-68f6bc1dd5ee@spud>
In-Reply-To: <20230624-mortally-parking-68f6bc1dd5ee@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 26 Jun 2023 12:25:42 -0700
Message-ID: <CALs-HstvXcwBa+h0u4mz_Pjm-bNd=9DX49Xy-=Fq0t3ECmAi2w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 5:12=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Evan,
>
> On Fri, Jun 23, 2023 at 03:23:53PM -0700, Evan Green wrote:
> > In /proc/cpuinfo, most of the information we show for each processor is
> > specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> > compatible, and the mmu size. But the ISA string gets filtered through =
a
> > lowest common denominator mask, so that if one CPU is missing an ISA
> > extension, no CPUs will show it.
> >
> > Now that we track the ISA extensions for each hart, let's report ISA
> > extension info accurately per-hart in /proc/cpuinfo.
>
> No, you can't do this as it breaks the assumptions of userspace that
> this shows the set supported across all harts.
> Sorry, but NAK.

My hope was that we were still early enough that no production systems
existed (yet) that actually had different ISA extensions in the set we
track, and therefore usermode would have been unable to make those
assumptions at this point. If such a system exists, and I don't know
if it does or not, then I agree it's too late to make a change like
this.

I thought I'd put this out here and see if someone could point at such
a system; but if not it'd be great to keep /proc/cpuinfo accurate and
consistent with hwprobe (which does return accurate per-hart ISA
extension info).

-Evan

>
> Cheers,
> Conor.
