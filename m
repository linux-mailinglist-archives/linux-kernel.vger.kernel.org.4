Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E9F6A5926
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjB1Mfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjB1Mfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:35:46 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D82ED55
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:35:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d6so5539340pgu.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhWe8sLMccBLRrPsWcYHRaaybNDxZ0zi1CaL4lrAFvc=;
        b=iJtweGpDdSTqN2kXZgyLyRHBqBC9GUkRRoy6rynxSdBwc/xi7Vbq/3f2N94C5mLujq
         w9EG2wiCllviId6GNDlLkbXFwd3mXYXseKL95wKTB6KmEQRjBHJCGbOqKmbCti3DI+ge
         /jjBYZdSq+2BssKiI8DTPI5TE4zup3ctckwnYAZoqcHmwlnU/lF34WLBlpPh5DbmZW1x
         OnYjrkr1l05OXbW3P7CY1B6CopBD27raod6Z7rbWXHCofjgDskhx3QBlMTRKsjTh8d0+
         GZZSBSrne7Q72pybnSMNmSC0ZLCujlURHmZoqWO/H6Tviay4BkJWod6ZfRaG33ptLhER
         A9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhWe8sLMccBLRrPsWcYHRaaybNDxZ0zi1CaL4lrAFvc=;
        b=yYdIs8mNqZQ+iSvpRIJMwsxwaf/dMA/eO7G6loEzhfdbd29utgBaNfo40OmCdsYon3
         gN2ehkAfntvcMYxL48SiUVo8uXPDRNCey5rWgmqLnK+g38SRlJ254L0YCP64KoMLsPAZ
         wVSu6l8rUzog1AGUAZ75u7yRKoex6MMmgsA7lqN+1vBtYk4cRL27yabEC11PRa1SMFD0
         gqvlPnMg0A2AF/qWXqsDgak3FNQ4QB81r2jiAfcP7XAjwpNubo/MtU5iEbIZB0MVgIpa
         Z0gIL2yzY2/dFyiDV+y8fqQ5GVKbHImaT0eVMszlj3bLcIlm38ZI5A3eNXYZPPj0lbyY
         OhYA==
X-Gm-Message-State: AO0yUKVGd+MxRLzwnRmtXSbOAv4zh9QtJQyBlb8xtJas90zXVLgQ4YKR
        9JMhhCJA41NSd+8bPj45+aEmAXHiFjW0TMQ5DmkyNuORFi+nCScRs3o=
X-Google-Smtp-Source: AK7set982toa957BfsESaT9p96TlyfxqaTB6xdGDJ93u6JOrGrfrsLteEwl7OmrMxFUw0AK+STVOgMbUnjwZ3PQRWHE=
X-Received: by 2002:a63:7807:0:b0:502:f4c6:b96 with SMTP id
 t7-20020a637807000000b00502f4c60b96mr701622pgc.5.1677587743821; Tue, 28 Feb
 2023 04:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20230228113305.83751-1-jiaxun.yang@flygoat.com> <20230228113305.83751-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20230228113305.83751-2-jiaxun.yang@flygoat.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Tue, 28 Feb 2023 13:35:32 +0100
Message-ID: <CAM1=_QTwYqAH+21fNnG3aBW-cV8vxtgM7h=enqZYaj2wbRnV8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: ebpf jit: Implement DADDI workarounds
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, paulburton@kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

On Tue, Feb 28, 2023 at 12:33=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
>
> For DADDI errata we just workaround by disable immediate operation
> for BPF_ADD / BPF_SUB to avoid generation of DADDIU.
>
> All other use cases in JIT won't cause overflow thus they are all safe.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop 64BIT ifdef
> ---
>  arch/mips/Kconfig            | 1 -
>  arch/mips/net/bpf_jit_comp.c | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 37072e15b263..df0910e3895c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -64,7 +64,6 @@ config MIPS
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_DYNAMIC_FTRACE
>         select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
> -                               !CPU_DADDI_WORKAROUNDS && \
>                                 !CPU_R4000_WORKAROUNDS && \
>                                 !CPU_R4400_WORKAROUNDS
>         select HAVE_EXIT_THREAD
> diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
> index b17130d510d4..a40d926b6513 100644
> --- a/arch/mips/net/bpf_jit_comp.c
> +++ b/arch/mips/net/bpf_jit_comp.c
> @@ -218,9 +218,13 @@ bool valid_alu_i(u8 op, s32 imm)
>                 /* All legal eBPF values are valid */
>                 return true;
>         case BPF_ADD:
> +               if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
> +                       return false;
>                 /* imm must be 16 bits */
>                 return imm >=3D -0x8000 && imm <=3D 0x7fff;
>         case BPF_SUB:
> +               if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
> +                       return false;
>                 /* -imm must be 16 bits */
>                 return imm >=3D -0x7fff && imm <=3D 0x8000;
>         case BPF_AND:
> --
> 2.37.1 (Apple Git-137.1)
>
