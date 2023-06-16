Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A69733CE2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjFPXY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFPXYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:24:55 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771D2119
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:24:54 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3fde1a16c3bso1649171cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686957894; x=1689549894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mA8/+gVI/uxP4eDnGOq5iD8c5wr/uCZxwMQSNlOAN8=;
        b=sHURqgBIzrJEhHWUVuaqXb8F/iRv3cXsxkyCBhBPibO6dLk4rbfm98rgPYlWNaFBQE
         EsUsOJGGbpLQxPT4fc5hN12Hlccw88jNkoJG/bVgLF92phStwz7Tii3cmwvNlSizFxsy
         a4j1+U8mfgIum1MaKY014grV5phRlboo4xKq8EFpbRgdmoiqW0iYYPItvoK8ikjPZcsU
         TlTPCJWEhosa/WtYflQiH6F1XoQfv+Gd3fHuuT8X6/Ip3ZKGRq4KlU2zKgqYl5EKtRVh
         PbET+obAgp7Hjzgbt0098xpPKrPMdMlb+M7UzyjuCkRYIItmePFm0lDUodaaiLmfw6JV
         6nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686957894; x=1689549894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mA8/+gVI/uxP4eDnGOq5iD8c5wr/uCZxwMQSNlOAN8=;
        b=GhNFC+Da7RNLUjwtA9Xvw2tSj0s7Fsq7deOPmU2kWhjF+gdp6TDbPCb3+9g3t0F1SG
         Ro0EG7OzHOU5EWJpNAq0ToceNGFp76MbIIpgY3N7Qjg72A4YMJWlq0ilYuzRf7CqXdvp
         QRPXTm+CYNhdi11GTSHb6oSitBa60mDN+b+CSYXu0Yyd/nk+SWFzvAPIJWBJD91quMcy
         8jylUHyWcweb2qnUhm1L6h14bYK9LQvAwDMBnd5w8MsODTxWyWtTfG77lJRGrH5DpEJB
         Lqo1nAXmMj3a3WoPtkyJal7jRixaQpD/dakzX1kBvykKz/A9BM0EqjVt6Xxv4IdgavW7
         4F8A==
X-Gm-Message-State: AC+VfDwW9zs9rFtNiCEcsdxKN8PBa7uarloBMQDuLOsS6UOyM/eXa13B
        PNS4SJdx8iGRgNeouVxFn1h75KVmsmoFzuvvUYDoViJprdXmxrlN1OM=
X-Google-Smtp-Source: ACHHUZ4uXiPcPthkU1eyk6BGP9GBE7J6Gi0ykqapH2ZPw4YhVg1mi0n5Oxyq0yypO0x55BNU8YScX9gh/j/7NLm7wFk=
X-Received: by 2002:a05:6214:301e:b0:625:af4b:415a with SMTP id
 ke30-20020a056214301e00b00625af4b415amr3407900qvb.19.1686957893796; Fri, 16
 Jun 2023 16:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230615193546.949657149@infradead.org>
In-Reply-To: <20230615193546.949657149@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 16 Jun 2023 16:24:17 -0700
Message-ID: <CABCJKueEgA3UQUzeWP-T9fuo9KbfngCxaF2Uz7Xy2NX5=dpJgw@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/cfi: Fix FineIBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:40=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> Hi!
>
> Alyssa reported a FineIBT issue; these patches sort that.
>
> Basically the morale of the story is that CALL_NOSPEC and JMP_NOSPEC are
> suspect and likely not what you want. The remaining users are:
>
> arch/x86/crypto/crc32c-pcl-intel-asm_64.S:      JMP_NOSPEC bufp
>
> This is broken on anything IBT afaict.
>
> arch/x86/include/asm/mshyperv.h:                             CALL_NOSPEC
> arch/x86/include/asm/mshyperv.h:        __asm__ __volatile__(CALL_NOSPEC
> arch/x86/include/asm/mshyperv.h:                __asm__ __volatile__(CALL=
_NOSPEC
> arch/x86/include/asm/mshyperv.h:                __asm__ __volatile__ (CAL=
L_NOSPEC
> arch/x86/include/asm/mshyperv.h:                                     CALL=
_NOSPEC
> arch/x86/include/asm/mshyperv.h:                __asm__ __volatile__ (CAL=
L_NOSPEC
> arch/x86/include/asm/xen/hypercall.h:   asm volatile(CALL_NOSPEC
>
> These are hypercalls and supposedly the targets are having ENDBR on.
>
> arch/x86/kernel/ftrace_64.S:    CALL_NOSPEC r8
>
> The thing is !DYNAMIC_FTRACE only, which we can fix with a Kconfig
> dependency I suppose.
>
> arch/x86/kvm/emulate.c: asm("push %[flags]; popf; " CALL_NOSPEC
> arch/x86/kvm/emulate.c: asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf=
; pop %[flags]\n"
>
> calls into the magic fastop stuff and should be ok, those have explicit
> ENDBR + IBT_NOSEAL() annotations.
>
> arch/x86/kvm/vmx/vmenter.S:     VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
>
> calls the IDT vectors manually, so should be ok (gross, but not broken
> from this pov).
>
> arch/x86/platform/efi/efi_stub_64.S:    CALL_NOSPEC rdi
>
> effectively a nocfi call, so should be ok.

Thanks, this looks good to me. For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
